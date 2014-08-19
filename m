From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Relative submodule URLs
Date: Tue, 19 Aug 2014 11:15:24 -0500
Message-ID: <CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
	<20140819102421.GA5012@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 18:15:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJm4P-00024z-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbaHSQP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:15:26 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:52592 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbaHSQPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:15:25 -0400
Received: by mail-vc0-f172.google.com with SMTP id im17so7686069vcb.31
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wMlKZC8IgLVzfpWW+5g750Webw96IwAA7C3/2N6Uymo=;
        b=rULcBFBWKYKk1R1Jj/ABbLIomCcA09jeaMAnAnxDYS9ZFKj6f1x5lKjp4++XziibZo
         Hz9NKvzfj+s0YRtPO2SqUzUDs8qw8OQQbzuDJRcMaeqqfG7YtHh+/BJL4vxWfiaZURwq
         khgivhvZjGY+TtxR3KXbQK1k/KB+5yvFR5dtvjaFBBlNt+MKTKHERP002a1QHq2meIwi
         afVByblI1NZY/fuyRfqG7RKq805rXzqUYXUYfiZwG7Vjh2r48dyPU/ZyNlNP997NhRz1
         TgojZAB9fKLjVt52QOGhwyasn2Nw+yFD8ebvM23v7rgK9uMqaxWYn3DMV24c/93ZUvlZ
         3iFA==
X-Received: by 10.220.96.137 with SMTP id h9mr1447108vcn.46.1408464924304;
 Tue, 19 Aug 2014 09:15:24 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Tue, 19 Aug 2014 09:15:24 -0700 (PDT)
In-Reply-To: <20140819102421.GA5012@book.hvoigt.net>
X-Google-Sender-Auth: _a6AcKW6Va1W9wiNJykyCIAzyE4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255463>

On Tue, Aug 19, 2014 at 5:24 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> I think the OP problem stems from him having a branch that does not have a
> remote configured. Since they do not have 'origin' as a remote and
>
>         git submodule update --init --recursive path/to/submodule
>
> fails. Right?

Not exactly. The issue is that there is a tug of war going on between
three specific commands (all of which utilize the tracked remote):

git fetch
git pull
git submodule update (for relative submodules)

The way I set up my remote tracking branch will be different for each
of these commands:

- git pull :: If I want convenient pulls (with rebase), I will track
my upstream branch. My pushes have to be more explicit as a tradeoff.
- git push :: If I want convenient pushes, track my origin branch.
Pulls become less convenient. My relative submodules will now need to
be forked.
- git submodule update :: I track upstream to avoid forking my
submodules. But pushes become more inconvenient.

As you can see, I feel like we're overusing the single remote setting.
Sure, we've added some global settings to set default push/pull
remotes and such, but I don't think that is a sustainable long term
solution. I like the idea of possibly introducing multiple tracking
remotes for various purposes. This adds some additional configuration
overhead (slightly), but git is already very config heavy so it might
be worth exploring. At least, this feels like a better thing for the
long term as I won't be constantly switching my tracking remote for
various purposes.

Could also explore the possibility of creating "const remotes". If we
specify a remote MUST exist for relative submodules, git can create it
for us, and fail to operate without it. It's up to the user to map
"fork" to "origin" if needed (perhaps add a `git remote clone <source>
<new remote>` to assist with this)?

Various approaches we can take, but I don't do development on Git so
I'm not sure what makes the most sense.
