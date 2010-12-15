From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/4] diff.c: implement a sanity check for word regexes
Date: Wed, 15 Dec 2010 16:13:26 +0100
Message-ID: <cc4ccf1a93c4de1b3229730fcac1409ac70b9ae1.1292424926.git.trast@student.ethz.ch>
References: <cover.1292424926.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Scott Johnson <scottj75074@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:13:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSt2x-0005pJ-Ap
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851Ab0LOPNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 10:13:33 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:20879 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab0LOPNc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:13:32 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:13:22 +0100
Received: from localhost.localdomain (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:13:29 +0100
X-Mailer: git-send-email 1.7.3.3.807.g6ee1f
In-Reply-To: <cover.1292424926.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163780>

Word regexes are a bit of a dangerous beast, since it is easily
possible to not match a non-space part, which is subsequently ignored
for the purposes of emitting the word diff.  This was clearly stated
in the docs, but users still tripped over it.

Implement a safeguard that verifies two basic sanity assumptions:

* The word regex matches anything that is !isspace().

* The word regex does not match '\n'.  (This case is not very harmful,
  but we used to silently cut off at the '\n' which may go against
  user expectations.)

This is configurable via 'diff.wordRegexCheck', and defaults to
'warn'.

Reported-by: Scott Johnson <scottj75074@yahoo.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/config.txt |    8 ++++
 diff.c                   |   93 +++++++++++++++++++++++++++++++++++++++++++--
 diff.h                   |    1 +
 t/t4034-diff-words.sh    |   65 +++++++++++++++++++++++++++++++-
 4 files changed, 161 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf9479e..2e033ea 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -897,6 +897,14 @@ diff.wordRegex::
 	sequences that match the regular expression are "words", all other
 	characters are *ignorable* whitespace.
 
+diff.wordRegexCheck::
+	Perform a simple sanity check on matches of the word regex.
+	Currently this check ensures that the word regex matches all
+	non-space characters, and that the word regex does not match a
+	newline.  The setting controls what to do when the check
+	fails: 'false'/'off'/'ignore' ignore, 'true'/'on'/'warn' emit
+	a warning, and 'error' abort with an error message.
+
 fetch.recurseSubmodules::
 	A boolean value which changes the behavior for fetch and pull, the
 	default is to not recursively fetch populated sumodules unless
diff --git a/diff.c b/diff.c
index 8758a51..becefcf 100644
--- a/diff.c
+++ b/diff.c
@@ -22,11 +22,17 @@
 #define FAST_WORKING_DIRECTORY 1
 #endif
 
+#define REGEX_CHECK_UNSET -1
+#define REGEX_CHECK_OFF 0
+#define REGEX_CHECK_WARN 1
+#define REGEX_CHECK_ERROR 2
+
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = 200;
 static int diff_suppress_blank_empty;
 int diff_use_color_default = -1;
 static const char *diff_word_regex_cfg;
+static int diff_word_regex_check_cfg = REGEX_CHECK_UNSET;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
@@ -75,6 +81,19 @@ static int git_config_rename(const char *var, const char *value)
 	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
 }
 
