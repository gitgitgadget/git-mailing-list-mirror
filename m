From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git-pack-objects dying with errors due to possible RHEL kernel bug
Date: Wed, 20 Apr 2011 23:39:04 +0200
Message-ID: <BANLkTimhNQrqhOq36-9wm9Zy=nL7Epk2Pw@mail.gmail.com>
References: <AANLkTimZ08_fJKgwqtiKBbd0pSJ3EFSnJ6jem=fPqRWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:39:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCf7B-0003rs-Jg
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 23:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab1DTVjH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2011 17:39:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34327 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab1DTVjG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2011 17:39:06 -0400
Received: by fxm17 with SMTP id 17so645297fxm.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GkvR4MVTGb2f2oqUlBUEeX4OqEMcwE8Pc+b0y61cpoY=;
        b=TBqFFxtWFxIYwfOIZfxSUjy7wtKWniNkb5+xMZpA13+NQPqB1mlb0Hyk6h21+8aJY7
         B/mDsnJXGYeJ+CQJ4Ofmw8qLWdLgyYcb/q3qYjjsTMcbD1emmpsLxCTon11oDUmrpXg0
         dWqvQbTwqFBqId3x4+xK2f8QJKZUgb+xVU/VE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AiMe16Bb86TOnEBAM9z9bXnkTeiQQF3/v2alORDQiZwkqNXsQJWpm0OAWIAg9KeFoy
         HYt4mL6fjM30Qjtkiu6leTBvTzgxNQXFkGng2L+ikdgRZWVbQl1cv9ULaOOcbpCsivGy
         TZ6XTTCrs7Jy6bWD2neCMhBY9DIJHcGebY+HQ=
Received: by 10.223.54.219 with SMTP id r27mr2584912fag.124.1303335544096;
 Wed, 20 Apr 2011 14:39:04 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Wed, 20 Apr 2011 14:39:04 -0700 (PDT)
In-Reply-To: <AANLkTimZ08_fJKgwqtiKBbd0pSJ3EFSnJ6jem=fPqRWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171875>

