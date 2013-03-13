From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] add: respect add.updateroot config option
Date: Wed, 13 Mar 2013 00:10:37 -0400
Message-ID: <20130313041037.GB5378@sigill.intra.peff.net>
References: <20130313040845.GA5057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 13 05:11:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFd1w-0005uD-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 05:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab3CMEKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 00:10:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50502 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786Ab3CMEKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 00:10:41 -0400
Received: (qmail 1450 invoked by uid 107); 13 Mar 2013 04:12:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Mar 2013 00:12:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2013 00:10:37 -0400
Content-Disposition: inline
In-Reply-To: <20130313040845.GA5057@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218031>

The `git add -u` command operates on the current subdir of
the repository, but is transitioning to operate on the whole
repository (see commit 0fa2eb5 for details). During the
transition period, we issue a warning. For users who have
read and accepted the warning, there is no way to jump
directly to the future behavior and silence the warning. The
config option added by this patch gives them such an option.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 19 +++++++++++++++++++
 builtin/add.c            | 10 ++++++++--
 t/t2200-add-update.sh    | 14 ++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bbba728..be0f6fc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -657,6 +657,25 @@ add.ignoreErrors::
 	convention for configuration variables.  Newer versions of Git
 	honor `add.ignoreErrors` as well.
 
+add.updateroot::
+	Historically, when the `git add -u` and `git add -A` commands
+	are run from a subdirectory of the repository and are not given
+	any pathspec, they have operated only on the subdirectory from
+	which they were called. In a future version of git, this behavior
+	will be switched to operate on the full repository instead. In
+	the meantime, issuing `git add -u` (or `-A`) from a subdirectory
+	continues to work on the subdirectory, but will now issue a
+	warning. If you are ready to move to the new behavior now,
+	accepting that you may be breaking existing scripts which expect
+	the old behavior, you can do so by setting `add.updateroot` to
+	`true`.
++
+Note that this is meant to let early adopters move to the new behavior
+immediately; it is not a toggle switch that will work forever.  After
+git transitions to the new behavior, this option will become a no-op;
+`git add -u` will always update the whole tree, and `git add -u .` will
+remain the correct way to limit to the current directory.
+
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/builtin/add.c b/builtin/add.c
index ab1c9e8..95fe35e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -22,6 +22,7 @@ static int take_worktree_changes;
 };
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
+static int update_root;
 
 struct update_callback_data {
 	int flags;
@@ -297,6 +298,10 @@ static int add_config(const char *var, const char *value, void *cb)
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "add.updateroot")) {
+		update_root = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -390,12 +395,13 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		short_option_with_implicit_dot = "-u";
 	}
 	if (option_with_implicit_dot && !argc) {
+		static const char *root[2] = { ":/", NULL };
 		static const char *here[2] = { ".", NULL };
-		if (prefix)
+		if (!update_root && prefix)
 			warn_pathless_add(option_with_implicit_dot,
 					  short_option_with_implicit_dot);
 		argc = 1;
-		argv = here;
+		argv = update_root ? root : here;
 	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index fe4f548..b9215d3 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -91,6 +91,20 @@ test_expect_success 'update did not touch files at root' '
 	test_cmp expect actual
 '
 
+test_expect_success 'update with add.updateroot set' '
+	(
+		cd dir1 &&
+		echo more >>sub2 &&
+		git -c add.updateroot=true add -u
+	)
+'
+
+test_expect_success 'all paths are updated' '
+	>expect &&
+	git diff-files --name-status >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success SYMLINKS 'replace a file with a symlink' '
 
 	rm foo &&
-- 
1.8.2.rc2.7.gef06216
