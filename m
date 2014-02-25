From: Joel Nothman <joel.nothman@gmail.com>
Subject: [PATCH] help: include list of aliases in git-help --all
Date: Tue, 25 Feb 2014 11:48:34 +1100
Message-ID: <1393289315-28982-1-git-send-email-joel.nothman@gmail.com>
Cc: Joel Nothman <joel.nothman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 25 01:55:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI6Id-0004TE-78
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 01:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbaBYAyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 19:54:52 -0500
Received: from mail1.bemta4.messagelabs.com ([85.158.143.250]:55477 "EHLO
	mail1.bemta4.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751489AbaBYAyv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 19:54:51 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2014 19:54:50 EST
Received: from [85.158.143.35:56935] by server-3.bemta-4.messagelabs.com id D9/62-11539-568EB035; Tue, 25 Feb 2014 00:48:37 +0000
X-Env-Sender: joel@schwa02.cs.usyd.edu.au
X-Msg-Ref: server-4.tower-21.messagelabs.com!1393289316!7995405!1
X-Originating-IP: [129.78.4.12]
X-StarScan-Received: 
X-StarScan-Version: 6.9.16; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21538 invoked from network); 25 Feb 2014 00:48:36 -0000
Received: from em-gw1-pro-2.ucc.usyd.edu.au (HELO em-gw1-pro-2.ucc.usyd.edu.au) (129.78.4.12)
  by server-4.tower-21.messagelabs.com with SMTP; 25 Feb 2014 00:48:36 -0000
Received: from schwa02.cs.usyd.edu.au (dmz5-snt-21.ucc.usyd.edu.au [172.20.34.21])
	by em-gw1-pro-2.ucc.usyd.edu.au (Postfix) with ESMTP id 533AF4000B;
	Tue, 25 Feb 2014 11:48:35 +1100 (EST)
Received: by schwa02.cs.usyd.edu.au (Postfix, from userid 5005)
	id BCACB121294; Tue, 25 Feb 2014 11:48:36 +1100 (EST)
X-Mailer: git-send-email 1.9.0.1.gb5ab0fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242659>

Git help --all had listed all git commands, but no configured aliases.
This includes aliases as a separate listing, after commands in the main
git directory and other $PATH directories.

Signed-off-by: Joel Nothman <joel.nothman <at> gmail.com>
---
 Documentation/git-help.txt |  4 +--
 builtin/help.c             |  7 ++---
 help.c                     | 64 +++++++++++++++++++++++++++++++++++-----------
 help.h                     |  7 ++++-
 4 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index b21e9d7..c9fe791 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -40,8 +40,8 @@ OPTIONS
 -------
 -a::
 --all::
-	Prints all the available commands on the standard output. This
-	option overrides any given command or guide name.
+	Prints all the available commands and aliases on the standard output.
+	This option overrides any given command or guide name.
 
 -g::
 --guides::
