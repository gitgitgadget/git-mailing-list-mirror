From: =?ISO-8859-1?Q?Conrad=A0Irwin?= <conrad.irwin@gmail.com>
Subject: Re: git branch -M" regression in 1.7.7?
Date: Fri, 25 Nov 2011 23:05:26 -0800
Message-ID: <CAOTq_pv4dyAkbqye+diK9mTTsrTg9OKg0tExKcfDgs8RfiTwTQ@mail.gmail.com>
References: <CALxtSbRbwkVDKJcXiKY9rHYCjA3XGgCytbXQnRhQvbEnY8SpjA@mail.gmail.com>
 <20111126023002.GA17652@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?4piCSm9zaCBDaGlhICjosKLku7vkuK0p?= <joshchia@gmail.com>,
	git@vger.kernel.org, Soeren Sonnenburg <sonne@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 26 08:07:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUCMU-0007iq-Oe
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 08:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604Ab1KZHFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Nov 2011 02:05:49 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63253 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab1KZHFs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2011 02:05:48 -0500
Received: by yenl6 with SMTP id l6so1656618yen.19
        for <git@vger.kernel.org>; Fri, 25 Nov 2011 23:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ehw9UX3197IcTobBC1FfaiW6wvy0kyYk1roJNwDaWEA=;
        b=IgzYSLwcuCLT/a7174shTbEFvS5zeZU4TKWTYDGcHJqF9BaOi/UB3HKpldyx8sWGUA
         aBPzBAlcVIPwP5f6JUMzVodwxPvwLh8i8wvjLnTjr8kXMXPDC3SNL/jJCtsKPKPLASuo
         I44mhlJuVaAxuYSZzP56MHULL8QBdh0H5iYU8=
Received: by 10.236.200.135 with SMTP id z7mr53222733yhn.33.1322291148109;
 Fri, 25 Nov 2011 23:05:48 -0800 (PST)
Received: by 10.236.103.12 with HTTP; Fri, 25 Nov 2011 23:05:26 -0800 (PST)
In-Reply-To: <20111126023002.GA17652@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185948>

On Fri, Nov 25, 2011 at 6:30 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> A reproduction recipe (preferrably in the form of a patch to
> t/t3200-branch.sh would be welcome.

Sent in a separate email. Feel free to add a "Tested-by:" header to
your patch if you want :).

>
> -- >8 --
> Subject: treat "git branch -M master master" as a no-op again
>
> Before v1.7.7-rc2~1^2~2 (Prevent force-updating of the current branch=
,
> 2011-08-20), commands like "git branch -M topic master" could be used
> even when "master" was the current branch, with the somewhat
> counterintuitive result that HEAD would point to some place new while
> the index and worktree kept the content of the old commit. =A0This is
> not a very sensible operation and the result is what almost nobody
> would expect, so erroring out in this case was a good change.
>
> However, there is one exception to the "it's usually not obvious what
> it would mean to overwrite the current branch by another one" rule.
> Namely:
>
> =A0 =A0 =A0 =A0git branch -M master master
>
> is clearly meant to be a no-op, even if you are on the master branch.

Agreed. I thought after reading your patch about making it just do:

    if (!strcmp(oldname, newname))
        exit(0);

but I guess it would then not mark an entry in the reflog that people
could be relying on...

> + =A0 =A0 =A0 clobber_head_ok =3D !strcmp(oldname, newname);
> +
> + =A0 =A0 =A0 validate_new_branchname(newname, &newref, force, clobbe=
r_head_ok);

This looks ok, and will be improvable if the NEEDSWORK in branch.h is d=
one.

The other thing I wonder is whether "git checkout -B master HEAD" or
"git branch -f master master" should have the same short-cut?

Conrad
