From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-commit: avoid always using reduce_heads()
Date: Fri,  3 Oct 2008 14:04:47 +0200
Message-ID: <1223035487-2576-1-git-send-email-vmiklos@frugalware.org>
References: <20081003023518.GA3291@spearce.org>
Cc: SZEDER Gabor <szeder@ira.uka.de>, jnareb@gmail.com,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Oct 03 14:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KljPy-0000as-Nw
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 14:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbYJCME3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 08:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbYJCME3
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 08:04:29 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:42328 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbYJCME1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 08:04:27 -0400
Received: from vmobile.example.net (dsl5401CD67.pool.t-online.hu [84.1.205.103])
	by yugo.frugalware.org (Postfix) with ESMTPA id E0CBD149C60;
	Fri,  3 Oct 2008 14:04:24 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7DFA019E7C3; Fri,  3 Oct 2008 14:04:47 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <20081003023518.GA3291@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97418>

In case git merge --no-ff is used with --no-commit or we have a
conflict, write info about if fast forwards are allowed or not to
$GIT_DIR/MERGE_MODE.

Based on this info, don't run reduce_heads() in case fast-forwards are
denied, to avoid turning a 'merge --no-ff' to a non-merge commit.

Test case by SZEDER Gabor <szeder@ira.uka.de>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Oct 02, 2008 at 07:35:18PM -0700, "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > +   unlink(git_path("MERGE_MODE"));
> >     unlink(git_path("SQUASH_MSG"));
> >
> >     if (commit_index_files())
>
> Hmmph.  Should branch.c and builtin-reset.c clean this new file
> up too?

Right, I added it to branch.c::remove_branch_state() and
builtin-merge.c::drop_save(). I don't think I should touch
builtin-reset.c, it does not delete MERGE_HEAD/MERGE_MSG either.

> > +           fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT,
> > 0666);
> > +           if (fd < 0)
> > +                   die("Could open %s for writing",
> > git_path("MERGE_MODE"));
> > +           strbuf_reset(&buf);
> > +           if (!allow_fast_forward)
> > +                   strbuf_addf(&buf, "no-ff");
> > +           if (write_in_full(fd, buf.buf, buf.len) != buf.len)
>
> Shouldn't we open this file with O_TRUNC to avoid this scenario:
>
>   $ git merge --no-ff --no-commit foo
>   $ git reset --hard
>   $ git merge --no-commit foo
>   ... *sigh* MERGE_MODE still has "no-ff" in it ...
>
> This is especially true since some porcelain (e.g. git-gui) just
> deletes MERGE_HEAD right now and doesn't know about cleaning up
> MERGE_MODE.  We'd want to at least reset it correctly on the next
> invocation to git-merge.

Fixed.

 branch.c         |    1 +
 builtin-commit.c |   13 ++++++++++++-
 builtin-merge.c  |   10 ++++++++++
 t/t7600-merge.sh |    9 +++++++++
 4 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/branch.c b/branch.c
index b1e59f2..205b89d 100644
--- a/branch.c
+++ b/branch.c
@@ -168,5 +168,6 @@ void remove_branch_state(void)
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_RR"));
 	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
 }
diff --git a/builtin-commit.c b/builtin-commit.c
index 55e1087..f546cf7 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -937,6 +937,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
+	struct stat statbuf;
+	int allow_fast_forward = 1;
 
 	git_config(git_commit_config, NULL);
 
@@ -988,7 +990,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		reflog_msg = "commit";
 		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 	}
-	parents = reduce_heads(parents);
+	strbuf_reset(&sb);
+	if (!stat(git_path("MERGE_MODE"), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
+			die("could not read MERGE_MODE: %s", strerror(errno));
+		if (!strcmp(sb.buf, "no-ff"))
+			allow_fast_forward = 0;
+	}
+	if (allow_fast_forward)
+		parents = reduce_heads(parents);
 
 	/* Finally, get the commit message */
 	strbuf_init(&sb, 0);
@@ -1040,6 +1050,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
 
 	if (commit_index_files())
diff --git a/builtin-merge.c b/builtin-merge.c
index 5c65a58..4c9ed5d 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -180,6 +180,7 @@ static void drop_save(void)
 {
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("MERGE_MODE"));
 }
 
 static void save_state(void)
@@ -1210,6 +1211,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			merge_msg.len)
 			die("Could not write to %s", git_path("MERGE_MSG"));
 		close(fd);
+		fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT | O_TRUNC, 0666);
+		if (fd < 0)
+			die("Could open %s for writing", git_path("MERGE_MODE"));
+		strbuf_reset(&buf);
+		if (!allow_fast_forward)
+			strbuf_addf(&buf, "no-ff");
+		if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+			die("Could not write to %s", git_path("MERGE_MODE"));
+		close(fd);
 	}
 
 	if (merge_was_ok) {
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9516f54..98cfc53 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -511,4 +511,13 @@ test_expect_success 'in-index merge' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge --no-ff --no-commit && commit' '
+	git reset --hard c0 &&
+	git merge --no-ff --no-commit c1 &&
+	EDITOR=: git commit &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.6.0.2
