From: Libor Pechacek <lpechacek@suse.cz>
Subject: [PATCH] Sanity-ckeck config variable names
Date: Wed, 19 Jan 2011 15:11:12 +0100
Message-ID: <20110119141112.GD8034@fm.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz> <20110111055922.GD10094@sigill.intra.peff.net> <20110119100105.GB8034@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 15:11:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfYkr-0003eY-CF
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 15:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab1ASOLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 09:11:14 -0500
Received: from cantor.suse.de ([195.135.220.2]:52726 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850Ab1ASOLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 09:11:13 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 9FF8B93A00;
	Wed, 19 Jan 2011 15:11:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110119100105.GB8034@fm.suse.cz>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165268>

Sanity-ckeck config variable names when adding and retrieving them.

As a side effect code duplication between git_config_set_multivar and get_value
(in builtin/config.c) was removed and the common functionality was placed in
git_config_parse_key.

The regular expression patterns are left intact when using --get-regexp option.

Signed-off-by: Libor Pechacek <lpechacek@suse.cz>
Cc: Jeff King <peff@peff.net>
---
 builtin/config.c |    8 ++---
 cache.h          |    1 +
 config.c         |  106 ++++++++++++++++++++++++++++++++++--------------------
 3 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ca4a0db..068ef76 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -153,7 +153,6 @@ static int show_config(const char *key_, const char *value_, void *cb)
 static int get_value(const char *key_, const char *regex_)
 {
 	int ret = -1;
-	char *tl;
 	char *global = NULL, *repo_config = NULL;
 	const char *system_wide = NULL, *local;
 
@@ -168,10 +167,6 @@ static int get_value(const char *key_, const char *regex_)
 	}
 
 	key = xstrdup(key_);
-	for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
-		*tl = tolower(*tl);
-	for (tl=key; *tl && *tl != '.'; ++tl)
-		*tl = tolower(*tl);
 
 	if (use_key_regexp) {
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
@@ -179,6 +174,9 @@ static int get_value(const char *key_, const char *regex_)
 			fprintf(stderr, "Invalid key pattern: %s\n", key_);
 			goto free_strings;
 		}
+	} else {
+		if (git_config_parse_key(key_, &key, NULL))
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
index 625e051..205282f 100644
--- a/config.c
+++ b/config.c
@@ -1098,6 +1098,72 @@ int git_config_set(const char *key, const char *value)
 	return git_config_set_multivar(key, value, NULL, 0);
 }
 
+/* Auxiliary function to sanity-check and split the key into the section
+ * identifier and variable name.
+ *
+ * Returns 0 on success, 1 when there is an invalid character in the key and 2
+ * if there is no section name in the key.
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
+		return 2;
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
+	return 1;
+}
+
 /*
  * If value==NULL, unset in (remove from) config,
  * if value_regex!=NULL, disregard key/value pairs where value does not match.
@@ -1124,59 +1190,21 @@ int git_config_set(const char *key, const char *value)
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
+	if ((ret = git_config_parse_key(key, &store.key, &store.baselen)))
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
-- 
1.7.4.rc2.2.gb4f4f
