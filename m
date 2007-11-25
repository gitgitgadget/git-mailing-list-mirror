From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add -i: Fix running from a subdirectory
Date: Sun, 25 Nov 2007 10:10:10 -0800
Message-ID: <7v7ik6nqm5.fsf@gitster.siamese.dyndns.org>
References: <1195996542-86074-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 19:12:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwLwF-0003zi-EX
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 19:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbXKYSKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 13:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbXKYSKT
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 13:10:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53756 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbXKYSKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 13:10:18 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 764032F9;
	Sun, 25 Nov 2007 13:10:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C183499880;
	Sun, 25 Nov 2007 13:10:33 -0500 (EST)
In-Reply-To: <1195996542-86074-1-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Sun, 25 Nov 2007 14:15:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65978>

This fixes the pathspec interactive_add() passes to the underlying
git-add--interactive helper.  When the command was run from a
subdirectory, cmd_add() already has gone up to the toplevel of the work
tree, and the helper will be spawned from there.  The pathspec given on
the command line from the user needs to be adjusted for this.

This adds "validate_pathspec()" function in the callchain, but it does
not validate yet.  The function can be changed to barf if there are
unmatching pathspec given by the user, but that is not strictly
necessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The reason it is not "strictly necessary" is because if you give
   unmatching pathspecs, you simply would not see their effects (good or
   bad) in any of the subcommands in git-add--interactive.

 builtin-add.c    |   24 ++++++++++++++++++++----
 builtin-commit.c |    2 +-
 commit.h         |    2 +-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 7c6a296..865c475 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -135,13 +135,29 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-int interactive_add(int argc, const char **argv)
+static const char **validate_pathspec(int argc, const char **argv, const char *prefix)
+{
+	const char **pathspec = get_pathspec(prefix, argv);
+
+	return pathspec;
+}
+
+int interactive_add(int argc, const char **argv, const char *prefix)
 {
 	int status;
-	const char **args = xcalloc(sizeof(const char *), (argc + 2));
+	const char **args;
+	const char **pathspec = NULL;
+
+	if (argc) {
+		pathspec = validate_pathspec(argc, argv, prefix);
+		if (!pathspec)
+			return -1;
+	}
 
+	args = xcalloc(sizeof(const char *), (argc + 2));
 	args[0] = "add--interactive";
-	memcpy(&(args[1]), argv, sizeof(const char *) * argc);
+	if (argc)
+		memcpy(&(args[1]), pathspec, sizeof(const char *) * argc);
 	args[argc + 1] = NULL;
 
 	status = run_command_v_opt(args, RUN_GIT_CMD);
@@ -177,7 +193,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
 	if (add_interactive)
-		exit(interactive_add(argc, argv));
+		exit(interactive_add(argc, argv, prefix));
 
 	git_config(git_default_config);
 
diff --git a/builtin-commit.c b/builtin-commit.c
index 5d27102..45e51b1 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -165,7 +165,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	const char **pathspec = NULL;
 
 	if (interactive) {
-		interactive_add(argc, argv);
+		interactive_add(argc, argv, prefix);
 		commit_style = COMMIT_AS_IS;
 		return get_index_file();
 	}
diff --git a/commit.h b/commit.h
index 9f0765b..10e2b5d 100644
--- a/commit.h
+++ b/commit.h
@@ -113,7 +113,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 
 int in_merge_bases(struct commit *, struct commit **, int);
 
-extern int interactive_add(int argc, const char **argv);
+extern int interactive_add(int argc, const char **argv, const char *prefix);
 extern int rerere(void);
 
 static inline int single_parent(struct commit *commit)
-- 
1.5.3.6.2014.g7500f
