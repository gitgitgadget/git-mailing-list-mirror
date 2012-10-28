From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] parse_dirstat_params(): use string_list to split comma-separated string
Date: Sun, 28 Oct 2012 17:50:54 +0100
Message-ID: <1351443054-10472-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:51:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSW5A-0007nZ-Be
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 17:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab2J1QvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 12:51:15 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:43020 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752981Ab2J1QvN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 12:51:13 -0400
X-AuditID: 12074411-b7fa36d0000008cc-ca-508d62808be3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id CD.D4.02252.0826D805; Sun, 28 Oct 2012 12:51:13 -0400 (EDT)
Received: from michael.fritz.box (p57A2465E.dip.t-dialin.net [87.162.70.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9SGp0Mb004125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Oct 2012 12:51:11 -0400
X-Mailer: git-send-email 1.8.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqNuY1BtgcHUSh0XXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE7Y8KfcywF
	rTIVj5ZENDBOFOti5OSQEDCRmLe6iQ3CFpO4cG89mC0kcJlRYvZl6y5GLiD7DJPE+X8fWUAS
	bAK6Eot6mplAbBEBWYnvhzcygtjMArkSi9/dZgexhQUiJLb1rwaLswioSuyc/Iu1i5GDg1fA
	ReLULR2IXXISH/Y8Yp/AyL2AkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6pXm5miV5qSukm
	RkgoCO5gnHFS7hCjAAejEg/vpYKeACHWxLLiytxDjJIcTEqivOoJvQFCfEn5KZUZicUZ8UWl
	OanFhxglOJiVRHiXcgPleFMSK6tSi/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoS
	vDKJQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoCCPLwaGOUiKB2ivLkg7b3FB
	Yi5QFKL1FKMux9E3cx8yCrHk5eelSonzcoMUCYAUZZTmwa2ARf4rRnGgj4V5P4G8xwNMGnCT
	XgEtYQJaosMHtqQkESEl1cDIlzr94/KUtZElJ/T3TzThcQozkvodsLXYPJODVzj499ZnGqkp
	My10f0iWMVq6TJuep68UXslVFTNl42KfK1ueLM+Q/nfl44fDv6ucNpzyzjY7u3vHKcvPC8Ie
	v1uVbiDUw6AVK+Mk0SncyN/5msdzmx5D4kX75bqLZB+u/rvV+Ot+16fM+gpKLMUZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208559>

Use string_list_split_in_place() to split the comma-separated
parameters string.  This simplifies the code and also fixes a bug: the
old code made calls like

    memcmp(p, "lines", p_len)

which needn't work if p_len is different than the length of the
constant string (and could illegally access memory if p_len is larger
than the length of the constant string).

When p_len was less than the length of the constant string, the old
code would have allowed some abbreviations to be accepted (e.g., "cha"
for "changes") but this seems to have been a bug rather than a
feature, because (1) it is not documented; (2) no attempt was made to
handle ambiguous abbreviations, like "c" for "changes" vs
"cumulative".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/diff.c b/diff.c
index 35d3f07..a9cc8a9 100644
--- a/diff.c
+++ b/diff.c
@@ -15,6 +15,7 @@
 #include "sigchain.h"
 #include "submodule.h"
 #include "ll-merge.h"
+#include "string-list.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -68,26 +69,30 @@ static int parse_diff_color_slot(const char *var, int ofs)
 	return -1;
 }
 
-static int parse_dirstat_params(struct diff_options *options, const char *params,
+static int parse_dirstat_params(struct diff_options *options, const char *params_string,
 				struct strbuf *errmsg)
 {
-	const char *p = params;
-	int p_len, ret = 0;
+	char *params_copy = xstrdup(params_string);
+	struct string_list params = STRING_LIST_INIT_NODUP;
+	int ret = 0;
+	int i;
 
-	while (*p) {
-		p_len = strchrnul(p, ',') - p;
-		if (!memcmp(p, "changes", p_len)) {
+	if (*params_copy)
+		string_list_split_in_place(&params, params_copy, ',', -1);
+	for (i = 0; i < params.nr; i++) {
+		const char *p = params.items[i].string;
+		if (!strcmp(p, "changes")) {
 			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
 			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
-		} else if (!memcmp(p, "lines", p_len)) {
+		} else if (!strcmp(p, "lines")) {
 			DIFF_OPT_SET(options, DIRSTAT_BY_LINE);
 			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
-		} else if (!memcmp(p, "files", p_len)) {
+		} else if (!strcmp(p, "files")) {
 			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
 			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
-		} else if (!memcmp(p, "noncumulative", p_len)) {
+		} else if (!strcmp(p, "noncumulative")) {
 			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
-		} else if (!memcmp(p, "cumulative", p_len)) {
+		} else if (!strcmp(p, "cumulative")) {
 			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
 		} else if (isdigit(*p)) {
 			char *end;
@@ -99,24 +104,21 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 				while (isdigit(*++end))
 					; /* nothing */
 			}
-			if (end - p == p_len)
+			if (!*end)
 				options->dirstat_permille = permille;
 			else {
-				strbuf_addf(errmsg, _("  Failed to parse dirstat cut-off percentage '%.*s'\n"),
-					    p_len, p);
+				strbuf_addf(errmsg, _("  Failed to parse dirstat cut-off percentage '%s'\n"),
+					    p);
 				ret++;
 			}
 		} else {
-			strbuf_addf(errmsg, _("  Unknown dirstat parameter '%.*s'\n"),
-				    p_len, p);
+			strbuf_addf(errmsg, _("  Unknown dirstat parameter '%s'\n"), p);
 			ret++;
 		}
 
-		p += p_len;
-
-		if (*p)
-			p++; /* more parameters, swallow separator */
 	}
+	string_list_clear(&params, 0);
+	free(params_copy);
 	return ret;
 }
 
-- 
1.8.0
