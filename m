From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge performance problem..
Date: Sat, 15 Jul 2006 21:24:48 -0700
Message-ID: <7vlkqukwhb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607151445270.5623@g5.osdl.org>
	<7v7j2eme3u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 16 06:25:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1yBr-00032b-67
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 06:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWGPEYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 00:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWGPEYu
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 00:24:50 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60066 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964884AbWGPEYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jul 2006 00:24:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060716042449.LQZS6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Jul 2006 00:24:49 -0400
To: git@vger.kernel.org
In-Reply-To: <7v7j2eme3u.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 15 Jul 2006 20:18:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23943>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> Junio, I think there is something wrong with git-merge. It sometimes takes 
>> up to ten seconds, and it's stuck at the
>>
>> 	git-show-branch --independent "$head" "$@"
>>
>> call.
>>
>> I don't know quite what that thing is even meant to do (we do already know 
>> the parents, why do we do something special here?) but even apart from 
>> that, the whole thing must be doing something seriously wrong, since it 
>> takes so long. Does it check the whole commit history?
>
> The code is to cull redundant parents primarily in octopus and
> is not strictly necessary.

Wrong.  The commit log says it was to remove redundant parents;
I think this as a reaction after seeing a few incorrectly made
merge commits in the kernel archive.

> ..., but in your case you never do an octopus so
> that would be the other branch head) to see what is going on
> please?

Disregard this request please.  I see a few commits that this
step takes a long time to process in the kernel archive.  The
last merge before you left to Ottawa was one of them.

b5032a5 48ce8b0

I do not think we need to do the --independent check there
especially for two-head cases because we have already done
fast-forward and up-to-date tests when we get there, so let's
revert that part from commit 6ea2334.

-- >8 --

diff --git a/git-merge.sh b/git-merge.sh
index 24e3b50..ee41077 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -314,7 +314,11 @@ # If we have a resulting tree, that mean
 # auto resolved the merge cleanly.
 if test '' != "$result_tree"
 then
-    parents=$(git-show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
+    parents="-p $head"
+    for remote
+    do
+	parents="$parents -p $remote"
+    done
     result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents) || exit
     finish "$result_commit" "Merge $result_commit, made by $wt_strategy."
     dropsave
