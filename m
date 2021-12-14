Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0EC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 15:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhLNPIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 10:08:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:51634 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232968AbhLNPIq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 10:08:46 -0500
Received: (qmail 14106 invoked by uid 109); 14 Dec 2021 15:08:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 15:08:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25356 invoked by uid 111); 14 Dec 2021 15:08:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 10:08:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 10:08:45 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] upload-pack.c: make output buffer size configurable
Message-ID: <YbizfdGq+RSu9BGe@coredump.intra.peff.net>
References: <20211213132345.26310-1-jacob@gitlab.com>
 <20211213132345.26310-2-jacob@gitlab.com>
 <211214.86y24nbd46.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211214.86y24nbd46.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 14, 2021 at 01:08:55PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > +#ifndef UPLOAD_PACK_BUFFER_SIZE
> > +#define UPLOAD_PACK_BUFFER_SIZE 8192
> > +#endif
> > +
> >  /* Enum for allowed unadvertised object request (UOR) */
> >  enum allow_uor {
> >  	/* Allow specifying sha1 if it is a ref tip. */
> > @@ -194,7 +198,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
> >  }
> >  
> >  struct output_state {
> > -	char buffer[8193];
> > +	char buffer[UPLOAD_PACK_BUFFER_SIZE+1];
> >  	int used;
> >  	unsigned packfile_uris_started : 1;
> >  	unsigned packfile_started : 1;
> 
> Making this configurable obviousl has big impact in some cases, but I'm
> a bit iffy on the faciltity to do so + it not being documented.
> 
> I don't think that the "static buffer" part here is important to anyone,
> but the write() size is clearly important.
> 
> So doesn't it make more sense to have a uploadPack.bufferSize=8k
> variable we can tweak, just make this "buffer" a "struct strbuf" instead
> (i.e. it'll by dynamically grown), and then just flush it whenever we
> hit the configured buffer size?

I don't think we want to grow dynamically, because we don't want to hold
arbitrary amounts of data in memory. We're just passing it through. But
if there were a run-time config option, we could easily heap-allocate
the buffer up front.

That may be overkill, though I do agree this is kind of weirdly
undocumented. There are two other subtleties I notice:

  - This output_state struct does go on the stack, so something big like
    64k is questionable there (though on Linux, without recursion, it's
    usually OK).

  - we're relaying the data into pkt-lines. Do we run into problems when
    the buffer is larger than a packet? I think in send_sideband() we'll
    break it up as appropriate. But before we hit the PACK header, we
    send out packfile-uris directly with packet_write_fmt(). Those
    aren't likely to be long, but if they are, we'd die() in
    format_packet(). So something around LARGE_PACKET_DATA_MAX is
    probably the highest you'd want to set it anyway (and the most
    performant, since otherwise you have to write out extra partial
    packets).

So I kind of wonder if there is any real _harm_ in just always using
bigger packets, even if it does not always help. Given the subtle rules
about packet-max above, then we could just use that optimal value and
not worry about configurability.

-Peff
