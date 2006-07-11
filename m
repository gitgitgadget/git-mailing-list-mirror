From: Shawn Pearce <spearce@spearce.org>
Subject: Re: reflog doesn't note that commit was --amend-ed, and doesn't record pulls
Date: Mon, 10 Jul 2006 22:48:47 -0400
Message-ID: <20060711024847.GD10700@spearce.org>
References: <e8uele$o7t$2@sea.gmane.org> <e8uhvg$5o1$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 04:48:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G08Iy-0007F6-QE
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 04:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWGKCsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 22:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWGKCsx
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 22:48:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:12721 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965085AbWGKCsw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 22:48:52 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G08If-0005nX-NI; Mon, 10 Jul 2006 22:48:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E5E5420E43C; Mon, 10 Jul 2006 22:48:47 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <e8uhvg$5o1$2@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23682>

Jakub Narebski <jnareb@gmail.com> wrote:
> Additionally, while reflog records git-reset invocations, it doesn't
> distinguish between an ordinary commit, and commit --amend (which I do
> a lot, most time because of forgotten update-index; yes, I know about commit
> -a option ;-). Well, you can extract this information looking at current
> and previous commit sha1, but it would be nice to have it noted somewhat in
> message part of reflog.

I'm attaching a patch below which fixes this.  It denotes the 4
major types of commits: initial, normal, amend, merge.
 
> Reflog doesn't seem also to record pulls (e.g. master branch): pulls has
> empty reflog message part.

Yea, that's a 'TODO' item.  Now that someone is complaining about
it I'll see if I can't get a fix done later tonight for it.
Its probably going to be a few patches: one for git-merge and
another for receive-pack.c.

-->--
Record the type of commit operation in the reflog.

If committing a merge (.git/MERGE_HEAD exists), an initial tree
(no HEAD) or using --amend to amend the prior commit then denote
the subtype of commit in the reflog.  This helps to distinguish
amended or merge commits from normal commits.

In the case of --amend the prior sha1 is probably the commit which
is being thrown away in favor of the new commit.  Since it is likely
that the old commit doesn't have any ref pointing to it anymore
it can be interesting to know why that the commit was replaced
and orphaned.

In the case of a merge the prior sha1 is probably the first parent
of the new merge commit.  Consequently having its prior sha1 in the
reflog is slightly less interesting but its still informative to
know the commit was the result of a merge which had to be completed
by hand.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-commit.sh         |    6 +++++-
 t/t1400-update-ref.sh |   19 ++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 22c4ce8..05eccfe 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -635,9 +635,12 @@ fi
 PARENTS="-p HEAD"
 if test -z "$initial_commit"
 then
+	rloga='commit'
 	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
+		rloga='commit (merge)'
 		PARENTS="-p HEAD "`sed -e 's/^/-p /' "$GIT_DIR/MERGE_HEAD"`
 	elif test -n "$amend"; then
+		rloga='commit (amend)'
 		PARENTS=$(git-cat-file commit HEAD |
 			sed -n -e '/^$/q' -e 's/^parent /-p /p')
 	fi
@@ -649,6 +652,7 @@ else
 	fi
 	PARENTS=""
 	current=
+	rloga='commit (initial)'
 fi
 
 if test -z "$no_edit"
@@ -724,7 +728,7 @@ then
 	fi &&
 	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
 	rlogm=$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
-	git-update-ref -m "commit: $rlogm" HEAD $commit $current &&
+	git-update-ref -m "$rloga: $rlogm" HEAD $commit $current &&
 	rm -f -- "$GIT_DIR/MERGE_HEAD" &&
 	if test -f "$NEXT_INDEX"
 	then
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index df3e993..6a3515d 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -188,17 +188,30 @@ test_expect_success \
 	 echo OTHER >F &&
 	 GIT_AUTHOR_DATE="2005-05-26 23:41" \
 	 GIT_COMMITTER_DATE="2005-05-26 23:41" git-commit -F M -a &&
-	 h_OTHER=$(git-rev-parse --verify HEAD)
+	 h_OTHER=$(git-rev-parse --verify HEAD) &&
+	 echo FIXED >F &&
+	 EDITOR=true \
+	 GIT_AUTHOR_DATE="2005-05-26 23:44" \
+	 GIT_COMMITTER_DATE="2005-05-26 23:44" git-commit --amend &&
+	 h_FIXED=$(git-rev-parse --verify HEAD) &&
+	 echo TEST+FIXED >F &&
+	 echo Merged initial commit and a later commit. >M &&
+	 echo $h_TEST >.git/MERGE_HEAD &&
+	 GIT_AUTHOR_DATE="2005-05-26 23:45" \
+	 GIT_COMMITTER_DATE="2005-05-26 23:45" git-commit -F M &&
+	 h_MERGED=$(git-rev-parse --verify HEAD)
 	 rm -f M'
 
 cat >expect <<EOF
-$Z $h_TEST $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	commit: add
+$Z $h_TEST $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	commit (initial): add
 $h_TEST $h_OTHER $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000	commit: The other day this did not work.
+$h_OTHER $h_FIXED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151040 +0000	commit (amend): The other day this did not work.
+$h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151100 +0000	commit (merge): Merged initial commit and a later commit.
 EOF
 test_expect_success \
 	'git-commit logged updates' \
 	'diff expect .git/logs/$m'
-unset h_TEST h_OTHER
+unset h_TEST h_OTHER h_FIXED h_MERGED
 
 test_expect_success \
 	'git-cat-file blob master:F (expect OTHER)' \
-- 
1.4.1.gc48f
