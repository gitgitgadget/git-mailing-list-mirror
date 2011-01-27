From: Libor Pechacek <lpechacek@suse.cz>
Subject: [PATCH v3] Sanity-check config variable names
Date: Thu, 27 Jan 2011 15:28:15 +0100
Message-ID: <20110127142815.GC6312@fm.suse.cz>
References: <20110120232232.GA9442@sigill.intra.peff.net> <20110121000629.GA7773@sigill.intra.peff.net> <20110108144644.GA11019@localhost.suse.cz> <20110111055922.GD10094@sigill.intra.peff.net> <20110119100105.GB8034@fm.suse.cz> <20110119141112.GD8034@fm.suse.cz> <20110120232232.GA9442@sigill.intra.peff.net> <20110121100212.GE19715@fm.suse.cz> <20110121102339.GG19715@fm.suse.cz> <20110121162318.GC21840@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 27 15:28:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiSpk-00025i-Em
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 15:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab1A0O2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 09:28:17 -0500
Received: from cantor.suse.de ([195.135.220.2]:35895 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990Ab1A0O2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 09:28:16 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 7D30493717;
	Thu, 27 Jan 2011 15:28:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110121162318.GC21840@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165580>

Sanity-check config variable names when adding and retrieving them.  As a side
effect code duplication between git_config_set_multivar and get_value (in
builtin/config.c) was removed and the common functionality was placed in
git_config_parse_key.

This breaks a test in t1300 which used invalid section-less keys in the tests
for "git -c". However, allowing such names there was useless, since there was
no way to set them via config file, and no part of git actually tried to use
section-less keys. This patch updates the test to use more realistic examples.

Signed-off-by: Libor Pechacek <lpechacek@suse.cz>
Cc: Jeff King <peff@peff.net>
---

On Fri 21-01-11 11:23:19, Jeff King wrote:
> Typo: s/ckeck/check/
> 
> Other than that, this version looks good to me.

Fixed the typo and return values from get_value and git_config_set_multivar.
We have changed git_config_parse_key to return negative values on error, but
forgot to negate the numbers when returning them as exit codes.  That led to
process exit codes 255 and 254, which is, I think, unwanted.

> Acked-by: Jeff King <peff@peff.net>

Thanks.  Now I consider this patch truly final.

Libor

 builtin/config.c       |   18 ++++++--
 cache.h                |    1 +
 config.c               |  107 ++++++++++++++++++++++++++++++-----------------
 t/t1300-repo-config.sh |    7 +--
 4 files changed, 85 insertions(+), 48 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ca4a0db..66c0586 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -153,7 +153,6 @@ static int show_config(const char *key_, const char *value_, void *cb)
 static int get_value(const char *key_, const char *regex_)
 {
 	int ret = -1;
-	char *tl;
 	char *global = NULL, *repo_config = NULL;
 	const char *system_wide = NULL, *local;
 
@@ -168,17 +167,26 @@ static int get_value(const char *key_, const char *regex_)
 	}
 
 	key = xstrdup(key_);
-	for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
-		*tl = tolower(*tl);
-	for (tl=key; *tl && *tl != '.'; ++tl)
-		*tl = tolower(*tl);
 
 	if (use_key_regexp) {
+		char *tl;
+
+		/* TODO - this naive pattern lowercasing obviously does not
+		 * work for more complex patterns like `^[^.]*Foo.*bar' */
+		for (tl = key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
+			*tl = tolower(*tl);
+		for (tl = key; *tl && *tl != '.'; ++tl)
+			*tl = tolower(*tl);
+
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid key pattern: %s\n", key_);
 			goto free_strings;
 		}
+	} else {
+		ret = -git_config_parse_key(key_, &key, NULL);
+		if (ret)
+			goto free_strings;
 	}
 
 	if (regex_) {
diff --git a/cache.h b/cache.h
index d83d68c..1e32d63 100644
--- a/cache.h
+++ b/cache.h
@@ -997,6 +997,7 @@ extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set(const char *, const char *);
+extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
diff --git a/config.c b/config.c
index 625e051..c976544 100644
--- a/config.c
+++ b/config.c
@@ -1098,6 +1098,72 @@ int git_config_set(const char *key, const char *value)
 	return git_config_set_multivar(key, value, NULL, 0);
 }
 
+/* Auxiliary function to sanity-check and split the key into the section
+ * identifier and variable name.
+ *
+ * Returns 0 on success, -1 when there is an invalid character in the key and
+ * -2 if there is no section name in the key.
+ *
+ * store_key - pointer to char* which will hold a copy of the key with
+ *             lowercase section and variable name, can be NULL
+ * baselen - pointer to int which will hold the length of the
+ *           section + subsection part, can be NULL
+ */
+int git_config_parse_key(const char *key, char **store_key, int *baselen_)
+{
+	int i, dot, baselen;
+	const char *last_dot = strrchr(key, '.');
+
+	/*
+	 * Since "key" actually contains the section name and the real
+	 * key name separated by a dot, we have to know where the dot is.
+	 */
+
+	if (last_dot == NULL) {
+		error("key does not contain a section: %s", key);
+		return -2;
+	}
+
+	baselen = last_dot - key;
+	if (baselen_)
+		*baselen_ = baselen;
+
+	/*
+	 * Validate the key and while at it, lower case it for matching.
+	 */
+	if (store_key)
+		*store_key = xmalloc(strlen(key) + 1);
+
+	dot = 0;
+	for (i = 0; key[i]; i++) {
+		unsigned char c = key[i];
+		if (c == '.')
+			dot = 1;
+		/* Leave the extended basename untouched.. */
+		if (!dot || i > baselen) {
+			if (!iskeychar(c) || (i == baselen+1 && !isalpha(c))) {
+				error("invalid key: %s", key);
+				goto out_free_ret_1;
+			}
+			c = tolower(c);
+		} else if (c == '\n') {
+			error("invalid key (newline): %s", key);
+			goto out_free_ret_1;
+		}
+		if (store_key)
+			(*store_key)[i] = c;
+	}
+	if (store_key)
+		(*store_key)[i] = 0;
+
+	return 0;
+
+out_free_ret_1:
+	if (store_key)
+		free(*store_key);
+	return -1;
+}
+
 /*
  * If value==NULL, unset in (remove from) config,
  * if value_regex!=NULL, disregard key/value pairs where value does not match.
@@ -1124,59 +1190,22 @@ int git_config_set(const char *key, const char *value)
 int git_config_set_multivar(const char *key, const char *value,
 	const char *value_regex, int multi_replace)
 {
-	int i, dot;
 	int fd = -1, in_fd;
 	int ret;
 	char *config_filename;
 	struct lock_file *lock = NULL;
-	const char *last_dot = strrchr(key, '.');
 
 	if (config_exclusive_filename)
 		config_filename = xstrdup(config_exclusive_filename);
 	else
 		config_filename = git_pathdup("config");
 
-	/*
-	 * Since "key" actually contains the section name and the real
-	 * key name separated by a dot, we have to know where the dot is.
-	 */
-
-	if (last_dot == NULL) {
-		error("key does not contain a section: %s", key);
-		ret = 2;
+	ret = -git_config_parse_key(key, &store.key, &store.baselen);
+	if (ret)
 		goto out_free;
-	}
-	store.baselen = last_dot - key;
 
 	store.multi_replace = multi_replace;
 
-	/*
-	 * Validate the key and while at it, lower case it for matching.
-	 */
-	store.key = xmalloc(strlen(key) + 1);
-	dot = 0;
-	for (i = 0; key[i]; i++) {
-		unsigned char c = key[i];
-		if (c == '.')
-			dot = 1;
-		/* Leave the extended basename untouched.. */
-		if (!dot || i > store.baselen) {
-			if (!iskeychar(c) || (i == store.baselen+1 && !isalpha(c))) {
-				error("invalid key: %s", key);
-				free(store.key);
-				ret = 1;
-				goto out_free;
-			}
-			c = tolower(c);
-		} else if (c == '\n') {
-			error("invalid key (newline): %s", key);
-			free(store.key);
-			ret = 1;
-			goto out_free;
-		}
-		store.key[i] = c;
-	}
-	store.key[i] = 0;
 
 	/*
 	 * The lock serves a purpose in addition to locking: the new
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index d0e5546..3e79c37 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -876,11 +876,10 @@ test_expect_success 'check split_cmdline return' "
 	"
 
 test_expect_success 'git -c "key=value" support' '
-	test "z$(git -c name=value config name)" = zvalue &&
 	test "z$(git -c core.name=value config core.name)" = zvalue &&
-	test "z$(git -c CamelCase=value config camelcase)" = zvalue &&
-	test "z$(git -c flag config --bool flag)" = ztrue &&
-	test_must_fail git -c core.name=value config name
+	test "z$(git -c foo.CamelCase=value config foo.camelcase)" = zvalue &&
+	test "z$(git -c foo.flag config --bool foo.flag)" = ztrue &&
+	test_must_fail git -c name=value config core.name
 '
 
 test_done
-- 
1.7.4.rc3.2.g27487
