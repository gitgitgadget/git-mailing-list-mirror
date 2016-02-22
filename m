From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 14/15] config: rename git_config_set to git_config_set_gently
Date: Mon, 22 Feb 2016 12:23:35 +0100
Message-ID: <1456140216-24169-15-git-send-email-ps@pks.im>
References: <1456140216-24169-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:25:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXoc4-0000ln-Jv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbcBVLY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:24:56 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48097 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754693AbcBVLYw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 06:24:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 60B1720C47
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 06:24:52 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 22 Feb 2016 06:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=1Rw6
	WLVF9K1Tdk4ZjlvaUENZ//E=; b=TJGQifa1hizv4docI6YVzC1XD7BOJZv69D2B
	k1ZVAkyJInH5ZdSn6xSLvHJJ1+zQ+2sqlOg8iLCqwO+NctEg1vqWugrIDE/UTVtF
	o5Csn4MMizfI95tQCuW9nvjUS/z7680q8LUgaJakMc/Jpzoem6mIWu4f34OxaswG
	X8nK3KU=
X-Sasl-enc: 6rZotnYJewqu8uiHqWhGhJ4dckCIYhPAzAQRPe76TAAM 1456140291
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id E1B276800FE;
	Mon, 22 Feb 2016 06:24:51 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456140216-24169-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286918>

The desired default behavior for `git_config_set` is to die
whenever an error occurs. Dying is the default for a lot of
internal functions when failures occur and is in this case the
right thing to do for most callers as otherwise we might run into
inconsistent repositories without noticing.

As some code may rely on the actual return values for
`git_config_set` we still require the ability to invoke these
functions without aborting. Rename the existing `git_config_set`
functions to `git_config_set_gently` to keep them available for
those callers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c         |  6 +++---
 builtin/clone.c  |  2 +-
 builtin/config.c | 28 ++++++++++++++--------------
 builtin/remote.c |  2 +-
 cache.h          | 10 +++++-----
 config.c         | 29 +++++++++++++++--------------
 submodule.c      |  2 +-
 7 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/branch.c b/branch.c
index 713ceda..c50ea42 100644
--- a/branch.c
+++ b/branch.c
@@ -70,18 +70,18 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	}
 
 	strbuf_addf(&key, "branch.%s.remote", local);
-	if (git_config_set(key.buf, origin ? origin : ".") < 0)
+	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
 		goto out_err;
 
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
-	if (git_config_set(key.buf, remote) < 0)
+	if (git_config_set_gently(key.buf, remote) < 0)
 		goto out_err;
 
 	if (rebasing) {
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
-		if (git_config_set(key.buf, "true") < 0)
+		if (git_config_set_gently(key.buf, "true") < 0)
 			goto out_err;
 	}
 	strbuf_release(&key);
diff --git a/builtin/clone.c b/builtin/clone.c
index 164038a..38094d4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -735,7 +735,7 @@ static int checkout(void)
 
 static int write_one_config(const char *key, const char *value, void *data)
 {
-	return git_config_set_multivar(key, value ? value : "true", "^$", 0);
+	return git_config_set_multivar_gently(key, value ? value : "true", "^$", 0);
 }
 
 static void write_config(struct string_list *config)
diff --git a/builtin/config.c b/builtin/config.c
index adc7727..c26d6e7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -582,7 +582,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		ret = git_config_set_in_file(given_config_source.file, argv[0], value);
+		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s.", argv[0]);
@@ -592,23 +592,23 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value, argv[2], 0);
+		return git_config_set_multivar_in_file_gently(given_config_source.file,
+							      argv[0], value, argv[2], 0);
 	}
 	else if (actions == ACTION_ADD) {
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value,
-						       CONFIG_REGEX_NONE, 0);
+		return git_config_set_multivar_in_file_gently(given_config_source.file,
+							      argv[0], value,
+							      CONFIG_REGEX_NONE, 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value, argv[2], 1);
+		return git_config_set_multivar_in_file_gently(given_config_source.file,
+							      argv[0], value, argv[2], 1);
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -634,17 +634,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 1, 2);
 		if (argc == 2)
-			return git_config_set_multivar_in_file(given_config_source.file,
-							       argv[0], NULL, argv[1], 0);
+			return git_config_set_multivar_in_file_gently(given_config_source.file,
+								      argv[0], NULL, argv[1], 0);
 		else
-			return git_config_set_in_file(given_config_source.file,
-						      argv[0], NULL);
+			return git_config_set_in_file_gently(given_config_source.file,
+							     argv[0], NULL);
 	}
 	else if (actions == ACTION_UNSET_ALL) {
 		check_write();
 		check_argc(argc, 1, 2);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], NULL, argv[1], 1);
