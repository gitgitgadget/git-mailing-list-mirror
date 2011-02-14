From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Mon, 14 Feb 2011 08:51:21 -0500
Message-ID: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, <santi@agolina.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 14:51:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Poyq8-0001mJ-RH
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 14:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab1BNNvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 08:51:39 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38998 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab1BNNvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 08:51:37 -0500
Received: by vws16 with SMTP id 16so3003366vws.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=tyLHmI+lUxicupYRYgopgTK4BMj8ETnexbmZFdzC0Oc=;
        b=wilv1JWH+SA8gY5TXS/gWujD6mEbH2dq1xUpsks+QTaOsMy82ZiJTGp+hkj/4gLGG+
         CzcjGK8Fx2ZTCN9r0GsF0yOR/yRAJXNIkcrDMrtciObcDCPRLSnRKs3ceBvWmDPysaQT
         WRJ7T61MiBlrQwE1OGLoAm2l19vP+eX3DlOXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=j3FiUSs1cGloxJgdQY0N/nj3N1w2Kv5QY0qb4VfQP3ewBKxiLe/NwdQWcYsCIbGiXs
         161t82JPBLP2oYDrN6Vczb0Rf5SJ3QUwwDx4MR1r2HC2jmUfppumvYjeGK6aRM/3+dzs
         WZaJbUSoAul/nI91CUdSFoelmvebwTEYA/n0g=
Received: by 10.220.176.65 with SMTP id bd1mr945352vcb.275.1297691496648;
        Mon, 14 Feb 2011 05:51:36 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id i1sm1889253vby.11.2011.02.14.05.51.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 05:51:35 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166710>

Since c85c792 (pull --rebase: be cleverer with rebased upstream
branches, 2008-01-26), 'git pull --rebase' has used the reflog to try
to rebase from the old upstream onto the new upstream.

However, if, instead of 'git pull --rebase', the user were to do 'git
fetch' followed by 'git rebase', the reflog would not be walked. This
patch teaches "git rebase" the same reflog-walking tricks that 'git
pull --rebase' already knows.

This may be useful for rebasing one branch against another local
branch that has been rebased. Currently, you would have to do that
using 'git rebase --onto' or by configuring it on the branch.

It might seem like most of the related code in git-pull.sh can be
removed once git-rebase.sh supports reflog walking. Unfortunately, not
much of it can be removed, though. The reason is that git-pull.sh
simulates one step of "reflog walking" by keeping track of the
position of the remote-tracking branch before and after the fetch
operation. This does not rely on reflogs. There are at least two cases
where the reflog is not used: a) when it is disabled, b) when the
remote branch was specified on the command line (as in 'git pull
--rebase origin master').  In both of these cases, git-pull.sh
remembers the position of the reference before the fetch and uses that
as a kind of '$upstream@{1}'.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
    This applies on top of mz/rebase.

    I have been using this in combination with the patch for defaulting
    rebase to @{upstream} for a few months now. I find it very convenient
    e.g. when Junio has published some changes and I want to rebase my
    branches. Then I just go to each of my branches and run 'git rebase'
    without any arguments, and they get rebased correctly, whether they
    are based on origin/master, origin/pu (they shouldn't be, but let's
    say they are anyway), or on a local branch that is in turn based on
    e.g. origin/master.

    HOWEVER, this causes a very noticable delay in some cases. With this
    patch, 'git rebase' walks the reflog of the upstream ref until it
    finds a commit that the branch-to-rebase contains. If the upstream ref
    has moved a lot since the branch was last rebased, there may be quite
    a few commits to test before the old upstream commit is found.

    The same thing can already occur with 'git pull --rebase' for exactly
    the same reasons. For example, assume that your upstream remote branch
    changes quite frequently and that you often fetch from the remote so
    that your origin/master gets a long reflog. If you then checkout some
    branch you had not been working on for a while, and run 'git pull',
    you get into the same situation. The delay is probably less likely to
    be noticed in the case of 'git pull --rebase', however, since most
    users will probably assume it is a problem with the network or the
    server.

    Of course, 'git pull --rebase' can also be used with a local branch
    configured as upstream. In this case, the behavior today is just like
    what this patch introduces for 'git rebase'.

    What do you think? I think it's a useful feature, but how do we handle
    the delay problem? Maybe simply by making it configurable?

    Should such a configuration variable apply to 'git pull --rebase' as
    well? It would seem inconsistent otherwise, but maybe that's ok since
    'git pull --rebase' is usually used with remote-tracking branches,
    which probably change less frequently. Btw, is this a correct
    assumption? It is definitely true for my own work on git, but I
    actually think it's the other way around for my work at $dayjob. Am I
    missing some part to the puzzle that explains why I had not noticed
    the delay until I started using this patch?


 Documentation/git-rebase.txt |    7 ++++++-
 git-rebase.sh                |   13 +++++++++++++
 t/t3400-rebase.sh            |   26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 095a67f..d4dbe28 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -24,7 +24,12 @@ it remains on the current branch.
 All changes made by commits in the current branch but that are not
 in <upstream> are saved to a temporary area.  This is the same set
 of commits that would be shown by `git log <upstream>..HEAD` (or
-`git log HEAD`, if --root is specified).
+`git log HEAD`, if --root is specified). If, however, there is a ref
+for the upstream branch, and this branch was rebased since the
+current branch was last rebased, the rebase uses that information to
+avoid rebasing changes done on the upstream branch. If you do not want
+'git rebase' to use this intelligence, refer to the upstream without
+using a reference (e.g. 'master~0').
 
 The current branch is reset to <upstream>, or <newbase> if the
 --onto option was supplied.  This has the exact same effect as
diff --git a/git-rebase.sh b/git-rebase.sh
index 5abfeac..1bc0c29 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -466,6 +466,19 @@ esac
 
 require_clean_work_tree "rebase" "Please commit or stash them."
 
+test -n "$upstream_name" && for reflog in \
+	$(git rev-list -g $upstream_name 2>/dev/null)
+do
+	if test $reflog = $(git merge-base $reflog $orig_head)
+	then
+		if test $reflog != $(git merge-base $onto $reflog)
+		then
+			upstream=$reflog
+		fi
+		break
+	fi
+done
+
 # Now we are rebasing commits $upstream..$orig_head (or with --root,
 # everything leading up to $orig_head) on top of $onto
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 349eebd..b64df31 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -209,4 +209,30 @@ test_expect_success 'rebase -m can copy notes' '
 	test "a note" = "$(git notes show HEAD)"
 '
 
+test_expect_success 'rebase against rebased upstream uses reflog' '
+	git checkout my-topic-branch &&
+	echo "Conflicting modification" > B &&
+	git add B &&
+	git commit -m "Modify B" &&
+	git reset --hard nonlinear &&
+	git checkout -b old-topic my-topic-branch@{1} &&
+	echo def > D &&
+	git add D &&
+	git commit -m "Add D" &&
+	git rebase my-topic-branch &&
+	test $(git rev-parse HEAD^) = $(git rev-parse my-topic-branch)
+'
+
+test_expect_success 'rebase against forwarded upstream does not reapply patches' '
+	git checkout my-topic-branch &&
+	echo abc > B &&
+	git add B &&
+	git commit -m "Conficting B" &&
+	git reset HEAD~2 &&
+	git reset HEAD@{1} &&
+	git checkout old-topic &&
+	git rebase my-topic-branch &&
+	test $(git rev-parse HEAD^) = $(git rev-parse my-topic-branch)
+'
+
 test_done
-- 
1.7.4.rc2.33.g8a14f
