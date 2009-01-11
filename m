From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 3/4] word diff: make regex configurable via attributes
Date: Sun, 11 Jan 2009 11:27:13 +0100
Message-ID: <72242bd75fa8d55c2afc723f8539ef56f2569d3e.1231669012.git.trast@student.ethz.ch>
References: <cover.1231669012.git.trast@student.ethz.ch>
 <4aea85caafd38a058145c5769fe8a30ffdbd4d13.1231669012.git.trast@student.ethz.ch>
 <529cd830908f018f796dbc46d3b055c1f8ba9c1b.1231669012.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 11:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLxYh-0002rW-2L
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 11:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbZAKK1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 05:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZAKK1V
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 05:27:21 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:42017 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbZAKK1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 05:27:18 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 11:27:05 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 11:27:05 +0100
X-Mailer: git-send-email 1.6.1.279.g41f0
In-Reply-To: <529cd830908f018f796dbc46d3b055c1f8ba9c1b.1231669012.git.trast@student.ethz.ch>
In-Reply-To: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
References: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 11 Jan 2009 10:27:05.0369 (UTC) FILETIME=[26407090:01C973D7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105163>

Make the --color-words splitting regular expression configurable via
the diff driver's 'wordregex' attribute.  The user can then set the
driver on a file in .gitattributes.  If a regex is given on the
command line, it overrides the driver's setting.

We also provide built-in regexes for some of the languages that
already had funcname patterns.  (They are designed to run UTF-8
sequences into a single chunk to make sure they remain readable.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/diff-options.txt  |    4 +++-
 Documentation/gitattributes.txt |   21 +++++++++++++++++++++
 diff.c                          |   10 ++++++++++
 userdiff.c                      |   27 +++++++++++++++++++--------
 userdiff.h                      |    1 +
 5 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6152d5b..d22c06b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -96,7 +96,9 @@ endif::git-format-patch[]
 	By default, a new word only starts at whitespace, so that a
 	'word' is defined as a maximal sequence of non-whitespace
 	characters.  The optional argument <regex> can be used to
-	configure this.
+	configure this.  It can also be set via a diff driver, see
+	linkgit:gitattributes[1]; if a <regex> is given explicitly, it
+	overrides any diff driver setting.
 +
 The <regex> must be an (extended) regular expression.  When set, every
 non-overlapping match of the <regex> is considered a word.  (Regular
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8af22ec..67f5522 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -334,6 +334,27 @@ patterns are available:
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
+	wordregex = "\\\\[a-zA-Z]+|[{}]|\\\\.|[^\\{} \t]+"
+------------------------
+
+Similar to 'xfuncname', a built in value is provided for the drivers
+`bibtex`, `html`, `java`, `php`, `python` and `tex`.  See the
+documentation of --color-words in linkgit:git-diff[1] for the precise
+semantics.
+
+
 Performing text diffs of binary files
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/diff.c b/diff.c
index badaea6..c1cc426 100644
--- a/diff.c
+++ b/diff.c
@@ -1548,6 +1548,12 @@ static const struct userdiff_funcname *diff_funcname_pattern(struct diff_filespe
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
@@ -1708,6 +1714,10 @@ static void builtin_diff(const char *name_a,
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
diff --git a/userdiff.c b/userdiff.c
index 3681062..7fd9a07 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -6,13 +6,17 @@ static struct userdiff_driver *drivers;
 static int ndrivers;
 static int drivers_alloc;
 
-#define FUNCNAME(name, pattern) \
+#define FUNCNAME(name, pattern)			\
 	{ name, NULL, -1, { pattern, REG_EXTENDED } }
+#define PATTERNS(name, pattern, wordregex)			\
+	{ name, NULL, -1, { pattern, REG_EXTENDED }, NULL, wordregex }
 static struct userdiff_driver builtin_drivers[] = {
-FUNCNAME("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$"),
-FUNCNAME("java",
+PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
+	 "[^<>= \t]+|\\S"),
+PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$"),
+	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
+	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[-+*/]=|\\+\\+|--|\\S|[\x80-\xff]+"),
 FUNCNAME("objc",
 	 /* Negate C statements that can look like functions */
 	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
@@ -27,14 +31,19 @@ FUNCNAME("pascal",
 		"implementation|initialization|finalization)[ \t]*.*)$"
 	 "\n"
 	 "^(.*=[ \t]*(class|record).*)$"),
-FUNCNAME("php", "^[\t ]*((function|class).*)"),
-FUNCNAME("python", "^[ \t]*((class|def)[ \t].*)$"),
+PATTERNS("php", "^[\t ]*((function|class).*)",
+	 "\\$?[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[-+*/]=|\\+\\+|--|->|\\S|[\x80-\xff]+"),
+PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
+	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[-+*/]=|//|\\S|[\x80-\xff]+"),
 FUNCNAME("ruby", "^[ \t]*((class|module|def)[ \t].*)$"),
-FUNCNAME("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$"),
-FUNCNAME("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$"),
+PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
+	 "[={}\"]|[^={}\" \t]+"),
+PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
+	 "\\\\[a-zA-Z@]+|[{}]|\\\\.|[^\\{} \t]+"),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef FUNCNAME
+#undef PATTERNS
 
 static struct userdiff_driver driver_true = {
 	"diff=true",
@@ -134,6 +143,8 @@ int userdiff_config(const char *k, const char *v)
 		return parse_string(&drv->external, k, v);
 	if ((drv = parse_driver(k, v, "textconv")))
 		return parse_string(&drv->textconv, k, v);
+	if ((drv = parse_driver(k, v, "wordregex")))
+		return parse_string(&drv->word_regex, k, v);
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index ba29457..2aab13e 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -12,6 +12,7 @@ struct userdiff_driver {
 	int binary;
 	struct userdiff_funcname funcname;
 	const char *textconv;
+	const char *word_regex;
 };
 
 int userdiff_config(const char *k, const char *v);
-- 
1.6.1.269.g0769
