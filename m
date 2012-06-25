From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] add: listen to --ignore-errors for submodule-errors
Date: Tue, 26 Jun 2012 01:21:59 +0200
Message-ID: <1340666519-41804-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 01:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjIbo-0004f3-BA
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 01:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087Ab2FYXWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 19:22:08 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43271 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab2FYXWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 19:22:04 -0400
Received: by lbbgm6 with SMTP id gm6so7197282lbb.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 16:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=JlDPpFcVz7uYbwYvvQmB/S5WQhYDvdGbyVmgLK8uCt0=;
        b=Qajio+hvy2+ujXbMHseSLZltGrjDeVH2RLQjWtJLv00+cFEKVToir81kTjq9K88eW+
         P3wMLOpg6O1zZSTmTpMW1MOu0ftwSCCckw1/ai4NBvnHkuvoXsouK6wmubJr6ns0mEQ2
         arwz/yNnBSU24oqyBbqHn/a7OxzyximMz4KxsZY1pqsY48Ms4EKlBPS5OSPai8+OhFhS
         PoERdQe4lr37BPfFNPIlpUOSc4rRP//WUajQpbduos4zFB9RaMgP+QkSAE1ek28PMMIO
         FzUTKnnZlUPNtJ/K1pKWAbBHjyHXiZURHp/aEyuc6/I54/RbiBVVeYbuyuBom1OUmJjY
         6WLw==
Received: by 10.152.148.161 with SMTP id tt1mr14161631lab.4.1340666522784;
        Mon, 25 Jun 2012 16:22:02 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id h6sm7343634lbl.13.2012.06.25.16.22.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 16:22:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.msysgit.0.3.g3006a55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200607>

"git add --ignore-errors -- some-submodule/foo" surprisingly
throws an error saying "fatal: Path 'some-submodule/foo' is in
submodule 'some-submodule/foo'".

Fix this by making sure we consult the flag, and propagate the
error code properly.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

I recently tried to do the following in the msysGit-repo:

 $ git add --ignore-errors -- */.gitignore
 fatal: Path 'src/git-cheetah/.gitignore' is in submodule 'src/git-cheetah'

I was a bit puzzled by this; I explicitly specified --ignore-errors
because I did not want to be stopped due to src/git-cheetah/.gitignore
being located in a submodule.

The documentation seems to suggest that this is what is supposed to
happen, and this seems like the most likely behavior that the user
wanted. After all, there's no good reason submodules are special
in this regard, no?

 builtin/add.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 87446cf..6e6feb0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -20,7 +20,7 @@ static const char * const builtin_add_usage[] = {
 	NULL
 };
 static int patch_interactive, add_interactive, edit_interactive;
-static int take_worktree_changes;
+static int take_worktree_changes, ignore_add_errors;
 
 struct update_callback_data {
 	int flags;
@@ -153,9 +153,9 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
 	return seen;
 }
 
-static void treat_gitlinks(const char **pathspec)
+static int treat_gitlinks(const char **pathspec)
 {
-	int i;
+	int i, exit_status = 0;
 
 	if (!pathspec || !*pathspec)
 		return;
@@ -172,12 +172,15 @@ static void treat_gitlinks(const char **pathspec)
 				if (len2 == len + 1)
 					/* strip trailing slash */
 					pathspec[j] = xstrndup(ce->name, len);
-				else
+				else if (!ignore_add_errors)
 					die (_("Path '%s' is in submodule '%.*s'"),
 						pathspec[j], len, ce->name);
+				else
+					exit_status = 1;
 			}
 		}
 	}
+	return exit_status;
 }
 
 static void refresh(int verbose, const char **pathspec)
@@ -312,7 +315,7 @@ static const char ignore_error[] =
 N_("The following paths are ignored by one of your .gitignore files:\n");
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
-static int ignore_add_errors, addremove, intent_to_add, ignore_missing = 0;
+static int addremove, intent_to_add, ignore_missing = 0;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, "dry run"),
@@ -418,7 +421,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
-	treat_gitlinks(pathspec);
+	exit_status |= treat_gitlinks(pathspec);
 
 	if (add_new_files) {
 		int baselen;
-- 
1.7.11.msysgit.0.3.g3006a55
