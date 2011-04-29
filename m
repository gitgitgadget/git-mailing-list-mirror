From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 7/8] Improve error handling when parsing dirstat parameters
Date: Fri, 29 Apr 2011 11:36:22 +0200
Message-ID: <1304069783-22739-8-git-send-email-johan@herland.net>
References: <7vfwp13dme.fsf@alter.siamese.dyndns.org>
 <1304069783-22739-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 11:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFk8P-0004WC-0f
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 11:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757995Ab1D2Jgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 05:36:45 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52918 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757974Ab1D2Jgn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 05:36:43 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKE00BN5QOZZU50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 11:36:35 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 1EF031EEFAEC_DBA86A3B	for <git@vger.kernel.org>; Fri,
 29 Apr 2011 09:36:35 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 044FB1EEFCD1_DBA86A2F	for <git@vger.kernel.org>; Fri,
 29 Apr 2011 09:36:34 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKE00LICQOV8010@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 11:36:34 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1304069783-22739-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172441>

When encountering errors or unknown tokens while parsing parameters to the
--dirstat option, it makes sense to die() with an error message informing
the user of which parameter did not make sense. However, when parsing the
diff.dirstat config variable, we cannot simply die(), but should instead
(after warning the user) ignore the erroneous or unrecognized parameter.
After all, future Git versions might add more dirstat parameters, and
using two different Git versions on the same repo should not cripple the
older Git version just because of a parameter that is only understood by
a more recent Git version.

This patch fixes the issue by refactoring the dirstat parameter parsing
so that parse_dirstat_params() keeps on parsing parameters, even if an
earlier parameter was not recognized. When parsing has finished, it returns
zero if all parameters were successfully parsed, and non-zero if one or
more parameters were not recognized (with appropriate error messages
appended to the 'errmsg' argument).

The parse_dirstat_params() callers then decide (based on the return value
from parse_dirstat_params()) whether to warn and ignore (in case of
diff.dirstat), or to warn and die (in case of --dirstat).

The patch also adds a couple of tests verifying the correct behavior of
--dirstat and diff.dirstat in the face of unknown (possibly future) dirstat
parameters.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 diff.c                  |   71 +++++++++++++++++++++++++++--------------------
 t/t4047-diff-dirstat.sh |   37 ++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 8703763..b290543 100644
--- a/diff.c
+++ b/diff.c
@@ -67,52 +67,56 @@ static int parse_diff_color_slot(const char *var, int ofs)
 	return -1;
 }
 
