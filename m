From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v5 2/4] extract functions for submodule config set and lookup
Date: Mon, 15 Jun 2015 23:06:12 +0200
Message-ID: <c077048f43a32418b3912962ab03c129d4e5352e.1434400625.git.hvoigt@hvoigt.net>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 23:06:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4baf-00022c-Vz
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 23:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876AbbFOVGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 17:06:38 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:49908 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755731AbbFOVGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 17:06:36 -0400
Received: from [178.11.201.3] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Z4baT-0001iC-2y; Mon, 15 Jun 2015 23:06:33 +0200
X-Mailer: git-send-email 2.4.2.391.g2979c89
In-Reply-To: <cover.1434400625.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1434400625.git.hvoigt@hvoigt.net>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271731>

This is one step towards using the new configuration API. We just
extract these functions to make replacing the actual code easier.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c | 142 +++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 45 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7822dc5..c3b5f44 100644
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
@@ -646,7 +699,7 @@ static void calculate_changed_submodule_paths(void)
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	/* No need to check if there are no submodules configured */
-	if (!config_name_for_path.nr)
+	if (!get_name_for_path(NULL))
 		return;
 
 	init_revisions(&rev, NULL);
@@ -693,7 +746,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 	int i, result = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct string_list_item *name_for_path;
+	const char *name_for_path;
 	const char *work_tree = get_git_work_tree();
 	if (!work_tree)
 		goto out;
@@ -724,18 +777,17 @@ int fetch_populated_submodules(const struct argv_array *options,
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
2.4.2.391.g2979c89
