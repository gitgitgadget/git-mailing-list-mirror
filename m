From: Jim Meyering <meyering@redhat.com>
Subject: [PATCH] add boolean diff.suppress-blank-empty config option
Date: Tue, 19 Aug 2008 15:29:48 +0200
Message-ID: <87d4k5yvxv.fsf@rho.meyering.net>
References: <87k5eiphro.fsf@rho.meyering.net>
	<7vmyjam5xh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Paul Eggert <eggert@cs.ucla.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 15:31:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVRIU-000272-RD
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 15:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbYHSN3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 09:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbYHSN3v
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 09:29:51 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:44839 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbYHSN3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 09:29:50 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 6CD12197A2;
	Tue, 19 Aug 2008 15:29:49 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 50E1D19756;
	Tue, 19 Aug 2008 15:29:48 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id D4E8C38632; Tue, 19 Aug 2008 15:29:48 +0200 (CEST)
In-Reply-To: <7vmyjam5xh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 18 Aug 2008 13:20:10 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92857>


GNU diff's --suppress-blank-empty option makes it so that diff no
longer outputs trailing white space unless the input data has it.
With this option, empty context lines are now empty also in diff -u output.
Before, they would have a single trailing space.

* diff.c (diff_suppress_blank_empty): New global.
(git_diff_basic_config): Set it.
(fn_out_consume): Honor it.
* t/t4029-diff-trailing-space.sh: New file.
* Documentation/config.txt: Document it.
---
Junio C Hamano <gitster@pobox.com> wrote:
...
> I would have preferred the option to hook into a bit higher layer (namely,
> the part that actually writes textual diff to the output stream).

Good point.  I've done that.
Here's the result:

 Documentation/config.txt       |    4 ++++
 diff.c                         |   13 +++++++++++++
 t/t4029-diff-trailing-space.sh |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100755 t/t4029-diff-trailing-space.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 676c39b..9020675 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -567,6 +567,10 @@ diff.autorefreshindex::
 	affects only 'git-diff' Porcelain, and not lower level
 	'diff' commands, such as 'git-diff-files'.

+diff.suppress-blank-empty::
+	A boolean to inhibit the standard behavior of printing a space
+	before each empty output line. Defaults to false.
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/diff.c b/diff.c
index bf5d5f1..fe43407 100644
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
@@ -580,6 +587,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}

+	if (diff_suppress_blank_empty
+	    && len == 2 && line[0] == ' ' && line[1] == '\n') {
+		line[0] = '\n';
+		len = 1;
+	}
+
 	/* This is not really necessary for now because
 	 * this codepath only deals with two-way diffs.
 	 */
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
new file mode 100755
index 0000000..4ca65e0
--- /dev/null
+++ b/t/t4029-diff-trailing-space.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+#
+# Copyright (c) Jim Meyering
+#
+test_description='diff honors config option, diff.suppress-blank-empty'
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
--
1.6.0.4.g750768
