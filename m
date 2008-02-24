From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] help: respect aliases
Date: Sun, 24 Feb 2008 17:17:37 -0500
Message-ID: <20080224221737.GD31309@coredump.intra.peff.net>
References: <cover.1203890846.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:18:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTPAm-00035y-Fu
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 23:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbYBXWRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 17:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbYBXWRk
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 17:17:40 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4553 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbYBXWRk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 17:17:40 -0500
Received: (qmail 2412 invoked by uid 111); 24 Feb 2008 22:17:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Feb 2008 17:17:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2008 17:17:37 -0500
Content-Disposition: inline
In-Reply-To: <cover.1203890846.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74970>

If we have an alias "foo" defined, then the help text for
"foo" (via "git help foo" or "git foo --help") now shows the
definition of the alias.

Before showing an alias definition, we make sure that there
is no git command which would override the alias (so that
even though you may have a "log" alias, even though it will
not work, we don't want to it supersede "git help log").

Signed-off-by: Jeff King <peff@peff.net>
---
 help.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/help.c b/help.c
index 5feb849..e57a50e 100644
--- a/help.c
+++ b/help.c
@@ -210,7 +210,7 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 	return longest;
 }
 
-static void list_commands(void)
+static unsigned int load_command_list(void)
 {
 	unsigned int longest = 0;
 	unsigned int len;
@@ -250,6 +250,14 @@ static void list_commands(void)
 	uniq(&other_cmds);
 	exclude_cmds(&other_cmds, &main_cmds);
 
+	return longest;
+}
+
+static void list_commands(void)
+{
+	unsigned int longest = load_command_list();
+	const char *exec_path = git_exec_path();
+
 	if (main_cmds.cnt) {
 		printf("available git commands in '%s'\n", exec_path);
 		printf("----------------------------");
@@ -284,6 +292,22 @@ void list_common_cmds_help(void)
 	}
 }
 
+static int is_in_cmdlist(struct cmdnames *c, const char *s)
+{
+	int i;
+	for (i = 0; i < c->cnt; i++)
+		if (!strcmp(s, c->names[i]->name))
+			return 1;
+	return 0;
+}
+
+static int is_git_command(const char *s)
+{
+	load_command_list();
+	return is_in_cmdlist(&main_cmds, s) ||
+		is_in_cmdlist(&other_cmds, s);
+}
+
 static const char *cmd_to_page(const char *git_cmd)
 {
 	if (!git_cmd)
@@ -372,6 +396,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
+	const char *alias;
 
 	setup_git_directory_gently(&nongit);
 	git_config(git_help_config);
@@ -391,6 +416,12 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	alias = alias_lookup(argv[0]);
+	if (alias && !is_git_command(argv[0])) {
+		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
+		return 0;
+	}
+
 	switch (help_format) {
 	case HELP_FORMAT_MAN:
 		show_man_page(argv[0]);
-- 
1.5.4.3.305.g073a4
