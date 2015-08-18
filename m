From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/7] submodule: extract functions for config set and lookup
Date: Mon, 17 Aug 2015 17:21:58 -0700
Message-ID: <1439857323-21048-3-git-send-email-sbeller@google.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 02:22:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRUfT-0007oZ-G5
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 02:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbbHRAWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 20:22:16 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36021 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbbHRAWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 20:22:14 -0400
Received: by pawq9 with SMTP id q9so21491295paw.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 17:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CtLt0LwWBmApa+LVz/wASnA4ySSgUlMb4So/V4gsQUM=;
        b=Q8JrbEGgazYgzrdxV/CmLIF6D7Gva7a1UX7qtLkYgWyAMQtmvAAwBln/4T76yL1q8F
         NWsSgi7LIcu3o4q3ay6gltzrfrfEB2O3AOUPNOvICwUWlXe2QmdL+S89of0qs2Nd7/bz
         23GSVd9gZ/D/LYGPHe9cZQ7lvTIBIPBlVY2ANc3Ve4k1IZwGtTk3O2oB2R9lL/nWjv+B
         p3Ob8zJIHMaYcLLrwxqlBytZ+pCoeU6bkE8B5/8K/2SFUqTx4YueMnIBM/ltNRxjTC6k
         ppC7UWET0MlaIWllNgYlZdOQNH6MfsxIpv9vnynTOUyWvPKRqhuVxmSVMluap79PhUr7
         qgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CtLt0LwWBmApa+LVz/wASnA4ySSgUlMb4So/V4gsQUM=;
        b=LrQnthlSdcp7HjFKw65wSpJvi+h1LMGlotYlEysBB+uf19wxiqg2veHDKARRIB+7KW
         n/aS8yccQG24HTOo56Fn7kbBfPGJ96aNeac8NB2t5O3LA1ONw/xQfBnp1ShNoU9vFL9h
         3vrPQP8fPpOpWZu6HSUzjLwxWs2DyLYrzCR1lbTVGLX8vR6LalWKTjVvqrB4ZUrvMz7J
         NKgJilTp6Xq1TrzBCZsjo2NXOQYvWxYXSnHxETfu9ymQA0Tzv4S2JoqPKeWMCmj+zUoA
         E18KNHwim2JAxQTX3kwDO3u7CXnnJ0ngAfRWuZc4xYp5UONhYXjSS7YP2Q9oQ/T2NDRG
         ufCA==
X-Gm-Message-State: ALoCoQmOFfGVkqmxWYNicRSZJWrD4canMShTbBO+2Ddxx2FovTyiL/PbDl5s14zxFCMS98cu5w7V
X-Received: by 10.68.65.99 with SMTP id w3mr7641367pbs.146.1439857334361;
        Mon, 17 Aug 2015 17:22:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bca6:6b6f:4dbb:30a3])
        by smtp.gmail.com with ESMTPSA id k5sm15936204pdb.53.2015.08.17.17.22.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 17:22:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.330.g130be8e.dirty
In-Reply-To: <1439857323-21048-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276110>

From: Heiko Voigt <hvoigt@hvoigt.net>

This is one step towards using the new configuration API. We just
extract these functions to make replacing the actual code easier.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 142 +++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 45 deletions(-)

diff --git a/submodule.c b/submodule.c
index 17b54e4..307fa43 100644
--- a/submodule.c
+++ b/submodule.c
@@ -41,6 +41,76 @@ static int gitmodules_is_unmerged;
  */
 static int gitmodules_is_modified;
 
