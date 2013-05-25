From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/25] add_existing(): do not retain a reference to sha1
Date: Sat, 25 May 2013 11:08:17 +0200
Message-ID: <1369472904-12875-19-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATn-0005GF-5x
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016Ab3EYJJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:31 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:52896 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754611Ab3EYJJY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:24 -0400
X-AuditID: 1207440d-b7fd06d000000905-a8-51a07fc3ad08
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F0.22.02309.3CF70A15; Sat, 25 May 2013 05:09:23 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gus000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:21 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqHu4fkGgwYkFHBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgztj76StTwVPOik2XrrA1MP5j72Lk5JAQMJE4dWsxC4QtJnHh3nq2
	LkYuDiGBy4wS33ffZYZwLjBJbFz8jRGkik1AV2JRTzMTiC0i4Chx4sF1VpAiZoFeRomHj76D
	JYQFvCVObLgOZrMIqErMO3AQqJmDg1fAVWJyByvENgWJy7PWMIOEOYHCb09wgoSFBFwknn86
	xzqBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJAw493B+H+dzCFG
	AQ5GJR7eHSXzA4VYE8uKK3MPMUpyMCmJ8vLXLggU4kvKT6nMSCzOiC8qzUktPsQowcGsJMLL
	kAKU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8HrUATUKFqWmp1ak
	ZeaUIKSZODhBBBfIBh6gDYEghbzFBYm5xZnpEEWnGBWlxHkngiQEQBIZpXlwA2AJ4RWjONA/
	wrwpIFU8wGQC1/0KaDAT0OCbufNBBpckIqSkGhirtaao6Dwx7rm05Utk3PoPdeKH7leJKmY9
	sJCZczJRWY39Z+JHT49f9e/vLYgKuxqnL79G6mX154/iz/pNk6++ORH3OWwrt/KR+R857uv2
	xa9qqbkizSQ2e+X/iZxpk08I66+ysRFIN7iz21pYq8wvKUjnzN/Tt6d/WLJMy0Xu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225501>

Its lifetime is not guaranteed, so make a copy.  Free the memory when
the string_list is cleared.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 48df5fa..fa6fe44 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -571,7 +571,8 @@ static int add_existing(const char *refname, const unsigned char *sha1,
 {
 	struct string_list *list = (struct string_list *)cbdata;
 	struct string_list_item *item = string_list_insert(list, refname);
-	item->util = (void *)sha1;
+	item->util = xmalloc(20);
+	hashcpy(item->util, sha1);
 	return 0;
 }
 
@@ -636,7 +637,7 @@ static void find_non_local_tags(struct transport *transport,
 		item = string_list_insert(&remote_refs, ref->name);
 		item->util = (void *)ref->old_sha1;
 	}
-	string_list_clear(&existing_refs, 0);
+	string_list_clear(&existing_refs, 1);
 
 	/*
 	 * We may have a final lightweight tag that needs to be
@@ -782,7 +783,7 @@ static int do_fetch(struct transport *transport,
 	}
 
  cleanup:
-	string_list_clear(&existing_refs, 0);
+	string_list_clear(&existing_refs, 1);
 	return retcode;
 }
 
-- 
1.8.2.3
