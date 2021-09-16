Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A347C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7315061209
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbhIPVdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:33:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:49476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231830AbhIPVdH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:33:07 -0400
Received: (qmail 8430 invoked by uid 109); 16 Sep 2021 21:31:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Sep 2021 21:31:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9203 invoked by uid 111); 16 Sep 2021 21:31:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Sep 2021 17:31:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Sep 2021 17:31:45 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
Message-ID: <YUO3wXG3a/fW7AME@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
 <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
 <YTTARcEvpXWSDfYW@coredump.intra.peff.net>
 <CAOLTT8QbdNBSY95bCa+UNJBqsJEEHbnaKfZLzvN2Qzd-Np8Lqg@mail.gmail.com>
 <YTeo/dCFfpAIfo3K@coredump.intra.peff.net>
 <CAOLTT8Ru-Zhmo5j=jNjWexrahT0qAO5zEMW09XT00-TCca-SkA@mail.gmail.com>
 <YTtrF8C0mmT6kBJT@coredump.intra.peff.net>
 <CAOLTT8RPzutEQxbr9cu=ze7rgPKvG6Ghu4b2Bi47eStY1TqGzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8RPzutEQxbr9cu=ze7rgPKvG6Ghu4b2Bi47eStY1TqGzQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 08:27:15PM +0800, ZheNing Hu wrote:

> > > @@ -2735,6 +2723,7 @@ void pretty_print_ref(const char *name, const
> > > struct object_id *oid,
> > >
> > >         ref_item = new_ref_array_item(name, oid);
> > >         ref_item->kind = ref_kind_from_refname(name);
> > > +       read_ref_full(name, 0, NULL, &ref_item->flag);
> > >         if (format_ref_array_item(ref_item, format, &output, &err))
> > >                 die("%s", err.buf);
> > >         fwrite(output.buf, 1, output.len, stdout);
> >
> > IMHO this is the wrong place to do it, since the caller may already have
> > the flags (and looking up the ref again is a non-trivial cost).
> >
> 
> Well, but not doing this means that we have to pass the flag from the
> pretty_print_ref() call stack.

Right. But there are only two callers of that function, so I don't think
it's a big imposition to require it.

> > My proposal was that we'd have a specific flag in ref-filter to say
> > "default refname:strip to this value". And then _only_ "tag --verify"
> > would set that (to "2"), leaving for-each-ref, etc unaffected.
> >
> 
> Indeed this may be a feasible solution. I will try to do this first.

Great, thanks for taking a look at it.

-Peff
