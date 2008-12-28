From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2] diff: add option to show context between close hunks
Date: Sun, 28 Dec 2008 19:45:32 +0100
Message-ID: <1230489932.8791.25.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Davide Libenzi <davidel@xmailserver.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 28 19:47:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LH0fF-0004B1-Fh
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 19:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbYL1Spk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 13:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbYL1Spk
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 13:45:40 -0500
Received: from india601.server4you.de ([85.25.151.105]:52706 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbYL1Spj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 13:45:39 -0500
Received: from [10.0.1.101] (p57B7E3E9.dip.t-dialin.net [87.183.227.233])
	by india601.server4you.de (Postfix) with ESMTPSA id E9DF62F803F;
	Sun, 28 Dec 2008 19:45:36 +0100 (CET)
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104057>

Merge two hunks if there is only the specified number of otherwise unshown
context between them.  For --inter-hunk-context=1, the resulting patch has
the same number of lines but shows uninterrupted context instead of a
context header line in between.

Patches generated with this option are easier to read but are also more
likely to conflict if the file to be patched contains other changes.

This patch keeps the default for this option at 0.  It is intended to just
make the feature available in order to see its advantages and downsides.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Changes: s/chunk/hunk/g, bash completion, redone test script.

 Documentation/diff-options.txt         |    4 ++
 contrib/completion/git-completion.bash |    2 +
 diff.c                                 |    4 ++
 diff.h                                 |    1 +
 t/t4032-diff-inter-hunk-context.sh     |   92 ++++++++++++++++++++++++++++++++
 xdiff/xdiff.h                          |    1 +
 xdiff/xemit.c                          |    3 +-
 7 files changed, 106 insertions(+), 1 deletions(-)
 create mode 100755 t/t4032-diff-inter-hunk-context.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c62b45c..c7fcc80 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -215,6 +215,10 @@ endif::git-format-patch[]
 -w::
 	Shorthand for "--ignore-all-space".
 
+--inter-hunk-context=<lines>::
+	Show the context between diff hunks, up to the specified number
+	of lines, thereby fusing hunks that are close to each other.
+
 --exit-code::
 	Make the program exit with codes similar to diff(1).
 	That is, it exits with 1 if there were differences and
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e004549..a046441 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -776,6 +776,7 @@ _git_diff ()
 			--no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
 			--base --ours --theirs
+			--inter-hunk-context=
 			"
 		return
 		;;
@@ -967,6 +968,7 @@ _git_log ()
 			--color-words --walk-reflogs
 			--parents --children --full-history
 			--merge
+			--inter-hunk-context=
 			"
 		return
 		;;
diff --git a/diff.c b/diff.c
index 0484601..56b80f9 100644
--- a/diff.c
+++ b/diff.c
@@ -1469,6 +1469,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.file = o->file;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
+		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (pe)
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
@@ -2538,6 +2539,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->b_prefix = arg + 13;
 	else if (!strcmp(arg, "--no-prefix"))
 		options->a_prefix = options->b_prefix = "";
+	else if (opt_arg(arg, '\0', "inter-hunk-context",
+			 &options->interhunkcontext))
+		;
 	else if (!prefixcmp(arg, "--output=")) {
 		options->file = fopen(arg + strlen("--output="), "w");
 		options->close_file = 1;
diff --git a/diff.h b/diff.h
index 42582ed..4d5a327 100644
--- a/diff.h
+++ b/diff.h
@@ -78,6 +78,7 @@ struct diff_options {
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
 	int context;
+	int interhunkcontext;
 	int break_opt;
 	int detect_rename;
 	int skip_stat_unmatch;
diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
new file mode 100755
index 0000000..e4e3e28
--- /dev/null
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='diff hunk fusing'
+
+. ./test-lib.sh
+
+f() {
+	echo $1
+	i=1
+	while test $i -le $2
+	do
+		echo $i
+		i=$(expr $i + 1)
+	done
+	echo $3
+}
+
+t() {
+	case $# in
+	4) hunks=$4; cmd="diff -U$3";;
+	5) hunks=$5; cmd="diff -U$3 --inter-hunk-context=$4";;
+	esac
+	label="$cmd, $1 common $2"
+	file=f$1
+	expected=expected.$file.$3.$hunks
+
+	if ! test -f $file
+	then
+		f A $1 B >$file
+		git add $file
+		git commit -q -m. $file
+		f X $1 Y >$file
+	fi
+
+	test_expect_success "$label: count hunks ($hunks)" "
+		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
+	"
+
+	test -f $expected &&
+	test_expect_success "$label: check output" "
+		git $cmd $file | grep -v '^index ' >actual &&
+		test_cmp $expected actual
+	"
+}
+
+cat <<EOF >expected.f1.0.1 || exit 1
+diff --git a/f1 b/f1
+--- a/f1
++++ b/f1
+@@ -1,3 +1,3 @@
+-A
++X
+ 1
+-B
++Y
+EOF
+
+cat <<EOF >expected.f1.0.2 || exit 1
+diff --git a/f1 b/f1
+--- a/f1
++++ b/f1
+@@ -1 +1 @@
+-A
++X
+@@ -3 +3 @@ A
+-B
++Y
+EOF
+
+# common lines	ctx	intrctx	hunks
+t 1 line	0		2
+t 1 line	0	0	2
+t 1 line	0	1	1
+t 1 line	0	2	1
+t 1 line	1		1
+
+t 2 lines	0		2
+t 2 lines	0	0	2
+t 2 lines	0	1	2
+t 2 lines	0	2	1
+t 2 lines	1		1
+
+t 3 lines	1		2
+t 3 lines	1	0	2
+t 3 lines	1	1	1
+t 3 lines	1	2	1
+
+t 9 lines	3		2
+t 9 lines	3	2	2
+t 9 lines	3	3	1
+
+test_done
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 84fff58..361f802 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -84,6 +84,7 @@ typedef long (*find_func_t)(const char *line, long line_len, char *buffer, long
 
 typedef struct s_xdemitconf {
 	long ctxlen;
+	long interhunkctxlen;
 	unsigned long flags;
 	find_func_t find_func;
 	void *find_func_priv;
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 4625c1b..05bfa41 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -59,9 +59,10 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
  */
 xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg) {
 	xdchange_t *xch, *xchp;
+	long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
 
 	for (xchp = xscr, xch = xscr->next; xch; xchp = xch, xch = xch->next)
-		if (xch->i1 - (xchp->i1 + xchp->chg1) > 2 * xecfg->ctxlen)
+		if (xch->i1 - (xchp->i1 + xchp->chg1) > max_common)
 			break;
 
 	return xchp;
-- 
1.6.1
