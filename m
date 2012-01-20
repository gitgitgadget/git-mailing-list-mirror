From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Fri, 20 Jan 2012 10:50:23 +0100
Message-ID: <CACBZZX7iiF2um11FvD+MBz=rZb7RrHtCJp3PqexLnSp3-Cbqug@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <7vfwfclf4v.fsf@alter.siamese.dyndns.org> <4F17C294.6010004@viscovery.net> <7vhazrk0jx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 10:50:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoB7T-0002eC-6T
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 10:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab2ATJuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 04:50:46 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53245 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752692Ab2ATJuo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 04:50:44 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id c1so204857lah.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 01:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ryHMJPS5rQDYnUZKMviA+PnRs9JAjNZs3gNBD2mY+lc=;
        b=hqVk9P5fB01rboe9Bhc2xmQpnZgzdXXMj+Nb1YqxoNn12FaKu9piiqK+M9w6A4yuAp
         pGUw01g9h9xPv+pVJA8USnQGCqhYYX73foQdDUYFVjOFyyfXkFwXv3eK8ZG+QPGNJb8Y
         OJknFMauBFnr2bIyX9/dLyETA6bsRaFjzfAow=
Received: by 10.152.144.133 with SMTP id sm5mr14523505lab.38.1327053044132;
 Fri, 20 Jan 2012 01:50:44 -0800 (PST)
Received: by 10.112.4.136 with HTTP; Fri, 20 Jan 2012 01:50:23 -0800 (PST)
In-Reply-To: <7vhazrk0jx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188872>

On Thu, Jan 19, 2012 at 19:30, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> ... We have, e.g., NO_MMAP, and I can set it to request
>> that some alternative is used, even if I have a working mmap(). The option
>> name "NO_GETTEXT" is in exactly the same spirit.
>>
>>> In the current approach we take for shell scripts, we cannot have "No i18n
>>> whatsoever and messages are emit with printf and echo". We always have to
>>> go through gettext/eval_gettext even though they may be an implementation
>>> that does not do i18n at all.
>>
>> Just like we go through _() in C code, even though there may be an
>> implementation that does not do i18n at all, right?
>
> Yes, just like that. The small detail that _() can be #define'd out to
> empty while gettext/eval_gettext cannot be made to be no-impact like that
> does not really matter.
>
>> In C, it is easy, in shell code it may be more involved.
>
> Correct.

To elaborate, the C code can:

 * Use the system gettext library to get translations.

 * Use the system gettext library, but effectively be pass-through
   because the user has the C locale.

 * Use our fallback functions which in any modern compiler will be
   optimized out.

However with the shell code we can:

 1. Be using the system gettext & eval_gettext to get translations.

 2. Be using the system gettext & eval_gettext as pass-through, either
    because we don't have translations since we've installed with
    NO_GETTEXT=YesPlease, or because we're in the C locale.

 3. Haven't detected that gettext.sh etc. exists, so we have to provide
    our own fallbacks.

The proposed patch would move all users of NO_GETTEXT=YesPlease to #3,
even though on most platforms we don't need to define our own dummy
fallbacks since the system already provides them.

I don't particularly like it because I'd rather use the OS vendor's
implementation if possible, even for fallback.

However it being broken is also unacceptable, but I think the way
forward is to detect the breakage either at compile time or at
runtime, to that end Alex could you provide us with the output from
the following commands on the offending system where this is broken:

    $ type gettext.sh
    $ gettext.sh --version
    $ gettext -h
    $ gettext "some test text"
    $ . gettext.sh
    eval_gettext
    $ variable=value eval_gettext "some \$variable"

Then how the eval_gettext function is defined:

    $ type eval_gettext
    eval_gettext is a function
    eval_gettext ()
    {
        gettext "$1" | ( export PATH `envsubst --variables "$1"`;
        envsubst "$1" )
    }

And then a --version for whatever programs that function uses,
e.g. here:

    $ envsubst --version

Once we know how it breaks we can e.g. add configure tests for
checking whether we can use the system's gettext library for the
fallbacks.

Could you also run the git test suite as described in t/README? I'd
expect a lot of the i18n tests to fail, but it would be curious to see
which ones exactly.
