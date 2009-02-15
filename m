From: demerphq <demerphq@gmail.com>
Subject: [PATCH] git diff ignore-space options should ignore missing EOL at 
	EOF differences
Date: Sun, 15 Feb 2009 15:09:12 +0100
Message-ID: <9b18b3110902150609q13333619k98f87a4a36a09030@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, davidel@xmailserver.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 15 15:10:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYhhj-0002TG-59
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 15:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZBOOJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 09:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbZBOOJO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 09:09:14 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:47942 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbZBOOJN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 09:09:13 -0500
Received: by qyk4 with SMTP id 4so2536126qyk.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 06:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=IolwuTC61GuXBg6q7wHqZvi6yBekrAKnyJXSdyEs0fM=;
        b=IhyuHoT2sBx35ykZIzjZt6dckh0WCv9SegA4Ab1sZRDjNx2qtgbfA5WUFnJtuTj+DN
         PyBp/UzrGcdMH+hZvscP2QYV5YA8bAoK5ZYuwjQ4lxaKkiGPtxMr/YjPq1+0iaeCweK1
         dHYz1s+THI6DEvt44DOmC54JSG0tRcAQy3QiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=W6Pw9qkPh6lWW6LdkfgVokHibTUkJNKKz17+YUX4sXdjJCbEaHjfPPNTlglQjkLA/Y
         E5EuAA0re3K6nd9BRvFY445nPOqwMFriJqz4vNBTO+p3o10GCUJoVDGhBCcu5OX0sPp8
         8KZQVctS1c6NLeQEW/R6I1asmushSEsexAS5g=
Received: by 10.224.45.204 with SMTP id g12mr1434744qaf.174.1234706952145; 
	Sun, 15 Feb 2009 06:09:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110011>

Fix bug where the diff library complains about missing EOL at EOF
mismatches even when run under the various ignore whitespace options.

Unfortunately the routine that needs the whitespace flags doesn't get
passed them directly, and is part of the API for the diff library, so
can't be modified.

Therefore it seems the best solution is to modify the xdemitcb_t struct
so that the flags are available inside the emit routine and then copy
them over at a suitable point in the call tree to ensure that they are
always the same.

This also adds a new flag to control this behavior independently of the
other whitespace options, and a new switch '--ignore-space-at-eof' to
git diff to expose the flag, as well as some slight clarifying language
to document the implications of the different whitespace options.

Also includes new tests to exercise each of the possible whitespace
options and verify that the EOF mismatch detection works as expected,
and is correctly suppressed by the relevant options.

Signed-off-by: Yves Orton <demerphq@gmail.com>
---
 Documentation/diff-options.txt         |    9 ++-
 contrib/completion/git-completion.bash |    1 +
 diff.c                                 |    2 +
 t/t4015-diff-whitespace.sh             |   79 ++++++++++++++++++++++++++++++++
 xdiff/xdiff.h                          |   10 ++++-
 xdiff/xdiffi.c                         |    3 +
 xdiff/xutils.c                         |    5 ++-
 7 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 813a7b1..6bc40e5 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -207,14 +207,17 @@ override configuration settings.
 --text::
 	Treat all files as text.

+--ignore-space-at-eof::
+	Ignore changes in whitespace at EOF.
+
 --ignore-space-at-eol::
-	Ignore changes in whitespace at EOL.
+	Ignore changes in whitespace at EOL (including EOF).

 -b::
 --ignore-space-change::
 	Ignore changes in amount of whitespace.  This ignores whitespace
-	at line end, and considers all other sequences of one or
-	more whitespace characters to be equivalent.
+	at line and file end, and considers all other sequences of one
+	or more whitespace characters to be equivalent.

 -w::
 --ignore-all-space::
diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 412d2c0..5c6b942 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -801,6 +801,7 @@ __git_diff_common_options="--stat --numstat
--shortstat --summary
 			--full-index --binary --abbrev --diff-filter=
 			--find-copies-harder
 			--text --ignore-space-at-eol --ignore-space-change
+			--ignore-space-at-eof
 			--ignore-all-space --exit-code --quiet --ext-diff
 			--no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
diff --git a/diff.c b/diff.c
index 006aa01..51a0c90 100644
--- a/diff.c
+++ b/diff.c
@@ -2572,6 +2572,8 @@ int diff_opt_parse(struct diff_options *options,
const char **av, int ac)
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(arg, "--ignore-space-at-eof"))
+		options->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOF;
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts |= XDF_PATIENCE_DIFF;

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6d13da3..1ba851e 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -51,6 +51,85 @@ test_expect_success "Ray's example with -w"
'test_cmp expect out'
 git diff -b > out
 test_expect_success "Ray's example with -b" 'test_cmp expect out'

