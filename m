From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 00:10:24 +0100
Message-ID: <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net> <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net> <20140105233943.GJ3156@odin.tremily.us>
 <20140106003314.GL3156@odin.tremily.us> <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 00:10:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0JJx-000777-Lu
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 00:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933252AbaAFXKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 18:10:48 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:43102 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbaAFXKp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 18:10:45 -0500
Received: by mail-ob0-f172.google.com with SMTP id gq1so19162324obb.3
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u89smDlye93lpVJU3RDu1fGT3mGTpUKLtAr9PsXyy2M=;
        b=Cu150Tzn5XLH5ZhH0E954pRcsJXHH2U66jwfRoDyEIjYLu6JXdKSa3ShzWSbc2Yhq7
         713+vMfCzhOgAsV6WRlZ2iGQwPJAfcdr2NSS0jQdNtVo9LCEVaLjy9w/m0u8sC1FMk0x
         T0e4M2RE3acJ5QYe6tmBoAKRLKXIz5X7rW2SzjWJ9vbE0NKxhaV3vaXllwO8dA9ncDiW
         W7Lbuc6z/0fHrRH7P8fFSVMNrS4lqu4xDgV6+3nBXe26RvjIGMrqnIDKrp4W6woCaclb
         JTnQmev2hwDVENic9lXuZx1mDSEIT1A4epWP5lzD8pPN2e2twDeJdluKoOcovX5M2xQA
         DGSA==
X-Received: by 10.60.124.138 with SMTP id mi10mr3248092oeb.57.1389049844297;
 Mon, 06 Jan 2014 15:10:44 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Mon, 6 Jan 2014 15:10:24 -0800 (PST)
In-Reply-To: <20140106160202.GE27265@t2784.greatnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240080>

2014/1/6 Heiko Voigt <hvoigt@hvoigt.net>:
>
> I agree. If we were to support this more easily we could add a
> configuration option so you can omit the --remote (i.e.:
> submodule.<name>.remote=true, as I also suggested in the other email).
>
> That way the developer checking out a branch in flight does not even
> need to know whether (and which) submodules sha1s are still in flight
> and temporarily set this configuration in the branches .gitmodules file.
>

"submodule.<name>.remote" can be useful but can be added later to aid
the current use case.

To not break the existing behavior what it's really needed here, IMO,
is a "submodule.<name>.attached" property that says two things:
- at the first clone on "git submodule update" stay attached to
"submodule.<name>.branch";
- implies "--remote", as it's the only thing that makes sense when the
submodules are attached.

My patch at the current unreleased state does exactly this.

> Maybe that could actually be the attach operation Francesco is
> suggesting:
>
>         git submodule attach [--pull] <submodule path> <branchname>
>
> will attach the specified submodule to a branch. That means it changes
> the .gitmodule file accordingly and stages it. With the --pull switch
> one can specify whether a local branch tracking the remote branch should
> be automatically created. Names and the command format are just a
> suggestion here.
>
> That way we can support the
>
>         fork superproject needing submodule changes and send submodule
>         changes upstream first.
>

My patch didn't do this, as the maintainer can do these things quite
easily[1] (maintainer is "cooler" with respect to other devs :) ), but
I think it could be good to also have this feature.

The feature I think that are still needed and you don't mention are:
- an "--attached" switch for the "add" command when the maintainer
create the submodule the first time (DONE in patch);
- a easy way to attach|detach the submodule locally by developer. This should:
    * fix the head state (DONE in patch);
    * fix the local .git/config "submodule.<name>.attached" property
accordingly (DONE in patch, unreleased).

I do the latest in the "update" command but it seems bad to touch
.git/config in the "update" command...

Maybe we should have a "git submodule head" command that does all
these things: --attach (for the maintainer), --attach|--detach (for
the developer).

[1]
$ ( cd submodule && git branch newbranch && git push -u origin HEAD)
$ git config -f .gitmodules submodule.newbranch.branch newbranch
$ git config -f .gitmodules submodule.newbranch.attached true
$ git add . && git commit -m "Forked superproject" && git push
