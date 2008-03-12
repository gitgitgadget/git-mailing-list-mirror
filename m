From: Jeff King <peff@peff.net>
Subject: [PATCH 11/16] config: add --literal-match option
Date: Wed, 12 Mar 2008 17:40:19 -0400
Message-ID: <20080312214019.GL26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:41:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYh8-0002CO-Hm
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbYCLVkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbYCLVkX
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:40:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2678 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbYCLVkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:40:22 -0400
Received: (qmail 3532 invoked by uid 111); 12 Mar 2008 21:40:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:40:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:40:19 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77002>

When limiting the values to be set (or returned), the user
previously had the option of specifying a regex. In some
cases, however, they may want to find a literal value. The
option --literal-match converts any matching regex into a
literal string comparison.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this is a nice addition regardless, but it is used by the next
patch.

The patch is about twice as long as it needs to be since getting and
setting in builtin-config follow two almost-the-same parallel codepaths.
I suspect this could be cleaned up, but I didn't look too closely.

 Documentation/git-config.txt |    7 ++++
 builtin-config.c             |   50 +++++++++++++++++++++++--------
 builtin-remote.c             |    2 +-
 cache.h                      |    2 +-
 config.c                     |   67 ++++++++++++++++++++++++++++--------------
 t/t1300-repo-config.sh       |   13 ++++++++
 6 files changed, 104 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index fa16171..5dc1af2 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -152,6 +152,13 @@ See also <<FILES>>.
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
 
+--literal-match::
+
+	Some invocations of git-config will limit their actions based on
+	matching a config value to a regular expression. If this option
+	is used, then any such matches are done as a string comparison
+	rather than as a regular expression match.
+
 [[FILES]]
 FILES
 -----
diff --git a/builtin-config.c b/builtin-config.c
index 2b9a426..ed318dc 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -8,6 +8,7 @@ static const char git_config_set_usage[] =
 static char *key;
 static regex_t *key_regexp;
 static regex_t *regexp;
+const char *value_match;
 static int show_keys;
 static int use_key_regexp;
 static int do_all;
@@ -17,6 +18,7 @@ static char delim = '=';
 static char key_delim = ' ';
 static char term = '\n';
 static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
+static int literal_match = 0;
 
 static int show_all_config(const char *key_, const char *value_)
 {
@@ -40,6 +42,9 @@ static int show_config(const char* key_, const char* value_)
 	if (regexp != NULL &&
 	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
 		return 0;
+	if (value_match != NULL &&
+		do_not_match ^ !!strcmp(value_match, (value_ ? value_ : "")))
+		return 0;
 
 	if (show_keys) {
 		if (value_)
@@ -66,7 +71,7 @@ static int show_config(const char* key_, const char* value_)
 	return 0;
 }
 
-static int get_value(const char* key_, const char* regex_)
+static int get_value(const char* key_, const char* match_)
 {
 	int ret = -1;
 	char *tl;
@@ -99,18 +104,28 @@ static int get_value(const char* key_, const char* regex_)
 		}
 	}
 
-	if (regex_) {
-		if (regex_[0] == '!') {
+	if (match_ && literal_match) {
+		value_match = match_;
+		do_not_match = 0;
+		regexp = NULL;
+	}
+	else if(match_) {
+		value_match = NULL;
+		if (match_[0] == '!') {
 			do_not_match = 1;
-			regex_++;
+			match_++;
 		}
 
 		regexp = (regex_t*)xmalloc(sizeof(regex_t));
-		if (regcomp(regexp, regex_, REG_EXTENDED)) {
-			fprintf(stderr, "Invalid pattern: %s\n", regex_);
+		if (regcomp(regexp, match_, REG_EXTENDED)) {
+			fprintf(stderr, "Invalid pattern: %s\n", match_);
 			goto free_strings;
 		}
 	}
+	else {
+		value_match = NULL;
+		regexp = NULL;
+	}
 
 	if (do_all && system_wide)
 		git_config_from_file(show_config, system_wide);
@@ -339,6 +354,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return get_color(argc-2, argv+2);
 		} else if (!strcmp(argv[1], "--get-colorbool")) {
 			return get_colorbool(argc-2, argv+2);
+		} else if (!strcmp(argv[1], "--literal-match")) {
+			literal_match = 1;
 		} else
 			break;
 		argc--;
@@ -352,7 +369,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[1], "--unset"))
 			return git_config_set(argv[2], NULL);
 		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, NULL, 1);
