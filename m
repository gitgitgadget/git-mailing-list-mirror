From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: [PATCH] color-words: Support diff.color-words config option
Date: Tue, 20 Jan 2009 21:46:57 -0600
Message-ID: <200901202146.58651.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901192145.21115.bss@iguanasuicide.net> <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 04:48:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPU4s-0006ji-K9
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 04:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351AbZAUDrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 22:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757056AbZAUDrF
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 22:47:05 -0500
Received: from eastrmmtao106.cox.net ([68.230.240.48]:36245 "EHLO
	eastrmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050AbZAUDrD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 22:47:03 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090121034701.JGBJ29613.eastrmmtao106.cox.net@eastrmimpo03.cox.net>;
          Tue, 20 Jan 2009 22:47:01 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 63mz1b0092i4SyG023n0qF; Tue, 20 Jan 2009 22:47:00 -0500
X-Authority-Analysis: v=1.0 c=1 a=T31XgCmOaw4A:10 a=5AhbXMf4u1YA:10
 a=Fq1VQ0LPAAAA:8 a=bOESGWKfyi8mm03IdEQA:9 a=1-8i6pu89AImRIXP_zoA:7
 a=0w4MGIYx5i1zqvy9l9v7C3oxeOkA:4 a=T3brmoaXcPoA:10 a=hpF-ijbX5cwA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPU3O-000IRx-U0; Tue, 20 Jan 2009 21:46:59 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
X-Eric-Conspiracy: There is no conspiracy
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106565>

When diff is invoked with --color-words (w/o =regex), use the regular
expression the user has configured as diff.wordregex.

diff drivers configured via attributes take precedence over the
diff.wordregex-words setting.  If the user wants to change them, they have
their own configuration variables.

Signed-off-by: Boyd Stephen Smith Jr <bss@iguanasuicide.net>
---
This version is squashed into one patch and includes documentation and
rewritten tests.  It was generated against js/diff-color-words~2,
80c49c3d (color-words: make regex configurable via attributes), replacing
my previous 2 patches.  It uses "diff.wordregex" for reasons mention by
Dscho and because that was already what the diff drivers were using.

I'm not entirely satisfied with it.  There should probably be some way
to force the default behavior (which is a bit faster) even if a global
config or diff driver exists.  Also, I think camelCase is better than
runtogether so I'd prefer to change "wordregex" -> "wordRegex" across
the entire patch set.

 Documentation/config.txt       |    6 +++++
 Documentation/diff-options.txt |    7 +++--
 diff.c                         |    5 ++++
 t/t4034-diff-words.sh          |   45 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7408bb2..0ca983a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -639,6 +639,12 @@ diff.suppress-blank-empty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
 
+diff.wordregex::
+	A POSIX Extended Regular Expression used to determine what is a "word"
+	when performing word-by-word difference calculations.  Character
+	sequences that match the regular expression are "words", all other
+	characters are *ignorable* whitespace.
+
 fetch.unpackLimit::
 	If the number of objects fetched over the git native
 	transfer is below this
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 1edb82e..164e2c5 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -103,9 +103,10 @@ expression to make sure that it matches all non-whitespace characters.
 A match that contains a newline is silently truncated(!) at the
 newline.
 +
-The regex can also be set via a diff driver, see
-linkgit:gitattributes[1]; giving it explicitly overrides any diff
-driver setting.
+The regex can also be set via a diff driver or configuration option, see
+linkgit:gitattributes[1] or linkgit:git-config[1].  Giving it explicitly
+overrides any diff driver or configuration setting.  Diff drivers
+override configuration settings.
 
 --no-renames::
 	Turn off rename detection, even when the configuration
diff --git a/diff.c b/diff.c
index 9fcde96..ed8b83c 100644
--- a/diff.c
+++ b/diff.c
@@ -23,6 +23,7 @@ static int diff_detect_rename_default;
 static int diff_rename_limit_default = 200;
 static int diff_suppress_blank_empty;
 int diff_use_color_default = -1;
+static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
@@ -92,6 +93,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
+	if (!strcmp(var, "diff.wordregex"))
+		return git_config_string(&diff_word_regex_cfg, var, value);
 
 	return git_diff_basic_config(var, value, cb);
 }
@@ -1550,6 +1553,8 @@ static void builtin_diff(const char *name_a,
 				o->word_regex = userdiff_word_regex(one);
 			if (!o->word_regex)
 				o->word_regex = userdiff_word_regex(two);
+			if (!o->word_regex)
+				o->word_regex = diff_word_regex_cfg;
 			if (o->word_regex) {
 				ecbdata.diff_words->word_regex = (regex_t *)
 					xmalloc(sizeof(regex_t));
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 744221b..6bcc153 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -77,6 +77,7 @@ a = b + c<RESET>
 
 <GREEN>aeff = aeff * ( aaa<RESET> )
 EOF
+cp expect expect.letter-runs-are-words
 
 test_expect_success 'word diff with a regular expression' '
 
@@ -92,7 +93,7 @@ post diff=testdriver
 EOF
 '
 
-test_expect_success 'option overrides default' '
+test_expect_success 'option overrides .gitattributes' '
 
 	word_diff --color-words="[a-z]+"
 
@@ -112,13 +113,53 @@ a = b + c<RESET>
 
 <GREEN>aeff = aeff * ( aaa )<RESET>
 EOF
+cp expect expect.non-whitespace-is-word
 
-test_expect_success 'use default supplied by driver' '
+test_expect_success 'use regex supplied by driver' '
 
 	word_diff --color-words
 
 '
 
+test_expect_success 'set diff.wordregex option' '
+	git config diff.wordregex "[[:alnum:]]+"
+'
+
+cp expect.letter-runs-are-words expect
+
+test_expect_success 'command-line overrides config' '
+	word_diff --color-words="[a-z]+"
+'
+
+cp expect.non-whitespace-is-word expect
+
+test_expect_success '.gitattributes override config' '
+	word_diff --color-words
+'
+
+test_expect_success 'remove diff driver regex' '
+	git config --unset diff.testdriver.wordregex
+'
+
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index 330b04f..5ed8eff 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
+<BROWN>@@ -1,3 +1,7 @@<RESET>
+h(4),<GREEN>hh[44<RESET>]
+<RESET>
+a = b + c<RESET>
+
+<GREEN>aa = a<RESET>
+
+<GREEN>aeff = aeff * ( aaa<RESET> )
+EOF
+
+test_expect_success 'use configured regex' '
+	word_diff --color-words
+'
+
 echo 'aaa (aaa)' > pre
 echo 'aaa (aaa) aaa' > post
 
-- 
1.5.6.5
-- 
Boyd Stephen Smith Jr.                     ,= ,-_-. =. 
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-' 
http://iguanasuicide.net/                      \_/     