+# newline at eof tests (original has no newline)
+IGNORE_SPACE_AT_EOF_OPTS="-w -b --ignore-all-space
--ignore-space-change --ignore-space-at-eol --ignore-space-at-eof"
+tr -d "\n" << EOF > x
+this file has no newline at end of file
+EOF
+
+git update-index x
+
+cat << EOF > x
+this file does have a newline at the end of file
+EOF
+
+cat << EOF > expect
+diff --git a/x b/x
+index 7668968..95ce259 100644
+--- a/x
++++ b/x
+@@ -1 +1 @@
+-this file has no newline at end of file
++this file does have a newline at the end of file
+EOF
+for opt in $IGNORE_SPACE_AT_EOF_OPTS; do
+    git diff $opt > out
+    test_expect_success "diff $opt must not warn about trailing
whitespace (add newline case)" 'test_cmp expect out'
+done
+
+cat << EOF > expect
+diff --git a/x b/x
+index 7668968..95ce259 100644
+--- a/x
++++ b/x
+@@ -1 +1 @@
+-this file has no newline at end of file
+\ No newline at end of file
++this file does have a newline at the end of file
+EOF
+git diff > out
+test_expect_success 'standard diff must warn about trailing
whitespace (add newline case)' 'test_cmp expect out'
+
+# newline at eof tests (replacement has no newline)
+cat << EOF > x
+this file does have a newline at the end of file
+EOF
+
+git update-index x
+
+tr -d "\n" << EOF > x
+this file has no newline at end of file
+EOF
+
+cat << EOF > expect
+diff --git a/x b/x
+index 95ce259..7668968 100644
+--- a/x
++++ b/x
+@@ -1 +1 @@
+-this file does have a newline at the end of file
++this file has no newline at end of file
+EOF
+for opt in $IGNORE_SPACE_AT_EOF_OPTS; do
+    git diff $opt > out
+    test_expect_success "diff $opt must not warn about trailing
whitespace (remove newline case)" 'test_cmp expect out'
+done
+
+cat << EOF > expect
+diff --git a/x b/x
+index 95ce259..7668968 100644
+--- a/x
++++ b/x
+@@ -1 +1 @@
+-this file does have a newline at the end of file
++this file has no newline at end of file
+\ No newline at end of file
+EOF
+git diff > out
+test_expect_success 'plain diff must warn about trailing whitespace
(remove newline case)' 'test_cmp expect out'
+
+# end newline at eof tests
+
 tr 'Q' '\015' << EOF > x
 whitespace at beginning
 whitespace change
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 4da052a..00367af 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -33,7 +33,14 @@ extern "C" {
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
 #define XDF_PATIENCE_DIFF (1 << 5)
-#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE |
XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
+#define XDF_IGNORE_WHITESPACE_AT_EOF (1 << 6)
+/*
+ * note this is deliberately a different define from XDF_WHITESPACE_FLAGS as
+ * there could be a new whitespace related flag which would not be part of
+ * the XDF_IGNORE_WHITESPACE_AT_EOF_ANY flags.
+ */
+#define XDF_IGNORE_WHITESPACE_AT_EOF_ANY
(XDF_IGNORE_WHITESPACE_AT_EOL | XDF_IGNORE_WHITESPACE_CHANGE |
XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_AT_EOF)
+#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE |
XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL |
XDF_IGNORE_WHITESPACE_AT_EOF)

 #define XDL_PATCH_NORMAL '-'
 #define XDL_PATCH_REVERSE '+'
@@ -79,6 +86,7 @@ typedef struct s_xpparam {
 typedef struct s_xdemitcb {
 	void *priv;
 	int (*outf)(void *, mmbuffer_t *, int);
+	long flags; /* whitespace flags */
 } xdemitcb_t;

 typedef long (*find_func_t)(const char *line, long line_len, char
*buffer, long buffer_size, void *priv);
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 3e97462..93dd284 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -556,6 +556,9 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2,
xpparam_t const *xpp,
 		return -1;
 	}
 	if (xscr) {
+		/* copy the whitespace flags over so they can be made available
+		 * to emit api code that only gets ecb */
+		ecb->flags = xpp->flags;
 		if (ef(&xe, xscr, ecb, xecfg) < 0) {

 			xdl_free_script(xscr);
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 04ad468..88591b7 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -52,7 +52,10 @@ int xdl_emit_diffrec(char const *rec, long size,
char const *pre, long psize,
 	mb[1].ptr = (char *) rec;
 	mb[1].size = size;
 	if (size > 0 && rec[size - 1] != '\n') {
-		mb[2].ptr = (char *) "\n\\ No newline at end of file\n";
+		if (ecb->flags & XDF_IGNORE_WHITESPACE_AT_EOF_ANY)
+			mb[2].ptr = (char *) "\n";
+		else
+			mb[2].ptr = (char *) "\n\\ No newline at end of file\n";
 		mb[2].size = strlen(mb[2].ptr);
 		i++;
 	}
-- 
1.6.0.3