+			return git_config_set_multivar(argv[2], NULL, NULL,
+					literal_match, 1);
 		else if (!strcmp(argv[1], "--get"))
 			return get_value(argv[2], NULL);
 		else if (!strcmp(argv[1], "--get-all")) {
@@ -369,9 +387,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		}
 	case 4:
 		if (!strcmp(argv[1], "--unset"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 0);
+			return git_config_set_multivar(argv[2], NULL, argv[3],
+					literal_match, 0);
 		else if (!strcmp(argv[1], "--unset-all"))
-			return git_config_set_multivar(argv[2], NULL, argv[3], 1);
+			return git_config_set_multivar(argv[2], NULL, argv[3],
+					literal_match, 1);
 		else if (!strcmp(argv[1], "--get"))
 			return get_value(argv[2], argv[3]);
 		else if (!strcmp(argv[1], "--get-all")) {
@@ -384,18 +404,22 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return get_value(argv[2], argv[3]);
 		} else if (!strcmp(argv[1], "--add")) {
 			value = normalize_value(argv[2], argv[3]);
-			return git_config_set_multivar(argv[2], value, "^$", 0);
+			return git_config_set_multivar(argv[2], value, "^$",
+					0, 0);
 		} else if (!strcmp(argv[1], "--replace-all")) {
 			value = normalize_value(argv[2], argv[3]);
-			return git_config_set_multivar(argv[2], value, NULL, 1);
+			return git_config_set_multivar(argv[2], value, NULL,
+					0, 1);
 		} else {
 			value = normalize_value(argv[1], argv[2]);
-			return git_config_set_multivar(argv[1], value, argv[3], 0);
+			return git_config_set_multivar(argv[1], value, argv[3],
+				       literal_match, 0);
 		}
 	case 5:
 		if (!strcmp(argv[1], "--replace-all")) {
 			value = normalize_value(argv[2], argv[3]);
-			return git_config_set_multivar(argv[2], value, argv[4], 1);
+			return git_config_set_multivar(argv[2], value, argv[4],
+					literal_match, 1);
 		}
 	case 1:
 	default:
diff --git a/builtin-remote.c b/builtin-remote.c
index 24e6929..4eae74b 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -107,7 +107,7 @@ static int add(int argc, const char **argv)
 		else
 			strbuf_addf(&buf2, "refs/heads/%s:refs/remotes/%s/%s",
 					item->path, name, item->path);
-		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
+		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0, 0))
 			return 1;
 	}
 
