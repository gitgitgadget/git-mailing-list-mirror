From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 4/4] color-words: make regex configurable via attributes
Date: Wed, 14 Jan 2009 23:26:03 +0100
Message-ID: <b404fdfe0f5af535b35d1f239a68f6a7911ede19.1231971446.git.trast@student.ethz.ch>
References: <3ff3ccf6e3c1cd6a002d200aee5df88a197a7bf6.1231971446.git.trast@student.ethz.ch>
 <48504e8a330beca560208ce050d43bc92ac04c90.1231971446.git.trast@student.ethz.ch>
 <b1290f83267e64856e58477e0c19e920dd416c82.1231971446.git.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 23:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNEDH-0000kg-5n
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZANW0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbZANW0S
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:26:18 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:14595 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958AbZANW0O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:26:14 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:26:07 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:26:07 +0100
X-Mailer: git-send-email 1.6.1.142.ge070e
In-Reply-To: <b1290f83267e64856e58477e0c19e920dd416c82.1231971446.git.trast@student.ethz.ch>
In-Reply-To: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Jan 2009 22:26:07.0738 (UTC) FILETIME=[1858C5A0:01C97697]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105717>

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

Incorporates the last round of Dscho's suggestions.

 Documentation/diff-options.txt  |    4 ++
 Documentation/gitattributes.txt |   21 ++++++++++
 diff.c                          |   10 +++++
 t/t4034-diff-words.sh           |   49 ++++++++++++++++++++++--
 userdiff.c                      |   78 +++++++++++++++++++++++++++++++-------
 userdiff.h                      |    1 +
 6 files changed, 144 insertions(+), 19 deletions(-)

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
index 8af22ec..17707ba 100644
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
+A built-in pattern is provided for all languages listed in the last
+section.
+
+
 Performing text diffs of binary files
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/diff.c b/diff.c
index 3f07ac1..0e82e18 100644
--- a/diff.c
+++ b/diff.c
@@ -1372,6 +1372,12 @@ int diff_filespec_is_binary(struct diff_filespec *one)
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
@@ -1532,6 +1538,10 @@ static void builtin_diff(const char *name_a,
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
index 6ad1c1f..631ca44 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -22,8 +22,10 @@ decrypt_color () {
 
 word_diff () {
 	test_must_fail git diff --no-index "$@" pre post > output &&
-	decrypt_color < output > output.decrypted &&
-	test_cmp expect output.decrypted
+	decrypt_color < output > output.decrypted
+}
+word_diff_check () {
+	test_cmp "$1" output.decrypted
 }
 
 cat > pre <<\EOF
@@ -80,7 +82,45 @@ EOF
 
 test_expect_success 'word diff with a regular expression' '
 
-	word_diff --color-words="[a-z]+"
+	word_diff --color-words="[a-z]+" &&
+	word_diff_check expect
+
+'
+
+cat > expect-by-chars <<\EOF
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
+test_expect_success 'set a diff driver' '
+	git config diff.testdriver.wordregex "[^[:space:]]" &&
+	cat <<EOF > .gitattributes
+pre diff=testdriver
+post diff=testdriver
+EOF
+'
+
+test_expect_success 'use default supplied by driver' '
+
+	word_diff --color-words &&
+	word_diff_check expect-by-chars
+
+'
+
+test_expect_success 'option overrides default' '
+
+	word_diff --color-words="[a-z]+" &&
+	word_diff_check expect
 
 '
 
@@ -98,7 +138,8 @@ EOF
 
 test_expect_success "test parsing words for newline" '
 
-	word_diff --color-words="a+"
+	word_diff --color-words="a+" &&
+	word_diff_check expect
 
 '
 
diff --git a/userdiff.c b/userdiff.c
index 3681062..dbfda6d 100644
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
+	 "\\\\[a-zA-Z@]+|[{}]|\\\\.|[^\\{} \t]+"),
+PATTERNS("cpp",
+	 /* Jump targets or access declarations */
+	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
+	 /* C functions at top level */
+	 "^([A-Za-z_][A-Za-z_0-9]*([ \t]+[A-Za-z_][A-Za-z_0-9]*){1,}[ \t]*\\([^;]*)$\n"
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
1.6.1.142.ge070e
