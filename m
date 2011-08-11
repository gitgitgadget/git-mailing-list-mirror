From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Documenting the 'rebase -i' workflow
Date: Thu, 11 Aug 2011 12:30:07 +0530
Message-ID: <CALkWK0kAX3U9AJvD4Gw9Cwndk9412jB4O_P+OGZKFk4kMhpnsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 11 09:00:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrPFp-0000oR-F3
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 09:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450Ab1HKHA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 03:00:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62256 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab1HKHA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 03:00:28 -0400
Received: by wyg24 with SMTP id 24so1205304wyg.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=eMi1l02xSUhV2RWEULQyYooeFK77s+eFcPsK85KYYbs=;
        b=mg7OaSVESTIOn3WLjWDxU7zewqtwvJ28pkPPMA+5HhQZRLhNE5mprEj4tqZ0xjPR5J
         y2ymXq1QQ7DUUfYoZ3VPY1ITRfyYH5YkW4YXhxec4RbCxAtaztbICajqjdgmp+JJxAql
         RjmDCJN7n6W4Gf7U+I30+USUeDpUge4tGEDn4=
Received: by 10.216.0.66 with SMTP id 44mr7477968wea.63.1313046027117; Thu, 11
 Aug 2011 00:00:27 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Thu, 11 Aug 2011 00:00:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179086>

Hi,

I used to find it hard to resolve conflicts during complex interactive
rebases, and I asked Jonathan for help off-list.  I found the response
very useful.  I thought I should reproduce the original email here so
that everyone on the list can benefit from it.  Please feel free to
add to it.

Also, we should document this somewhere.

-- 8< --
Ramkumar Ramachandra wrote:
> How did you manage to make the rebase look so effortless?  I tried it
> too, but I always end up messing up the conflict resolution, and
> aborting many times before I get it right.  Even after that, I run
> tests on all the patches and correct the pending mistakes by hand.

True, this workflow is underdocumented.  The most important details
are

       [merge] conflictstyle = diff3
       [rerere] enabled

in ~/.gitconfig.  I used to use "git checkout --conflict=diff3"
explicitly instead, which also works.

If you are lucky, a conflict hunk will look something like this:

       <<<<<<< ours
       A
       B
       C
       ||||||| parent of theirs
       B
       =======
       B
       C
       D
       >>>>>>> theirs

It can be merged blindly by following the rule "whenever a feature
is the same between the ancestor and one of the competing versions,
delete it from them".  For example, both the ancestor and "theirs"
have 'B', so:

       <<<<<<< ours
       A
       B
       C
       ||||||| parent of theirs
       =======
       C
       D
       >>>>>>> theirs

Our side and their side both added C independently and from the
context we know that a second 'C' would be redundant.  So we are ready
to resolve the conflict after thinking a little.

       A
       B
       C
       D

Unfortunately sometimes the diff3 conflict style makes conflicts huge
and unmanageable.  That's no good.  I dream of a conflict style that
would show "our" version and the patch hunk to apply.  Since that
doesn't exist yet, often a good strategy is to fake it by looking at
the patch directly.  For example, patches to ChangeLog files rarely
merge cleanly and the conflicts don't tend to be very useful.

       git checkout HEAD ChangeLog
       vim ChangeLog
       :split .git/rebase-merge/patch

"git add" is used to mark good changes and "git diff" to see what's
left to do.  When ready, I build, run some simple tests, "git diff
--cached", "git rebase -i --continue", flinch at how git 1.7.6 broke
my muscle memory, and "git rebase --continue".

Usually I try to only make a single change in an interactive rebase
and let it ripple through, then rinse and repeat.  If something goes
wrong, I can "git rebase --abort" and previous unrelated changes are
not lost.

After a rebase, I use "git diff" to compare to the previous version,
to make sure the changes accumulated are good and nothing was lost.

Summary:

 - conflictstyle=diff3 makes 3-way merging require way less thought
  and history mining.  I don't know how I coped with
  conflictstyle=merge.

 - For thorny cases, "git checkout --ours file" unapplies the patch.
  Then one can

   (a) apply the patch by hand, if it is short.
   (b) fix up the patch by hand and apply it with "git apply", if
       it is long.

  The patch is in .git/rebase-merge/patch.

 - "git rerere forget" is a lifesaver.

 - Check for sanity at each step (by running manual or automatic
  tests) before continuing.

 - Inspect with "git log -p" and by diffing against a merge of the
  pre-rebase state with the new upstream when done.
