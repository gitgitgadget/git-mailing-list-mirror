From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/7] grep: move pattern-type bits support to top-level
 grep.[ch]
Date: Wed, 10 Oct 2012 00:55:10 -0700
Message-ID: <1349855714-17008-4-git-send-email-gitster@pobox.com>
References: <1349855714-17008-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 09:55:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLr8s-0000Z3-J8
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 09:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab2JJHzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 03:55:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab2JJHzh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 03:55:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B0956F9D
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=NYQR
	lU2FR6oLoiXJVs7osgWcTk0=; b=doPqqYl9JUZ2lROOYW+5ArAo2Ful3oEWs49l
	Fl/v53Ca3PoTp74N/hMCQkaNuDlVPhRWHk9R3U3r3yth66L5jeHKSpcq9pLXEGmP
	R3PHk+4CRkdWuFU/zAFALVl7E4wj9iqHzQjAAOoWsFrX9VY1GNaF3QMqJgKgS15i
	Mp0Gofo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=u69xH8
	M5z4sNAYeAajFISp5q2K4tz9Ki0jm85261gUULJ4qNf3hNXxLx5MCUhZBgtBHzE3
	4JVmhI6nYufUgm+dhdPhGqzByg27EO/Rd71AhDFn8aN7bH3hxEm+Ztdg0SLOUF3F
	0+EvwI973DvYK03+eXPvhh+H98gyclW97LDew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88ED86F9C
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F6636F9B for
 <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:35 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc1.76.g5a375e6
In-Reply-To: <1349855714-17008-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DFA594E0-12AF-11E2-9BE1-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207375>

Switching between -E/-G/-P/-F correctly needs a lot more than just
flipping opt->regflags bit these days, and we have a nice helper
function buried in builtin/grep.c for the sole use of "git grep".

Extract it so that "log --grep" family can also use it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c | 40 +---------------------------------------
 grep.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
 grep.h         |  2 ++
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index b63a9f8..c296e6f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -261,38 +261,6 @@ static int wait_all(void)
 }
 #endif
 
-static void grep_pattern_type_options(const int pattern_type, struct grep_opt *opt)
-{
-	switch (pattern_type) {
-	case GREP_PATTERN_TYPE_UNSPECIFIED:
-		/* fall through */
-
-	case GREP_PATTERN_TYPE_BRE:
-		opt->fixed = 0;
-		opt->pcre = 0;
-		opt->regflags &= ~REG_EXTENDED;
-		break;
-
-	case GREP_PATTERN_TYPE_ERE:
-		opt->fixed = 0;
-		opt->pcre = 0;
-		opt->regflags |= REG_EXTENDED;
-		break;
-
-	case GREP_PATTERN_TYPE_FIXED:
-		opt->fixed = 1;
-		opt->pcre = 0;
-		opt->regflags &= ~REG_EXTENDED;
-		break;
-
-	case GREP_PATTERN_TYPE_PCRE:
-		opt->fixed = 0;
-		opt->pcre = 1;
-		opt->regflags &= ~REG_EXTENDED;
-		break;
-	}
-}
-
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
 	int st = grep_config(var, value, cb);
@@ -798,13 +766,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
-
-	if (pattern_type_arg != GREP_PATTERN_TYPE_UNSPECIFIED)
-		grep_pattern_type_options(pattern_type_arg, &opt);
-	else if (opt.pattern_type_option != GREP_PATTERN_TYPE_UNSPECIFIED)
-		grep_pattern_type_options(opt.pattern_type_option, &opt);
-	else if (opt.extended_regexp_option)
-		grep_pattern_type_options(GREP_PATTERN_TYPE_ERE, &opt);
+	grep_commit_pattern_type(pattern_type_arg, &opt);
 
 	if (use_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
diff --git a/grep.c b/grep.c
index 621e6ec..279a559 100644
--- a/grep.c
+++ b/grep.c
@@ -137,6 +137,48 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	strcpy(opt->color_sep, def->color_sep);
 }
 
+void grep_commit_pattern_type(enum grep_pattern_type pattern_type, struct grep_opt *opt)
+{
+	if (pattern_type != GREP_PATTERN_TYPE_UNSPECIFIED)
+		grep_set_pattern_type_option(pattern_type, opt);
+	else if (opt->pattern_type_option != GREP_PATTERN_TYPE_UNSPECIFIED)
+		grep_set_pattern_type_option(opt->pattern_type_option, opt);
+	else if (opt->extended_regexp_option)
+		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, opt);
+}
+
+void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
+{
+	switch (pattern_type) {
+	case GREP_PATTERN_TYPE_UNSPECIFIED:
+		/* fall through */
+
+	case GREP_PATTERN_TYPE_BRE:
+		opt->fixed = 0;
+		opt->pcre = 0;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_ERE:
+		opt->fixed = 0;
+		opt->pcre = 0;
+		opt->regflags |= REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_FIXED:
+		opt->fixed = 1;
+		opt->pcre = 0;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_PCRE:
+		opt->fixed = 0;
+		opt->pcre = 1;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+	}
+}
+
 static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
 					const char *origin, int no,
 					enum grep_pat_token t,
diff --git a/grep.h b/grep.h
index 9aa1cc7..701c784 100644
--- a/grep.h
+++ b/grep.h
@@ -141,6 +141,8 @@ struct grep_opt {
 extern void init_grep_defaults(void);
 extern int grep_config(const char *var, const char *value, void *);
 extern void grep_init(struct grep_opt *, const char *prefix);
+void grep_set_pattern_type_option(enum grep_pattern_type, struct grep_opt *opt);
+void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 extern void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
-- 
1.8.0.rc1.76.g5a375e6
