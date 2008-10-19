From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH, RFC] diff: add option to show context between close chunks
Date: Sun, 19 Oct 2008 19:59:23 +0200
Message-ID: <48FB757B.9030105@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Davide Libenzi <davidel@xmailserver.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 13:13:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrcaD-0004do-Er
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 20:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYJSR7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 13:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbYJSR7d
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 13:59:33 -0400
Received: from india601.server4you.de ([85.25.151.105]:57706 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbYJSR7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 13:59:32 -0400
Received: from [10.0.1.101] (p57B7FE55.dip.t-dialin.net [87.183.254.85])
	by india601.server4you.de (Postfix) with ESMTPSA id A25A32F8057;
	Sun, 19 Oct 2008 19:59:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98654>

This patch adds a new diff option, --inter-chunk-context.  It can be
used to show the context in gaps between chunks, thereby creating a
big chunk out of two close chunks, in order to have an unbroken
context, making reviews easier.

With --inter-chunk-context=1, patches have the same number of lines
as without the option, as only the chunk header is replaced by the
context line it was shadowing.

You can use commit b0b44bc7b26c8c4b4221a377ce6ba174b843cb8d in the
git repo to try out this option; there's a chunk in transport.c
which is just one line away from the next.  (I found this option
helpful in reviewing my own patch before sending. :)

I think it makes sense to make 1, or even 3, the default for this
option for all commands that create patches intended for human
consumption.  The patch keeps the default at 0, though.

There are downsides, of course: values higher than 1 potentially make
the resulting patch longer.  More context means a higher probability
of (perhaps unnecessary) merge conflicts.

Comments?
---
 Documentation/diff-options.txt      |    4 ++
 diff.c                              |    4 ++
 diff.h                              |    1 +
 t/t4030-diff-inter-chunk-context.sh |   75 +++++++++++++++++++++++++++++++++++
 xdiff/xdiff.h                       |    1 +
 xdiff/xemit.c                       |    3 +-
 6 files changed, 87 insertions(+), 1 deletions(-)
 create mode 100755 t/t4030-diff-inter-chunk-context.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c62b45c..e0c6d8c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -215,6 +215,10 @@ endif::git-format-patch[]
 -w::
 	Shorthand for "--ignore-all-space".
 
+--inter-chunk-context=<lines>::
+	Show the context between diff chunks, up to the specified number
+	of lines, thereby fusing chunks that are close to each other.
+
 --exit-code::
 	Make the program exit with codes similar to diff(1).
 	That is, it exits with 1 if there were differences and
diff --git a/diff.c b/diff.c
index 1c6be89..4a3b486 100644
--- a/diff.c
+++ b/diff.c
@@ -1594,6 +1594,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.file = o->file;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
+		xecfg.interchunkctxlen = o->interchunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (pe)
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
@@ -2677,6 +2678,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->b_prefix = arg + 13;
 	else if (!strcmp(arg, "--no-prefix"))
 		options->a_prefix = options->b_prefix = "";
+	else if (opt_arg(arg, '\0', "inter-chunk-context",
+			 &options->interchunkcontext))
+		;
 	else if (!prefixcmp(arg, "--output=")) {
 		options->file = fopen(arg + strlen("--output="), "w");
 		options->close_file = 1;
diff --git a/diff.h b/diff.h
index a49d865..6003024 100644
--- a/diff.h
+++ b/diff.h
@@ -77,6 +77,7 @@ struct diff_options {
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
 	int context;
+	int interchunkcontext;
 	int break_opt;
 	int detect_rename;
 	int skip_stat_unmatch;
diff --git a/t/t4030-diff-inter-chunk-context.sh b/t/t4030-diff-inter-chunk-context.sh
new file mode 100755
index 0000000..448f1b9
--- /dev/null
+++ b/t/t4030-diff-inter-chunk-context.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description='diff chunk merging'
+
+. ./test-lib.sh
+
+f() {
+	i=1
+	echo $1
+	while test $i -le $2
+	do
+		echo $i
+		i=$(expr $i + 1)
+	done
+	echo $3
+}
+
+test_expect_success 'setup' '
+	f a 1 b >f1 &&
+	f a 2 b >f2 &&
+	f a 3 b >f3 &&
+	git add f1 f2 f3 &&
+	git commit -q -m. f1 f2 f3 &&
+	f x 1 y >f1 &&
+	f x 2 y >f2 &&
+	f x 3 y >f3
+'
+
+t() {
+	case "$2" in
+	'')	cmd="diff -U$1" ;;
+	*)	cmd="diff -U$1 --inter-chunk-context=$2" ;;
+	esac
+	label="$cmd, $3 common $4"
+
+	test_expect_success "$label: count chunks ($5)" "
+		test $(git $cmd f$3 | grep '^@@ ' | wc -l) = $5
+	"
+
+	expected="expected.$1.$3.$5"
+	test -f $expected &&
+	test_expect_success "$label: check output" "
+		git $cmd f$3 >actual &&
+		test_cmp $expected actual
+	"
+}
+
+cat <<EOF >expected.0.1.1 || exit 1
+diff --git a/f1 b/f1
+index f1e80ce..ae397d0 100644
+--- a/f1
++++ b/f1
+@@ -1,3 +1,3 @@
+-a
++x
+ 1
+-b
++y
+EOF
+
+# ctx	intrctx	common	lines	chunks
+t 0	''	1	line	2
+t 0	0	1	line	2
+t 0	1	1	line	1
+t 0	2	1	line	1
+t 0	''	2	lines	2
+t 0	0	2	lines	2
+t 0	1	2	lines	2
+t 0	2	2	lines	1
+t 1	''	3	lines	2
+t 1	0	3	lines	2
+t 1	1	3	lines	1
+t 1	2	3	lines	1
+
+test_done
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index deebe02..d8f14e6 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -84,6 +84,7 @@ typedef long (*find_func_t)(const char *line, long line_len, char *buffer, long
 
 typedef struct s_xdemitconf {
 	long ctxlen;
+	long interchunkctxlen;
 	unsigned long flags;
 	find_func_t find_func;
 	void *find_func_priv;
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index d3d9c84..3bf2581 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -60,9 +60,10 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
  */
 static xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg) {
 	xdchange_t *xch, *xchp;
+	long max_common = 2 * xecfg->ctxlen + xecfg->interchunkctxlen;
 
 	for (xchp = xscr, xch = xscr->next; xch; xchp = xch, xch = xch->next)
-		if (xch->i1 - (xchp->i1 + xchp->chg1) > 2 * xecfg->ctxlen)
+		if (xch->i1 - (xchp->i1 + xchp->chg1) > max_common)
 			break;
 
 	return xchp;
-- 
1.6.0.2.287.g3791f
