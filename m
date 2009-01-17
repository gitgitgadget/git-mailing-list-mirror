From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 7/7] color-words: make regex configurable via attributes
Date: Sat, 17 Jan 2009 17:29:48 +0100
Message-ID: <1232209788-10408-8-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-2-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-3-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-4-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-5-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-6-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-7-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:31:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOE5N-00087b-5D
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763661AbZAQQaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763512AbZAQQ36
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:29:58 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8904 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763382AbZAQQ3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:29:48 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:41 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:41 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232209788-10408-7-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:29:41.0190 (UTC) FILETIME=[CC35C660:01C978C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106081>

Make the --color-words splitting regular expression configurable via
the diff driver's 'wordregex' attribute.  The user can then set the
driver on a file in .gitattributes.  If a regex is given on the
command line, it overrides the driver's setting.

We also provide built-in regexes for the languages that already had
funcname patterns, and add an appropriate diff driver entry for C/++.
(The patterns are designed to run UTF-8 sequences into a single chunk
to make sure they remain readable.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/diff-options.txt  |    4 ++
 Documentation/gitattributes.txt |   21 ++++++++++
 diff.c                          |   10 +++++
 t/t4034-diff-words.sh           |   36 ++++++++++++++++++
 userdiff.c                      |   78 +++++++++++++++++++++++++++++++-------
 userdiff.h                      |    1 +
 6 files changed, 135 insertions(+), 15 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 8689a92..1edb82e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -102,6 +102,10 @@ differences.  You may want to append `|[^[:space:]]` to your regular
 expression to make sure that it matches all non-whitespace characters.
 A match that contains a newline is silently truncated(!) at the
 newline.
++
+The regex can also be set via a diff driver, see
+linkgit:gitattributes[1]; giving it explicitly overrides any diff
+driver setting.
 
 --no-renames::
 	Turn off rename detection, even when the configuration
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8af22ec..ba3ba12 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -317,6 +317,8 @@ patterns are available:
 
 - `bibtex` suitable for files with BibTeX coded references.
 
+- `cpp` suitable for source code in the C and C++ languages.
+
 - `html` suitable for HTML/XHTML documents.
 
 - `java` suitable for source code in the Java language.
@@ -334,6 +336,25 @@ patterns are available:
 - `tex` suitable for source code for LaTeX documents.
 
 
+Customizing word diff
+^^^^^^^^^^^^^^^^^^^^^
+
+You can customize the rules that `git diff --color-words` uses to
+split words in a line, by specifying an appropriate regular expression
+in the "diff.*.wordregex" configuration variable.  For example, in TeX
+a backslash followed by a sequence of letters forms a command, but
+several such commands can be run together without intervening
+whitespace.  To separate them, use a regular expression such as
+
+------------------------
+[diff "tex"]
+	wordregex = "\\\\[a-zA-Z]+|[{}]|\\\\.|[^\\{}[:space:]]+"
+------------------------
+
+A built-in pattern is provided for all languages listed in the
+previous section.
+
+
 Performing text diffs of binary files
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/diff.c b/diff.c
index 00c661f..9fcde96 100644
--- a/diff.c
+++ b/diff.c
@@ -1380,6 +1380,12 @@ int diff_filespec_is_binary(struct diff_filespec *one)
 	return one->driver->funcname.pattern ? &one->driver->funcname : NULL;
 }
 
+static const char *userdiff_word_regex(struct diff_filespec *one)
+{
+	diff_filespec_load_driver(one);
+	return one->driver->word_regex;
+}
+
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b)
 {
 	if (!options->a_prefix)
@@ -1540,6 +1546,10 @@ static void builtin_diff(const char *name_a,
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
 			ecbdata.diff_words->file = o->file;
+			if (!o->word_regex)
+				o->word_regex = userdiff_word_regex(one);
+			if (!o->word_regex)
+				o->word_regex = userdiff_word_regex(two);
 			if (o->word_regex) {
 				ecbdata.diff_words->word_regex = (regex_t *)
 					xmalloc(sizeof(regex_t));
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 4873486..744221b 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -84,6 +84,41 @@ test_expect_success 'word diff with a regular expression' '
 
 '
 
+test_expect_success 'set a diff driver' '
+	git config diff.testdriver.wordregex "[^[:space:]]" &&
+	cat <<EOF > .gitattributes
+pre diff=testdriver
+post diff=testdriver
+EOF
+'
+
+test_expect_success 'option overrides default' '
+
+	word_diff --color-words="[a-z]+"
+
+'
+
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index 330b04f..5ed8eff 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
+<BROWN>@@ -1,3 +1,7 @@<RESET>
+h(4)<GREEN>,hh[44]<RESET>
+<RESET>
+a = b + c<RESET>
+
+<GREEN>aa = a<RESET>
+
+<GREEN>aeff = aeff * ( aaa )<RESET>
+EOF
+
+test_expect_success 'use default supplied by driver' '
+
+	word_diff --color-words
+
+'
+
 echo 'aaa (aaa)' > pre
 echo 'aaa (aaa) aaa' > post
 
@@ -100,6 +135,7 @@ test_expect_success 'test parsing words for newline' '
 
 	word_diff --color-words="a+"
 
+
 '
 
 echo '(:' > pre
diff --git a/userdiff.c b/userdiff.c
index 3681062..2b55509 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -6,14 +6,20 @@
 static int ndrivers;
 static int drivers_alloc;
 
-#define FUNCNAME(name, pattern) \
-	{ name, NULL, -1, { pattern, REG_EXTENDED } }
+#define PATTERNS(name, pattern, wordregex)			\
+	{ name, NULL, -1, { pattern, REG_EXTENDED }, wordregex }
 static struct userdiff_driver builtin_drivers[] = {
-FUNCNAME("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$"),
-FUNCNAME("java",
+PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
+	 "[^<>= \t]+|[^[:space:]]|[\x80-\xff]+"),
+PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$"),
-FUNCNAME("objc",
+	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	 "|[-+*/<>%&^|=!]="
+	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"
+	 "|[^[:space:]]|[\x80-\xff]+"),
+PATTERNS("objc",
 	 /* Negate C statements that can look like functions */
 	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
 	 /* Objective-C methods */
@@ -21,20 +27,60 @@
 	 /* C functions */
 	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$\n"
 	 /* Objective-C class/protocol definitions */
-	 "^(@(implementation|interface|protocol)[ \t].*)$"),
-FUNCNAME("pascal",
+	 "^(@(implementation|interface|protocol)[ \t].*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
+	 "|[^[:space:]]|[\x80-\xff]+"),
+PATTERNS("pascal",
 	 "^((procedure|function|constructor|destructor|interface|"
 		"implementation|initialization|finalization)[ \t]*.*)$"
 	 "\n"
-	 "^(.*=[ \t]*(class|record).*)$"),
-FUNCNAME("php", "^[\t ]*((function|class).*)"),
-FUNCNAME("python", "^[ \t]*((class|def)[ \t].*)$"),
-FUNCNAME("ruby", "^[ \t]*((class|module|def)[ \t].*)$"),
-FUNCNAME("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$"),
-FUNCNAME("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$"),
+	 "^(.*=[ \t]*(class|record).*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
+	 "|<>|<=|>=|:=|\\.\\."
+	 "|[^[:space:]]|[\x80-\xff]+"),
+PATTERNS("php", "^[\t ]*((function|class).*)",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
+	 "|[-+*/<>%&^|=!.]=|--|\\+\\+|<<=?|>>=?|===|&&|\\|\\||::|->"
+	 "|[^[:space:]]|[\x80-\xff]+"),
+PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
+	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"
+	 "|[^[:space:]|[\x80-\xff]+"),
+	 /* -- */
+PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
+	 /* -- */
+	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
+	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"
+	 "|[^[:space:]|[\x80-\xff]+"),
+PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
+	 "[={}\"]|[^={}\" \t]+"),
+PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
+	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+|[^[:space:]]"),
+PATTERNS("cpp",
+	 /* Jump targets or access declarations */
+	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
+	 /* C/++ functions/methods at top level */
+	 "^([A-Za-z_][A-Za-z_0-9]*([ \t]+[A-Za-z_][A-Za-z_0-9]*([ \t]*::[ \t]*[^[:space:]]+)?){1,}[ \t]*\\([^;]*)$\n"
+	 /* compound type at top level */
+	 "^((struct|class|enum)[^;]*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
+	 "|[^[:space:]]|[\x80-\xff]+"),
 { "default", NULL, -1, { NULL, 0 } },
 };
-#undef FUNCNAME
+#undef PATTERNS
 
 static struct userdiff_driver driver_true = {
 	"diff=true",
@@ -134,6 +180,8 @@ int userdiff_config(const char *k, const char *v)
 		return parse_string(&drv->external, k, v);
 	if ((drv = parse_driver(k, v, "textconv")))
 		return parse_string(&drv->textconv, k, v);
+	if ((drv = parse_driver(k, v, "wordregex")))
+		return parse_string(&drv->word_regex, k, v);
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index ba29457..c315159 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -11,6 +11,7 @@ struct userdiff_driver {
 	const char *external;
 	int binary;
 	struct userdiff_funcname funcname;
+	const char *word_regex;
 	const char *textconv;
 };
 
-- 
1.6.1.315.g92577
