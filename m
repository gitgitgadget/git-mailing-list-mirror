From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] --color-words: Make the word characters configurable
Date: Sat, 3 May 2008 15:03:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805031501290.30431@racer>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com> <1209736766-8029-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 16:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsILU-0008Vn-9l
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 16:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbYECODV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 10:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYECODV
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 10:03:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:59827 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750712AbYECODU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 10:03:20 -0400
Received: (qmail invoked by alias); 03 May 2008 14:03:17 -0000
Received: from dslb-088-067-214-063.pools.arcor-ip.net (EHLO dslb-088-067-214-063.pools.arcor-ip.net) [88.67.214.63]
  by mail.gmx.net (mp041) with SMTP; 03 May 2008 16:03:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pzsYwiPhpBu5TVJoNP7nRzYKYdoD+tes9yoSNll
	oLp5PxtLhn7xMB
X-X-Sender: gene099@racer
In-Reply-To: <1209736766-8029-1-git-send-email-pkufranky@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81087>


Now, you can specify which characters are to be interpreted as word 
characters with "--color-words=A-Za-z", or by setting the config variable 
diff.wordCharacters.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I would have preferred an approach like this.

 Documentation/config.txt       |    6 ++++
 Documentation/diff-options.txt |    8 ++++-
 README                         |    2 +-
 diff.c                         |   64 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 05bf2df..663d82b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -546,6 +546,12 @@ diff.renames::
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
 
+diff.wordcharacters::
+	This config setting overrides which characters are interpreted as
+	word characters by the --color-words option of linkgit:git-diff[1].
++
+The default is: all ASCII characters excluding NUL to SPACE.
+
 fetch.unpackLimit::
 	If the number of objects fetched over the git native
 	transfer is below this
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 13234fa..88ea5d4 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -93,8 +93,14 @@ endif::git-format-patch[]
 	Turn off colored diff, even when the configuration file
 	gives the default to color output.
 
---color-words::
+--color-words[=<set>]::
 	Show colored word diff, i.e. color words which have changed.
++
+If a set of characters is specified, it is interpreted as the range of
+word characters.  Example: "0-9A-Fa-f".  As a convenience, "[:alnum:]"
+and "[:alpha:]" expand to alpha-numeric and alpha characters,
+respectively.  This argument overrides the config setting
+'diff.wordCharacters'.
 
 --no-renames::
 	Turn off rename detection, even when the configuration
diff --git a/README b/README
index 548142c..0e325e2 100644
--- a/README
+++ b/README
@@ -4,7 +4,7 @@
 
 ////////////////////////////////////////////////////////////////
 
-"git" can mean anything, depending on your mood.
+"git" cann mean anything, depending on your mood.
 
  - random three-letter combination that is pronounceable, and not
    actually used by any common UNIX command.  The fact that it is a
diff --git a/diff.c b/diff.c
index 3632b55..3e8719c 100644
--- a/diff.c
+++ b/diff.c
@@ -23,6 +23,20 @@ static int diff_rename_limit_default = 100;
 int diff_use_color_default = -1;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
+static char word_character[256] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+};
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
@@ -123,6 +137,44 @@ static int parse_funcname_pattern(const char *var, const char *ep, const char *v
 	return 0;
 }
 
+static void set_word_character_range(char start, char end)
+{
+	int i;
+	for (i = (unsigned char)start; i <= (unsigned char)end; i++)
+		word_character[i] = 1;
+}
+
+static int set_word_characters(const char *set)
+{
+	int previous_character = -1;
+
+	memset(word_character, 0, sizeof(word_character));
+
+	/* parse values like "0-9[:alnum:]" */
+	for (; *set; set++)
+		if (!prefixcmp(set, "[:alpha:]")) {
+			set_word_character_range('A', 'Z');
+			set_word_character_range('a', 'z');
+			previous_character = -1;
+			set += 8;
+		} else if (!prefixcmp(set, "[:alnum:]")) {
+			set_word_character_range('A', 'Z');
+			set_word_character_range('a', 'z');
+			set_word_character_range('0', '9');
+			previous_character = -1;
+			set += 8;
+		} else if (*set == '-' && previous_character >= 0) {
+			set++;
+			set_word_character_range(previous_character, *set);
+			previous_character = -1;
+		} else {
+			word_character[(unsigned int)*set] = 1;
+			previous_character = *set;
+		}
+
+	return 0;
+}
+
 /*
  * These are to give UI layer defaults.
  * The core-level commands such as git-diff-files should
@@ -179,6 +231,12 @@ int git_diff_basic_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.wordcharacters")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return set_word_characters(value);
+	}
+
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 		if (ep != var + 4) {
@@ -456,7 +514,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	plus.ptr = xmalloc(plus.size);
 	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
 	for (i = 0; i < plus.size; i++)
-		if (isspace(plus.ptr[i]))
+		if (!word_character[(unsigned char)plus.ptr[i]])
 			plus.ptr[i] = '\n';
 	diff_words->plus.current = 0;
 
@@ -2489,6 +2547,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, COLOR_DIFF);
 	else if (!strcmp(arg, "--color-words"))
 		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+	else if (!prefixcmp(arg, "--color-words=")) {
+		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+		set_word_characters(arg + 13);
+	}
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	else if (!strcmp(arg, "--quiet"))
-- 
1.5.5.1.266.g7cbb