+		return git_config_set_multivar_in_file_gently(given_config_source.file,
+							      argv[0], NULL, argv[1], 1);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
diff --git a/builtin/remote.c b/builtin/remote.c
index fe57f77..abd5f67 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1397,7 +1397,7 @@ static int update(int argc, const char **argv)
 
 static int remove_all_fetch_refspecs(const char *remote, const char *key)
 {
-	return git_config_set_multivar(key, NULL, NULL, 1);
+	return git_config_set_multivar_gently(key, NULL, NULL, 1);
 }
 
 static void add_branches(struct remote *remote, const char **branches,
diff --git a/cache.h b/cache.h
index 209d8c8..4dcf473 100644
--- a/cache.h
+++ b/cache.h
@@ -1487,7 +1487,7 @@ extern int update_server_info(int);
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
 #define CONFIG_NO_SECTION_OR_NAME 2
-/* git_config_set(), git_config_set_multivar() return the above or these: */
+/* git_config_set_gently(), git_config_set_multivar_gently() return the above or these: */
 #define CONFIG_NO_LOCK -1
 #define CONFIG_INVALID_FILE 3
 #define CONFIG_NO_WRITE 4
@@ -1525,15 +1525,15 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
-extern int git_config_set_in_file(const char *, const char *, const char *);
+extern int git_config_set_in_file_gently(const char *, const char *, const char *);
 extern void git_config_set_in_file_or_die(const char *, const char *, const char *);
-extern int git_config_set(const char *, const char *);
+extern int git_config_set_gently(const char *, const char *);
 extern void git_config_set_or_die(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_key_is_valid(const char *key);
-extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_config_set_multivar_gently(const char *, const char *, const char *, int);
 extern void git_config_set_multivar_or_die(const char *, const char *, const char *, int);
-extern int git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
+extern int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
 extern void git_config_set_multivar_in_file_or_die(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, const char *);
diff --git a/config.c b/config.c
index 261853a..a75f60c 100644
--- a/config.c
+++ b/config.c
@@ -1849,10 +1849,10 @@ contline:
 	return offset;
 }
 
-int git_config_set_in_file(const char *config_filename,
-			const char *key, const char *value)
+int git_config_set_in_file_gently(const char *config_filename,
+				  const char *key, const char *value)
 {
-	return git_config_set_multivar_in_file(config_filename, key, value, NULL, 0);
+	return git_config_set_multivar_in_file_gently(config_filename, key, value, NULL, 0);
 }
 
 void git_config_set_in_file_or_die(const char *config_filename,
@@ -1861,9 +1861,9 @@ void git_config_set_in_file_or_die(const char *config_filename,
 	git_config_set_multivar_in_file_or_die(config_filename, key, value, NULL, 0);
 }
 
-int git_config_set(const char *key, const char *value)
+int git_config_set_gently(const char *key, const char *value)
 {
-	return git_config_set_multivar(key, value, NULL, 0);
+	return git_config_set_multivar_gently(key, value, NULL, 0);
 }
 
 void git_config_set_or_die(const char *key, const char *value)
@@ -1985,9 +1985,10 @@ int git_config_key_is_valid(const char *key)
  * - the config file is removed and the lock file rename()d to it.
  *
  */
-int git_config_set_multivar_in_file(const char *config_filename,
-				const char *key, const char *value,
-				const char *value_regex, int multi_replace)
+int git_config_set_multivar_in_file_gently(const char *config_filename,
+					   const char *key, const char *value,
+					   const char *value_regex,
+					   int multi_replace)
 {
 	int fd = -1, in_fd = -1;
 	int ret;
@@ -2218,16 +2219,16 @@ void git_config_set_multivar_in_file_or_die(const char *config_filename,
 				const char *key, const char *value,
 				const char *value_regex, int multi_replace)
 {
-	if (git_config_set_multivar_in_file(config_filename, key, value,
-					    value_regex, multi_replace) < 0)
+	if (git_config_set_multivar_in_file_gently(config_filename, key, value,
+						   value_regex, multi_replace) < 0)
 		die(_("Could not set '%s' to '%s'"), key, value);
 }
 
-int git_config_set_multivar(const char *key, const char *value,
-			const char *value_regex, int multi_replace)
+int git_config_set_multivar_gently(const char *key, const char *value,
+				   const char *value_regex, int multi_replace)
 {
-	return git_config_set_multivar_in_file(NULL, key, value, value_regex,
-					       multi_replace);
+	return git_config_set_multivar_in_file_gently(NULL, key, value, value_regex,
+						      multi_replace);
 }
 
 void git_config_set_multivar_or_die(const char *key, const char *value,
diff --git a/submodule.c b/submodule.c
index 589a82c..be8b5cc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -69,7 +69,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	strbuf_addstr(&entry, "submodule.");
 	strbuf_addstr(&entry, submodule->name);
 	strbuf_addstr(&entry, ".path");
-	if (git_config_set_in_file(".gitmodules", entry.buf, newpath) < 0) {
+	if (git_config_set_in_file_gently(".gitmodules", entry.buf, newpath) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not update .gitmodules entry %s"), entry.buf);
 		strbuf_release(&entry);
-- 
2.7.1