On Fri, Mar 4, 2011 at 12:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> This is a summary of an issue I've been looking at with a very large
> centralized Git repository. It's a repository that gets approximately
> 100 commits per day, almost all to its master branch.
>
> I think I've found why the issue I'm describing happens (not confirme=
d
> yet), I mainly wanted to write something to the list to have a record
> of this in case anyone runs into it in the future.
>
> Last week we upgraded form Git 1.6.5 to 1.7.2.1 on the server housing
> our repository, and started getting errors like these from developers
> running variants of git-fetch:
>
> =C2=A0 =C2=A0$ git pull --rebase
> =C2=A0 =C2=A0remote: Counting objects: 2, done.
> =C2=A0 =C2=A0remote: Compressing objects: 100% (2/2), done.
> =C2=A0 =C2=A0remote: Total 2 (delta 0), reused 0 (delta 0)
> =C2=A0 =C2=A0remote: aborting due to possible repository corruption o=
n the remote side.
> =C2=A0 =C2=A0error: waitpid for pack-objects failed: No child process=
es
> =C2=A0 =C2=A0error: git upload-pack: git-pack-objects died with error=
=2E
> =C2=A0 =C2=A0fatal: git upload-pack: aborting due to possible reposit=
ory
> corruption on the remote side.
> =C2=A0 =C2=A0Unpacking objects: 100% (2/2), done.
> =C2=A0 =C2=A0fatal: error in sideband demultiplexer
>
> That error is from
> https://github.com/git/git/commit/b1c71b72815cb82a8bad14020a047320b88=
a04eb
> by Junio from 2006, we're refusing to send an incomplete pack file on
> failure.
>
> We've also been getting this error from git-fetch directly (from a
> wrapper script):
>
> =C2=A0 =C2=A0# INFO : Checking working directory
> =C2=A0 =C2=A0# ERROR: failed to git fetch --tags from 'origin' errorc=
ode: 128
> =C2=A0 =C2=A0# ERROR: git fetch --tags origin
> =C2=A0 =C2=A0# ERROR: error: waitpid for pack-objects failed: No chil=
d processes
> =C2=A0 =C2=A0# ERROR: error: git upload-pack: git-pack-objects died w=
ith error.
> =C2=A0 =C2=A0# ERROR: fatal: git upload-pack: aborting due to possibl=
e
> repository corruption on the remote side.
> =C2=A0 =C2=A0# ERROR: remote: aborting due to possible repository cor=
ruption on
> the remote side.
> =C2=A0 =C2=A0# ERROR: fatal: error in sideband demultiplexer
>
> And from git-remote-update(1):
>
> =C2=A0 =C2=A0$ git remote update
> =C2=A0 =C2=A0Fetching origin
> =C2=A0 =C2=A0remote: Counting objects: 9, done.
> =C2=A0 =C2=A0remote: Compressing objects: 100% (5/5), done.
> =C2=A0 =C2=A0remote: Total 5 (delta 4), reused 0 (delta 0)
> =C2=A0 =C2=A0error: waitpid for pack-objects failed: No child process=
es
> =C2=A0 =C2=A0error: git upload-pack: git-pack-objects died with error=
=2E
> =C2=A0 =C2=A0fatal: git upload-pack: aborting due to possible reposit=
ory
> corruption on the remote side.
> =C2=A0 =C2=A0remote: aborting due to possible repository corruption o=
n the remote side.
> =C2=A0 =C2=A0Unpacking objects: 100% (5/5), done.
> =C2=A0 =C2=A0fatal: error in sideband demultiplexer
> =C2=A0 =C2=A0error: Could not fetch origin
>
> All of these except maybe the first one (wasn't able to contact the
> dev in question) come from Git 1.7.2.1 clients talking to the 1.7.2.1
> server.
>
> Anyway, I think this issue is caused by this RHEL bug:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D166669 ([RHEL3 U5]
> waitpid() returns unexpected ECHILD) which was fixed in this RHEL
> update: http://rhn.redhat.com/errata/RHSA-2006-0144.html
>
> This is our Git server:
>
> =C2=A0 =C2=A0$ cat /etc/redhat-release && uname -r
> =C2=A0 =C2=A0CentOS release 4.1 (Final)
> =C2=A0 =C2=A02.6.9-11.ELsmp
>
> And if I run:
>
> =C2=A0 =C2=A0wget https://bugzilla.redhat.com/attachment.cgi?id=3D118=
759 -O killipf.c &&
> =C2=A0 =C2=A0gcc -O2 -o killipf killipf.c -lpthread &&
> =C2=A0 =C2=A0PASS=3D0; while ./killipf; do let PASS=3D++PASS; echo $P=
ASS; done
>
> It'll die within a minute with a message like this:
>
> =C2=A0 =C2=A0PASS : received expected signal 9
> =C2=A0 =C2=A014605
>
> =C2=A0 =C2=A0child pid:2563
> =C2=A0 =C2=A0waitpid failed!: No child processes
>
> It does *not* die on these machines:
>
> =C2=A0 =C2=A0$ cat /etc/redhat-release && uname -r
> =C2=A0 =C2=A0CentOS release 4.6 (Final)
> =C2=A0 =C2=A02.6.9-67.0.7.ELsmp
>
> =C2=A0 =C2=A0$ cat /etc/redhat-release && uname -r
> =C2=A0 =C2=A0CentOS release 5.5 (Final)
> =C2=A0 =C2=A02.6.18-194.el5PAE
>
> Or on my personal Debian box:
>
> =C2=A0 =C2=A0$ cat /etc/debian_version && uname -r
> =C2=A0 =C2=A0wheezy/sid
> =C2=A0 =C2=A02.6.32-5-amd64
>
> I haven't been able to trigger this issue with Git itself. I tried
> putting a copy of the repository in /tmp, then one on client running
> in a while loop:
>
> =C2=A0 =C2=A0while true; do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0head -n 10 /dev/urandom >a_file &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m"more crap" a_file &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git push
> =C2=A0 =C2=A0done
>
> And on another client running:
>
> =C2=A0 =C2=A0while true; do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git pull
> =C2=A0 =C2=A0done
>
> And I never got this waitpid error message, I might have just been
> unlucky though, or perhaps it wasn't triggered in that case for some
> reason.
>
> Given this information we're going to upgrade CentOS on the relevant
> machine, I'll follow up on the list in a couple of weeks indicating
> whether or not that worked. We have enough users that if I ask people
> to tell me if we get this error and I don't hear anything for two
> weeks I can safely assume it went away.
>
> What we might want to do in Git is to work around this broken waitpid
> behavior (if that's indeed the issue). I haven't dug into what the
> RHEL kernel patch is solving, so I don't know if we can inexpensively
> detect this when this is happening and warn users about it.
>
> Then again it would be a lot of work to work around a specific kernel
> bug. What I *mainly* wanted to do was to insert some note of this int=
o
> the Git mailing list archive. Which I've now done.

An update: after upgrading CentOS past a kernel with this bug we
stopped having these errors. We used to have many of them every day,
but haven't had one in the week since the server was upgraded.
