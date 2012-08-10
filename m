From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: cherry-pick and 'log --no-walk' and ordering
Date: Fri, 10 Aug 2012 13:41:36 -0700
Message-ID: <CAOeW2eE=VcUs1YcWqqEUc6vM6jW9JaXzE-_tVWy48VtPzm_+wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 22:42:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szw1e-0002wa-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 22:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab2HJUlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 16:41:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49067 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645Ab2HJUlg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 16:41:36 -0400
Received: by pbbrr13 with SMTP id rr13so3261845pbb.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 13:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=ZxeWBtrydpcpugYjr9FHXbfQSa+bTIk8a3y3iCQbgQ4=;
        b=F1FF4C0SKxMGTjrSzQqIduIuOqfjlYbU1Blcz8PQj6/TUFEaO2y2+Su9rWThUlGvMI
         XQJv7Ro7FUXL4U0I6Pai3l4GxN3zJj0Rm+Mhy0hfEope4J35xb8tAMpgvd1t/qPNTA2w
         Mmx/oJJ0PCtSD++Y6uztX7Fy2//Hox5KEs6Gp4SewAfkzCJO3ggYdobr5rMMuigQcyyR
         PnDwX5WDPTyDUFh4hDw6IIK5hcdztTxMfmMoURsZ0/fGXTugwRP5cH6zX5K1dmtXV19S
         rmw3Xcuhs3GxqE+fHvqat5q8gWyX9C78xK67T5rQ9/HR7YX5BjrljctuZSzzNkRYIQs3
         MWHQ==
Received: by 10.68.241.228 with SMTP id wl4mr402046pbc.51.1344631296154; Fri,
 10 Aug 2012 13:41:36 -0700 (PDT)
Received: by 10.68.42.164 with HTTP; Fri, 10 Aug 2012 13:41:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203259>

A while ago when I was looking at revision.c, I was surprised to see
that commits are sorted even when --no-walk is passed, but as 8e64006
(Teach revision machinery about --no-walk, 2007-07-24) points out,
this can be useful for doing

 $ git log --abbrev-commit --pretty=oneline --decorate --all --no-walk

and get the result sorted by date. However, it can also be useful
_not_ to get a result sorted by date, e.g. when doing something like
"<generate an ordered list of revisions> | git rev-list --oneline
--no-walk --stdin". Would a --no-sort option to rev-list be
appreciated or are there better solutions?

There is also cherry-pick/revert, which I _think_ does not really want
the revisions sorted. cherry-pick implicitly reverses the order of the
walk, so 'git cherry-pick branch~2..branch' applies them in the right
order (at least in the absence of clock skew). The documentation for
cherry-pick suggests "git rev-list --reverse master -- README | git
cherry-pick -n --stdin", which I think makes no sense -- this would
reverse the output from rev-list only to have it reversed again in
cherry-pick, if it wasn't for the sorting by date. I think the
--reverse passed to rev-list might even break the cherry-pick if there
are commits in non-increasing date order. This is also supported by
the fact that test still pass after applying the patch below. I think
the test cases make more sense after the patch.

Do others agree with the analysis? I suppose it's too late to change
cherry-pick to start differentiating between "git cherry-pick commit1
commit2" and "git cherry-pick commit2 commit1", but I think we should
at least update the documentation as in the patch below (or maybe even
with a --topo-order passed to cherry-pick?). We could possibly change
cherry-pick's ordering from the default ordering to topological
ordering.



Martin


Sorry about the mangled whitespace below; just for reference, not
intended to be applied.

diff --git a/Documentation/git-cherry-pick.txt
b/Documentation/git-cherry-pick.txt
index 0e170a5..454e205 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -181,7 +181,7 @@ EXAMPLES
        are in next but not HEAD to the current branch, creating a new
        commit for each new change.

-`git rev-list --reverse master -- README | git cherry-pick -n --stdin`::
+`git rev-list master -- README | git cherry-pick -n --stdin`::

        Apply the changes introduced by all commits on the master
        branch that touched README to the working tree and index,
diff --git a/t/t3508-cherry-pick-many-commits.sh
b/t/t3508-cherry-pick-many-commits.sh
index 75f7ff4..020baaf 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -164,7 +164,7 @@ test_expect_success 'cherry-pick --stdin works' '
        git checkout -f master &&
        git reset --hard first &&
        test_tick &&
-       git rev-list --reverse first..fourth | git cherry-pick --stdin &&
+       git rev-list first..fourth | git cherry-pick --stdin &&
        git diff --quiet other &&
        git diff --quiet HEAD other &&
        check_head_differs_from fourth
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index f4e6450..9e28910 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -400,7 +400,7 @@ test_expect_success '--continue of single-pick
respects -x' '

 test_expect_success '--continue respects -x in first commit in multi-pick' '
        pristine_detach initial &&
-       test_must_fail git cherry-pick -x picked anotherpick &&
+       test_must_fail git cherry-pick -x anotherpick picked &&
        echo c >foo &&
        git add foo &&
        git cherry-pick --continue &&
@@ -430,7 +430,7 @@ test_expect_success '--signoff is not
automatically propagated to resolved confl

 test_expect_success '--signoff dropped for implicit commit of
resolution, multi-pick case' '
        pristine_detach initial &&
-       test_must_fail git cherry-pick -s picked anotherpick &&
+       test_must_fail git cherry-pick -s anotherpick picked &&
        echo c >foo &&
        git add foo &&
        git cherry-pick --continue &&
