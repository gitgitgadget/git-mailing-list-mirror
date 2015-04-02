From: Jeff King <peff@peff.net>
Subject: [PATCH v2] init: don't set core.worktree when initializing /.git
Date: Thu, 2 Apr 2015 14:37:40 -0400
Message-ID: <20150402183739.GA19911@peff.net>
References: <0FD999DB-3DBF-40D4-8128-715BDC49EAAB@free.fr>
 <20150331181552.GC19206@peff.net>
 <20150331183423.GD19206@peff.net>
 <20150331191420.GE22844@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Cedric Gava <gava.c@free.fr>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 20:37:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydjzx-0004sd-R7
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 20:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbbDBSho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 14:37:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:41473 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751688AbbDBShm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 14:37:42 -0400
Received: (qmail 10658 invoked by uid 102); 2 Apr 2015 18:37:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 13:37:42 -0500
Received: (qmail 14184 invoked by uid 107); 2 Apr 2015 18:38:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 14:38:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2015 14:37:40 -0400
Content-Disposition: inline
In-Reply-To: <20150331191420.GE22844@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266654>

On Tue, Mar 31, 2015 at 12:14:20PM -0700, Jonathan Nieder wrote:

> > No tests, as we would need to be able to write to "/" to do
> > so.
> 
> t1509-root-worktree.sh is supposed to test the repository-at-/ case.
> But I wouldn't be surprised if it's bitrotted, since people don't set
> up a throwaway chroot or VM for tests too often.

Thanks, I had thought we had such a test script, but for some reason had
trouble finding it earlier. I couldn't get it to run using the included
t1509/prepare-chroot.sh helper; the resulting chroot was missing several
tools we rely on in test-lib.sh (perl, expr, tr, and mv).

I gave up for now; I don't think rescuing that script is worth the
effort for this minor bug.

> > The current behavior isn't _wrong_, in the sense that it's OK to set
> > core.worktree when we don't need to. But I think it is unnecessarily
> > confusing to users who expect to be able to move .git directories
> > around, because it usually just works. So I'd call this an extremely
> > minor bug.
> 
> This belongs in the commit message.

It's mostly a restatement of what is already in the first paragraph of
the commit message. I folded it into that paragraph.

> > +static int needs_work_tree_config(const char *git_dir, const char *work_tree)
> > +{
> > +	/* special case that is missed by the general rule below */
> 
> (optional) I'd leave out this comment --- it seems obvious enough in
> context and the purpose of the comment is unobvious without looking
> at the history.

OK, dropped. Here's the re-roll.

-- >8 --
Subject: [PATCH] init: don't set core.worktree when initializing /.git

If you create a git repository in the root directory with
"git init /", we erroneously write a core.worktree entry.
This isn't _wrong_, in the sense that it's OK to set
core.worktree when we don't need to. But it is unnecessarily
surprising if you later move the .git directory to another
path (which usually moves the relative working tree, but is
foiled if there is an explicit worktree set).

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

still finds the top-level correctly (as "/"), and does not
set any core.worktree variable.

Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/init-db.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6723d39..ab9f86b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -182,6 +182,20 @@ static int git_init_db_config(const char *k, const char *v, void *cb)
 	return 0;
 }
 
+/*
+ * If the git_dir is not directly inside the working tree, then git will not
+ * find it by default, and we need to set the worktree explicitly.
+ */
+static int needs_work_tree_config(const char *git_dir, const char *work_tree)
+{
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
@@ -274,10 +288,8 @@ static int create_default_files(const char *template_path)
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
