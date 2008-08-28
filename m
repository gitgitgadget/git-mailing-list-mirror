From: Alex Riesen <fork0@users.sourceforge.net>,
	Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Remove calculation of the longest command name from where
	it is not used
Date: Thu, 28 Aug 2008 19:15:33 +0200
Message-ID: <20080828171533.GA6024@blimp.local>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 19:26:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlGa-0007aw-HQ
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbYH1RZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbYH1RZS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:25:18 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:13788 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbYH1RZK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:25:10 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20xf4EvTSQ==
Received: from tigra.home (Faec3.f.strato-dslnet.de [195.4.174.195])
	by post.webmailer.de (mrclete mo4) (RZmta 16.47)
	with ESMTP id h02c2ak7SGMJNd ; Thu, 28 Aug 2008 19:25:07 +0200 (MEST)
	(envelope-from: <fork0@users.sourceforge.net>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 141C8277C4;
	Thu, 28 Aug 2008 19:25:06 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id C157E36D20; Thu, 28 Aug 2008 19:15:33 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94094>

Just calculate it where it is needed - it is cheap and trivial,
as all the lengths are already there (stored when creating the
command lists).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

And it less code than before (it is even more deletions than
insertions).

BTW, the Johannesses typo-guesser conflicts heavily in recent master.
Pity. I'm going to rebase it and send out the rebased version.

 builtin-help.c  |    4 ++--
 builtin-merge.c |    8 ++++----
 help.c          |   34 +++++++++++++++-------------------
 help.h          |    6 +++---
 4 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index 391f749..9225102 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -418,7 +418,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
 	const char *alias;
-	unsigned int longest = load_command_list("git-", &main_cmds, &other_cmds);
+	load_command_list("git-", &main_cmds, &other_cmds);
 
 	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
@@ -428,7 +428,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all) {
 		printf("usage: %s\n\n", git_usage_string);
-		list_commands("git commands", longest, &main_cmds, &other_cmds);
+		list_commands("git commands", &main_cmds, &other_cmds);
 		printf("%s\n", git_more_info_string);
 		return 0;
 	}
diff --git a/builtin-merge.c b/builtin-merge.c
index d6bcbec..dcd08f7 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -80,7 +80,7 @@ static struct strategy *get_strategy(const char *name)
 	int i;
 	struct strategy *ret;
 	static struct cmdnames main_cmds, other_cmds;
-	static int longest;
+	static int loaded;
 
 	if (!name)
 		return NULL;
@@ -89,14 +89,14 @@ static struct strategy *get_strategy(const char *name)
 		if (!strcmp(name, all_strategy[i].name))
 			return &all_strategy[i];
 
-	if (!longest) {
+	if (!loaded) {
 		struct cmdnames not_strategies;
+		loaded = 1;
 
 		memset(&main_cmds, 0, sizeof(struct cmdnames));
 		memset(&other_cmds, 0, sizeof(struct cmdnames));
 		memset(&not_strategies, 0, sizeof(struct cmdnames));
-		longest = load_command_list("git-merge-", &main_cmds,
-				&other_cmds);
+		load_command_list("git-merge-", &main_cmds, &other_cmds);
 		for (i = 0; i < main_cmds.cnt; i++) {
 			int j, found = 0;
 			struct cmdname *ent = main_cmds.names[i];
diff --git a/help.c b/help.c
index 1afbac0..a17a746 100644
--- a/help.c
+++ b/help.c
@@ -133,11 +133,10 @@ static int is_executable(const char *name)
 	return st.st_mode & S_IXUSR;
 }
 
-static unsigned int list_commands_in_dir(struct cmdnames *cmds,
+static void list_commands_in_dir(struct cmdnames *cmds,
 					 const char *path,
 					 const char *prefix)
 {
-	unsigned int longest = 0;
 	int prefix_len;
 	DIR *dir = opendir(path);
 	struct dirent *de;
@@ -145,7 +144,7 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 	int len;
 
 	if (!dir)
-		return 0;
+		return;
 	if (!prefix)
 		prefix = "git-";
 	prefix_len = strlen(prefix);
@@ -168,29 +167,22 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 		if (has_extension(de->d_name, ".exe"))
 			entlen -= 4;
 
-		if (longest < entlen)
-			longest = entlen;
-
 		add_cmdname(cmds, de->d_name + prefix_len, entlen);
 	}
 	closedir(dir);
 	strbuf_release(&buf);
-
-	return longest;
 }
 
-unsigned int load_command_list(const char *prefix,
+void load_command_list(const char *prefix,
 		struct cmdnames *main_cmds,
 		struct cmdnames *other_cmds)
 {
-	unsigned int longest = 0;
-	unsigned int len;
 	const char *env_path = getenv("PATH");
 	char *paths, *path, *colon;
 	const char *exec_path = git_exec_path();
 
 	if (exec_path)
-		longest = list_commands_in_dir(main_cmds, exec_path, prefix);
+		list_commands_in_dir(main_cmds, exec_path, prefix);
 
 	if (!env_path) {
 		fprintf(stderr, "PATH not set\n");
@@ -202,9 +194,7 @@ unsigned int load_command_list(const char *prefix,
 		if ((colon = strchr(path, PATH_SEP)))
 			*colon = 0;
 
-		len = list_commands_in_dir(other_cmds, path, prefix);
-		if (len > longest)
-			longest = len;
+		list_commands_in_dir(other_cmds, path, prefix);
 
 		if (!colon)
 			break;
@@ -220,14 +210,20 @@ unsigned int load_command_list(const char *prefix,
 	      sizeof(*other_cmds->names), cmdname_compare);
 	uniq(other_cmds);
 	exclude_cmds(other_cmds, main_cmds);
-
-	return longest;
 }
 
-void list_commands(const char *title, unsigned int longest,
-		struct cmdnames *main_cmds, struct cmdnames *other_cmds)
+void list_commands(const char *title, struct cmdnames *main_cmds,
+		   struct cmdnames *other_cmds)
 {
 	const char *exec_path = git_exec_path();
+	int i, longest = 0;
+
+	for (i = 0; i < main_cmds->cnt; i++)
+		if (longest < main_cmds->names[i]->len)
+			longest = main_cmds->names[i]->len;
+	for (i = 0; i < other_cmds->cnt; i++)
+		if (longest < other_cmds->names[i]->len)
+			longest = other_cmds->names[i]->len;
 
 	if (main_cmds->cnt) {
 		printf("available %s in '%s'\n", title, exec_path);
diff --git a/help.h b/help.h
index 3f1ae89..2733433 100644
--- a/help.h
+++ b/help.h
@@ -16,14 +16,14 @@ static inline void mput_char(char c, unsigned int num)
 		putchar(c);
 }
 
-unsigned int load_command_list(const char *prefix,
+void load_command_list(const char *prefix,
 		struct cmdnames *main_cmds,
 		struct cmdnames *other_cmds);
 void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 /* Here we require that excludes is a sorted list. */
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
 int is_in_cmdlist(struct cmdnames *c, const char *s);
-void list_commands(const char *title, unsigned int longest,
-		struct cmdnames *main_cmds, struct cmdnames *other_cmds);
+void list_commands(const char *title, struct cmdnames *main_cmds,
+		   struct cmdnames *other_cmds);
 
 #endif /* HELP_H */
-- 
1.6.0.1.150.g5966
