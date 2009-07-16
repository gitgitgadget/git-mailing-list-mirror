From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of 
	subtrees separately.
Date: Thu, 16 Jul 2009 14:34:58 -0400
Message-ID: <32541b130907161134n51e070a1l93690d1b8a63bee8@mail.gmail.com>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com> 
	<32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com> 
	<20090430085853.GA21880@pvv.org> <32541b130904300732i691800f5kecc2f845584071c1@mail.gmail.com> 
	<loom.20090716T160021-218@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrey Smirnov <allter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 20:35:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRVnj-0005vi-QG
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 20:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027AbZGPSfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 14:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933024AbZGPSfU
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 14:35:20 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:43750 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933019AbZGPSfT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 14:35:19 -0400
Received: by gxk9 with SMTP id 9so525988gxk.13
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cvXRc3IYfiHA3mFOaTn3a8I3s6O08r8M1j9u9pjEzA8=;
        b=Mi2qKVjocIbN5yG0UKzdEqWMkQzmieMbwETVrOSe9PULqBnx/CAedk9hUlPlZzyZO2
         NJuviXN1bMYvmea+vOJiX2sL06nm9uoNt1XDTr/pen5j57Yz+RZyMFIDLa/+2b3R9qDv
         7LjGZf/B6dXi94bD5SkVfHRh5EG0nmKt0mntk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=F4LgzRC5qEIZWp99ne0M+IjEnqqUAXKFAYZhoK2D3rLllgnCzUlgbpI/99xHD6Q2y5
         K8iLNn79PzV+1ihZOWgcbLqn7avIh+HyTEydNpGNa53ORSuG4piqtAym3Q/QMsJVojXr
         7PrbecJO/j1sDVuSnV7EEle8qt6cfr96fnwvQ=
Received: by 10.151.112.4 with SMTP id p4mr311544ybm.129.1247769318062; Thu, 
	16 Jul 2009 11:35:18 -0700 (PDT)
In-Reply-To: <loom.20090716T160021-218@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123414>

On Thu, Jul 16, 2009 at 2:04 PM, Andrey Smirnov<allter@gmail.com> wrote=
:
> I found the git-subtree aproach of handling sub-repositories very int=
eresting
> and useful to me. This is the previous-to-last feature I've awaited f=
rom DVCS
> world since I went into it.

I'm glad you like it.

> My goal was to rebase changes to shared library of two similar projec=
ts from one
> project to another. The commits in the more recent project were touch=
ing both
> lib/ directory with shared library and the rest of the project.
>
> When I did
> =A0 git subtree split --prefix=3Dlib NewProj -b test-split
> =A0and
> =A0 git subtree split --prefix=3Dlib OldProj -b test-split-old
> I got the following two trees without a common root:
>
> ...X ----- Y ----- OldProj ----...---- Z ---- NewProj
>
> X' ----- Y'=3D=3Dtest-split-old ----- Z'=3D=3Dtest-split

So, why don't they have a common root?  This is, of course, the
primary cause of your problems.

How did this shared library get merged into OldProj and NewProj in the
first place?  Did you just copy the files, or did you use something
like 'git merge -s subtree'?  If the latter, you should be able to
convince git-subtree to produce two split repositories with identical
roots, and then merge smoothly between them.

If you just copied the files (or applied patches with git-rebase, etc)
then a common root is impossible, and you'll have to repair the
damage, as I'll explain below:

> Problem:
>
> When I did
> =A0 git subtree merge test-split --prefix=3Dlib
> it printed:
> =A0Auto-merged lib/x.cgi
> =A0CONFLICT (add/add): Merge conflict in lib/x.cgi
> =A0Auto-merged lib/y.cgi
> =A0CONFLICT (add/add): Merge conflict in lib/y.cgi
> =A0Automatic merge failed; fix conflicts and then commit the result.
>
> It's obvious that it should be that way because logically both trees =
don't have
> the same root at the time of merge. But I've expected subtree merge -=
-prefix
> will understand that X' is identical to changes to 'lib/*' in X, Y' t=
o Y and Z'
> to Z.

'git subtree merge' is just like 'git merge' - if you don't have a
shared merge-base commit, it won't know what to do, and will have to
guess.

> Solution:
>
> =A0 =A0git rebase --onto OldProj test-split-old test-split
> it printed:
> =A0First, rewinding head to replay your work on top of it...
> =A0Applying ZZZZZ
> =A0error: x.cgi: does not exist in index
> =A0error: y.cgi: does not exist in index
> =A0Using index info to reconstruct a base tree...
> =A0Falling back to patching base and 3-way merge...
>
> I don't know what magic it used but it did rebase right. Furthermore =
"-s
> subtree" didn't work at all:
> =A0 =A0git rebase --onto OldProj test-split-old test-split -s subtree
> =A0First, rewinding head to replay your work on top of it...
> =A0Fast-forwarded OldProj to OldProj.

Now you've just made a mess.  Instead, I might have tried something lik=
e this:

  git checkout -b test-merged test-split
  git rebase test-split-old

Now you've got a split branch test-merged that should contain all the
changes from both test-split and test-split-old, and its parentage is
test-split-old.  Let's make it so that it can merge conflict-free into
either branch:

  git merge -s ours test-split

Next, you merge it into one of your main projects:

  git checkout OldProj
    # you should have used split --rejoin earlier, and the next
command wouldn't be necessary here
  git subtree split --prefix=3Dlib OldProj --rejoin
  git subtree merge --prefix=3Dlib test-merged

And the other:

  git checkout NewProj
    # you should have used split --rejoin earlier, and the next
command wouldn't be necessary here
  git subtree split --prefix=3Dlib NewProj --rejoin
  git subtree merge --prefix=3Dlib test-merged

Now both projects are caught up with test-merged, and moreover, if you
split either of them in the future, they will share a common
merge-base (ie. today's value of test-merged).  Future merges will
therefore be easier.

> And so I ask if this behavior is the way git-subtree was meant to wor=
k.
> It probably has sense to add 'rebase' command to git-subtree script t=
o let
> perform such tasks simplier.

I don't think that's a good idea.  git-subtree is completely separate
from rebasing, and doesn't deal with patches at all.  Maybe there
should be some kind of "force-update" option that does what "git
subtree add" does, but wiping out everything in the subtree before it
starts.  That would have simplified the above commands a bit.

Avery