diff --git a/builtin/help.c b/builtin/help.c
index 1fdefeb..d1dfecd 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -38,7 +38,7 @@ static int show_guides = 0;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
-	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
+	OPT_BOOL('a', "all", &show_all, N_("print all available commands and aliases")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
@@ -453,6 +453,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	int nongit;
 	const char *alias;
 	enum help_format parsed_help_format;
+	struct cmdnames alias_cmds;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
@@ -461,8 +462,8 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (show_all) {
 		git_config(git_help_config, NULL);
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
-		load_command_list("git-", &main_cmds, &other_cmds);
-		list_commands(colopts, &main_cmds, &other_cmds);
+		load_commands_and_aliases("git-", &main_cmds, &other_cmds, &alias_cmds);
+		list_commands(colopts, &main_cmds, &other_cmds, &alias_cmds);
 	}
 
 	if (show_guides)
diff --git a/help.c b/help.c
index df7d16d..3c14af4 100644
--- a/help.c
+++ b/help.c
@@ -86,7 +86,7 @@ static void pretty_print_string_list(struct cmdnames *cmds,
 	int i;
 
 	for (i = 0; i < cmds->cnt; i++)
-		string_list_append(&list, cmds->names[i]->name);
+	    string_list_append(&list, cmds->names[i]->name);
 	/*
 	 * always enable column display, we only consult column.*
 	 * about layout strategy and stuff
@@ -202,8 +202,48 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
 
+static struct cmdnames aliases;
+
+static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
+{
+	int i;
+	ALLOC_GROW(cmds->names, cmds->cnt + old->cnt, cmds->alloc);
+
+	for (i = 0; i < old->cnt; i++)
+		cmds->names[cmds->cnt++] = old->names[i];
+	free(old->names);
+	old->cnt = 0;
+	old->names = NULL;
+}
+
+static int load_aliases_cb(const char *var, const char *value, void *cb)
+{
+	if (starts_with(var, "alias."))
+		add_cmdname(&aliases, var + 6, strlen(var + 6));
+	return 0;
+}
+
+void load_commands_and_aliases(const char *prefix,
+		struct cmdnames *main_cmds,
+		struct cmdnames *other_cmds,
+		struct cmdnames *alias_cmds)
+{
+	load_command_list(prefix, main_cmds, other_cmds);
+
+	/* reuses global aliases from unknown command functionality */
+	git_config(load_aliases_cb, NULL);
+
+	add_cmd_list(alias_cmds, &aliases);
+	qsort(alias_cmds->names, alias_cmds->cnt,
+		  sizeof(*alias_cmds->names), cmdname_compare);
+	uniq(alias_cmds);
+	exclude_cmds(alias_cmds, main_cmds);
+	exclude_cmds(alias_cmds, other_cmds);
+}
+
 void list_commands(unsigned int colopts,
-		   struct cmdnames *main_cmds, struct cmdnames *other_cmds)
+		   struct cmdnames *main_cmds, struct cmdnames *other_cmds,
+		   struct cmdnames *alias_cmds)
 {
 	if (main_cmds->cnt) {
 		const char *exec_path = git_exec_path();
@@ -219,6 +259,13 @@ void list_commands(unsigned int colopts,
 		pretty_print_string_list(other_cmds, colopts);
 		putchar('\n');
 	}
+
+	if (alias_cmds->cnt) {
+		printf_ln(_("aliases defined in git configuration"));
+		putchar('\n');
+		pretty_print_string_list(alias_cmds, colopts);
+		putchar('\n');
+	}
 }
 
 void list_common_cmds_help(void)
@@ -248,7 +295,6 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 }
 
 static int autocorrect;
-static struct cmdnames aliases;
 
 static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 {
@@ -270,18 +316,6 @@ static int levenshtein_compare(const void *p1, const void *p2)
 	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
 }
 
-static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
-{
-	int i;
-	ALLOC_GROW(cmds->names, cmds->cnt + old->cnt, cmds->alloc);
-
-	for (i = 0; i < old->cnt; i++)
-		cmds->names[cmds->cnt++] = old->names[i];
-	free(old->names);
-	old->cnt = 0;
-	old->names = NULL;
-}
-
 /* An empirically derived magic number */
 #define SIMILARITY_FLOOR 7
 #define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
diff --git a/help.h b/help.h
index b21d7c9..3939bc6 100644
--- a/help.h
+++ b/help.h
@@ -21,11 +21,16 @@ extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
 			      struct cmdnames *other_cmds);
+extern void load_commands_and_aliases(const char *prefix,
+			      struct cmdnames *main_cmds,
+			      struct cmdnames *other_cmds,
+			      struct cmdnames *alias_cmds);
 extern void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 /* Here we require that excludes is a sorted list. */
 extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
 extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
-extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
+extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds,
+			  struct cmdnames *other_cmds, struct cmdnames *alias_cmds);
 
 /*
  * call this to die(), when it is suspected that the user mistyped a
-- 
1.8.3.4 (Apple Git-47)