+static int parse_regex_check_level(int *b, const char *k, const char *v)
+{
+	if (v && !strcasecmp(v, "ignore"))
+		*b = REGEX_CHECK_OFF;
+	else if (v && !strcasecmp(v, "warn"))
+		*b = REGEX_CHECK_WARN;
+	else if (v && !strcasecmp(v, "error"))
+		*b = REGEX_CHECK_ERROR;
+	else
+		*b = git_config_bool(k, v);
+	return 1;
+}
+
 /*
  * These are to give UI layer defaults.
  * The core-level commands such as git-diff-files should
@@ -107,6 +126,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!strcmp(var, "diff.wordregex"))
 		return git_config_string(&diff_word_regex_cfg, var, value);
+	if (!strcmp(var, "diff.wordregexcheck"))
+		return parse_regex_check_level(&diff_word_regex_check_cfg, var, value);
 
 	if (!strcmp(var, "diff.ignoresubmodules"))
 		handle_ignore_submodules_arg(&default_diff_options, value);
@@ -777,6 +798,50 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	diff_words->last_minus = minus_first;
 }
 
+
+static void check_word_regex_match(struct diff_words_data *diff_words,
+		char *start, int len, int unmatched)
+{
+	int check = diff_words->opt->word_regex_check;
+	void (*report_fn)(const char *, ...);
+
+	if (check == REGEX_CHECK_OFF)
+		return;
+
+	if (check == REGEX_CHECK_WARN)
+		report_fn = warning;
+	else if (check == REGEX_CHECK_ERROR)
+		report_fn = die;
+	else
+		assert(!"expected REGEX_CHECK_WARN or _ERROR");
+
+	if (unmatched) {
+		int i;
+		char *match_str;
+		for (i = 0; i < len; i++) {
+			if (isspace(start[i]))
+				continue;
+			match_str = xmemdupz(start, len);
+			report_fn("The following snippet contains non-space "
+				  "characters, but was not\nmatched by the "
+				  "word regex:\n'%s'\n"
+				  "They would be ignored for the purposes of "
+				  "the diff, which is\nusually not what you want.",
+				  match_str);
+			free(match_str);
+			break;
+		}
+	} else {
+		if (memchr(start, '\n', len)) {
+			char *match_str = xmemdupz(start, len);
+			report_fn("The following word regex match contains a newline "
+				  "and will be truncated there:\n'%s'",
+				  match_str);
+			free(match_str);
+		}
+	}
+}
+
 /* This function starts looking at *begin, and returns 0 iff a word was found. */
 static int find_word_boundaries(mmfile_t *buffer, struct diff_words_data *diff_words,
 		int *begin, int *end)
