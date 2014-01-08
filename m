From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/3] gen_scanf_fmt(): delete function and use snprintf() instead
Date: Wed,  8 Jan 2014 15:43:39 +0100
Message-ID: <1389192220-13913-3-git-send-email-mhagger@alum.mit.edu>
References: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 15:51:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0uTe-0004Lh-7F
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 15:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbaAHOvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 09:51:21 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53993 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755664AbaAHOvU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jan 2014 09:51:20 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2014 09:51:20 EST
X-AuditID: 12074411-b7f426d000005455-ba-52cd6441d431
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 22.10.21589.1446DC25; Wed,  8 Jan 2014 09:44:17 -0500 (EST)
Received: from michael.fritz.box (p4FDD47EC.dip0.t-ipconnect.de [79.221.71.236])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s08EhhdI022001
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jan 2014 09:44:16 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsUixO6iqOuYcjbI4NIRTYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M642b6JqaBPoOLi9A8sDYyX
	eLoYOTgkBEwk1k/x72LkBDLFJC7cW8/WxcjFISRwmVFizdbHjCAJIYHjTBLXXyaB2GwCuhKL
	epqZQGwRATWJiW2HWEBsZgEHic2fGxlBZgoLBEhM3eoHEmYRUJU4dP4WE0iYV8BFYu1fFYit
	ChKrrwuBVHAKuEpcPLycDWKRi8TcD1dZJzDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qk
	a6qXm1mil5pSuokREiKCOxhnnJQ7xCjAwajEw9ugciZIiDWxrLgy9xCjJAeTkiivfvTZICG+
	pPyUyozE4oz4otKc1OJDjBIczEoivJfigHK8KYmVValF+TApaQ4WJXFeviXqfkIC6Yklqdmp
	qQWpRTBZGQ4OJQnenUlAjYJFqempFWmZOSUIaSYOThDBBbKBB2hDDEghb3FBYm5xZjpE0SlG
	RSlx3ukgCQGQREZpHtwAWDS/YhQH+keYdwVIFQ8wEcB1vwIazAQ0ODTuFMjgkkSElFQDo6je
	lVVLfc2/JvjlH+fWDZhVqvNct147x/LTdYUE/lKZi9Gm5UVW6idnc5ms95/rEvglXdl+2+5P
	kyKc9uxmadi1NOvhV+VS1qgvFnZdii7PxPNsfz1Q4cu4OfWRaPKSLQmSk4V8O4wyS8vqry1P
	XffAa+4GmePfJs82yzrwtcfMadrMo9EqSizFGYmGWsxFxYkAljA+DcECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240217>

To replace "%.*s" with "%s", all we have to do is use snprintf()
to interpolate "%s" into the pattern.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 9530480..ef9cdea 100644
--- a/refs.c
+++ b/refs.c
@@ -3334,29 +3334,6 @@ cleanup:
 	return ret;
 }
 
-/*
- * generate a format suitable for scanf from a ref_rev_parse_rules
- * rule, that is replace the "%.*s" spec with a "%s" spec
- */
-static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
-{
-	char *spec;
-
-	spec = strstr(rule, "%.*s");
-	if (!spec || strstr(spec + 4, "%.*s"))
-		die("invalid rule in ref_rev_parse_rules: %s", rule);
-
-	/* copy all until spec */
-	strncpy(scanf_fmt, rule, spec - rule);
-	scanf_fmt[spec - rule] = '\0';
-	/* copy new spec */
-	strcat(scanf_fmt, "%s");
-	/* copy remaining rule */
-	strcat(scanf_fmt, spec + 4);
-
-	return;
-}
-
 char *shorten_unambiguous_ref(const char *refname, int strict)
 {
 	int i;
@@ -3364,8 +3341,13 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	static int nr_rules;
 	char *short_name;
 
-	/* pre generate scanf formats from ref_rev_parse_rules[] */
 	if (!nr_rules) {
+		/*
+		 * Pre-generate scanf formats from ref_rev_parse_rules[].
+		 * Generate a format suitable for scanf from a
+		 * ref_rev_parse_rules rule by interpolating "%s" at the
+		 * location of the "%.*s".
+		 */
 		size_t total_len = 0;
 		size_t offset = 0;
 
@@ -3378,9 +3360,10 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 
 		offset = 0;
 		for (i = 0; i < nr_rules; i++) {
+			assert(offset < total_len);
 			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
-			gen_scanf_fmt(scanf_fmts[i], ref_rev_parse_rules[i]);
-			offset += strlen(ref_rev_parse_rules[i]);
+			offset += snprintf(scanf_fmts[i], total_len - offset,
+					   ref_rev_parse_rules[i], 2, "%s") + 1;
 		}
 	}
 
-- 
1.8.5.2
