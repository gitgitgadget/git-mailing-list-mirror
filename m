Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DBBC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 02:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B20611AD
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 02:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhKDCkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 22:40:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:52738 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhKDCkN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 22:40:13 -0400
Received: (qmail 6614 invoked by uid 109); 4 Nov 2021 02:37:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 02:37:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27669 invoked by uid 111); 4 Nov 2021 02:37:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Nov 2021 22:37:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Nov 2021 22:37:35 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email,
        eschwartz@archlinux.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] async_die_is_recursing: fix use of pthread_getspecific
 for Fedora
Message-ID: <YYNHb0qq2n5OWC+R@coredump.intra.peff.net>
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
 <CAPUEspjw4zypiywCBRc=y9uC4G5CKTE35GLVf_wDY436oO0C5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspjw4zypiywCBRc=y9uC4G5CKTE35GLVf_wDY436oO0C5w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 07:23:23PM -0700, Carlo Arenas wrote:

> > diff --git a/run-command.c b/run-command.c
> > index 7ef5cc712a9..a82cf69e7d3 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -1099,7 +1099,7 @@ static NORETURN void die_async(const char *err, va_list params)
> >  static int async_die_is_recursing(void)
> >  {
> >         void *ret = pthread_getspecific(async_die_counter);
> > -       pthread_setspecific(async_die_counter, (void *)1);
> > +       pthread_setspecific(async_die_counter, &ret); /* set to any non-NULL valid pointer */
> 
> I guess this would work, since the pointer is never dereferenced, but
> the use of (void *)1 was hacky, and this warning seems like the right
> time to make it less so.
> 
> Would a dynamically allocated pthread_local variable be a better
> option,  or even a static global, since we don't care about its value
> so no need to worry about any races?

Yeah, I had the same thought. I think what's in the patch above is OK in
practice, but it sure _feels_ wrong to store the address of an auto
variable that goes out of scope.

I'm OK with it as a minimal fix, though, to get things unstuck. The
commit message nicely explains what's going on, and the original (which
it looks like blames to me ;) ) is pretty gross, too.

Keeping an actual counter variable would be the least-confusing thing,
IMHO, but that implies allocating per-thread storage (which means having
to clean it up). And we really only care about counting up to "1", so
the boolean "do we have a pointer" is fine. The static variable you
suggest might be a good middle ground there, and we could even use it
for the comparison to make things more clear.  Something like:

  static int async_die_is_recursing(void)
  {
	  static int async_recursing_flag;
          void *ret = pthread_getspecific(async_die_counter);
	  pthread_setspecific(async_die_counter, &async_recursing_flag);
	  return ret == &async_recursing_flag;
  }

But I don't feel that strongly either way.

-Peff
