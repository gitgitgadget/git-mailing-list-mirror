From: Mark Lodato <lodatom@gmail.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 19:33:56 -0500
Message-ID: <ca433831002121633j5b96049bs71e539c96397aff4@mail.gmail.com>
References: <ron1-CD3223.04030512022010@news.gmane.org> <4B75BD06.1010802@lsrfire.ath.cx> 
	<ron1-519083.13253112022010@news.gmane.org> <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com> 
	<ron1-62D136.13570812022010@news.gmane.org> <C022F034-F60E-4E89-A174-DC0F53ADEC19@silverinsanity.com> 
	<ron1-5EFFD7.14390512022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 01:34:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng5xn-0001ZE-KM
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 01:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab0BMAeS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 19:34:18 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:47402 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab0BMAeR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 19:34:17 -0500
Received: by yxe34 with SMTP id 34so1132503yxe.15
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 16:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NPXesgG3sqWMiV4wgaP8JUa6rcSI+LSTVeN7tvddD+w=;
        b=BLOLaL+FynDT8b3aQ48VYoBuw0oGc6QNNW5QFFhw9zml2UPcTgz00Xt/tQtSO29IDz
         pi4DG38WqFdQDj7u9ofBm6pbftCR1dE4UK4+/sdZuA9IhaD7bPOtjo3PCMuc3a2LJF6M
         H/vOL86YvUnKOt8duKYU+zGobIj8oDYqLn++o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Yi/WCqhDQ4czD/+EpzNeFRYVxmP0sOXIpHEKE/PLNSDzlNz4lSimwO/VcuVKgy6w4z
         e7ISEjDE4S9WJrWEomNs6IhipblOfFBWoKg59WIqOWOUHaLMSDbNbbjgsxmGlwmKV6WI
         0UddelCh/HOyCss+vrNWwcGtnJO0yhdSIFPbs=
Received: by 10.91.145.11 with SMTP id x11mr2086761agn.86.1266021256111; Fri, 
	12 Feb 2010 16:34:16 -0800 (PST)
In-Reply-To: <ron1-5EFFD7.14390512022010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139765>

Ron, I also could use a feature like this.  Sometimes I just have some
code that I don't want to just throw away, but it really doesn't go in
the history.  I usually just create a file called "junk" and add it to
=2Egit/info/excludes, but I'd rather have it stored in git.

On Fri, Feb 12, 2010 at 5:39 PM, Ron Garret <ron1@flownet.com> wrote:
> Yes, I think the right answer is going to be something like this:
>
> git symbolic-ref HEAD refs/heads/snapshots
> git rm --cached -r .
> git commit --allow-empty -m 'Snapshot branch'
>
> Then, to take a snapshot:
>
> git branch snapshot
> git checkout master -- path
> git add path
> git commit -a -m 'Snapshot of [path]'
> git checkout master
>
> (All of that will be in a script of course.)
>
> And to rollback:
>
> git checkout snapshot-[n] -- path
>
> Or something like that. =C2=A0I haven't actually tried this yet, but =
it seems
> like it ought to work.

I took your idea and ran with it.  In my version, I don't bother
switching branches and instead use plumbing commands to get the job
done.  (This prevents issues if there's a conflict from the old
commit.)  Also, I record HEAD as an additional parent of the commit,
so I can see where the commit came from.

I uploaded it as a Github Gist with a bunch of comments.  (It's much
nicer to read it with syntax highlighting.)  You may be able to modify
this to suit your needs.  In particular, if you'd prefer it not to be
a real branch, you could change $BRANCH to /refs/snapshots/foo or
something like that to hide it.

http://gist.github.com/303142

The basic steps are:

backup .git/index
git add -a
git write-tree
git commit-tree
restore .git/index

I don't know much about git's plumbing commands, so I'd be interested
in hearing from git experts to see if what I'm doing is a good idea.

> Am I right that 'git checkout branch' changes branches, but 'git
> checkout branch -- path' doesn't? =C2=A0That's very confusing. =C2=A0=
Useful, but
> confusing :)

Yes on both counts :)

--
Mark