diff --git a/cache.h b/cache.h
index 2a1e7ec..30830b0 100644
--- a/cache.h
+++ b/cache.h
@@ -695,7 +695,7 @@ extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_set(const char *, const char *);
-extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_config_set_multivar(const char *, const char *, const char *, int, int);
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value);
diff --git a/config.c b/config.c
index 0624494..862b0e6 100644
--- a/config.c
+++ b/config.c
@@ -575,7 +575,15 @@ static struct {
 	int baselen;
 	char* key;
 	int do_not_match;
-	regex_t* value_regex;
+	enum {
+		VALUE_NONE,
+		VALUE_REGEX,
+		VALUE_STRING,
+	} value_type;
+	union {
+		regex_t* regex;
+		const char *string;
+	} value;
 	int multi_replace;
 	size_t offset[MAX_MATCHES];
 	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
@@ -584,10 +592,19 @@ static struct {
 
 static int matches(const char* key, const char* value)
 {
-	return !strcmp(key, store.key) &&
-		(store.value_regex == NULL ||
-		 (store.do_not_match ^
-		  !regexec(store.value_regex, value, 0, NULL, 0)));
+	if (strcmp(key, store.key))
+		return 0;
+	switch(store.value_type) {
+	case VALUE_NONE:
+		return 1;
+	case VALUE_REGEX:
+		return store.do_not_match ^
+			!regexec(store.value.regex, value, 0, NULL, 0);
+	case VALUE_STRING:
+		return store.do_not_match ^
+			!strcmp(value, store.value.string);
+	}
+	die("bug in config.c:matches");
 }
 
 static int store_aux(const char* key, const char* value)
@@ -764,12 +781,12 @@ contline:
 
 int git_config_set(const char* key, const char* value)
 {
-	return git_config_set_multivar(key, value, NULL, 0);
+	return git_config_set_multivar(key, value, NULL, 0, 0);
 }
 
 /*
  * If value==NULL, unset in (remove from) config,
- * if value_regex!=NULL, disregard key/value pairs where value does not match.
+ * if value_match!=NULL, disregard key/value pairs where value does not match.
  * if multi_replace==0, nothing, or only one matching key/value is replaced,
  *     else all matching key/values (regardless how many) are removed,
  *     before the new pair is written.
@@ -791,7 +808,7 @@ int git_config_set(const char* key, const char* value)
  *
  */
 int git_config_set_multivar(const char* key, const char* value,
-	const char* value_regex, int multi_replace)
+	const char* value_match, int literal_match, int multi_replace)
 {
 	int i, dot;
 	int fd = -1, in_fd;
@@ -892,21 +909,27 @@ int git_config_set_multivar(const char* key, const char* value,
 		size_t contents_sz, copy_begin, copy_end;
 		int i, new_line = 0;
 
-		if (value_regex == NULL)
-			store.value_regex = NULL;
+		if (value_match == NULL)
+			store.value_type = VALUE_NONE;
+		else if(literal_match) {
+			store.value_type = VALUE_STRING;
+			store.do_not_match = 0;
+			store.value.string = value_match;
+		}
 		else {
-			if (value_regex[0] == '!') {
+			store.value_type = VALUE_REGEX;
+			if (value_match[0] == '!') {
 				store.do_not_match = 1;
-				value_regex++;
+				value_match++;
 			} else
 				store.do_not_match = 0;
 
-			store.value_regex = (regex_t*)xmalloc(sizeof(regex_t));
-			if (regcomp(store.value_regex, value_regex,
+			store.value.regex = (regex_t*)xmalloc(sizeof(regex_t));
+			if (regcomp(store.value.regex, value_match,
 					REG_EXTENDED)) {
 				fprintf(stderr, "Invalid pattern: %s\n",
-					value_regex);
-				free(store.value_regex);
+					value_match);
+				free(store.value.regex);
 				ret = 6;
 				goto out_free;
 			}
@@ -925,18 +948,18 @@ int git_config_set_multivar(const char* key, const char* value,
 		if (git_config_from_file(store_aux, config_filename)) {
 			fprintf(stderr, "invalid config file\n");
 			free(store.key);
-			if (store.value_regex != NULL) {
-				regfree(store.value_regex);
-				free(store.value_regex);
+			if (store.value_type == VALUE_REGEX) {
+				regfree(store.value.regex);
+				free(store.value.regex);
 			}
 			ret = 3;
 			goto out_free;
 		}
 
 		free(store.key);
-		if (store.value_regex != NULL) {
-			regfree(store.value_regex);
-			free(store.value_regex);
+		if (store.value_type == VALUE_REGEX) {
+			regfree(store.value.regex);
+			free(store.value.regex);
 		}
 
 		/* if nothing to unset, or too many matches, error out */
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index b36a901..6c5ccdd 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -682,4 +682,17 @@ test_expect_success 'symlinked configuration' '
 
 '
 
+test_expect_success 'literal matching works' '
+
+	git config literal.key1 value &&
+	git config literal.key2 va..e &&
+	git config --get-regexp "literal..*" va..e >output &&
+	grep key1 output &&
+	grep key2 output &&
+	git config --literal-match --get-regexp "literal..*" va..e >output &&
+	! grep key1 output &&
+	grep key2 output
+
+'
+
 test_done
-- 
1.5.4.4.543.g30fdd.dirty
