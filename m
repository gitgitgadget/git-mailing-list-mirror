From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Thu, 19 Jan 2012 00:18:54 +0100
Message-ID: <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com> <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 00:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnemo-0006nI-Id
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 00:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab2ARXTR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jan 2012 18:19:17 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:54178 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab2ARXTQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 18:19:16 -0500
Received: by wibhm6 with SMTP id hm6so2632119wib.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 15:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wleQWHnIkPDi3XA8LExFEFZf4ZRDQmUhePpmUdeNRug=;
        b=HNwCJrKFmi899LxQXwSwhn7YSok0gew9VocRSJpmnLllgvG1LN4K90z62bkfWQkoEa
         8lPI1CRfy7EeDToSjB6+HirFrcVlDml4fWXgZGXopGohNpGEqiELq/YutipfsUH4/p8g
         WX73XIs2461utKFgx/mWTj2F6xHI2wW9ay3qk=
Received: by 10.180.77.228 with SMTP id v4mr39871188wiw.8.1326928755360; Wed,
 18 Jan 2012 15:19:15 -0800 (PST)
Received: by 10.223.103.148 with HTTP; Wed, 18 Jan 2012 15:18:54 -0800 (PST)
In-Reply-To: <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188778>

On Wed, Jan 18, 2012 at 19:57, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Wed, Jan 18, 2012 at 16:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> On Tue, Jan 17, 2012 at 14:42, Alex Riesen <raa.lkml@gmail.com> wrot=
e:
>>> Otherwise the i18n is used in the scripts even with NO_GETTEXT set.
>>> It is very unexpected.
>>
>> So the reason it's like that is that I was assuming that gettext.sh
>> wouldn't be FUBAR anywhere, but the translations shouldn't kick in
>> since we haven't installed them during "make install".
>>
>> But I wonder if this negatively affects some systems, now we now:
>>
>> =C2=A0* Don't use gettext.sh, which means that we're using our fallb=
ack
>> =C2=A0 shell function instead of the binary gettext(1), which is pro=
bably
>> =C2=A0 faster.
>>
>> =C2=A0* Use our own eval_gettext() instead of using the system one, =
which
>> =C2=A0 uses the GNU binary which is more likely to be in the FS cach=
e
>> =C2=A0 already since other programs are probably using it.
>>
>> Which is why I didn't do something like this to begin with.
>
> Well, if I say NO_GETTEXT, I kind of want none of local gettext,
> whether it works, or not.

That's not what NO_GETTEXT means, and not what it *should* mean. It
means that your output won't be translated, but we might still make
use of a locally installed library to provide the gettext() and
eval_gettext() functions.

This approach has worked everywhere so far (Linux, OSX, *BSD etc.),
and you want to change *everywhere* because you have some completely
broken Cygwin install.

How did you even get that install? Is it a known issue? Some ancient
now-fixed bug? What version of Cygwin / gettext etc.

Now I'm not saying that we shouldn't fix this, I just don't think that
this is the right way to go about it.

Now I haven't done exhaustive tests but this is the sort of slowdown
we might be looking at on Linux for output, both with warm cache:

    $ cat our-eval_gettext.sh
    #!/bin/bash

    eval_gettext () {
            printf "%s" "$1" | (
                    export PATH $(git sh-i18n--envsubst --variables "$1=
");
                    git sh-i18n--envsubst "$1"
            )
    }
    for i in {1..1000}
    do
        some_variable=3D"for speed"
        eval_gettext "benchmark this \$some_variable"
    done
    $ time bash our-eval_gettext.sh >/dev/null

    real    0m3.336s
    user    0m0.052s
    sys     0m0.128s

Compared to using the system eval_gettext, which for me is much
faster:

    $ cat system-eval_gettext.sh
    #!/bin/bash

    . gettext.sh
    for i in {1..1000}
    do
        some_variable=3D"for speed"
        eval_gettext "benchmark this \$some_variable"
    done
    $ time bash system-eval_gettext.sh >/dev/null

    real    0m1.671s
    user    0m0.048s
    sys     0m0.140s

And then we have the gettext() function itself:

    $ cat our-gettext.sh
    #!/bin/bash

    gettext () {
            printf "%s" "$1"
    }

    for i in {1..1000}
    do
        gettext "benchmark this"
    done
    $ cat system-gettext.sh
    #!/bin/bash

    for i in {1..1000}
    do
        gettext "benchmark this"
    done

Where our fallback is faster, because printf() is a bash built-in:

    $ time bash system-gettext.sh >/dev/null

    real    0m0.534s
    user    0m0.016s
    sys     0m0.084s
    $ time bash our-gettext.sh >/dev/null

    real    0m0.018s
    user    0m0.016s
    sys     0m0.000s

Anyway speed is the least of the issues here, it's not like we're very
constrained by spewing out gettext output.

I just think we should consider portability more carefully than "it
doesn't work on one obscure setup, let's change it everywhere", when
actually it's working just fine in most places.

I think a better fix would be to add probes for whether the system
functions actually work in the autoconf script.

I'd also love to be able to use C macros in the git-*.sh scripts, it
would make the code in git-sh-i18n.sh much nicer since we can
determine what functions we want at compile time.

Another option would be to pipe our shellscripts through some
pre-processor that would completely remove the gettext and
eval_gettext calls. Then we'd be doing the same thing we're doing on
the C-Level, and we wouldn't have the previously cited command-call
overhead or Win32.

But in summary: We shouldn't be *always* using fallback functions
whether they're the C stuff in compat/* or the gettext fallbacks in
git-sh-i18n.sh just because there's some version out there of the
system-supplied functions that's broken.

It makes sense to prefer the system functions by default in both
cases, but when the OS one can be broken or lacking we can just add
probes or Makefile options like we do for fnmatch() with the
NO_FNMATCH_CASEFOLD switch.
