From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/9] sha1_name.c: allow get_short_sha1() to take other
 flags
Date: Wed, 20 Jun 2012 23:35:30 -0700
Message-ID: <1340260532-11378-8-git-send-email-gitster@pobox.com>
References: <1340260532-11378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 08:36:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shazm-0006l5-1S
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab2FUGfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:35:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755741Ab2FUGfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:35:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 208188B2E
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=VwuZ
	8INrxtBPPcbC3Uxq0Tp7Pwk=; b=srizN8RnG2g9xA1z/xnV8HlFYAMhyAVU4W3G
	1cv+Xl2C+B2WeBQ1hOL378D+CgXZks7Am56CzxlBqA++nU0uvk/D84RDDdH3vUut
	KJXYS4eEqMaypVPaH7eXWtxQUNUQsdZvSCmJbQjShZzFyLUfKlMNTJUou4pFkbv8
	W+BX7c4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eY4rZB
	dQKk/Yic1S12zmNLFfsj7D2mNjkAx8pKK9TH+T6NLX13wAf8ILL4vZdCy9EJkpyH
	p3JjYfEWferh0EM0MiGhMt1nOtd69CzCtIrC90a9USzV8iYKCvrrQHffUd9Nu/yq
	73n247Nx8dhE5XwwnAbglcJ5bGkLkHgTkzY2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1313A8B2D
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95DC88B2C for
 <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.gd284367
In-Reply-To: <1340260532-11378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 55626A24-BB6B-11E1-8D81-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200392>

Instead of a separate "int quietly" argument, make it take "unsigned flags"
so that we can pass other options to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 852d5c2..7cca7d9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -218,13 +218,16 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	return 0;
 }
 
+#define GET_SHORT_QUIETLY 01
+
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
-			  int quietly)
+			  unsigned flags)
 {
 	int i, status;
 	char hex_pfx[40];
 	unsigned char bin_pfx[20];
 	struct disambiguate_state ds;
+	int quietly = !!(flags & GET_SHORT_QUIETLY);
 
 	if (len < MINIMUM_ABBREV || len > 40)
 		return -1;
@@ -272,7 +275,7 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
-		status = get_short_sha1(hex, len, sha1_ret, 1);
+		status = get_short_sha1(hex, len, sha1_ret, GET_SHORT_QUIETLY);
 		if (exists
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
@@ -603,7 +606,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_sha1(cp, len, sha1, 1);
+				return get_short_sha1(cp, len, sha1, GET_SHORT_QUIETLY);
 			}
 		}
 	}
-- 
1.7.11.2.gd284367
