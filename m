From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/9] longest_ancestor_length(): use string_list_longest_prefix()
Date: Sat, 29 Sep 2012 08:16:00 +0200
Message-ID: <1348899362-4057-8-git-send-email-mhagger@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqMC-0002Xr-4j
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682Ab2I2GQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:41 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:61932 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758418Ab2I2GQf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 02:16:35 -0400
X-AuditID: 1207440f-b7fde6d00000095c-1a-506692426108
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 05.2B.02396.24296605; Sat, 29 Sep 2012 02:16:34 -0400 (EDT)
Received: from michael.fritz.box (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T6G744026219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 02:16:33 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsUixO6iqOs0KS3AoKlN36LrSjeTRUPvFWaL
	o6csLG6vmM9ssf7dVWYHVo+/7z8weeycdZfd4+IlZY/Pm+QCWKK4bZISS8qCM9Pz9O0SuDP2
	t5xmKmjlquh59IqpgXESRxcjB4eEgInEhm6fLkZOIFNM4sK99WxdjFwcQgKXGSWWrLvHDuGc
	ZZK4ueIJG0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgUmMEj0bHrCDJIQFgiVO9Z5kBNnAIqAq
	seGEG4jJK+As0XnIBWKZosSP72uYQWxOAReJ3z3TWUFsIaCSR3vvsE5g5F3AyLCKUS4xpzRX
	NzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQTIySI+Hcwdq2XOcQowMGoxMOrdTw1QIg1say4
	MvcQoyQHk5Iob87EtAAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwZxUDlvCmJlVWpRfkwKWkO
	FiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJ3hKQoYJFqempFWmZOSUIaSYOThDBBbKBB2hD
	DUghb3FBYm5xZjpE0SlGRSlx3kSQhABIIqM0D24ALN5fMYoD/SPMGwhSxQNMFXDdr4AGMwEN
	XropCWRwSSJCSqqBkfXxCe09T3fLR/yNlHv4QaqvImxfnfE/49XzanPXOhtdqHD/632UI679
	1kLuKRo5bj3fn27a2La4KX89X/KeL8zpLoueFXPe/rrw9ZbYw2y3LrC7RFuKqW304pjmt+3N
	/0PyNuE5zzvl9ffX/fZWzvbXXZbVU8p9jvetyILMKymu21c6rfYQVGIpzkg01GIu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206643>

Use string_list_longest_prefix() in the implementation of
longest_ancestor_length(), instead of an equivalent loop.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/path.c b/path.c
index a56c64a..b20f2fb 100644
--- a/path.c
+++ b/path.c
@@ -604,23 +604,16 @@ static int normalize_path_callback(struct string_list_item *item, void *cb_data)
 int longest_ancestor_length(const char *path, const char *prefix_list)
 {
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
-	int i, max_len = -1;
+	int max_len;
+	const char *longest_prefix;
 
 	if (prefix_list == NULL || !strcmp(path, "/"))
 		return -1;
 
 	string_list_split(&prefixes, prefix_list, PATH_SEP, -1);
 	filter_string_list(&prefixes, 0, normalize_path_callback, NULL);
-
-	for (i = 0; i < prefixes.nr; i++) {
-		const char *ceil = prefixes.items[i].string;
-		int len = strlen(ceil);
-
-		if (!strncmp(path, ceil, len) &&
-		    len - 1 > max_len) {
-			max_len = len - 1;
-		}
-	}
+	longest_prefix = string_list_longest_prefix(&prefixes, path);
+	max_len = longest_prefix ? strlen(longest_prefix) - 1 : -1;
 
 	string_list_clear(&prefixes, 0);
 	return max_len;
-- 
1.7.11.3
