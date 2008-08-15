From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] add boolean diff.suppress-blank-empty config option
Date: Fri, 15 Aug 2008 14:47:07 +0200
Message-ID: <87k5eiphro.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Eggert <eggert@cs.ucla.edu>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 14:48:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTyj2-00014K-0B
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 14:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbYHOMrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 08:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbYHOMrL
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 08:47:11 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:56582 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422AbYHOMrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 08:47:09 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 1385C1977E;
	Fri, 15 Aug 2008 14:47:08 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp6-g19.free.fr (Postfix) with ESMTP id E522219743;
	Fri, 15 Aug 2008 14:47:07 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 975B06A8E8; Fri, 15 Aug 2008 14:47:07 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92470>


GNU diff's --suppress-blank-empty option makes it so that diff does not
add a space or tab before each empty output line of context.  With this
option, empty context lines are empty also in "git diff" output.
Before (and without the option), they'd have a single trailing space.

* diff.c (diff_suppress_blank_empty): New global.
(git_diff_basic_config): Set it.
(builtin_diff): Use it to set the bit in ecbdata, aka ecb.priv.
* xdiff-interface.c (xdiff_outf): Honor the new option.
* xdiff-interface.h (struct xdiff_emit_state) [suppress_blank_empty]:
New member.
* t/t4029-diff-trailing-space.sh: New file.
* Documentation/config.txt: Document it.
---
I'm posting this solely in case someone else finds it useful.
Of course, if you're interested in making it part of git, I'll
be happy to make any required adjustments.
I've been using a variant of this for over a year with no ill effects.
[FWIW, this is relative to today's "maint"]

 Documentation/config.txt       |    4 ++++
 diff.c                         |    8 ++++++++
 t/t4029-diff-trailing-space.sh |   39 +++++++++++++++++++++++++++++++++++++++
 xdiff-interface.c              |    7 +++++++
 xdiff-interface.h              |    1 +
 5 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100755 t/t4029-diff-trailing-space.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b8ec01c..ccc2432 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -567,6 +567,10 @@ diff.autorefreshindex::
 	affects only 'git-diff' Porcelain, and not lower level
 	'diff' commands, such as 'git-diff-files'.

+diff.suppress-blank-empty::
+	A boolean to inhibit the standard behavior of printing a
+	space or tab before each empty output line. Defaults to false.
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/diff.c b/diff.c
index bf5d5f1..f0fe746 100644
--- a/diff.c
+++ b/diff.c
@@ -20,6 +20,7 @@

 static int diff_detect_rename_default;
 static int diff_rename_limit_default = 200;
+static int diff_suppress_blank_empty;
 int diff_use_color_default = -1;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
@@ -176,6 +177,12 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}

+	/* like GNU diff's --suppress-blank-empty option  */
+	if (!strcmp(var, "diff.suppress-blank-empty")) {
+		diff_suppress_blank_empty = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 		if (ep != var + 4) {
@@ -1523,6 +1530,7 @@ static void builtin_diff(const char *name_a,
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
 		ecb.outf = xdiff_outf;
 		ecb.priv = &ecbdata;
+		ecbdata.xm.suppress_blank_empty = diff_suppress_blank_empty;
 		ecbdata.xm.consume = fn_out_consume;
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS)) {
 			ecbdata.diff_words =
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
new file mode 100755
index 0000000..f3351dc
--- /dev/null
+++ b/t/t4029-diff-trailing-space.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+#
+# Copyright (c) Jim Meyering
+#
+test_description='diff does not add trailing spaces'
+
+. ./test-lib.sh
+
+cat <<\EOF > exp ||
+diff --git a/f b/f
+index 5f6a263..8cb8bae 100644
+--- a/f
++++ b/f
+@@ -1,2 +1,2 @@
+
+-x
++y
+EOF
+exit 1
+
+test_expect_success \
+    "$test_description" \
+    'printf "\nx\n" > f &&
+     git add f &&
+     git commit -q -m. f &&
+     printf "\ny\n" > f &&
+     git config --bool diff.suppress-blank-empty true &&
+     git diff f > actual &&
+     test_cmp exp actual &&
+     perl -i.bak -p -e "s/^\$/ /" exp &&
+     git config --bool diff.suppress-blank-empty false &&
+     git diff f > actual &&
+     test_cmp exp actual &&
+     git config --bool --unset diff.suppress-blank-empty &&
+     git diff f > actual &&
+     test_cmp exp actual
+     '
+
+test_done
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 61dc5c5..5544e5a 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -66,6 +66,13 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 	struct xdiff_emit_state *priv = priv_;
 	int i;

+	if (priv->suppress_blank_empty
+	    && mb[0].size == 1
+	    && mb[0].ptr[0] == ' '
+	    && mb[1].size == 1
+	    && mb[1].ptr[0] == '\n')
+	  mb[0].size = 0;
+
 	for (i = 0; i < nbuf; i++) {
 		if (mb[i].ptr[mb[i].size-1] != '\n') {
 			/* Incomplete line */
diff --git a/xdiff-interface.h b/xdiff-interface.h
index f7f791d..dc305ba 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -11,6 +11,7 @@ struct xdiff_emit_state {
 	xdiff_emit_consume_fn consume;
 	char *remainder;
 	unsigned long remainder_size;
+	unsigned int suppress_blank_empty:1;
 };

 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
-- 
1.6.0.rc3.12.g5b095
