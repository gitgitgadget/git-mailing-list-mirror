From: Nathan Collins <nathan.collins@gmail.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Mon, 5 May 2014 18:33:28 -0700
Message-ID: <CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
 <20140501024042.GX9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:53:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiGQ-0007Xo-0u
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933705AbaEFBeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 21:34:11 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:49445 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933701AbaEFBeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 21:34:09 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so7368604qgf.3
        for <git@vger.kernel.org>; Mon, 05 May 2014 18:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=76J/ALbDCqzHz7nBT0LzKyTKCuT7BGmQPjOrZPM3pEc=;
        b=HQRe0qmjz50cUeBzvV1SqWQRbj66ymyem1XtGuw6inSJ/maGyDcF02owDDb/vnQOZo
         6OXN9jufilft5E3kYf1sdv4Ocjy02lXRnqti0m7+H26Vy4BOUfgT5z8shMQFRrUMmoQp
         iBIrB8ydVtm2JfPbNIkueYPKuZMmcPx2oQb9aOSML1YVsX7OFtMz8bE1XSBiGm17qphZ
         P9PzmOxH1+jmwfhH3OxZVsOaROHbd9I5doJOE89UBxfisob5aBj+8Rl6+msDkk0Orj3p
         vsHIuL1yz06MgzZZoHvsCqlc0kHRGDiWpB4TOJVroyjUNQKfgXWp8eneG2+Y9NNzZ4Rx
         yaJA==
X-Received: by 10.224.67.195 with SMTP id s3mr50914283qai.96.1399340048559;
 Mon, 05 May 2014 18:34:08 -0700 (PDT)
Received: by 10.229.150.208 with HTTP; Mon, 5 May 2014 18:33:28 -0700 (PDT)
In-Reply-To: <20140501024042.GX9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248158>

On Wed, Apr 30, 2014 at 7:40 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Nathan Collins wrote:
>
>> Patches created with 'diff.noprefix=true' don't 'git apply' without
>> specifying '-p0'.
>>
>> I'm not sure this is a bug -- the 'man git-apply' just says "Reads the
>> supplied diff output (i.e. "a patch") and applies it to files" -- but
>> I would expect patches I create locally to apply cleanly locally.
>
> Sounds like a documentation bug, at least.  Any ideas for clearer
> wording?

Hmmm. Maybe a warning that the patch is expected to be in '-p1'
format, and that setting 'diff.noprefix=true' makes some commands
generate '-p0' patches? But I worry this would just confuse / distract
the people that don't have 'diff.noprefix=true' set, which I expect is
the majority of users.  Better I think would be for 'git apply' to be
smarter, as you suggest below.

>>                                                                   In
>> real life the 'diff.noprefix=true' is in my ~/.gitconfig, so this was
>> pretty confusing.
>
> I personally think setting diff.noprefix is not very sane (it also
> breaks "patch -p1"), and I suppose I should have been louder about
> that when it was introduced.
>
> Can you say more about the workflow you use that requires
> diff.noprefix?  Maybe we can make other changes to improve it, too.

I have 'diff.noprefix=true' set so I can copy and paste paths from the
'git diff' output easily.  I like to create small, logically
independent commits, usually comprising a subset of my current
changes. So, I do 'git diff' in one terminal, and then 'git add
<path>' or 'git add --patch <path>' in another terminal to build up a
commit (I suppose this is the work flow that 'git add --interactive'
is designed for ...), where I get '<path>' from the diff by copying
and pasting. With 'diff.noprefix=true', I can copy with double left
click and paste with middle click; with 'diff.noprefix=false', to copy
I instead have to carefully highlight the non-prefix part of the path
in the diff, which is less convenient.

> At first glance I don't suspect making diff.noprefix imply -p0 for
> "git am" would be great, since that would generate the the opposite
> problem when applying patches from the outside world.  But maybe we
> need better autodetection and maybe noprefix is a good signal about
> when to use it.

Autodetecting the lack or presence of the 'a/' and 'b/' prefixes seems
like a great solution to me: externally user friendly and easy to
implement internally.

> Another complication is that unlike 'git diff', 'git apply' is
> plumbing that is meant to be useful and reliable for scripts.  And
> unlike most plumbing, there is no higher-level command with similar
> functionality for which we can experiment more freely with the UI.
> Adding a new command to fix that might be a good direction toward
> handling noprefix patches better.

Related to 'git apply' being a scriptable plumbing command: naively I
would expect there to be a "scripting mode" for Git commands which
ignored the local configuration entirely (e.g. ~/.gitconfig). I've
wanted this a few times and was surprised I could find no very sane
way to achieve it. In fact, here's the corresponding question I posted
on Stack Overflow while I was composing my original email (I wanted to
be sure that 'diff.noprefix=true' was the only relevant part of my
~/.gitconfig, so I wanted disable my ~/.gitconfig entirely):

http://stackoverflow.com/questions/23400449/how-to-make-git-temporarily-ignore-gitconfig

> [...]
>> git show | git apply --reverse
>
> The following which only uses plumbing commands should work:
>
>         git diff-tree -p HEAD^! |
>         git apply --reverse

Nice! However, I don't now how to generalize this solution to other
(probably insane) use cases, e.g.

  git log -S<string> --patch | git apply --reverse

(Context: http://stackoverflow.com/a/23401018/470844).

> Thanks for some food for thought,
> Jonathan

Thanks for your reply. I didn't see it until today because a GMail
filter ate it :P

-nathan
