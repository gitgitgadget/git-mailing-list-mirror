Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02815C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6E360FDC
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhGBVQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 17:16:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:40276 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230461AbhGBVQA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 17:16:00 -0400
Received: (qmail 32580 invoked by uid 109); 2 Jul 2021 21:13:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Jul 2021 21:13:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28443 invoked by uid 111); 2 Jul 2021 21:13:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Jul 2021 17:13:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Jul 2021 17:13:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 7/8] serve: add support for a "startup" git_config()
 callback
Message-ID: <YN+BdikYt+lH+L3I@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
 <patch-7.8-0a4fb01ae38-20210628T191634Z-avarab@gmail.com>
 <YN3wvy6fhD4V+FA3@coredump.intra.peff.net>
 <87o8bkamxb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8bkamxb.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 02, 2021 at 02:55:38PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Sadly I don't think this addresses my "v2 receive-pack" concern. The
> > ls_refs_startup_config() function will get called after we've received a
> > request for "ls-refs", which is good. But:
> 
> I think it does in that you rightly objected to us moving all config to
> such a callback, because for some of it we don't have the information
> needed to look it up yet, we do that in the request handler.
> 
> But for a lot of our config it's fine to do it early, hence "startup"
> config.

So I think your patch is OK, but just to lay out my thinking, it was
this. The v2 serve code basically does:

  1. Somebody calls serve().

  2. It reads a capability/operation name, then dispatches to the
     appropriate function.

  3. That function reads operation-specific data, like options.

Your first patch read config at step 1. This one reads at step 2.

But from past discussions, the hide-refs config could only be read (or
interpreted) after step 3, because that's when we'd see an option saying
"this is for pushing".

So anything except step 3 is "too late". But that doesn't stop us from
having some early config and some operation-specific late config.

> Yes I've moved the ls-refs handling into the "startup" because /right
> now/ it's only handling fetches, it'll need to be moved out if and when
> we start handling pushes.
> 
> But isn't it going to be obvious that we'll need to do that then? Since
> we'll have the example of upload-pack.c doing that exact thing?
>
> I.e. do you not want to have the "startup config" concept at all, or
> would just prefer to have the ls-refs part of it pre-emotively moved out
> of it in anticipation of handling pushes some day, even if we can do
> that on "startup" now?

Sorry to be so confusing. About halfway through writing my previous
email I had realized "well, I guess we can have two phases of
config-reading, and that's not so bad". So I'm OK with this direction.

I don't think anything else needs to happen on top of your patch here.
The "late" phase for ls-refs config reading already happens totally
separately (it's in the git_config(ls_refs_config) call, which is
already separate from the ensure_config_read() thing. And your patch
leaves that line untouched.

> > And then it is a separate thing entirely from your "serve will read
> > config" code. It's arguably more confusing, because now config is read
> > in two places, but that is already true because of this
> > ensure_config_read() thing.
> 
> This suggests to me you'd like to preemptively move it out of "startup",
> correct?

It's already out of the startup, so I think we are OK.

My big question here was: is the concept of "startup config" and "other
config we read after seeing the options" too confusing? But probably
not.

> I just thought preemptively doing it for "ls-refs" wouldn't be needed,
> since we'd notice in testing such a feature that "do it once" would
> break in obvious ways for multi-requests, especially with the comment
> for the "startup_config" callback explicitly calling out that case.

Yeah, we'd definitely notice. I was just wondering if we'd end up
needing to back out these changes to accommodate it. But the two-phase
thing solves that.

-Peff
