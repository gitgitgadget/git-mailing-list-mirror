From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/5] builtin-help: make it possible to exclude some commands in list_commands()
Date: Tue, 29 Jul 2008 23:25:18 +0200
Message-ID: <eb25e1eda6daf7c9b49552fe464b58cb05d99ace.1217366612.git.vmiklos@frugalware.org>
References: <cover.1217366612.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 23:25:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNwhb-0007IK-Vv
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 23:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbYG2VYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 17:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbYG2VYw
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 17:24:52 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:40105 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbYG2VYv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 17:24:51 -0400
Received: from vmobile.example.net (dsl5400FA31.pool.t-online.hu [84.0.250.49])
	by yugo.frugalware.org (Postfix) with ESMTP id CE9B11DDC5B;
	Tue, 29 Jul 2008 23:24:49 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id E744E1AA738; Tue, 29 Jul 2008 23:25:18 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <7vabg0eamk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90687>

The supposed method is to build a list of commands to be excluded using
add_cmdname(), then pass the list as the new exclude parameter. If no
exclude is needed, NULL should be used.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Tue, Jul 29, 2008 at 12:46:59PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> You require that exclude is a sorted list; this should be documented
> somewhere to avoid future misuses.

This version now adds a comment in load_command_list() about this.

 help.c |   27 ++++++++++++---------------
 help.h |   14 +++++++++++++-
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/help.c b/help.c
index 7a42517..26aa3e0 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,7 @@
 #include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "help.h"
 
 static struct man_viewer_list {
 	struct man_viewer_list *next;
@@ -300,18 +301,11 @@ static inline void mput_char(char c, unsigned int num)
 		putchar(c);
 }
 
-static struct cmdnames {
-	int alloc;
-	int cnt;
-	struct cmdname {
-		size_t len;
-		char name[1];
-	} **names;
-} main_cmds, other_cmds;
+struct cmdnames main_cmds, other_cmds;
 
-static void add_cmdname(struct cmdnames *cmds, const char *name, int len)
+void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
-	struct cmdname *ent = xmalloc(sizeof(*ent) + len);
+	struct cmdname *ent = xmalloc(sizeof(*ent) + len + 1);
 
 	ent->len = len;
 	memcpy(ent->name, name, len);
@@ -463,7 +457,7 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 	return longest;
 }
 
-static unsigned int load_command_list(const char *prefix)
+static unsigned int load_command_list(const char *prefix, struct cmdnames *exclude)
 {
 	unsigned int longest = 0;
 	unsigned int len;
@@ -502,13 +496,16 @@ static unsigned int load_command_list(const char *prefix)
 	      sizeof(*other_cmds.names), cmdname_compare);
 	uniq(&other_cmds);
 	exclude_cmds(&other_cmds, &main_cmds);
+	if (exclude)
+		/* Here we require that exclude is a sorted list. */
+		exclude_cmds(&main_cmds, exclude);
 
 	return longest;
 }
 
-void list_commands(const char *prefix, const char *title)
+void list_commands(const char *prefix, const char *title, struct cmdnames *exclude)
 {
-	unsigned int longest = load_command_list(prefix);
+	unsigned int longest = load_command_list(prefix, exclude);
 	const char *exec_path = git_exec_path();
 
 	if (main_cmds.cnt) {
@@ -558,7 +555,7 @@ static int is_in_cmdlist(struct cmdnames *c, const char *s)
 
 int is_git_command(const char *s, const char *prefix)
 {
-	load_command_list(prefix);
+	load_command_list(prefix, NULL);
 	return is_in_cmdlist(&main_cmds, s) ||
 		is_in_cmdlist(&other_cmds, s);
 }
@@ -704,7 +701,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all) {
 		printf("usage: %s\n\n", git_usage_string);
-		list_commands("git-", "git commands");
+		list_commands("git-", "git commands", NULL);
 		printf("%s\n", git_more_info_string);
 		return 0;
 	}
diff --git a/help.h b/help.h
index 0741662..3eb8cfb 100644
--- a/help.h
+++ b/help.h
@@ -1,7 +1,19 @@
 #ifndef HELP_H
 #define HELP_H
 
+struct cmdnames {
+	int alloc;
+	int cnt;
+	struct cmdname {
+		size_t len;
+		char name[FLEX_ARRAY];
+	} **names;
+};
+
 int is_git_command(const char *s, const char *prefix);
-void list_commands(const char *prefix, const char *title);
+void list_commands(const char *prefix, const char *title, struct cmdnames *exclude);
+void add_cmdname(struct cmdnames *cmds, const char *name, int len);
+
+extern struct cmdnames main_cmds, other_cmds;
 
 #endif /* HELP_H */
-- 
1.6.0.rc0.14.g95f8.dirty
