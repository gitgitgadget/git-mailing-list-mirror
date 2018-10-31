Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC3D1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 05:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeJaOJs (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 10:09:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:33858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725811AbeJaOJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 10:09:48 -0400
Received: (qmail 9349 invoked by uid 109); 31 Oct 2018 05:13:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 05:13:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7519 invoked by uid 111); 31 Oct 2018 05:12:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 31 Oct 2018 01:12:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2018 01:13:16 -0400
Date:   Wed, 31 Oct 2018 01:13:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/3] check_stream_sha1(): handle input underflow
Message-ID: <20181031051316.GC5601@sigill.intra.peff.net>
References: <20181030231232.GA6141@sigill.intra.peff.net>
 <20181030232312.GB32038@sigill.intra.peff.net>
 <xmqqpnvqyc9x.fsf@gitster-ct.c.googlers.com>
 <20181031043051.GA5601@sigill.intra.peff.net>
 <xmqq36smybbq.fsf@gitster-ct.c.googlers.com>
 <20181031050338.GB5601@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181031050338.GB5601@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 01:03:39AM -0400, Jeff King wrote:

> Phew. I almost just deleted all of the above, because now I think I'm
> ready to write that comment you asked for. ;) But I left it since maybe
> it makes sense to follow my thought process.

So here it is in a more succinct form.

-Peff

-- >8 --
Subject: [PATCH] read_istream_pack_non_delta(): document input handling

Twice now we have scratched our heads about why the loose streaming code
needs the protection added by 692f0bc7ae (avoid infinite loop in
read_istream_loose, 2013-03-25), but the similar code in its pack
counterpart does not.

The short answer is that use_pack() will die before it lets us run out
of bytes. Note that this could mean reading garbage (including the
trailing hash) from the packfile in some cases of corruption, but that's
OK. zlib will notice and complain (and if not, certainly the end result
will not match the object hash we expect).

Let's leave a comment this time to document our findings.

Signed-off-by: Jeff King <peff@peff.net>
---
 streaming.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/streaming.c b/streaming.c
index d1e6b2dce6..ac7c7a22f9 100644
--- a/streaming.c
+++ b/streaming.c
@@ -408,6 +408,15 @@ static read_method_decl(pack_non_delta)
 			st->z_state = z_done;
 			break;
 		}
+
+		/*
+		 * Unlike the loose object case, we do not have to worry here
+		 * about running out of input bytes and spinning infinitely. If
+		 * we get Z_BUF_ERROR due to too few input bytes, then we'll
+		 * replenish them in the next use_pack() call when we loop. If
+		 * we truly hit the end of the pack (i.e., because it's corrupt
+		 * or truncated), then use_pack() catches that and will die().
+		 */
 		if (status != Z_OK && status != Z_BUF_ERROR) {
 			git_inflate_end(&st->z);
 			st->z_state = z_error;
-- 
2.19.1.1298.g19f18f2a22

