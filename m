From: Sergei Organov <osv@javad.com>
Subject: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 22:39:06 +0300
Message-ID: <87d4uv3wh1.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 20:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InJPS-0002Yf-7m
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 20:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbXJaTjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 15:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbXJaTjO
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 15:39:14 -0400
Received: from javad.com ([216.122.176.236]:3599 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbXJaTjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 15:39:13 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id l9VJdBm83414
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 19:39:12 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1InJP8-0008Ce-6i
	for git@vger.kernel.org; Wed, 31 Oct 2007 22:39:06 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62854>

Hello,

I've made my first attempt at tracking my changes to upstream git
repository using git-fetch/git-rebase workflow. I did three commits to
my master branch, and then upstream incorporated two of them in slightly
modified form, so that some conflicts are to be expected. I did
git-fetch followed by git-rebase, and finally have got the end result I
hoped for, but there were some confusion along the way. I think I'd post
the log of the session here along with my thoughts so that an interested
person could see how it works for a newbie (my thoughts and non-git
actions at the time of rebasing are marked with 'me>' prefix):

$ git fetch
[...]
$ git rebase origin
First, rewinding head to replay your work on top of it...
HEAD is now at 9c51414... Merge branch 'maint' into HEAD

Applying Fix a typo.

Wrote tree f5b2feefc021486eae9d2d84c69e0d6ead027a9d
Committed: 983e907b1360c17c7ac925d6035d82cc7243f406

Applying Use new syntax (-m option) for git-merge.

error: patch failed: Documentation/core-tutorial.txt:878
error: Documentation/core-tutorial.txt: patch does not apply
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merged Documentation/core-tutorial.txt
CONFLICT (content): Merge conflict in Documentation/core-tutorial.txt
Failed to merge in the changes.
Patch failed at 0002.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

me> Nice, this conflict is expected.
me> Editing Documentation/core-tutorial.txt to resolve the
me> conflict... Conflict is resolved so that the working file matches
me> upstream version.

$ git rebase --continue
You must edit all merge conflicts and then
mark them as resolved using git add

me> Nice helpful message, -- need to do git-add

$ git add Documentation/core-tutorial.txt
$ git rebase --continue

Applying Use new syntax (-m option) for git-merge.

No changes - did you forget to use 'git add'?

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

me> What?! I just did the git-add! Moreover, before I did git-add, the
me> error was different and helpful. Something went wrong? 
me> Well, it's unlikely, but maybe I made a mistake of not specifying
me> the 'origin'?

$ git rebase --continue origin

Applying Use new syntax (-m option) for git-merge.

No changes - did you forget to use 'git add'?

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

me> No luck :( A few seconds of thinking... Hmm... no-op patch, do I
me> need to skip it? Let's try the --skip:

$ git rebase --skip

Applying Fix SYNOPSIS.

error: patch failed: Documentation/git-merge.txt:10
error: Documentation/git-merge.txt: patch does not apply
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merged Documentation/git-merge.txt
CONFLICT (content): Merge conflict in Documentation/git-merge.txt
Failed to merge in the changes.
Patch failed at 0003.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

me> Aha, that's it! But why git didn't just skip the no-op patch
me> automatically? Well, anyway , now I have a new expected conflict,
me> and I'm sure I just want to skip this patch, so let's try exactly
me> that:

$ git rebase --skip
Dirty index: cannot apply patches (dirty: Documentation/git-merge.txt)

me> No luck :( Well, let's go the long way, -- edit conflicting
me> Documentation/git-merge.txt (so that it matches upstream),

$ git add Documentation/git-merge.txt
$ git rebase --skip
Nothing to do.

me> Well, I already knew this will work, but why should I edit the file
me> and then git-add it just to skip the patch? Is there better way?
me> Anyway, the "Nothing to do." above is slightly confusing, -- did it
me> actually skip the patch? So let's check the result:

$ gitk

me> The result is as expected, -- the only patch on top of current origin
me> HEAD, -- nice.

-- 
Sergei.
