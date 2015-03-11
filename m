From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --amend safety check?
Date: Tue, 10 Mar 2015 23:18:45 -0700
Message-ID: <CAPc5daVMec1okdBW3Wo_gEr7W3FwRwmH5pmiiMaAgGoN7MGa_A@mail.gmail.com>
References: <CAJo=hJuwdOzNZSVBRAPDz97Gdoi6JWvYxE0ufY+Hd9K8jjCqfA@mail.gmail.com>
 <xmqq8uf46ru8.fsf@gitster.dls.corp.google.com> <CAJo=hJtxeZGyP=VxLSdDzoMOtVZTFNsNTqPpNUTXUOBDZKzY9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 07:19:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVZzE-0008KX-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 07:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbbCKGTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 02:19:08 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:40742 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbCKGTG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 02:19:06 -0400
Received: by obcuz6 with SMTP id uz6so6788507obc.7
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 23:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZYrL+iTKaBlhjUcWagno4BrqA0/txVZnD0b1kdoVv6I=;
        b=CUWThuMvdBFLxgKqSb5sxYrC9Fvu/cSVIbSLgwrtAiqAAwYeIUF5yAEGxpyoPZhFNt
         CLiWTm56UWJfSKYlUs5cowiqxnZq+emo7fMTDODFtfdMMD6rgLGxYEzMzGiDRR/HPrps
         tyYp5L922VFCKeSl1r0lQUhjtg3Fg+sSs/37J7IAe7qhwBSmYbZwZY8cf5Ljif6Zy4Cz
         Lt87U763hrWZxSyYCzC6wHdpvzHpVrsfG3SVEu0un0iZRbDYLkgHQ08C9s3Cl+RhWhDh
         Np6uuibgsvctLNjm0WvuOy2fqTm/hbNara7K+EcmBojqlF7dV/loWyw/oddIH49GtLBD
         w5gw==
X-Received: by 10.60.139.1 with SMTP id qu1mr28758566oeb.83.1426054745785;
 Tue, 10 Mar 2015 23:19:05 -0700 (PDT)
Received: by 10.202.48.143 with HTTP; Tue, 10 Mar 2015 23:18:45 -0700 (PDT)
In-Reply-To: <CAJo=hJtxeZGyP=VxLSdDzoMOtVZTFNsNTqPpNUTXUOBDZKzY9Q@mail.gmail.com>
X-Google-Sender-Auth: K0Php4_fdctK2WIV9d4GswSfw-M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265304>

On Tue, Mar 10, 2015 at 11:00 PM, Shawn Pearce <spearce@spearce.org> wrote:
>
> OK, replace that Gerrit-specific push syntax with:
>
>  git send-email
>
> :)

Heh don't be too defensive; I was merely pulling your leg.

>> ...  But I am not sure what the definition of
>> unusual should be.  In a non-Gerrit central repository workflow, the
>> rule might be "HEAD must not be reachable from @{upstream}"
>> (otherwise you are rewriting what you got from elsewhere), or it may
>> be "HEAD must not be reachable from @{publish}'s remote tracking
>> branch", or perhaps both, as these two could be different in
>> triangular workflow.
>>
>> But I am not sure what the sensible rules are when the user prepares
>> the commit, planning to push it to a ref like refs/for/master that
>> does not have a counterpart on our side.
>
> True.

With a more concrete example, I'd imagine you have something like
this to wok on branch "master"

[remote "origin"]
  url = ...
  pushurl = ...
  fetch = +refs/heads/*:refs/remotes/origin/*
  push = refs/heads/*:refs/for/*

[branch "master"]
  merge = refs/heads/master

Even though we cannot prevent the user from rewriting what _he_
already pushed out to refs/for/master (as we do not have the record
of what the last thing we pushed there and its history via a reflog),
we could at least detect when he attempts to rewrite what he
obtained directly from the upstream by noticing where origin/master
is. If HEAD is _at_ that commit, or its ancestor, then he is trying to
rewrite what he got from elsewhere.

It would catch your original "commit --amend -m 'my first'" scenario.
Run is_ancestor(HEAD, @{upstream}) we can notice. That may be
better than nothing, but I do not offhand know if that is sufficient.

> Another way users get into a bind is they pull someone else's branch
> (so they can build on top of her work), then `git commit --amend -a`
> by mistake instead of making a new commit.

One thing we already do is to give an extra "Author: " line in the
comment when the user edits the log message, so that it is clear
that what is being edited is not their own work but hers. We obviously
can add the extra warning, when the is_ancestor() thing triggers, to
say YOU ARE REWRITING PUBLISHED HISTORY in blinking red
bold letters there.

But the symptom indicates that they are not reading these warning
comment. Perhaps it is necessary to introduce a training wheel mode
where you cannot use "--amend" and "-m" options from the command
line until you ask nicely to override it?
