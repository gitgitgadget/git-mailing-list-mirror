From: Jeff King <peff@peff.net>
Subject: [DONOTAPPLY PATCH 2/3] setup: warn about implicit worktree with
 $GIT_DIR
Date: Tue, 26 Mar 2013 16:12:08 -0400
Message-ID: <20130326201208.GB22522@sigill.intra.peff.net>
References: <20130326200851.GA22080@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:12:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKaEc-0006Gq-8D
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760177Ab3CZUMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:12:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40636 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab3CZUMN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:12:13 -0400
Received: (qmail 7174 invoked by uid 107); 26 Mar 2013 20:13:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 16:13:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 16:12:08 -0400
Content-Disposition: inline
In-Reply-To: <20130326200851.GA22080@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219197>

It can be surprising to some users that pointing GIT_DIR to
a ".git" directory does not use the working tree that
surrounds the .git directory, but rather uses the current
working directory as the working tree.

Git has always worked this way, and for the most part it has
not been a big problem.  However, given that one way of the
user finding this out is by having a destructive git command
impact an unexpected area of the filesystem, it would be
nice to default to something less surprising and likely to
cause problems (namely, having no working directory).

This breaks existing users of the feature, of course; they
can adapt by setting GIT_WORK_TREE explicitly to ".", but
they need to be told to do so. Therefore we'll start with a
deprecation period and a warning to give them time to fix
their scripts and workflows.

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c               | 21 ++++++++++++++++++++-
 t/t1510-repo-setup.sh |  8 ++++++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 01c5476..afc245f 100644
--- a/setup.c
+++ b/setup.c
@@ -437,6 +437,23 @@ const char *read_gitfile(const char *path)
 	return path;
 }
 
+static const char warn_implicit_work_tree_msg[] =
+N_("You have set GIT_DIR (or used --git-dir) without specifying\n"
+   "a working tree. In Git 2.0, the behavior will change from using current\n"
+   "working directory as the working tree to having no working tree at all.\n"
+   "If you wish to continue the current behavior, please set GIT_WORK_TREE\n"
+   "or core.worktree explicitly. See `git help git` for more details.");
+
+static void warn_implicit_work_tree(void)
+{
+	static int warn_once;
+
+	if (warn_once++)
+		return;
+
+	warning("%s", _(warn_implicit_work_tree_msg));
+}
+
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 					  char *cwd, int len,
 					  int *nongit_ok)
@@ -503,8 +520,10 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		free(gitfile);
 		return NULL;
 	}
-	else /* #2, #10 */
+	else { /* #2, #10 */
+		warn_implicit_work_tree();
 		set_git_work_tree(".");
+	}
 
 	/* set_git_work_tree() must have been called by now */
 	worktree = get_git_work_tree();
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index cf2ee78..0910de1 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -243,7 +243,9 @@ test_expect_success '#2: worktree defaults to cwd with explicit GIT_DIR' '
 test_expect_success '#2: worktree defaults to cwd with explicit GIT_DIR' '
 	try_repo 2 unset "$here/2/.git" unset "" unset \
 		"$here/2/.git" "$here/2" "$here/2" "(null)" \
-		"$here/2/.git" "$here/2/sub" "$here/2/sub" "(null)"
+		"$here/2/.git" "$here/2/sub" "$here/2/sub" "(null)" \
+		2>message &&
+	test_i18ngrep "warning:.*GIT_DIR" message
 '
 
 test_expect_success '#2b: relative GIT_DIR' '
@@ -378,7 +380,9 @@ test_expect_success '#10: GIT_DIR can point to gitfile' '
 test_expect_success '#10: GIT_DIR can point to gitfile' '
 	try_repo 10 unset "$here/10/.git" unset gitfile unset \
 		"$here/10.git" "$here/10" "$here/10" "(null)" \
-		"$here/10.git" "$here/10/sub" "$here/10/sub" "(null)"
+		"$here/10.git" "$here/10/sub" "$here/10/sub" "(null)" \
+		2>message &&
+	test_i18ngrep "warning:.*GIT_DIR" message
 '
 
 test_expect_success '#10b: relative GIT_DIR can point to gitfile' '
-- 
1.8.2.13.g0f18d3c