@@ -785,8 +850,15 @@ static int find_word_boundaries(mmfile_t *buffer, struct diff_words_data *diff_w
 		regmatch_t match[1];
 		if (!regexec(diff_words->word_regex, buffer->ptr + *begin,
 			     1, match, 0)) {
-			char *p = memchr(buffer->ptr + *begin + match[0].rm_so,
-					'\n', match[0].rm_eo - match[0].rm_so);
+			char *prev_start = buffer->ptr + *begin;
+			char *match_start = prev_start + match[0].rm_so;
+			int match_len = match[0].rm_eo - match[0].rm_so;
+			char *p;
+			check_word_regex_match(diff_words, prev_start,
+					       match_start-prev_start, 1);
+			check_word_regex_match(diff_words, match_start,
+					       match_len, 0);
+			p = memchr(match_start, '\n', match_len);
 			*end = p ? p - buffer->ptr : match[0].rm_eo + *begin;
 			*begin += match[0].rm_so;
 			return *begin >= *end;
@@ -829,7 +901,7 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 
 	for (i = 0; i < buffer->text.size; i++) {
 		if (find_word_boundaries(&buffer->text, diff_words, &i, &j))
-			return;
+			break;
 
 		/* store original boundaries */
 		ALLOC_GROW(buffer->orig, buffer->orig_nr + 1,
@@ -846,6 +918,11 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 
 		i = j - 1;
 	}
+
+	/* no more boundaries, check any non-matched chunk remaining */
+	if (i < buffer->text.size)
+		check_word_regex_match(diff_words, buffer->text.ptr + i,
+				       buffer->text.size-i, 1);
 }
 
 /* this executes the word diff on the accumulated buffers */
@@ -882,8 +959,8 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
-	diff_words_fill(&diff_words->minus, &minus, diff_words->word_regex);
-	diff_words_fill(&diff_words->plus, &plus, diff_words->word_regex);
+	diff_words_fill(&diff_words->minus, &minus, diff_words);
+	diff_words_fill(&diff_words->plus, &plus, diff_words);
 	xpp.flags = 0;
 	/* as only the hunk header will be parsed, we need a 0-context */
 	xecfg.ctxlen = 0;
@@ -2021,6 +2098,10 @@ static void builtin_diff(const char *name_a,
 				o->word_regex = userdiff_word_regex(two);
 			if (!o->word_regex)
 				o->word_regex = diff_word_regex_cfg;
+			if (o->word_regex_check == REGEX_CHECK_UNSET)
+				o->word_regex_check = diff_word_regex_check_cfg;
+			if (o->word_regex_check == REGEX_CHECK_UNSET)
+				o->word_regex_check = REGEX_CHECK_WARN;
 			if (o->word_regex) {
 				ecbdata.diff_words->word_regex = (regex_t *)
 					xmalloc(sizeof(regex_t));
@@ -2861,6 +2942,8 @@ void diff_setup(struct diff_options *options)
 		options->a_prefix = "a/";
 		options->b_prefix = "b/";
 	}
+
+	options->word_regex_check = REGEX_CHECK_UNSET;
 }
 
 int diff_setup_done(struct diff_options *options)
diff --git a/diff.h b/diff.h
index 165f368..5f6a7be 100644
--- a/diff.h
+++ b/diff.h
@@ -123,6 +123,7 @@ struct diff_options {
 	int stat_width;
 	int stat_name_width;
 	const char *word_regex;
+	int word_regex_check;
 	enum diff_words_type word_diff;
 
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 8096d8a..ebe72ce 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -8,7 +8,8 @@ test_expect_success setup '
 
 	git config diff.color.old red &&
 	git config diff.color.new green &&
-	git config diff.color.func magenta
+	git config diff.color.func magenta &&
+	git config diff.wordRegexCheck off
 
 '
 
@@ -331,4 +332,66 @@ test_expect_success '--word-diff=none' '
 
 '
 
+echo abcd > pre
+echo aXYd > post
+
+test_expect_success 'diff.wordRegexCheck="error" catches nonspaces' '
+
+	git config diff.wordRegexCheck error &&
+	test_must_fail git diff --no-index --word-diff-regex="a|d" pre post 2>out &&
+	grep "fatal.*contains non-space characters" out
+
+'
+
+newline="
+"
+
+test_expect_success 'diff.wordRegexCheck="error" catches newlines' '
+
+	git config diff.wordRegexCheck error &&
+	test_must_fail git diff --no-index --word-diff-regex=".|$newline" pre post 2>out &&
+	grep "fatal.*contains a newline" out
+
+'
+
+test_expect_success 'diff.wordRegexCheck="warn" works' '
+
+	git config diff.wordRegexCheck warn &&
+	test_must_fail git diff --no-index --word-diff-regex="a|d" pre post 2>out &&
+	grep "warning.*contains non-space characters" out
+
+'
+
+test_expect_success 'diff.wordRegexCheck="ignore" works' '
+
+	git config diff.wordRegexCheck ignore &&
+	test_must_fail git diff --no-index --word-diff-regex="a|d" pre post 2>out &&
+	! grep "contains non-space characters" out
+
+'
+
+test_expect_success 'diff.wordRegexCheck="false" is like "ignore"' '
+
+	git config diff.wordRegexCheck false &&
+	test_must_fail git diff --no-index --word-diff-regex="a|d" pre post 2>out &&
+	! grep "contains non-space characters" out
+
+'
+
+test_expect_success 'diff.wordRegexCheck="true" is like "warn"' '
+
+	git config diff.wordRegexCheck true &&
+	test_must_fail git diff --no-index --word-diff-regex="a|d" pre post 2>out &&
+	grep "warning.*contains non-space characters" out
+
+'
+
+test_expect_success 'diff.wordRegexCheck unset is like "warn"' '
+
+	git config --unset diff.wordRegexCheck &&
+	test_must_fail git diff --no-index --word-diff-regex="a|d" pre post 2>out &&
+	grep "warning.*contains non-space characters" out
+
+'
+
 test_done
-- 
1.7.3.3.807.g6ee1f
