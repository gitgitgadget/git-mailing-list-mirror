From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Sat, 03 Feb 2007 16:23:38 -0800
Message-ID: <7v8xfe22k5.fsf@assigned-by-dhcp.cox.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
	<20070201234805.3313.20525.stgit@gandelf.nowhere.earth>
	<b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com>
	<20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
	<20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net>
	<b0943d9e0702021501g2cb9bb6cocae0d706c8742868@mail.gmail.com>
	<b0943d9e0702021525o2379883aqaf27f874134668c5@mail.gmail.com>
	<20070203214619.GM5362@nan92-1-81-57-214-146.fbx.proxad.net>
	<7v8xfe3kwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 01:24:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDVAu-0002vY-VS
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 01:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbXBDAXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 19:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbXBDAXl
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 19:23:41 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:43609 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751258AbXBDAXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 19:23:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204002340.IDOP4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 19:23:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KCPf1W00E1kojtg0000000; Sat, 03 Feb 2007 19:23:39 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38621>

Junio C Hamano <junkio@cox.net> writes:

> Yann Dirson <ydirson@altern.org> writes:
> ...
>> Since branch.*.merge accept local ref names, there is probably far
>> more to change that what I initially feared.
>
> If that is the case maybe we should fix branch.*.merge not to
> match the local tracking branch name.  Matching it with local
> tracking branch name when the remote name does not match was
> werely a fallback to help broken configurations confused people
> might create by hand, and has never been the part of sane
> practice at all.

That is, I suspect that reverting 80c79776 would make things a
lot more consistent.

-- >8 --
[PATCH] Revert "Allow branch.*.merge to talk about remote tracking branches."

This reverts commit 80c797764a6b6a373f0f1f47d7f56b0d950418a9.

Back when I committed this, it seemed to be a good idea.  People
who always use remote tracking branches can optionally use the
local name they happen to use to specify what to merge, which meant
that I did not have to teach them why we use the name at the remote
side every time they are confused.

But allowing it seems to break other people's scripts.  The real
solution is not to allow more ways to express the same thing, but
to educate people to use the right syntax.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-parse-remote.sh |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 3e783b7..5208ee6 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -174,12 +174,8 @@ canon_refs_list_for_fetch () {
 		else
 			for merge_branch in $merge_branches
 			do
-			    if	test "$remote" = "$merge_branch" ||
-				test "$local" = "$merge_branch"
-			    then
-				    dot_prefix=
-				    break
-			    fi
+			    [ "$remote" = "$merge_branch" ] &&
+			    dot_prefix= && break
 			done
 		fi
 		case "$remote" in
-- 
1.5.0.rc3.24.g2391
