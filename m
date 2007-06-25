From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Add core.quotepath configuration variable.
Date: Sun, 24 Jun 2007 17:11:05 -0700
Message-ID: <1182730265719-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 02:11:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2cAi-0000P3-A3
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 02:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbXFYALJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 20:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbXFYALH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 20:11:07 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47254 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbXFYALG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 20:11:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625001105.RKDR17635.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sun, 24 Jun 2007 20:11:05 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FcB51X00L1kojtg0000000; Sun, 24 Jun 2007 20:11:06 -0400
X-Mailer: git-send-email 1.5.2.2.1334.g1625
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50851>

We always quote "unusual" byte values in a pathname using
C-string style, to make it safer for parsing scripts that do not
handle NUL separated records well (or just too lazy to bother).
The absolute minimum bytes that need to be quoted for this
purpose are TAB, LF (and other control characters), double quote
and backslash.

However, we have also always quoted the bytes in high 8-bit
range; this was partly because we were lazy and partly because
we were being cautious.

This introduces an internal "quote_path_fully" variable, and
core.quotepath configuration variable to control it.  When set
to false, it does not quote bytes in high 8-bit range anymore
but passes them intact.

The variable defaults to "true" to retain the traditional
behaviour for now.  Maybe in later versions of git we might want
to change the default to false, so people need to explicitly ask
for safer quoting.  But that would be for a separate patch in
different timeframe.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |   12 ++++
 cache.h                  |    1 +
 config.c                 |    5 ++
 environment.c            |    1 +
 quote.c                  |    5 +-
 t/t3902-quoted.sh        |  126 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100755 t/t3902-quoted.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a2057d9..34b1c97 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -117,6 +117,18 @@ core.fileMode::
 	the working copy are ignored; useful on broken filesystems like FAT.
 	See gitlink:git-update-index[1]. True by default.
 
+core.quotepath::
+	The commands that output paths (e.g. `ls-files`,
+	`diff`), when not given the `-z` option, will quote
+	"unusual" characters in the pathname by enclosing the
+	pathname in a double-quote pair and with backslashes the
+	same way strings in C source code are quoted.  If this
+	variable is set to false, the bytes higher than 0x80 are
+	not quoted but output as verbatim.  Note that double
+	quote, backslash and control characters are always
+	quoted without `-z` regardless of the setting of this
+	variable.
+
 core.autocrlf::
 	If true, makes git convert `CRLF` at the end of lines in text files to
 	`LF` when reading from the filesystem, and convert in reverse when
diff --git a/cache.h b/cache.h
index ed83d92..6776357 100644
--- a/cache.h
+++ b/cache.h
@@ -292,6 +292,7 @@ extern int delete_ref(const char *, const unsigned char *sha1);
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
+extern int quote_path_fully;
 extern int has_symlinks;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
diff --git a/config.c b/config.c
index e323153..4de8926 100644
--- a/config.c
+++ b/config.c
@@ -271,6 +271,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.quotepath")) {
+		quote_path_fully = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.symlinks")) {
 		has_symlinks = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 8b9b89d..1c2773f 100644
--- a/environment.c
+++ b/environment.c
@@ -12,6 +12,7 @@
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
+int quote_path_fully = 1;
 int has_symlinks = 1;
 int assume_unchanged;
 int prefer_symlink_refs;
diff --git a/quote.c b/quote.c
index aa44009..d88bf75 100644
--- a/quote.c
+++ b/quote.c
@@ -188,7 +188,8 @@ static int quote_c_style_counted(const char *name, int namelen,
 #define EMITQ() EMIT('\\')
 
 	const char *sp;
-	int ch, count = 0, needquote = 0;
+	unsigned char ch;
+	int count = 0, needquote = 0;
 
 	if (!no_dq)
 		EMIT('"');
@@ -197,7 +198,7 @@ static int quote_c_style_counted(const char *name, int namelen,
 		if (!ch)
 			break;
 		if ((ch < ' ') || (ch == '"') || (ch == '\\') ||
-		    (ch >= 0177)) {
+		    (quote_path_fully && (ch >= 0177))) {
 			needquote = 1;
 			switch (ch) {
 			case '\a': EMITQ(); ch = 'a'; break;
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
new file mode 100755
index 0000000..63f950b
--- /dev/null
+++ b/t/t3902-quoted.sh
@@ -0,0 +1,126 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Junio C Hamano
+#
+
+test_description='quoted output'
+
+. ./test-lib.sh
+
+FN='濱野'
+GN='純'
+HT='	'
+LF='
+'
+DQ='"'
+
+for_each_name () {
+	for name in \
+	    Name "Name and a${LF}LF" "Name and an${HT}HT" "Name${DQ}" \
+	    "$FN$HT$GN" "$FN$LF$GN" "$FN $GN" "$FN$GN" "$FN$DQ$GN" \
+	    "With SP in it"
+	do
+		eval "$1"
+	done
+}
+
+test_expect_success setup '
+
+	for_each_name "echo initial >\"\$name\""
+	git add . &&
+	git commit -q -m Initial &&
+
+	for_each_name "echo second >\"\$name\"" &&
+	git commit -a -m Second
+
+	for_each_name "echo modified >\"\$name\""
+
+'
+
+cat >expect.quoted <<\EOF
+Name
+"Name and a\nLF"
+"Name and an\tHT"
+"Name\""
+With SP in it
+"\346\277\261\351\207\216\t\347\264\224"
+"\346\277\261\351\207\216\n\347\264\224"
+"\346\277\261\351\207\216 \347\264\224"
+"\346\277\261\351\207\216\"\347\264\224"
+"\346\277\261\351\207\216\347\264\224"
+EOF
+
+cat >expect.raw <<\EOF
+Name
+"Name and a\nLF"
+"Name and an\tHT"
+"Name\""
+With SP in it
+"濱野\t純"
+"濱野\n純"
+濱野 純
+"濱野\"純"
+濱野純
+EOF
+
+test_expect_success 'check fully quoted output from ls-files' '
+
+	git ls-files >current && diff -u expect.quoted current
+
+'
+
+test_expect_success 'check fully quoted output from diff-files' '
+
+	git diff --name-only >current &&
+	diff -u expect.quoted current
+
+'
+
+test_expect_success 'check fully quoted output from diff-index' '
+
+	git diff --name-only HEAD >current &&
+	diff -u expect.quoted current
+
+'
+
+test_expect_success 'check fully quoted output from diff-tree' '
+
+	git diff --name-only HEAD^ HEAD >current &&
+	diff -u expect.quoted current
+
+'
+
+test_expect_success 'setting core.quotepath' '
+
+	git config --bool core.quotepath false
+
+'
+
+test_expect_success 'check fully quoted output from ls-files' '
+
+	git ls-files >current && diff -u expect.raw current
+
+'
+
+test_expect_success 'check fully quoted output from diff-files' '
+
+	git diff --name-only >current &&
+	diff -u expect.raw current
+
+'
+
+test_expect_success 'check fully quoted output from diff-index' '
+
+	git diff --name-only HEAD >current &&
+	diff -u expect.raw current
+
+'
+
+test_expect_success 'check fully quoted output from diff-tree' '
+
+	git diff --name-only HEAD^ HEAD >current &&
+	diff -u expect.raw current
+
+'
+
+test_done
-- 
1.5.2.2.1334.g1625
