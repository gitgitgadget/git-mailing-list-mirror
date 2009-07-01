From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/6] grep -p: support user defined regular expressions
Date: Thu, 02 Jul 2009 00:07:24 +0200
Message-ID: <4A4BDE1C.8070903@lsrfire.ath.cx>
References: <4A4BDC65.80504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:07:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM7xj-0004L1-QO
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbZGAWHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 18:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbZGAWHW
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:07:22 -0400
Received: from india601.server4you.de ([85.25.151.105]:55631 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbZGAWHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:07:21 -0400
Received: from [10.0.1.101] (p57B7FA76.dip.t-dialin.net [87.183.250.118])
	by india601.server4you.de (Postfix) with ESMTPSA id B9E852F8068;
	Thu,  2 Jul 2009 00:07:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <4A4BDC65.80504@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122608>

Respect the userdiff attributes and config settings when looking for
lines with function definitions in git grep -p.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-grep.txt |    3 +++
 builtin-grep.c             |    7 +++++++
 grep.c                     |   29 ++++++++++++++++++++++++++---
 grep.h                     |    1 +
 t/t7002-grep.sh            |   13 +++++++++++++
 5 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index b3bb283..b753c9d 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -126,6 +126,9 @@ OPTIONS
 --show-function::
 	Show the preceding line that contains the function name of
 	the match, unless the matching line is a function name itself.
+	The name is determined in the same way as 'git diff' works out
+	patch hunk headers (see 'Defining a custom hunk-header' in
+	linkgit:gitattributes[5]).
 
 -f <file>::
 	Read patterns from <file>, one per line.
diff --git a/builtin-grep.c b/builtin-grep.c
index 037452e..9343cc5 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -11,6 +11,7 @@
 #include "tree-walk.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "userdiff.h"
 #include "grep.h"
 
 #ifndef NO_EXTERNAL_GREP
@@ -30,6 +31,12 @@ static int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
 
+	switch (userdiff_config(var, value)) {
+	case 0: break;
+	case -1: return -1;
+	default: return 0;
+	}
+
 	if (!strcmp(var, "color.grep")) {
 		opt->color = git_config_colorbool(var, value, -1);
 		return 0;
diff --git a/grep.c b/grep.c
index 3a5c138..c47785a 100644
--- a/grep.c
+++ b/grep.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "grep.h"
+#include "userdiff.h"
 #include "xdiff-interface.h"
 
 void append_header_grep_pattern(struct grep_opt *opt, enum grep_header_field field, const char *pat)
@@ -535,8 +536,15 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	printf("%.*s\n", rest, bol);
 }
 
-static int match_funcname(char *bol, char *eol)
+static int match_funcname(struct grep_opt *opt, char *bol, char *eol)
 {
+	xdemitconf_t *xecfg = opt->priv;
+	if (xecfg && xecfg->find_func) {
+		char buf[1];
+		return xecfg->find_func(bol, eol - bol, buf, 1,
+					xecfg->find_func_priv) >= 0;
+	}
+
 	if (bol == eol)
 		return 0;
 	if (isalpha(*bol) || *bol == '_' || *bol == '$')
@@ -557,7 +565,7 @@ static void show_funcname_line(struct grep_opt *opt, const char *name,
 		if (lno <= opt->last_shown)
 			break;
 
-		if (match_funcname(bol, eol)) {
+		if (match_funcname(opt, bol, eol)) {
 			show_line(opt, bol, eol, name, lno, '=');
 			break;
 		}
@@ -582,7 +590,7 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 		while (bol > buf && bol[-1] != '\n')
 			bol--;
 		cur--;
-		if (funcname_needed && match_funcname(bol, eol)) {
+		if (funcname_needed && match_funcname(opt, bol, eol)) {
 			funcname_lno = cur;
 			funcname_needed = 0;
 		}
@@ -614,6 +622,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	int binary_match_only = 0;
 	unsigned count = 0;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
+	xdemitconf_t xecfg;
 
 	opt->last_shown = 0;
 
@@ -630,6 +639,17 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		}
 	}
 
+	memset(&xecfg, 0, sizeof(xecfg));
+	if (opt->funcname && !opt->unmatch_name_only && !opt->status_only &&
+	    !opt->name_only && !binary_match_only && !collect_hits) {
+		struct userdiff_driver *drv = userdiff_find_by_path(name);
+		if (drv && drv->funcname.pattern) {
+			const struct userdiff_funcname *pe = &drv->funcname;
+			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
+			opt->priv = &xecfg;
+		}
+	}
+
 	while (left) {
 		char *eol, ch;
 		int hit;
@@ -711,6 +731,9 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		return 1;
 	}
 
+	xdiff_clear_find_func(&xecfg);
+	opt->priv = NULL;
+
 	/* NEEDSWORK:
 	 * The real "grep -c foo *.c" gives many "bar.c:0" lines,
 	 * which feels mostly useless but sometimes useful.  Maybe
diff --git a/grep.h b/grep.h
index 3f75e3a..f00db0e 100644
--- a/grep.h
+++ b/grep.h
@@ -87,6 +87,7 @@ struct grep_opt {
 	unsigned post_context;
 	unsigned last_shown;
 	int show_hunk_mark;
+	void *priv;
 };
 
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index ef59ab9..b13aa7e 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -244,11 +244,24 @@ test_expect_success 'grep with CE_VALID file' '
 '
 
 cat >expected <<EOF
+hello.c=#include <stdio.h>
+hello.c:	return 0;
+EOF
+
+test_expect_success 'grep -p with userdiff' '
+	git config diff.custom.funcname "^#" &&
+	echo "hello.c diff=custom" >.gitattributes &&
+	git grep -p return >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
 hello.c=int main(int argc, const char **argv)
 hello.c:	return 0;
 EOF
 
 test_expect_success 'grep -p' '
+	rm -f .gitattributes &&
 	git grep -p return >actual &&
 	test_cmp expected actual
 '
-- 
1.6.3.3
