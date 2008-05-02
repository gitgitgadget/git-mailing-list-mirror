From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] Make boundary characters for --color-words configurable
Date: Fri,  2 May 2008 21:59:26 +0800
Message-ID: <1209736766-8029-1-git-send-email-pkufranky@gmail.com>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 16:00:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrvoC-0005LG-Aj
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 16:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763357AbYEBN7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 09:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762862AbYEBN7c
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 09:59:32 -0400
Received: from mail.qikoo.org ([60.28.205.235]:51428 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759486AbYEBN7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 09:59:31 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 4FD25470AE; Fri,  2 May 2008 21:59:26 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.117.g73010
In-Reply-To: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80999>

Previously --color-words only allow spaces as boundary characters.
However, just space is not enough. For example, when i rename a function
from foo to bar, following example doesn't show as expected when using
--color-words.

------------------
- if (foo(arg))
+ if (bar(arg))
------------------

It shows as "if <r>(foo(arg))</r><g>(foo(arg))</g>". Actually, it's the
best to show as "if (<r>foo</r><g>bar</g>(arg))". Here "r" and "g"
represent "red" and "green" separately.

This patch introduces a configuration diff.nonwordchars to make
--color-words treat both spaces and characters in diff.nonwordchars as
boundary characters.

If we set diff.nonwordchars to "()", the example above will show as
"if (<r>foo(</r><g>bar(</g>arg))". It's much better, athough not the best,

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
>>  In general, my opinion is that with international text it's better to
>>  define word boundary characters than trying to maintain a _huge_ list of
>>  characters used within words in different human languages.
>>
>
> Agreed, there is no easy way to designate such a huge list of
> non-ascii characters. Even if we figure out one way, the user may
> still be scared by such a huge list or the character class syntax.
> 
> I think doing this complex both the implementation and the representation.
> 
> Instead, if using non word characters, the user only needs specify a
> small list of characters (ascii or wide character). instead of the
> nearly whole set.

Two changes:

* Rename diff.wordsboundary to diff.nonwordchars
* Add documentation

 Documentation/config.txt |    4 ++++
 diff.c                   |   14 ++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 824e416..eb05592 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -546,6 +546,10 @@ diff.renames::
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
 
+diff.nonwordchars::
+    Specify additional boundary characters other than spaces for
+    --color-words.
+
 fetch.unpackLimit::
 	If the number of objects fetched over the git native
 	transfer is below this
diff --git a/diff.c b/diff.c
index 3632b55..e48466d 100644
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
 
@@ -434,6 +439,11 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	}
 }
 
+static int is_non_word_char(char c)
+{
+	return isspace(c) || !!strchr(diff_non_word_chars, c);
+}
+
 /* this executes the word diff on the accumulated buffers */
 static void diff_words_show(struct diff_words_data *diff_words)
 {
@@ -448,7 +458,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	minus.ptr = xmalloc(minus.size);
 	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
 	for (i = 0; i < minus.size; i++)
-		if (isspace(minus.ptr[i]))
+		if (is_non_word_char(minus.ptr[i]))
 			minus.ptr[i] = '\n';
 	diff_words->minus.current = 0;
 
@@ -456,7 +466,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	plus.ptr = xmalloc(plus.size);
 	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
 	for (i = 0; i < plus.size; i++)
-		if (isspace(plus.ptr[i]))
+		if (is_non_word_char(plus.ptr[i]))
 			plus.ptr[i] = '\n';
 	diff_words->plus.current = 0;
 
-- 
1.5.5.1.117.g73010