+static const char *get_name_for_path(const char *path)
+{
+	struct string_list_item *path_option;
+	if (path == NULL) {
+		if (config_name_for_path.nr > 0)
+			return config_name_for_path.items[0].util;
+		else
+			return NULL;
+	}
+	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
+	if (!path_option)
+		return NULL;
+	return path_option->util;
+}
+
+static void set_name_for_path(const char *path, const char *name, int namelen)
+{
+	struct string_list_item *config;
+	config = unsorted_string_list_lookup(&config_name_for_path, path);
+	if (config)
+		free(config->util);
+	else
+		config = string_list_append(&config_name_for_path, xstrdup(path));
+	config->util = xmemdupz(name, namelen);
+}
+
+static const char *get_ignore_for_name(const char *name)
+{
+	struct string_list_item *ignore_option;
+	ignore_option = unsorted_string_list_lookup(&config_ignore_for_name, name);
+	if (!ignore_option)
+		return NULL;
+
+	return ignore_option->util;
+}
+
+static void set_ignore_for_name(const char *name, int namelen, const char *ignore)
+{
+	struct string_list_item *config;
+	char *name_cstr = xmemdupz(name, namelen);
+	config = unsorted_string_list_lookup(&config_ignore_for_name, name_cstr);
+	if (config) {
+		free(config->util);
+		free(name_cstr);
+	} else
+		config = string_list_append(&config_ignore_for_name, name_cstr);
+	config->util = xstrdup(ignore);
+}
+
+static int get_fetch_recurse_for_name(const char *name)
+{
+	struct string_list_item *fetch_recurse;
+	fetch_recurse = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name);
+	if (!fetch_recurse)
+		return RECURSE_SUBMODULES_NONE;
+
+	return (intptr_t) fetch_recurse->util;
+}
+
+static void set_fetch_recurse_for_name(const char *name, int namelen, int fetch_recurse)
+{
+	struct string_list_item *config;
+	char *name_cstr = xmemdupz(name, namelen);
+	config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name_cstr);
+	if (!config)
+		config = string_list_append(&config_fetch_recurse_submodules_for_name, name_cstr);
+	else
+		free(name_cstr);
+	config->util = (void *)(intptr_t) fetch_recurse;
+}
 
 int is_staging_gitmodules_ok(void)
 {
@@ -55,7 +125,7 @@ int is_staging_gitmodules_ok(void)
 int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 {
 	struct strbuf entry = STRBUF_INIT;
-	struct string_list_item *path_option;
+	const char *path;
 
 	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
 		return -1;
@@ -63,13 +133,13 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (gitmodules_is_unmerged)
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	path_option = unsorted_string_list_lookup(&config_name_for_path, oldpath);
-	if (!path_option) {
+	path = get_name_for_path(oldpath);
+	if (!path) {
 		warning(_("Could not find section in .gitmodules where path=%s"), oldpath);
 		return -1;
 	}
 	strbuf_addstr(&entry, "submodule.");
-	strbuf_addstr(&entry, path_option->util);
+	strbuf_addstr(&entry, path);
 	strbuf_addstr(&entry, ".path");
 	if (git_config_set_in_file(".gitmodules", entry.buf, newpath) < 0) {
 		/* Maybe the user already did that, don't error out here */
@@ -89,7 +159,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 int remove_path_from_gitmodules(const char *path)
 {
 	struct strbuf sect = STRBUF_INIT;
-	struct string_list_item *path_option;
+	const char *path_option;
 
 	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
 		return -1;
@@ -97,13 +167,13 @@ int remove_path_from_gitmodules(const char *path)
 	if (gitmodules_is_unmerged)
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
+	path_option = get_name_for_path(path);
 	if (!path_option) {
 		warning(_("Could not find section in .gitmodules where path=%s"), path);
 		return -1;
 	}
 	strbuf_addstr(&sect, "submodule.");
-	strbuf_addstr(&sect, path_option->util);
+	strbuf_addstr(&sect, path_option);
 	if (git_config_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not remove .gitmodules entry for %s"), path);
@@ -165,12 +235,11 @@ done:
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
-	struct string_list_item *path_option, *ignore_option;
-	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
-	if (path_option) {
-		ignore_option = unsorted_string_list_lookup(&config_ignore_for_name, path_option->util);
-		if (ignore_option)
-			handle_ignore_submodules_arg(diffopt, ignore_option->util);
+	const char *name = get_name_for_path(path);
+	if (name) {
+		const char *ignore = get_ignore_for_name(name);
+		if (ignore)
+			handle_ignore_submodules_arg(diffopt, ignore);
 		else if (gitmodules_is_unmerged)
 			DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
 	}
@@ -221,7 +290,6 @@ void gitmodules_config(void)
 
 int parse_submodule_config_option(const char *var, const char *value)
 {
-	struct string_list_item *config;
 	const char *name, *key;
 	int namelen;
 
@@ -232,22 +300,14 @@ int parse_submodule_config_option(const char *var, const char *value)
 		if (!value)
 			return config_error_nonbool(var);
 
-		config = unsorted_string_list_lookup(&config_name_for_path, value);
-		if (config)
-			free(config->util);
-		else
-			config = string_list_append(&config_name_for_path, xstrdup(value));
-		config->util = xmemdupz(name, namelen);
+		set_name_for_path(value, name, namelen);
+
 	} else if (!strcmp(key, "fetchrecursesubmodules")) {
-		char *name_cstr = xmemdupz(name, namelen);
-		config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name_cstr);
-		if (!config)
-			config = string_list_append(&config_fetch_recurse_submodules_for_name, name_cstr);
-		else
-			free(name_cstr);
-		config->util = (void *)(intptr_t)parse_fetch_recurse_submodules_arg(var, value);
+		int fetch_recurse = parse_fetch_recurse_submodules_arg(var, value);
+
+		set_fetch_recurse_for_name(name, namelen, fetch_recurse);
+
 	} else if (!strcmp(key, "ignore")) {
-		char *name_cstr;
 
 		if (!value)
 			return config_error_nonbool(var);
@@ -258,14 +318,7 @@ int parse_submodule_config_option(const char *var, const char *value)
 			return 0;
 		}
 
-		name_cstr = xmemdupz(name, namelen);
-		config = unsorted_string_list_lookup(&config_ignore_for_name, name_cstr);
-		if (config) {
-			free(config->util);
-			free(name_cstr);
-		} else
-			config = string_list_append(&config_ignore_for_name, name_cstr);
-		config->util = xstrdup(value);
+		set_ignore_for_name(name, namelen, value);
 		return 0;
 	}
 	return 0;
@@ -647,7 +700,7 @@ static void calculate_changed_submodule_paths(void)
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	/* No need to check if there are no submodules configured */
-	if (!config_name_for_path.nr)
+	if (!get_name_for_path(NULL))
 		return;
 
 	init_revisions(&rev, NULL);
@@ -694,7 +747,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 	int i, result = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct string_list_item *name_for_path;
+	const char *name_for_path;
 	const char *work_tree = get_git_work_tree();
 	if (!work_tree)
 		goto out;
@@ -725,18 +778,17 @@ int fetch_populated_submodules(const struct argv_array *options,
 			continue;
 
 		name = ce->name;
-		name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
+		name_for_path = get_name_for_path(ce->name);
 		if (name_for_path)
-			name = name_for_path->util;
+			name = name_for_path;
 
 		default_argv = "yes";
 		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
-			struct string_list_item *fetch_recurse_submodules_option;
-			fetch_recurse_submodules_option = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name);
-			if (fetch_recurse_submodules_option) {
-				if ((intptr_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_OFF)
+			int fetch_recurse_option = get_fetch_recurse_for_name(name);
+			if (fetch_recurse_option != RECURSE_SUBMODULES_NONE) {
+				if (fetch_recurse_option == RECURSE_SUBMODULES_OFF)
 					continue;
-				if ((intptr_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_ON_DEMAND) {
+				if (fetch_recurse_option == RECURSE_SUBMODULES_ON_DEMAND) {
 					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
 						continue;
 					default_argv = "on-demand";
-- 
2.5.0.330.g130be8e.dirty
