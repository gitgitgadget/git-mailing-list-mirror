From: Jeff King <peff@peff.net>
Subject: [PATCH] init: don't set core.worktree when initializing /.git
Date: Tue, 31 Mar 2015 14:34:23 -0400
Message-ID: <20150331183423.GD19206@peff.net>
References: <0FD999DB-3DBF-40D4-8128-715BDC49EAAB@free.fr>
 <20150331181552.GC19206@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Cedric Gava <gava.c@free.fr>
X-From: git-owner@vger.kernel.org Tue Mar 31 20:34:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd0zg-0000Ds-HW
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 20:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbbCaSe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 14:34:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:40495 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751032AbbCaSe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 14:34:26 -0400
Received: (qmail 19345 invoked by uid 102); 31 Mar 2015 18:34:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:34:25 -0500
Received: (qmail 26411 invoked by uid 107); 31 Mar 2015 18:34:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 14:34:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 14:34:23 -0400
Content-Disposition: inline
In-Reply-To: <20150331181552.GC19206@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266545>

If you create a git repository in the root directory with
"git init /", we erroneously write a core.worktree entry.
That can be surprising if you later move the .git directory
to another path (which usually moves the relative working
tree, but is foiled if there is an explicit worktree set).

The problem is that we check whether core.worktree is
necessary by seeing if we can make the git_dir by
concatenating "/.git" onto the working tree. That would lead
to "//.git" in this instance, but we actually have "/.git"
(without the doubled slash).

We can fix this by special-casing the root directory. I also
split the logic out into its own function to make the
conditional a bit more readable (and used skip_prefix, which
I think makes it a little more obvious what is going on).

No tests, as we would need to be able to write to "/" to do
so. I did manually confirm that:

  sudo git init /
  cd /
  git rev-parse --show-toplevel
  git config core.worktree

Still finds the top-level correctly (as "/"), and does not
set any core.worktree variable.

Signed-off-by: Jeff King <peff@peff.net>
---
The current behavior isn't _wrong_, in the sense that it's OK to set
core.worktree when we don't need to. But I think it is unnecessarily
confusing to users who expect to be able to move .git directories
around, because it usually just works. So I'd call this an extremely
minor bug.

 builtin/init-db.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6723d39..6efe2df 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -182,6 +182,21 @@ static int git_init_db_config(const char *k, const char *v, void *cb)
 	return 0;
 }
 
+/*
+ * If the git_dir is not directly inside the working tree, then git will not
+ * find it by default, and we need to set the worktree explicitly.
+ */
+static int needs_work_tree_config(const char *git_dir, const char *work_tree)
+{
+	/* special case that is missed by the general rule below */
+	if (!strcmp(work_tree, "/") && !strcmp(git_dir, "/.git"))
+		return 0;
+	if (skip_prefix(git_dir, work_tree, &git_dir) &&
+	    !strcmp(git_dir, "/.git"))
+		return 0;
+	return 1;
+}
+
 static int create_default_files(const char *template_path)
 {
 	const char *git_dir = get_git_dir();
@@ -274,10 +289,8 @@ static int create_default_files(const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
-		if (!starts_with(git_dir, work_tree) ||
-		    strcmp(git_dir + strlen(work_tree), "/.git")) {
+		if (needs_work_tree_config(git_dir, work_tree))
 			git_config_set("core.worktree", work_tree);
-		}
 	}
 
 	if (!reinit) {
-- 
2.4.0.rc0.363.gf9f328b
