From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] pager: turn on "cat" optimization for DEFAULT_PAGER
Date: Wed, 20 Nov 2013 18:24:45 +0100
Message-ID: <CABPQNSb6PD+oSw_LT6KaUYd8BTeN-WHJFodcuiLe=u76rFYFJw@mail.gmail.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
 <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com> <201308281819.r7SIJmnh025977@freeze.ariadne.com>
 <xmqqr4dd8suz.fsf@gitster.dls.corp.google.com> <201308291541.r7TFfuJr023110@freeze.ariadne.com>
 <vpqsixsv6dq.fsf@anie.imag.fr> <201309030227.r832RmBd013888@freeze.ariadne.com>
 <20130903074150.GE3608@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 20 18:25:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjBWs-0008Nh-TW
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 18:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab3KTRZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 12:25:27 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40679 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab3KTRZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 12:25:26 -0500
Received: by mail-oa0-f46.google.com with SMTP id o6so4431353oag.19
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 09:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=iWC0Js90DYEgP6C8MP7UTpi5pAnV95fCOrPCG8Y2r6k=;
        b=gwnCCe4cJEuf4SJK1S3jUXAe97J0kfCRQid8jLBrQ86P4MGKwnuIevlJ0Z163Jml4/
         bh4tyzM/AErOswhI07M2HCbT6OB2/vO+XSnfQhjsijewCbhLXnbW2fDZbKSkb9fRKKgF
         YEx2m1S08ubGMIwcz9GxIlEdT6ol0fQKt/hmNQnrzAhqRaIOtltHvPrPHG2Ns7owl9dq
         vbdFP1dIYj9EhbnMWSyHcSNMWwXzTdj0pfvx1xeK3zr2Z6OFA6aH1MNP/rh7TySLiTOd
         u3UxEYovktt572Nd+jFajZ2QMwi0ag3XAfBT07tdIY20mfUfxgFiPezzTjXpOrk41PQ6
         m3ng==
X-Received: by 10.182.2.42 with SMTP id 10mr1313468obr.73.1384968326089; Wed,
 20 Nov 2013 09:25:26 -0800 (PST)
Received: by 10.76.111.170 with HTTP; Wed, 20 Nov 2013 09:24:45 -0800 (PST)
In-Reply-To: <20130903074150.GE3608@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238084>

On Tue, Sep 3, 2013 at 9:41 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 02, 2013 at 10:27:48PM -0400, Dale R. Worley wrote:
>
>> > I guess the "else" could and should be dropped. If you do so (and
>> > possibly insert a blank line between the DEFAULT_PAGER case and the
>> > "pager = NULL" case), you get a nice pattern
>> >
>> > if (!pager)
>> >     try_something();
>> > if (!pager)
>> >     try_next_option();
>>
>> That's true, but it would change the effect of using "cat" as a value:
>> "cat" as a value of DEFAULT_PAGER would cause git_pager() to return
>> NULL, whereas now it causes git_pager() to return "cat".  (All other
>> places where "cat" can be a value are translated to NULL already.)
>>
>> This is why I want to know what the *intended* behavior is, because we
>> might be changing Git's behavior, and I want to know that if we do
>> that, we're changing it to what it should be.  And I haven't seen
>> anyone venture an opinion on what the intended behavior is.
>
> I'll venture my opinion. We should do this:
>
> -- >8 --
> Subject: pager: turn on "cat" optimization for DEFAULT_PAGER
>
> If the user specifies a pager of "cat" (or the empty
> string), whether it is in the environment or from config, we
> automagically optimize it out to mean "no pager" and avoid
> forking at all. We treat an empty pager variable similary.
>
> However, we did not apply this optimization when
> DEFAULT_PAGER was set to "cat" (or the empty string). There
> is no reason to treat DEFAULT_PAGER any differently. The
> optimization should not be user-visible (unless the user has
> a bizarre "cat" in their PATH). And even if it is, we are
> better off behaving consistently between the compile-time
> default and the environment and config settings.
>
> The stray "else" we are removing from this code was
> introduced by 402461a (pager: do not fork a pager if PAGER
> is set to empty., 2006-04-16). At that time, the line
> directly above used:
>
>    if (!pager)
>            pager = "less";
>
> as a fallback, meaning that it could not possibly trigger
> the optimization. Later, a3d023d (Provide a build time
> default-pager setting, 2009-10-30) turned that constant into
> a build-time setting which could be anything, but didn't
> loosen the "else" to let DEFAULT_PAGER use the optimization.
>
> Noticed-by: Dale R. Worley <worley@alum.mit.edu>
> Suggested-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pager.c b/pager.c
> index c1ecf65..fa19765 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -54,7 +54,7 @@ const char *git_pager(int stdout_is_tty)
>                 pager = getenv("PAGER");
>         if (!pager)
>                 pager = DEFAULT_PAGER;
> -       else if (!*pager || !strcmp(pager, "cat"))
> +       if (!*pager || !strcmp(pager, "cat"))

Hmmpf. It's sometimes useful to actually pipe through cat rather than
disabling the pager, as this changes the return-code from isatty. I
sometimes use this for debugging-purposes. Does this patch break that?
