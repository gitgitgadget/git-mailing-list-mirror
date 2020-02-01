Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB557C33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF7B206E6
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgBALIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 06:08:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:50310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbgBALIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 06:08:37 -0500
Received: (qmail 21081 invoked by uid 109); 1 Feb 2020 11:08:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Feb 2020 11:08:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8036 invoked by uid 111); 1 Feb 2020 11:16:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Feb 2020 06:16:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 Feb 2020 06:08:36 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/7] sha1-file: pass git_hash_algo to
 write_object_file_prepare()
Message-ID: <20200201110836.GB1864948@coredump.intra.peff.net>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
 <f256d2058736091c3d9662788762849e8df794b0.1580413221.git.matheus.bernardino@usp.br>
 <20200201100337.u4ikzmrprca4ltvb@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200201100337.u4ikzmrprca4ltvb@tb-raspi4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 01, 2020 at 11:03:37AM +0100, Torsten Bögershausen wrote:

> > diff --git a/sha1-file.c b/sha1-file.c
> > index 13b90b1cb1..e789bfd153 100644
> > --- a/sha1-file.c
> > +++ b/sha1-file.c
> > @@ -1647,7 +1647,8 @@ void *read_object_with_reference(struct repository *r,
> >  	}
> >  }
> >
> > -static void write_object_file_prepare(const void *buf, unsigned long len,
> > +static void write_object_file_prepare(const struct git_hash_algo *algo,
> > +				      const void *buf, unsigned long len,
> >  				      const char *type, struct object_id *oid,
> >  				      char *hdr, int *hdrlen)
> >  {
> 
> One minor minor suggestion/nit, may be my own type of style only.
> 
> When adding a parameter to a function, we typically add it at the end of
> the parameter list, rather than at the beginning.
> The other (unwritten) convention, when dealing with "buffer pointer/len",
> seams to be that buffer-ptr is the first paramter and len is is the second.

I'd usually add new options at the end, too, all things being equal. But
in this case, I see:

  - some of these are input parameters and some are output (I think oid,
    hdr, and hdrlen are the latter); it makes sense to keep them grouped
    that way

  - in object-oriented functions, we'd often take the object first
    (e.g., strbuf_add). In non-object-oriented functions, we often take
    a "context" argument first that shapes how the function works (e.g.,
    all of the pp_* functions that take a pretty_print_context). I'd
    think of the algorithm a little bit as a "context" argument, though
    I admit it's mostly a gut feeling and quite subjective.

    But if you believe that line of reasoning, then it doesn't seem out
    of place as the first argument.

-Peff
