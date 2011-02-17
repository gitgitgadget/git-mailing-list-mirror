From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: RFC: git config --list-defaults
Date: Thu, 17 Feb 2011 20:45:43 +0100
Message-ID: <AANLkTik7D+VeDpbpy5Nx8KDB9NSJNvMx58zxFqOcX7Rq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 20:46:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq9nh-00022C-Qj
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 20:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757887Ab1BQTpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 14:45:47 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39822 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106Ab1BQTpo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 14:45:44 -0500
Received: by vws16 with SMTP id 16so1364794vws.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 11:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=3RyiyGMDjeXHq6e6FF7yP25zQcdNL74Qh4XBJyUTdg4=;
        b=gmxPidiAEs0kc4dt4hIC/6KJXto9kf0MH0Pr8efG3t3kaoe3UVkhzvJdk9F1DAWNxI
         LBhYSSbAXat8+6ov68mDNHNWbxmf7urj3nx0L5DfLTiK9q7FyAaJyMrtXpcogQEAT0Dn
         GSw1667cAG6SONxXkroTedy5KrUPZG1+pXsUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qcaaPlSfjFtJI9jNVyjc051U3E9NjwXP7woMf017g2cGVqvXM2oXvrs7cCJAmCSoCw
         RNbuc9M3Jnz2IVoOj1LTLmqQZVBoJeRZ22cFnLSBqTjJ/o9+egjkhY7TpuNjnKUUKIry
         TeTaBWCBM5pjlct29DV5mayQCX2RDcCGh2lnU=
Received: by 10.52.158.66 with SMTP id ws2mr436411vdb.177.1297971943654; Thu,
 17 Feb 2011 11:45:43 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Thu, 17 Feb 2011 11:45:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167103>

Hi,

were there any attempts to implement printing all recognized config options?

Simplest method seems to be to manually ask all commands to print their
known options. Not very nice, easy to forget about adding option etc.

But the alternative requires some kind of formalized registration of options,
similar to command line arguments. Not that it's a bad thing, just requires
much bigger rewrite IMO.

Ultimately I think it'd be nice to have a short description of an option too.

What do you think about this and what kind of approach would be acceptable?

Attached patch is just an example. Adds "--list-all":

$ ./git config --list-all
Listing all configs
[core]
	filemode	= 1
	trustctime	= 1
	quotepath	= 1
	symlinks	= 1
	ignorecase	= 0
	abbrevguard	= 0
	bare	= 0
	ignorestat	= 0
	prefersymlinkrefs	= 0
[advice]
	pushnonfastforward	= 1
	statushints	= 1
	commitbeforemerge	= 1
	resolveconflict	= 1
	implicitidentity	= 1
	detachedhead	= 1


From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date: Wed, 16 Feb 2011 21:55:10 +0100
Subject: [PATCH] Call functions to print config values

---
 advice.c         |    9 +++++++++
 advice.h         |    1 +
 builtin/config.c |    7 +++++++
 cache.h          |    1 +
 config.c         |   27 +++++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/advice.c b/advice.c
index 0be4b5f..c077fc5 100644
--- a/advice.c
+++ b/advice.c
@@ -19,6 +19,15 @@ static struct {
 	{ "detachedhead", &advice_detached_head },
 };

+void git_advice_config_list_defaults(void)
+{
+	int i;
+	printf("[advice]\n");
+	for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
+		printf("\t%s\t= %d\n", advice_config[i].name, *advice_config[i].preference);
+	}
+}
+
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k = skip_prefix(var, "advice.");
diff --git a/advice.h b/advice.h
index 3244ebb..890f342 100644
--- a/advice.h
+++ b/advice.h
@@ -10,6 +10,7 @@ extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;

+void git_advice_config_list_defaults(void);
 int git_default_advice_config(const char *var, const char *value);

 extern void NORETURN die_resolve_conflict(const char *me);
diff --git a/builtin/config.c b/builtin/config.c
index dad86fe..b0bb84d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -41,6 +41,7 @@ static int end_null;
 #define ACTION_SET_ALL (1<<12)
 #define ACTION_GET_COLOR (1<<13)
 #define ACTION_GET_COLORBOOL (1<<14)
+#define ACTION_LIST_ALL (1<<15)

 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
@@ -64,6 +65,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "rename-section", &actions, "rename section: old-name
new-name", ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, "remove a section: name",
ACTION_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, "list all", ACTION_LIST),
+	OPT_BIT(0, "list-all", &actions, "list all registered options",
ACTION_LIST_ALL),
 	OPT_BIT('e', "edit", &actions, "opens an editor", ACTION_EDIT),
 	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color
configured: [default]"),
 	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find
the color setting: [stdout-is-tty]"),
@@ -413,6 +415,11 @@ int cmd_config(int argc, const char **argv, const
char *prefix)
 				die("error processing config file(s)");
 		}
 	}
+	else if (actions == ACTION_LIST_ALL) {
+		check_argc(argc, 0, 0);
+		printf("Listing all configs\n");
+		git_config_list_defaults();
+	}
 	else if (actions == ACTION_EDIT) {
 		check_argc(argc, 0, 0);
 		if (!config_exclusive_filename && nongit)
diff --git a/cache.h b/cache.h
index 3abf895..8b9716a 100644
--- a/cache.h
+++ b/cache.h
@@ -983,6 +983,7 @@ extern int update_server_info(int);

 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
+extern void git_config_list_defaults(void);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_parse_parameter(const char *text);
diff --git a/config.c b/config.c
index 625e051..13ab03a 100644
--- a/config.c
+++ b/config.c
@@ -472,6 +472,23 @@ int git_config_pathname(const char **dest, const
char *var, const char *value)
 	return 0;
 }

+static void git_core_config_list_defaults(void)
+{
+#define PRINT_CONFIG_INT(name, var) printf("\t%s\t= %d\n", #name, var);
+	printf("[core]\n");
+	PRINT_CONFIG_INT(filemode, trust_executable_bit);
+	PRINT_CONFIG_INT(trustctime, trust_ctime);
+	PRINT_CONFIG_INT(quotepath, quote_path_fully);
+	PRINT_CONFIG_INT(symlinks, has_symlinks);
+	PRINT_CONFIG_INT(ignorecase, ignore_case);
+	PRINT_CONFIG_INT(abbrevguard, unique_abbrev_extra_length);
+	PRINT_CONFIG_INT(bare, is_bare_repository_cfg);
+	PRINT_CONFIG_INT(ignorestat, assume_unchanged);
+	PRINT_CONFIG_INT(prefersymlinkrefs, prefer_symlink_refs);
+	/* Other from git_default_core_config() should follow */
+#undef PRINT_CONFIG_INT
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -762,6 +779,16 @@ static int git_default_mailmap_config(const char
*var, const char *value)
 	return 0;
 }

+void git_config_list_defaults(void)
+{
+	git_core_config_list_defaults();
+	git_advice_config_list_defaults();
+	/* core.gitproxy set in git_proxy_command_options in connect.c */
+	/* branch.* set in git_default_branch_config in config.c and
git_branch_config() in branch.c */
+	/* color.branch.<nr> */
+	/* What about branch.<name>.mergeoptions (merge.c::git_merge_config) etc? */
+}
+
 int git_default_config(const char *var, const char *value, void *dummy)
 {
 	if (!prefixcmp(var, "core."))
-- 
1.7.1


-- 
Piotrek
