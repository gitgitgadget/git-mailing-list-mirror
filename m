From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [1.8.0] Change branch --set-uptream to take an argument
Date: Tue, 1 Feb 2011 16:14:07 -0500
Message-ID: <AANLkTimOLPVp0EdhTsrPcF7gtykh3o-yE7KimBSJwfY3@mail.gmail.com>
References: <AANLkTinUn2SMijphe3EmPMVOOwBjPB5ffFwwqZVxQmW0@mail.gmail.com> <vpqzkqg5dsq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:14:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkNYh-0005qD-Rp
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab1BAVOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:14:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44280 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab1BAVOi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:14:38 -0500
Received: by iyj18 with SMTP id 18so6374988iyj.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 13:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=umbXMZgY7an1z6RlZXEKF6OHTeo43PZZ0gOOlqhgZ/I=;
        b=q/OTdUFhHYYqihVRByJtBKbi211bHsELW8R8vbhQS7sQgeMcaseaoJ8cMfAEs91APS
         zjdLoorS1mbrPVMTl75N4GIIw5numPVZpbVH9h98Q6iLsTX6lEHVpMJGbq21PtZIlKcF
         7thfeeXEnOmAfRwzci8UhzXvNFkk6kAovboHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=wQ0FhnPEBQ2y9LcdLybJW+PI139K49gb2VjReSReB4YVo2GJFsVAq+j85Ck60wSqsb
         ZCjB9QShJWxm4qzTMC9EmmUzo3DyMqEUXIvCqI4QQ6iCuiF301oDP0WTkMu3IP2dMzqQ
         wlrP7/m1AYpqD+UFSBzINktT7xDrs82zyvlt8=
Received: by 10.231.12.132 with SMTP id x4mr8863366ibx.177.1296594877285; Tue,
 01 Feb 2011 13:14:37 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Tue, 1 Feb 2011 13:14:07 -0800 (PST)
In-Reply-To: <vpqzkqg5dsq.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165855>

On Tue, Feb 1, 2011 at 4:01 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> Currently it is very easy to misinvoke --set-upstream if you assume it
>> takes an argument:
>
> Your proposal sounds interesting, but I'd like to see something more
> global: right now, some commands take a --track option and other take
> a --set-upstream. In short, I'd like to see this --track deprecated
> (since it's not actually about remote-tracking ...).

There are a few things at work here. --track/--no-track are used to
override the branch.autosetupmerge configuration and are supported by
checkout and branch. --set-upstream is only supported by branch, and
is subtly different from --track.

There is also branch.autosetuprebase, for which there is no
command-line option to override.

These options/configs control how branch.<name>.{merge,remote,rebase}
are set. --track/--no-track only take effect when the branch is
created. --set-upstream can be used when the branch is created, or
after the fact.

(Aside, the names of the config params are starting to look
sub-optimal, but it's probably not worth the pain of changing them.)

I suppose a more comprehensive proposal looks like this:

1. Deprecate --track and --no-track (remove from documentation and
usage). I wonder if anyone ever uses them?

2. Deprecate --set-upstream as its usage is confusing.

3. Add -u <name> to both checkout and branch to specify the upstream
branch. It is used with checkout -b in cases where an upstream would
not normally be configured, either because it's not the default
according to branch.autosetupmerge or because the start-point is not a
branch. It is used with branch when creating a branch in a similar
manner to how it's used with checkout when creating a branch, but may
also be used to reset the upstream after the fact like so:

   $  git branch -u <upstream> [<branch>]

4. Add --pull-default={rebase,merge} to both checkout and branch used
for setting/unsetting branch.<name>.rebase during initial branch
creation, or after the fact in the case of git-branch. It is an error
to try to set --pull-default if the upstream is not configured, either
automatically or via -u.

>> (Though I'm not sure whether the options parser allows for both
>> --set-upstream and --set-upstream=<arg>)
>
> There are already many instances of this. When <arg> is mandatory, you
> can write either --option <arg> or --option=<arg> (like "git log
> --grep pattern" Vs "git log --grep=pattern"), and when <arg> is
> optional, you can write either --option alone, or --option=<arg> (like
> "git diff --color-words" and "git diff --color-words=.").

Sorry. What I meant was that you'd need the ability to differentiate
between "--set-upstream=foo" and "--set-upstream foo" due to
git-branch's existing semantics. Right now:

$ git branch --set-upstream topic origin/master

Creates topic from origin/master and sets topic's upstream to
origin/master. If --set-upstream suddenly starts taking an argument,
that means something completely different: create a new branch named
origin/master starting at HEAD and set its upstream to "topic".

I think we're better off just deprecating --set-upstream and
introducing the more convenient -u.

j.
