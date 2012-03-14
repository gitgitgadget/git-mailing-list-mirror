From: Avishay Lavie <some.avish@gmail.com>
Subject: Re: git-svn with svn.pushmergeinfo incorrectly creates
 self-referencing svn:mergeinfo properties
Date: Wed, 14 Mar 2012 13:38:42 +0200
Message-ID: <CAHkK2bqo63zk1NYSoTUZJuL4W+=n_njZOPQvr1WhuBOqk=Xk3A@mail.gmail.com>
References: <CAHkK2bpg3AYtue=uPVXFMqkyjL5xuZNhfJ6vy-pj2T8Q88ysqg@mail.gmail.com>
 <CAHkK2bokWzhtaB9CEEG3Uths1DXHAzj7QzH0V3p0FGvE_ua2hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 12:39:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7mXu-0002iV-FV
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 12:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610Ab2CNLjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 07:39:06 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48121 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab2CNLjD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 07:39:03 -0400
Received: by wibhj6 with SMTP id hj6so6989557wib.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=0yEMinmmK9Zq5HaZq6YlVUdtb2fxH8KftItIAzbsAS4=;
        b=D+13aU9+M4YI33+bI2CtmjYX0q5QCRrMhGg/IxVrvZ9lDkQ2dfjuUmc74kjqX1OuvR
         bL0TImgKf7S4tRD5RzknFCFgr53Falsvkpous9cU2NcT0C3LwwwpW9xRMAvW6KJIKDJD
         qEU031LyN/JQWLJn8e1A8acRkIy20jUPBfG/O7VoplKBLjM0Xpjps8nAL06DadeBQXMl
         WrsFahowt2vXVuY7XgKYTekumlZNNkh5etocPf+4dLIH1aKmQHzgneZXGC8WdO7ms7qJ
         IFhHvO24b6IaBt65K2DisxHAEM8r+qxZuIWXgOhbKSO4EFsTXdewxFOIkktPY2J+ay1S
         0ZZA==
Received: by 10.216.131.212 with SMTP id m62mr1435413wei.20.1331725142209;
 Wed, 14 Mar 2012 04:39:02 -0700 (PDT)
Received: by 10.216.170.70 with HTTP; Wed, 14 Mar 2012 04:38:42 -0700 (PDT)
In-Reply-To: <CAHkK2bokWzhtaB9CEEG3Uths1DXHAzj7QzH0V3p0FGvE_ua2hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193095>

Anyone? Please?
Even a code pointer into git-svn's mergeinfo handling would be a start...

Avish

On Thu, Mar 1, 2012 at 5:05 PM, Avishay Lavie <some.avish@gmail.com> wrote:
>
> Hello,
>
> I'm using git-svn from git 1.7.8.msysgit.0 with svn.pushmergeinfo set.
> So far, it works beautifully and really closes the gap for developers
> to be able to work with git-svn, including merging/reintegrating SVN
> branches.
> However, there seem to be a subtle bug in git-svn's behavior, where
> the svn:mergeinfo property on a branch references commits from the
> same branch, effectively saying "this branch was merged onto itself".
> SVN then gets confused at this in subtle ways which ultimately cause
> it to fail.
>
> The following workflow reproduces the issue:
>
> 1. Work on some branch (git checkout my-branch)
> 2. Merge trunk into your branch (git merge trunk && git svn dcommit)
> 3. Reintegrate the branch back to trunk (git checkout master && git
> merge my-branch && git svn dcommit)
> 4. Someone else reintegrates a different branch into trunk using a
> regular SVN client (non-git).
> 5. A third someone merges trunk into their branch using a regular SVN
> client.
> 6. That third someone now tries to merge trunk into their branch
> again, using SVN.
>
> What we noticed happens is the following:
> * Step #2 adds svn:mergeinfo on your branch to represent the commits
> merged in from trunk (this is normal and desired).
> * Step #3 copies these references from the svn:mergeinfo on the merged
> branch back into the svn:mergeinfo property on trunk, so we end up
> with trunk's mergeinfo referencing its own commits (this is the buggy
> behavior -- when reintegrating with SVN, this part doesn't happen).
> * In step #4, SVN detects the self-referencing mergeinfo property on
> trunk and removes it, leaving only mergeinfo for the other branches
> (this is also desirable behavior on SVN's part, since a branch
> shouldn't include any mergeinfo references to itself).
> * In step #5, SVN tries to apply the changes made on trunk to the
> target branch, including the previous merge which removed some
> mergeinfo references. This removes the same trunk commits from the
> mergeinfo property on the target branch, leaving "holes" in mergeinfo
> property for trunk on that branch.
> * In step #6, SVN detects that the mergeinfo property for trunk on the
> target branch has holes in it, and tries to merge those revisions from
> trunk again. This causes tree conflicts and other noise which fails
> the merge.
>
> As I see it, the bug here is the creation of self-referencing
> mergeinfo properties in step #3; SVN doesn't exhibit this behavior and
> this is what causes the problems later on.
> I think a general solution is to never add an svn:mergeinfo line
> referencing the branch being dcommitted into.
>
> Can anyone confirm this is indeed a bug, suggest a fix or workaround
> and/or point me at the relevant code?
>
> Thank you,
>
> Avish
