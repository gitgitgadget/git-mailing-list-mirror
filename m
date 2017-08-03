Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53FE72047F
	for <e@80x24.org>; Thu,  3 Aug 2017 08:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbdHCIGI (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 04:06:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:56526 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751050AbdHCIGF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 04:06:05 -0400
Received: (qmail 9943 invoked by uid 109); 3 Aug 2017 08:06:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Aug 2017 08:06:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16842 invoked by uid 111); 3 Aug 2017 08:06:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Aug 2017 04:06:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Aug 2017 04:06:00 -0400
Date:   Thu, 3 Aug 2017 04:06:00 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v3 01/16] Add initial external odb support
Message-ID: <20170803080600.aeaprj5hb6ucrkgy@sigill.intra.peff.net>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
 <20161130210420.15982-2-chriscool@tuxfamily.org>
 <xmqqmvggbl6m.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD0ecFW2Sk0fr3ysAXPERNp1RiBMqZMTjYxgt_mvtY-kaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0ecFW2Sk0fr3ysAXPERNp1RiBMqZMTjYxgt_mvtY-kaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 03, 2017 at 09:46:38AM +0200, Christian Couder wrote:

> >> +static int external_odb_config(const char *var, const char *value, void *data)
> >> +{
> >> +     struct odb_helper *o;
> >> +     const char *key, *dot;
> >> +
> >> +     if (!skip_prefix(var, "odb.", &key))
> >> +             return 0;
> >> +     dot = strrchr(key, '.');
> >> +     if (!dot)
> >> +             return 0;
> >
> > Is this something Peff wrote long time ago?  I find it surprising
> > that he would write this without using parse_config_key().
> 
> parse_config_key() is used now.

Yeah, I think the original was from 2012. We didn't add
parse_config_key() until 2013. Definitely worth using.

> >> +     for (;;) {
> >> +             unsigned char buf[4096];
> >> +             int r;
> >> +
> >> +             r = xread(cmd.child.out, buf, sizeof(buf));
> >> +             if (r < 0) {
> >> +                     error("unable to read from odb helper '%s': %s",
> >> +                           o->name, strerror(errno));
> >> +                     close(cmd.child.out);
> >> +                     odb_helper_finish(o, &cmd);
> >> +                     git_inflate_end(&stream);
> >> +                     return -1;
> >> +             }
> >> +             if (r == 0)
> >> +                     break;
> >> +
> >> +             write_or_die(fd, buf, r);
> >> +
> >> +             stream.next_in = buf;
> >> +             stream.avail_in = r;
> >> +             do {
> >> +                     unsigned char inflated[4096];
> >> +                     unsigned long got;
> >> +
> >> +                     stream.next_out = inflated;
> >> +                     stream.avail_out = sizeof(inflated);
> >> +                     zret = git_inflate(&stream, Z_SYNC_FLUSH);
> >> +                     got = sizeof(inflated) - stream.avail_out;
> >> +
> >> +                     git_SHA1_Update(&hash, inflated, got);
> >> +                     /* skip header when counting size */
> >> +                     if (!total_got) {
> >> +                             const unsigned char *p = memchr(inflated, '\0', got);
> [reconstructed quoted function so we can see the whole thing]
> >> +                             if (p)
> >> +                                     got -= p - inflated + 1;
> >> +                             else
> >> +                                     got = 0;
> >> +                     }
> >> +                     total_got += got;
> >> +             } while (stream.avail_in && zret == Z_OK);
> >> +     }
> >
> > Does this assume that a single xread() that can result in a
> > short-read would not return in the middle of "header", and if so, is
> > that a safe assumption to make?
> 
> I am not sure what would go wrong in case of a short read.
> My guess is that as long as we test that p is not NULL below we should be fine.
> As Peff wrote this code, he could probably answer much better than me.

I think it's OK. The idea is to suck up characters until we hit the
end-of-header NUL. So "total_got" only becomes non-zero once we've seen
that NUL. If we get a short read then that memchr() returns NULL, and we
set "got" to 0, and don't advance total_got at all. When we finally do
hit a partial read that contains the NUL, then "p" will be non-NULL, and
we'll reduce "got" as appropriate.

All that said, I agree with the bits you both said later that we should
probably be checking the actual content of the header (if we're indeed
going to keep this on-the-wire format -- see below).

> > I am tempted to debate myself if it is a sensible design to require
> > "get" to return a loose object representation, but cannot decide
> > without seeing the remainder of the series.  An obvious alternative
> > is to define the "get" request to interface with us via the raw
> > contents (not even deflated) and leave the deflating to us, i.e. Git
> > sitting on the receiving end, which would allow us to choose to
> > store it differently (e.g. we may want to try streaming it into its
> > own pack using the streaming.h API, for example).
> 
> There is now both a get_raw_obj and a get_git_obj to handle both cases.

Yeah, I don't recall why I picked the loose format as the transfer
mechanism. I guess I figured that the objects would be large, so we'd
want them in their own loose objects (not part of a pack that might have
to get rewritten). So storing and sending as a loose-object zlib stream
means we can avoid any recompression and just send it out to disk.

But that was a long time ago. I think these days we prefer to put even
large objects into packfiles. If we wanted something the client could
stream directly into storage, the pack format would probably make more
sense. But it also probably isn't the end of the world to just get raw
contents and then re-zlib them. That's a little extra overhead on the
receiving side, but it makes things nice and simple. And we're already
uncompressing and computing the sha1 to verify the incoming content
anyway.

-Peff
