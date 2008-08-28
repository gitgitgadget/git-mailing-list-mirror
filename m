From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Thu, 28 Aug 2008 23:28:15 +0200
Message-ID: <20080828212815.GG6439@steel.home>
References: <20080828171533.GA6024@blimp.local> <20080828212722.GF6439@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 23:30:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYp3p-0003lK-RB
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbYH1V2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbYH1V2S
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:28:18 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:22458 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbYH1V2R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:28:17 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20hf4kO7
Received: from tigra.home (Faa1f.f.strato-dslnet.de [195.4.170.31])
	by post.webmailer.de (klopstock mo9) (RZmta 16.47)
	with ESMTP id m01874k7SHfnTs ; Thu, 28 Aug 2008 23:28:15 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4EF1A277AE;
	Thu, 28 Aug 2008 23:28:15 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 457C556D2A; Thu, 28 Aug 2008 23:28:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080828212722.GF6439@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94180>

It is off(0) by default, to avoid scaring people unless they asked to.
If set to a non-0 value, wait for that amount of deciseconds before
running the corrected command.

Suggested by Junio, so he has a chance to hit Ctrl-C.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Documentation/config.txt |    9 ++++++++
 help.c                   |   50 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af57d94..8c644ab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -790,6 +790,15 @@ help.format::
 	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
 	the default. 'web' and 'html' are the same.
 
+help.autocorrect::
+	Automatically correct and execute mistyped commands after
+	waiting for the given number of deciseconds (0.1 sec). If more
+	than one command can be deduced from the entered text, nothing
+	will be executed.  If the value of this option is negative,
+	the corrected command will be executed immediately. If the
+	value is 0 - the command will be just shown but not executed.
+	This is the default.
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see linkgit:curl[1]).  This can be overridden
diff --git a/help.c b/help.c
index 981fb02..7bfbbcd 100644
--- a/help.c
+++ b/help.c
@@ -38,6 +38,16 @@ void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 	cmds->names[cmds->cnt++] = ent;
 }
 
+static void clean_cmdnames(struct cmdnames *cmds)
+{
+	int i;
+	for (i = 0; i < cmds->cnt; ++i)
+		free(cmds->names[i]);
+	free(cmds->names);
+	cmds->cnt = 0;
+	cmds->alloc = 0;
+}
+
 static int cmdname_compare(const void *a_, const void *b_)
 {
 	struct cmdname *a = *(struct cmdname **)a_;
@@ -258,6 +268,16 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
+static int autocorrect;
+
+static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "help.autocorrect"))
+		autocorrect = git_config_int(var,value);
+
+	return git_default_config(var, value, cb);
+}
+
 static const char *levenshtein_cmd;
 static int similarity(const char *cmd) {
 	return levenshtein(levenshtein_cmd, cmd, 0, 2, 1, 4);
@@ -274,7 +294,7 @@ static int levenshtein_compare(const void *p1, const void *p2)
 
 const char *help_unknown_cmd(const char *cmd)
 {
-	int i, best_similarity = 0;
+	int i, best_similarity = 0, n;
 	char cwd[PATH_MAX];
 	static struct cmdnames main_cmds, other_cmds;
 
@@ -283,6 +303,7 @@ const char *help_unknown_cmd(const char *cmd)
 		cwd[0] = '\0';
 	}
 
+	git_config(git_unknown_cmd_config, NULL);
 	if (!main_cmds.cnt && !other_cmds.cnt)
 		load_command_list("git-", &main_cmds, &other_cmds);
 
@@ -299,26 +320,39 @@ const char *help_unknown_cmd(const char *cmd)
 	if (!main_cmds.cnt)
 		die ("Uh oh.  Your system reports no Git commands at all.");
 	best_similarity = similarity(main_cmds.names[0]->name);
-	if (main_cmds.cnt < 2 ||
-	    best_similarity < similarity(main_cmds.names[1]->name)) {
+	n = 1;
+	while (n < main_cmds.cnt &&
+		best_similarity == similarity(main_cmds.names[n]->name))
+		++n;
+	if (autocorrect && n == 1) {
+		const char *assumed;
 		if (!*cwd)
 			exit(1);
 		if (chdir(cwd))
 			die ("Could not change directory back to '%s'", cwd);
+		assumed = main_cmds.names[0]->name;
+		main_cmds.names[0] = NULL;
+		clean_cmdnames(&other_cmds);
+		clean_cmdnames(&main_cmds);
 		fprintf(stderr, "WARNING: You called a Git program named '%s', "
 			"which does not exist.\n"
 			"Continuing under the assumption that you meant '%s'\n",
-			cmd, main_cmds.names[0]->name);
-		return main_cmds.names[0]->name;
+			cmd, assumed);
+		if (autocorrect > 0) {
+			fprintf(stderr, "in %0.1f seconds automatically...\n",
+				(float)autocorrect/10.0);
+			poll(NULL, 0, autocorrect * 100);
+		}
+		return assumed;
 	}
 
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
 
 	if (best_similarity < 6) {
-		fprintf(stderr, "\nDid you mean one of these?\n");
+		fprintf(stderr, "\nDid you mean %s?\n",
+			n < 2 ? "this": "one of these");
 
-		for (i = 0; i < main_cmds.cnt && best_similarity ==
-				similarity(main_cmds.names[i]->name); i++)
+		for (i = 0; i < n; i++)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
 	}
 
-- 
1.6.0.106.g97c8
