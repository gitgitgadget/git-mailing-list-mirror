From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 4/6] --color-words: Make non-word characters configurable
Date: Sun,  4 May 2008 12:20:13 +0800
Message-ID: <1209874815-14411-5-git-send-email-pkufranky@gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-4-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 06:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsVip-0004qs-JV
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 06:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbYEDEU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 00:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbYEDEUY
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 00:20:24 -0400
Received: from mail.qikoo.org ([60.28.205.235]:54657 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750840AbYEDEUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 00:20:19 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 2133E470B1; Sun,  4 May 2008 12:20:15 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209874815-14411-4-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81127>

Previously --color-words only allow spaces as non-word characters.
However, just space is not enough. For example, when i rename a function
from foo to bar, following example doesn't show as expected when using
--color-words.

  - if (foo(arg))
  + if (bar(arg))

Assuming "r" and "g" represent "red" and "green" separately. It shows as

  if <r>(foo(arg))</r><g>(foo(arg))</g>

Actually, it's the best to show as

  if (<r>foo</r><g>bar</g>(arg))

This patch introduces a configuration diff.nonwordchars to allow configurable
non-word characters (both spaces and chars in diff.nonwordchars)
for --color-words.

Now, with diff.nonwordchars set to "()", the example above will show as

  if (<r>foo(</r><g>bar(</g>arg))

It's much better, athough not the best,

NOTE:

With current implementation (i.e. to replace non word characters with
LF before feeding into xdi_diff), we can't get the best output.

A more sensible implementation is to use 'insert' instead of 'replace'.
Say, to insert a line break between runs of word characters and non-word
characters or between non-word characters.

That is, "foo>=bar" will be rewritten as "foo\n>\n=\nbar" instead of
"foo\n\nbar".

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 Documentation/config.txt       |    4 ++++
 Documentation/diff-options.txt |    1 +
 diff.c                         |   12 +++++++++++-
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 824e416..812ec2c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -537,6 +537,10 @@ diff.external::
 	program only on a subset of your files, you might want to
 	use linkgit:gitattributes[5] instead.
 
+diff.nonwordchars::
+	Specify additional boundary characters other than spaces for
+	--color-words.
+
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the git diff option '-l'.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 13234fa..70acc14 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -95,6 +95,7 @@ endif::git-format-patch[]
 
 --color-words::
 	Show colored word diff, i.e. color words which have changed.
+	The non-word characters can be configured with diff.nonwordchars.
 
 --no-renames::
 	Turn off rename detection, even when the configuration
diff --git a/diff.c b/diff.c
index c7a0d77..eb7c086 100644
--- a/diff.c
+++ b/diff.c
@@ -23,6 +23,7 @@ static int diff_rename_limit_default = 100;
 int diff_use_color_default = -1;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
+static const char *diff_non_word_chars = "";
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
@@ -159,6 +160,10 @@ int git_diff_ui_config(const char *var, const char *value)
 		external_diff_cmd_cfg = xstrdup(value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.nonwordchars")) {
+		diff_non_word_chars = value ? xstrdup(value) : "";
+		return 0;
+	}
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 
@@ -443,6 +448,11 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	}
 }
 
+static int is_non_word_char(char c)
+{
+	return isspace(c) || !!strchr(diff_non_word_chars, c);
+}
+
 static void mmfile_copy_set_boundary(mmfile_t *dest, mmfile_t *src) {
 	int i;
 
@@ -450,7 +460,7 @@ static void mmfile_copy_set_boundary(mmfile_t *dest, mmfile_t *src) {
 	dest->ptr = xmalloc(dest->size);
 	memcpy(dest->ptr, src->ptr, dest->size);
 	for (i = 0; i < dest->size; i++)
-		if (isspace(dest->ptr[i]))
+		if (is_non_word_char(dest->ptr[i]))
 			dest->ptr[i] = '\n';
 }
 
-- 
1.5.5.1.121.g26b3
