From: Steinar Bang <sb@dod.no>
Subject: Re: Merging back from master but keeping a subtree
Date: Wed, 16 Nov 2011 14:39:40 +0100
Organization: Probably a good idea
Message-ID: <87aa7wrxsz.fsf@dod.no>
References: <87y5xn8v6z.fsf@dod.no>
	<20110918033719.GB17977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 14:40:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQfib-0003VR-PJ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 14:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291Ab1KPNj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 08:39:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:52179 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757112Ab1KPNj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 08:39:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RQfiS-0003QY-UE
	for git@vger.kernel.org; Wed, 16 Nov 2011 14:39:52 +0100
Received: from cm-84.208.231.161.getinternet.no ([84.208.231.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 14:39:52 +0100
Received: from sb by cm-84.208.231.161.getinternet.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 14:39:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: cm-84.208.231.161.getinternet.no
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:JevIiI0lyP9ZALVsMlbRKAQalUc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185546>

>>>>> Jeff King <peff@peff.net>:

> Git should generally do that automatically, unless both sides are
> changing mydirectory. In which case it will produce conflicts.

I thought so too, but the end result didn't build, and I was unable to
figure out why.

> Are you sure you really want to just throw out what the other side did
> in mydirectory?

Yes, that's the only thing I'm sure about.  All changes to mydirectory
should come from my branch.  If there are changes necessary to make
things build, they are better done by me.

> If git was able to auto-merge some files, then they will not be marked
> as conflicts in the index. And "git checkout --ours" is about looking in
> the index for conflicted entries, and then selecting one side.

> I think what you want instead is to do is (assuming you really want to
> throw out their side):

Thanks for the suggestion.  I tried following this approach, but...

>   1. Start a merge between them and us:

>        git merge --no-commit remoterepo/master

>   2. Throw out whatever the merge came up with and make it look like
>      their tree:

...I never quite could figure out if I did the right thing here.
Ie. when throwing out what the commit came up with.

>        git checkout remoterepo/master -- top

>   3. Now overwrite their version of mydirectory with what was in your
>      branch:

>        git checkout HEAD -- top/middle/mydirectory

>   4. Commit the resulting tree:

>        git commit

The problem was that the end result didn't build, wit pretty much the
same obscure failures that the regular merge had.

But I eventually tried something that worked:
 1. First create a local branch off master
 2. Merge in mybranch with "-s ours --no-commit"
 3. Checkout mydirectory from mybranch
 4. Commit
 5. Switch to mybranch
 6. Merge in the new local branch, which resulted in a conflict-free
    merge that has my changes in mydirectory and the rest of the world
    in the rest of the working directory, and the history of mydirectory
    looks ok

The end result built and worked.

If git had had a "-s theirs" strategy, I wouldn't have needed the
temporary branch made off master.  That need for that branch is probably
the most cryptic thing for people following my instructions for future
merges.

To sum up the commands:
 git checkout master
 git checkout -b master_nicely_merged_with_mybranch
 git merge -s ours --no-commit origin/mybranch
 git checkout origin/mybranch top/middle/mydirectory
 git commit
 git checkout mybranch
 git merge master_nicely_merged_with_mybranch

Thanks!


- Steinar
