From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] pager: turn on "cat" optimization for DEFAULT_PAGER
Date: Wed, 20 Nov 2013 18:33:05 +0100
Message-ID: <CABPQNSYWntx_36kTB4GG4i+m8tXn4k+YSDEWn9KZU-9t6xCAXQ@mail.gmail.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
 <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com> <201308281819.r7SIJmnh025977@freeze.ariadne.com>
 <xmqqr4dd8suz.fsf@gitster.dls.corp.google.com> <201308291541.r7TFfuJr023110@freeze.ariadne.com>
 <vpqsixsv6dq.fsf@anie.imag.fr> <201309030227.r832RmBd013888@freeze.ariadne.com>
 <20130903074150.GE3608@sigill.intra.peff.net> <CABPQNSb6PD+oSw_LT6KaUYd8BTeN-WHJFodcuiLe=u76rFYFJw@mail.gmail.com>
 <20131120173054.GA15339@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 20 18:33:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjBew-0004DP-4W
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 18:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab3KTRdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 12:33:46 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:40683 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab3KTRdp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 12:33:45 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so1097624ief.24
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 09:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WB8RCIb/rWfEIhgVyC2fgZhLbWWfX3m8etTQ+Ri7ACU=;
        b=TCTIaesV1WImm9lx4nZzXSOo/oeAukrpERFo6LCW9cYK5hBAZpbTgDFbKVFQ8Ws+Zu
         3tmPnpkKlIUTP24Vh/16tVEKzN2bCboO9dsgcs6rbKGbCc78d51UXBj63HgbRssgDxsd
         G2R3apnXQVuGITCS5jaUf6RWuQo/PgjxxnQT4mrnHJ6DIspBcb3fnRcp0qKUyDuMZv4a
         LQVk3Vurv9Hk/GJEJasMf6CxHNZFBSpmk9XLI1hllBMUL8P3EPnjAhvQTurlUARB3N9x
         VzLZDzQEaN9aSmSZi86oQX6yTeyYtML94a37BJINmfSJcXCjA/mQ6UmRrlEnWXyBy+BN
         tsPA==
X-Received: by 10.43.55.68 with SMTP id vx4mr1199434icb.65.1384968825469; Wed,
 20 Nov 2013 09:33:45 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Wed, 20 Nov 2013 09:33:05 -0800 (PST)
In-Reply-To: <20131120173054.GA15339@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238087>

On Wed, Nov 20, 2013 at 6:30 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 20, 2013 at 06:24:45PM +0100, Erik Faye-Lund wrote:
>
>> > diff --git a/pager.c b/pager.c
>> > index c1ecf65..fa19765 100644
>> > --- a/pager.c
>> > +++ b/pager.c
>> > @@ -54,7 +54,7 @@ const char *git_pager(int stdout_is_tty)
>> >                 pager = getenv("PAGER");
>> >         if (!pager)
>> >                 pager = DEFAULT_PAGER;
>> > -       else if (!*pager || !strcmp(pager, "cat"))
>> > +       if (!*pager || !strcmp(pager, "cat"))
>>
>> Hmmpf. It's sometimes useful to actually pipe through cat rather than
>> disabling the pager, as this changes the return-code from isatty. I
>> sometimes use this for debugging-purposes. Does this patch break that?
>
> My patch should not change the behavior of PAGER=cat, GIT_PAGER=cat,
> core.pager, etc. It should _only_ impact the case where DEFAULT_PAGER is
> set to "cat" (or NULL), and bring it in line with the other cases.
>
> I am not clear on how you are using "cat", so I can't say whether it is
> broken. But if you are doing:
>
>   PAGER=cat git log
>
> that already is a no-op, and that is not changed by my patch. If you
> want to make stdout not a tty, I'd think:
>
>   git log | cat
>
> is the right way to do it (and anyway, when the pager is in effect git
> will pretend that stdout is a tty, since you would still want things
> like auto-color to go to the pager).

You are of course right. Explicitly piping through cat is plenty fine
for my purposes, sorry for disturbing you.
