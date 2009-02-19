From: John Tapsell <johnflux@gmail.com>
Subject: Re: git merge --abort
Date: Thu, 19 Feb 2009 13:34:03 +0000
Message-ID: <43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
	 <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 14:35:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La93w-0001Dw-8x
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 14:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbZBSNeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 08:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbZBSNeH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 08:34:07 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:36207 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbZBSNeE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 08:34:04 -0500
Received: by gxk22 with SMTP id 22so974289gxk.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=joNCoQm4HHRNDsuHw2GpTHoMp+9yN5Oy1tV3BanjYe0=;
        b=Z+RSDqIYqrmL6h0FF6XoB427ErH6qhs7VS6QS03teRVvmPhXfXer7cOkJKTsW/ak5P
         91j5sFM2aDJ1Gc4D6DWx/tP4sKS9UnUsDolPaAfzDjOdyjh+XjvCon8AM2z2mnEsAQUV
         knYmx009EpMzKP7b4kz/KB4nQjl5CRj2HYqiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=eUt10P+1rG5aBX3JN1RHteL7nRbY4uiffPHAeBaWWUPIDOO6IYg9mGzPY7Sjotsltf
         2O4Cyn2zyD9y+gaPLT1z3MhTWlStFZJ48mb6bUIQnkglcCzF0OcHkI8O2Xxi3R7cbkWO
         G4p4F/9RvCaHvOGhA+gGK2Tf1SORrxIt9pdC8=
Received: by 10.151.107.8 with SMTP id j8mr984856ybm.112.1235050443363; Thu, 
	19 Feb 2009 05:34:03 -0800 (PST)
In-Reply-To: <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110696>

2009/2/19 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:
>
>>   It's not obvious how to abort a merge between two trees.  Would
>> aliasing  "git merge --abort"  to "git reset --hard"  be sensible?
>
> Not at all.  Especially when you have local changes.

Just to confirm that I've understood this - there's currently no way
at the moment to 'cancel' an abort.  In the example you gave:

>    $ edit goodbye.c ;# without "git add"
>    $ git merge other
>    Conflict in hello.c
>    $ git add goodbye.c
>    $ git merge --abort ;# ???

There's no reliable way of getting back to the state before the merge?


> The user's "git add goodbye.c" will make the state of the index unusable
> for the above outlined algorithm to tell what was changed by the merge and
> what were already different before the merge.
>
> So in general, even "merge --abort" implemented according to the above
> outline cannot be sold as "a safe procedure to recover to where you were
> before you started the last failed merge".  There is no such thing, unless
> you really educate the user not to expect miracle.
>
> If you mistakenly run "git merge" while your index is already unmerged
> (iow, after a failed merge before you resolved it nor resetted the index),
> the command aborts without touching the index nor the work tree.  If you
> implement "merge --abort" as outlined above, it will try to abort the
> previous conflicted merge, not this round which did not do anything, but
> again, the user could have done any other random things in addition to the
> attempt to run the second "git merge".
>
> Having said all that, I suspect
>
>        $ git reset --merge HEAD
>
> may do the right thing, if your git already has the option ;-)
>
>
> [Footnote]
>
> *1* CVS/SVN want to linearize so even if your local changes want to go
> directy on top of what you checked out, "cvs update" tries to replay your
> uncommitted changes on top of what comes as the latest from the central
> server, which could result in conflicts.  With git, you do not have to
> risk losing your local changes that way.  Instead, you can commit your
> local changes and then "git pull" will try to merge.  The merge can
> conflict and leave the same mess as "cvs update" would leave when it tries
> to replay your uncommitted changes, but a _huge_ difference here is that
> you get only one chance to resolve that conflict with CVS/SVN (because
> nothing records your local changes before the "update") and if you screw
> that up, you are out of luck.  With git, you have the local commit that
> records the changes you did on top of the old tip of the branch, and you
> can redo the merge.
>
> *2* I say *ought to*, and I am reasonably sure resolve strategy works
> correctly, but I wouldn't be surprised if recursive strategy which is the
> default these days still have corner case bugs when the merge involves
> renames and/or D/F conflicts).
>
