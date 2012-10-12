From: Phil Hord <phil.hord@gmail.com>
Subject: minor bug in git pull --rebase
Date: Fri, 12 Oct 2012 18:47:47 -0400
Message-ID: <CABURp0rxUY9Tj3x3AM7avAg5FXDZXovo-9SZDF5OJ+kxB+nsnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, santi@agolina.net,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 00:48:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMo1m-0001lY-Jq
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 00:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab2JLWsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 18:48:11 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:53578 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab2JLWsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 18:48:10 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2300814lag.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=QYMMwVlGX4ExByNU+NaLnDDLzvEZpHXX+NcRkepY5nE=;
        b=bs7jJrXTOJ7txOIrEmE/e5I7CGjYzoSqsoVxwhK+hij4SMNxK3mlGtUH3wDIKqzkPL
         PTl/4lDgUTngHo900Cn6f81mOvRCjnA3tWADts+nQbzgmIqHXcoB6VHxyLJ3KypMJx+2
         EVW+oe3xM7BE87c+IpIZb3E0S8u9XmgHvn0IMWaaYng1YqcMoKgVLCH1fYgfaYCiTRxx
         BKAKQAMpa19MDjlFfFTOc0p3jgTEm5fpolTl0RPxasZhB1U5CSj+Lc9+cS5XGhDGXepy
         SYo9eJ2i2WaOMM4k8CUf5VSuVwRHGpejg2yE4jUIFyjkQlaN/cPhpDWWas1WGyUdVPVh
         3YSw==
Received: by 10.112.13.173 with SMTP id i13mr2159492lbc.108.1350082088036;
 Fri, 12 Oct 2012 15:48:08 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Fri, 12 Oct 2012 15:47:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207566>

I saw some unexpected usage output today in git pull --rebase when I
was on a detached head.

$ git pull --rebase origin BL/3.0
usage: git merge-base [-a|--all] <commit> <commit>...
   or: git merge-base [-a|--all] --octopus <commit>...
   or: git merge-base --independent <commit>...
   or: git merge-base --is-ancestor <commit> <commit>

    -a, --all             output all common ancestors
    --octopus             find ancestors for a single n-way merge
    --independent         list revs not reachable from others
    --is-ancestor         is the first one ancestor of the other?

>From gerrit:iptv/bootloader-all
 * branch            BL/3.0     -> FETCH_HEAD
First, rewinding head to replay your work on top of it...
Fast-forwarded HEAD to 99ba23a9fce5c5becb9dd86b5f76a8467286d811.
$

It occurs when using pull --rebase on a detached head.  It's because
git-pull doesn't expect ${current_branch} to be empty in some places,
but it does check in others.  It appears to have been introduced three
years ago and no one seems to have complained yet. I hesitate to
mention it during a release cycle, but I worry I'll forget later.

Here's a patch.

-- >8 --
Subject: [PATCH] git-pull: Avoid merge-base on detached head

git pull --rebase does some clever tricks to find the base
for $upstream , but it forgets that we may not have any
branch at all.  As a result, git merge-base emits some
usage noise in the middle of an otherwise successful
rebase operation.

Since we do not need the merge-base trick in the case of a
detached HEAD, detect this condition and bypass the clever
trick.
---
There is another git-merge-base call which may need similar
treatment, but I have not dug deeply enough to see for sure.
 git-pull.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-pull.sh b/git-pull.sh
index 2a10047..266e682 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -200,6 +200,7 @@ test true = "$rebase" && {
 		require_clean_work_tree "pull with rebase" "Please commit or stash them."
 	fi
 	oldremoteref= &&
+	test -n "$curr_branch" &&
 	. git-parse-remote &&
 	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
 	oldremoteref="$(git rev-parse -q --verify "$remoteref")" &&
-- 
1.8.0.rc2.1.g44028c0.dirty

Phil