-static int parse_dirstat_params(struct diff_options *options, const char *params)
+static int parse_dirstat_params(struct diff_options *options, const char *params,
+				struct strbuf *errmsg)
 {
 	const char *p = params;
+	int p_len, ret = 0;
+
 	while (*p) {
-		if (!prefixcmp(p, "changes")) {
-			p += 7;
+		p_len = strchrnul(p, ',') - p;
+		if (!memcmp(p, "changes", p_len)) {
 			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
 			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
-		} else if (!prefixcmp(p, "lines")) {
-			p += 5;
+		} else if (!memcmp(p, "lines", p_len)) {
 			DIFF_OPT_SET(options, DIRSTAT_BY_LINE);
 			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
-		} else if (!prefixcmp(p, "files")) {
-			p += 5;
+		} else if (!memcmp(p, "files", p_len)) {
 			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
 			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
-		} else if (!prefixcmp(p, "noncumulative")) {
-			p += 13;
+		} else if (!memcmp(p, "noncumulative", p_len)) {
 			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
-		} else if (!prefixcmp(p, "cumulative")) {
-			p += 10;
+		} else if (!memcmp(p, "cumulative", p_len)) {
 			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
 		} else if (isdigit(*p)) {
 			char *end;
-			options->dirstat_permille = strtoul(p, &end, 10) * 10;
-			p = end;
-			if (*p == '.' && isdigit(*++p)) {
+			int permille = strtoul(p, &end, 10) * 10;
+			if (*end == '.' && isdigit(*++end)) {
 				/* only use first digit */
-				options->dirstat_permille += *p - '0';
+				permille += *end - '0';
 				/* .. and ignore any further digits */
-				while (isdigit(*++p))
+				while (isdigit(*++end))
 					; /* nothing */
 			}
-		} else
-			return error("Unknown --dirstat parameter '%s'", p);
-
-		if (*p) {
-			/* more parameters, swallow separator */
-			if (*p != ',')
-				return error("Missing comma separator at char "
-					"%"PRIuMAX" of '%s'",
-					(uintmax_t) (p - params), params);
-			p++;
+			if (end - p == p_len)
+				options->dirstat_permille = permille;
+			else {
+				strbuf_addf(errmsg, "  Failed to parse dirstat cut-off percentage '%.*s'\n",
+					    p_len, p);
+				ret++;
+			}
+		} else {
+			strbuf_addf(errmsg, "  Unknown dirstat parameter '%.*s'\n",
+				    p_len, p);
+			ret++;
 		}
+
+		p += p_len;
+
+		if (*p)
+			p++; /* more parameters, swallow separator */
 	}
-	return 0;
+	return ret;
 }
 
 static int git_config_rename(const char *var, const char *value)
@@ -195,8 +199,12 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "diff.dirstat")) {
+		struct strbuf errmsg = STRBUF_INIT;
 		default_diff_options.dirstat_permille = diff_dirstat_permille_default;
-		(void) parse_dirstat_params(&default_diff_options, value);
+		if (parse_dirstat_params(&default_diff_options, value, &errmsg))
+			warning("Found errors in 'diff.dirstat' config variable:\n%s",
+				errmsg.buf);
+		strbuf_release(&errmsg);
 		diff_dirstat_permille_default = default_diff_options.dirstat_permille;
 		return 0;
 	}
@@ -3245,8 +3253,11 @@ static int stat_opt(struct diff_options *options, const char **av)
 
 static int parse_dirstat_opt(struct diff_options *options, const char *params)
 {
-	if (parse_dirstat_params(options, params))
-		die("Failed to parse --dirstat/-X option parameter");
+	struct strbuf errmsg = STRBUF_INIT;
+	if (parse_dirstat_params(options, params, &errmsg))
+		die("Failed to parse --dirstat/-X option parameter:\n%s",
+		    errmsg.buf);
+	strbuf_release(&errmsg);
 	/*
 	 * The caller knows a dirstat-related option is given from the command
 	 * line; allow it to say "return this_function();"
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index b8ad92a..cc947fd 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -939,4 +939,41 @@ test_expect_success 'diff.dirstat=0,lines' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success '--dirstat=future_param,lines,0 should fail loudly' '
+	test_must_fail git diff --dirstat=future_param,lines,0 HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
+	test_debug "cat actual_error" &&
+	test_cmp /dev/null actual_diff_dirstat &&
+	grep -q "future_param" actual_error &&
+	grep -q "\--dirstat" actual_error
+'
+
+test_expect_success '--dirstat=dummy1,cumulative,2dummy should report both unrecognized parameters' '
+	test_must_fail git diff --dirstat=dummy1,cumulative,2dummy HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
+	test_debug "cat actual_error" &&
+	test_cmp /dev/null actual_diff_dirstat &&
+	grep -q "dummy1" actual_error &&
+	grep -q "2dummy" actual_error &&
+	grep -q "\--dirstat" actual_error
+'
+
+test_expect_success 'diff.dirstat=future_param,0,lines should warn, but still work' '
+	git -c diff.dirstat=future_param,0,lines diff --dirstat HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
+	test_debug "cat actual_error" &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	grep -q "future_param" actual_error &&
+	grep -q "diff\\.dirstat" actual_error &&
+
+	git -c diff.dirstat=future_param,0,lines diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M 2>actual_error &&
+	test_debug "cat actual_error" &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	grep -q "future_param" actual_error &&
+	grep -q "diff\\.dirstat" actual_error &&
+
+	git -c diff.dirstat=future_param,0,lines diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC 2>actual_error &&
+	test_debug "cat actual_error" &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC &&
+	grep -q "future_param" actual_error &&
+	grep -q "diff\\.dirstat" actual_error
+'
+
 test_done
-- 
1.7.5.rc1.3.g4d7b
