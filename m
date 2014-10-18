From: Ciro Santilli <ciro.santilli@gmail.com>
Subject: Re: Stop prepending /usr/bin to hooks PATH, or document it very clearly
Date: Sat, 18 Oct 2014 18:45:51 +0200
Message-ID: <CAFXrp_fspAC1Q2NOzpFoxG=pQ1SsR3VaRf+BGx9V_dxUu7=diw@mail.gmail.com>
References: <CAFXrp_c+dxafLOO6T=LDd6OxhfpamkJsUc8iBwB-B41z8Htc4A@mail.gmail.com>
	<20141018144924.GA17925@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 18:46:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfX8p-0002tz-P7
	for gcvg-git-2@plane.gmane.org; Sat, 18 Oct 2014 18:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbaJRQpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2014 12:45:53 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:56198 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbaJRQpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2014 12:45:52 -0400
Received: by mail-lb0-f177.google.com with SMTP id w7so2018511lbi.22
        for <git@vger.kernel.org>; Sat, 18 Oct 2014 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=eYLpMFn1pKMrQ/FPx8ee1/5BE05gCcBB+Fym74GeCfI=;
        b=GEOraVtu2zZYgV1FbbldAeWRflIyVzi4/+bJUB6tinzPak8KNNYyqvvfx/ZmKFWPuI
         c9Cr4tleLj+J8swN+Gx/Y2soFbT4yJQCXN6aeKndb4imz7W7XOpxPxVxzwhF7tS5RdpV
         MLYhPN0/v68Q/UuWkwv69EHE+6bS97TidiELIUW6Afs1rEUn/WDHCqqVVImVZMzExU2E
         G6/Dd8WMZkeES+3N3dub+xR0XzQwXFjetcb+wq7JtYKKG418E9FW5jsupMeTN4Mnkw4K
         WvHqlFBmPHx/81ShBv+IGnkVCI3jrRERabFnOtbaPie0uf54gCkMLzerF2hshORA4R0V
         Jqgw==
X-Received: by 10.152.5.38 with SMTP id p6mr11450540lap.44.1413650751146; Sat,
 18 Oct 2014 09:45:51 -0700 (PDT)
Received: by 10.152.170.133 with HTTP; Sat, 18 Oct 2014 09:45:51 -0700 (PDT)
In-Reply-To: <20141018144924.GA17925@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 18, 2014 at 4:49 PM, Andreas Krey <a.krey@gmx.de> wrote:
> On Fri, 17 Oct 2014 13:25:42 +0000, Ciro Santilli wrote:
> ...
>> The problem is that the `/usr/bin` breaks "interpreter version manager
>> systems" like RVM, rbenv, virtualenv, etc. since people will write
>> hooks like:
>>
>>     #!/usr/bin/env ruby
>>
>> and the `/usr/bin` ruby will get run instead of the managed one
>
> And that is the right thing to do. What ruby to execute with is
> a property of the hook script, not of the virtualenv a user happens
> to be in. If you want virtualenvs, you should set up the right one
> within the hook script.
>

I'm sure what you say has a good rationale, but can you give a more
concrete example where PATH prepending is desirable?

Use cases that I have seen where it is surprising and undesirable:

- I want binaries I manually installed under `/usr/local/bin` to have
precedence over the system defaults under `/usr/bin`, so I modify the
PATH on my `.profile`. But then I run a hook and things fail: so in
each hook I have to do export PATH="$THE_GOOD_PATH", which makes me
repeat the same thing many times.

- Locally I use RVM. But the CI uses rbenv. Next year, there will be
another version manager. If we follow the rule that when I invoke
`system('git something')` it runs in the same environment as current,
I don't need to do anything. But if environments change, I'd have to
either write extra code for each manager, or install dependencies on
multiple versions of the interpreter.

For now I'm going to go with `export PATH="$THE_GOOD_PATH && ruby
real_script.rb"`.

> ...
>> - documenting this behavior *very* clearly on `man githooks`
>
> That would still be a good thing to do.
>
> Andreas
>
> --
> "Totally trivial. Famous last words."
> From: Linus Torvalds <torvalds@*.org>
> Date: Fri, 22 Jan 2010 07:29:21 -0800
