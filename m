Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971841F453
	for <e@80x24.org>; Wed, 31 Oct 2018 05:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeJaOAJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 10:00:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:33834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728908AbeJaOAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 10:00:09 -0400
Received: (qmail 8964 invoked by uid 109); 31 Oct 2018 05:03:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 05:03:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7460 invoked by uid 111); 31 Oct 2018 05:02:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 31 Oct 2018 01:02:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2018 01:03:39 -0400
Date:   Wed, 31 Oct 2018 01:03:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/3] check_stream_sha1(): handle input underflow
Message-ID: <20181031050338.GB5601@sigill.intra.peff.net>
References: <20181030231232.GA6141@sigill.intra.peff.net>
 <20181030232312.GB32038@sigill.intra.peff.net>
 <xmqqpnvqyc9x.fsf@gitster-ct.c.googlers.com>
 <20181031043051.GA5601@sigill.intra.peff.net>
 <xmqq36smybbq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36smybbq.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 01:44:25PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> See 692f0bc7 to find who did the fix you stole from, and for what
> >> kind of breakage the original fix was made.
> >
> > Heh. I did not dig into it, but actually thought "I'll bet Junio had to
> > get this right when he wrote the streaming code. No wonder he spotted my
> > mistake so quickly!".
> >
> >> By the way, a very similar loop for pack_non_delta istream iterates
> >> while total_read is smaller than sz, but it does not have the same
> >> check upon BUF_ERROR to see if we've read everything.
> >
> > Indeed. Did you find that one by inspection, or did you peek at:
> >
> >   https://public-inbox.org/git/20130325202114.GD16019@sigill.intra.peff.net/
> 
> I looked for BUF_ERROR in the streaming.c and found two instances in
> a very similar looking loop with a subtle differnce, and the
> difference was due to one of them getting fixed in the past while
> the other one was left intact as written at its inception.
> 
> I should have looked for that message to read the part below
> three-dash mark.  Or we may want to transplant that comment somehow
> to the function so next person will not be puzzled like I did?

Hmm. Reading that function, I am not sure if it actually might need
fixing.

Might we actually get Z_BUF_ERROR asking for more input if zlib reads to
the end of the pack window? That is probably quite unlikely in practice,
but in theory you could feed a very large buffer for the output and use
a very small pack window.

So I do not think we can use the same logic in that loop. But at the
same time, what prevents use_pack() from getting to the very end of the
pack and saying "I have no bytes left for you"? And then we'd loop
infinitely, feeding zlib nothing.

I'm not sure what the solution is. I do not think this works:

diff --git a/streaming.c b/streaming.c
index d1e6b2dce6..a92a85ed10 100644
--- a/streaming.c
+++ b/streaming.c
@@ -394,6 +394,9 @@ static read_method_decl(pack_non_delta)
 		mapped = use_pack(st->u.in_pack.pack, &window,
 				  st->u.in_pack.pos, &st->z.avail_in);
 
+		if (!st->z.avail_in)
+			break;
+
 		st->z.next_out = (unsigned char *)buf + total_read;
 		st->z.avail_out = sz - total_read;
 		st->z.next_in = mapped;

because we may have read to the very end but still have bytes to output.

Though hrm. I think use_pack() will always tell us about the trailing
20-byte hash in the "avail" window. Which means we should never
legitimately get to 0 there, because it means that either:

  1. We're reading the trailing hash, which cannot possibly be right (in
     most cases I'd expect zlib to barf at that point anyway, but of
     course it's possible to have a hash that is valid zlib data ;) ).

  2. We're truncated _before_ the hash, so we really did read to EOF,
     and there are no more bytes. I suspect we may actually detect this
     case upon opening the pack (since we do peek at the trailer then),
     but again that could be fooled by coincidence.

I guess that's not the whole story, though. use_pack() tries to promise
at least 20 bytes (to simplify some of the other parsing routines). So
we shouldn't actually ever get "0" here. If we really are that close to
the end of the pack, we'd hit this logic in use_pack:

  if (offset > (p->pack_size - the_hash_algo->rawsz))
	die("offset beyond end of packfile (truncated pack?)");

So actually, I think this code is OK as-is. We will always have at least
20 bytes of input, or use_pack() will die.

Phew. I almost just deleted all of the above, because now I think I'm
ready to write that comment you asked for. ;) But I left it since maybe
it makes sense to follow my thought process.

-Peff
