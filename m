From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [RFC] rebase: be cleverer with rebased upstream branches
Date: Fri, 12 Nov 2010 21:11:53 +0100
Message-ID: <1289592713-11786-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, trast@student.ethz.ch, santi@agolina.net,
	newren@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 13 03:12:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH5bD-0003u3-P2
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 03:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab0KMCMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 21:12:10 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49154 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab0KMCMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 21:12:07 -0500
Received: by vws13 with SMTP id 13so1212312vws.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 18:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YW3X4PdIHuQitZvp2TLcGVY16ovVGIzAEDWMS2darf4=;
        b=MFwG4EU51a6WcEMjtdEA6Rj4aXlfFTyqmAnsXExM3H7y5vv3FdCkvebLhIKy6yXICZ
         Zp5TTaDMIfZl/rmVZsgTgbmeVAq9qWCl9jojICQCOKYXY35CZE6eLu+3JQlv46utqd/w
         twLrCKnldeedQiys2rS3AapCOK5M9anKgv2/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tv44LKVJHQKiKmn/5ihLagenXGH8Vxzkpag8CIOYZKvrTotE0KhabWf7jQ+s1dmAUb
         V9HPidmbmULaksE9PwBy8gC7SiVhnD+wXPQ59L3150NU1b8/fKT2GDsVa/XOr+fRrohA
         KfROvJmNkP3+C/YWKH2mU/dxNmalaA5wXYD9E=
Received: by 10.220.188.4 with SMTP id cy4mr716280vcb.265.1289614325233;
        Fri, 12 Nov 2010 18:12:05 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id w5sm1112886vcr.6.2010.11.12.18.12.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 18:12:04 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161381>

Since c85c792 (pull --rebase: be cleverer with rebased upstream
branches, 2008-01-26), 'git pull --rebase' has used the reflog to try to
rebase from the old upstream onto the new upstream.

However, if, instead of 'git pull --rebase', the user were to do 'git
fetch' followed by 'git rebase @{upstream}', the reflog would not be
walked. This patch teaches "git rebase" the same reflog-walking tricks
that 'git pull --rebase' already knows.

Apart from making 'git rebase' better aligned with 'git pull --rebase',
this may also be useful on its own for rebasing one branch against
another local branch that has been rebased. Currently, you would have to
do that using 'git rebase --onto' or by configuring it on the branch.

It might seem like most of the related code in git-pull.sh can be
removed once git-rebase.sh supports reflog walking. Unfortunately, not
much of it can be removed, though. The reason is that git-pull.sh does
one step of 'reflog' walking even when the reflog is not used. There are
at least two cases where the reflog is not used: a) when it is disabled,
b) when the remote branch was specified on the command line (let's say
'git pull --rebase origin master'). In both of these cases, git-pull.sh
remembers the position of the reference before the fetch and uses that
in place of '$ref@{1}'.
---
Junio, don't apply this patch yet, as I will rebase it on top of the
refactored rebase code once I'm done with that (to make it work with
interactive rebase as well).

However, it should apply cleanly on top of the patches in
http://thread.gmane.org/gmane.comp.version-control.git/160682/, and maybe
even right on top of master.

The documentation was copied from git-pull before the patch on on that
documentation that I sent out a little while ago, so the documentation
for this patch will at the very least be updated accordingly.

Should the "RECOVERING FROM UPSTREAM REBASE" section of
Documentation/git-rebase.txt be updated?


 Documentation/git-rebase.txt |    7 ++++++-
 git-rebase.sh                |   13 +++++++++++++
 t/t3400-rebase.sh            |   26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 30e5c0e..1baddd2 100644
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
index 847555c..fade99a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -495,6 +495,19 @@ case "$#" in
 esac
 orig_head=$branch
 
+test -n $upstream_name && for reflog in \
+	$(git rev-list -g $upstream_name 2>/dev/null)
+do
+	if test $reflog = $(git merge-base $reflog $branch)
+	then
+		if test $reflog != $(git merge-base $onto $reflog)
+		then
+			upstream=$reflog
+		fi
+		break
+	fi
+done
+
 # Now we are rebasing commits $upstream..$branch (or with --root,
 # everything leading up to $branch) on top of $onto
 
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
1.7.3.2.167.ga361b
