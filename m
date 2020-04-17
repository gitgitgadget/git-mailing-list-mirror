Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB11C2D0EF
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 18:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8DA2078E
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 18:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgDQSGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:06:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:58304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730236AbgDQSGq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 14:06:46 -0400
Received: (qmail 3437 invoked by uid 109); 17 Apr 2020 18:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Apr 2020 18:06:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21651 invoked by uid 111); 17 Apr 2020 18:17:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Apr 2020 14:17:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Apr 2020 14:06:45 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, James Ramsay <james@jramsay.com.au>
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
Message-ID: <20200417180645.GJ1739940@coredump.intra.peff.net>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <20200318101825.GB1227946@coredump.intra.peff.net>
 <CAP8UFD3v_J3zGqHKa94d71QB82hTsX0MZasERB-jOnY3Ya-uJw@mail.gmail.com>
 <20200417174030.GB2103@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417174030.GB2103@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 17, 2020 at 11:40:30AM -0600, Taylor Blau wrote:

> > What do you think about something like:
> >
> > [promisorFilter "noBlobs"]
> >         type = blob:none
> >         uploadpack = true # maybe "allow" could also mean "true" here
> >         ...
> > ?
> 
> I'm not sure about introducing a layer of indirection here with
> "noBlobs". It's nice that it could perhaps be enabled/disabled for
> different builtins (e.g., by adding 'revList = false', say), but I'm not
> convinced that this is improving all of those cases, either.

Yeah, I don't like forcing the user to invent a subsection name. My
first thought was to suggest:

  [promisorFilter "blob:none"]
  uploadpack = true

but your tree example shows why that gets awkward: there are more keys
than just "allow this".

> One thing that I can think of (other than replacing the '.' with another
> delimiting character other than '=') is renaming the key from
> 'uploadPack' to 'uploadPackFilter'. I believe that this was suggested by

Yeah, that proposal isn't bad. To me the two viable options seem like:

 - uploadpack.filter.<filter>.*: this has the ugly fake multilevel
   subsection, but stays under uploadpack.*

 - uploadpackfilter.<filter>.*: more natural subsection, but not grouped
   syntactically with other uploadpack stuff

I am actually leaning towards the second. It should make the parsing
code less confusing, and it's not like there aren't already other config
sections that impact uploadpack.

> > > For reference, the patch I was thinking of was this:
> > >
> > >   https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/
> >
> > Are you using the patches in this series with or without something
> > like the above patch? I am ok to resend this patch series including
> > the above patch (crediting Szeder) if you use something like it.
> 
> We're not using them, but without them we suffer from a problem that if
> we can get a SIGPIPE when writing the "sorry, I don't support that
> filter" message back to the client, then they won't receive it.
> 
> Szeder's patches help address that issue by catching the SIGPIPE and
> popping off enough from the client buffer so that we can write the
> message out before dying.

I definitely think we should pursue that patch, but it really can be
done orthogonally. It's an existing bug that affects other instances
where upload-pack returns an error. The tests can work around it with
"test_must_fail ok=sigpipe" in the meantime.

-Peff
