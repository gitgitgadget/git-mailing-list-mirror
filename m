Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB040211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 19:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725743AbeLBHC6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 02:02:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:56240 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725728AbeLBHC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 02:02:58 -0500
Received: (qmail 21361 invoked by uid 109); 1 Dec 2018 19:49:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Dec 2018 19:49:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1550 invoked by uid 111); 1 Dec 2018 19:49:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Dec 2018 14:49:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2018 14:49:40 -0500
Date:   Sat, 1 Dec 2018 14:49:40 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Geert Jansen <gerardu@amazon.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick
 existence check
Message-ID: <20181201194940.GA29081@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
 <ec25f85c-4b8c-0b83-addb-074957de1e1c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec25f85c-4b8c-0b83-addb-074957de1e1c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 09:48:57PM +0100, René Scharfe wrote:

> > +static int quick_has_loose(struct repository *r,
> > +			   const unsigned char *sha1)
> > +{
> > +	int subdir_nr = sha1[0];
> > +	struct object_id oid;
> > +	struct object_directory *odb;
> > +
> > +	hashcpy(oid.hash, sha1);
> > +
> > +	prepare_alt_odb(r);
> > +	for (odb = r->objects->odb; odb; odb = odb->next) {
> > +		odb_load_loose_cache(odb, subdir_nr);
> 
> Is this thread-safe?  What happens if e.g. one index-pack thread resizes
> the array while another one sorts it?

No, but neither is any of the object_info / has_object_file path, which
may use static function-local buffers, or (before my series) alt scratch
bufs, or even call reprepare_packed_git().

In the long run, I think the solution is probably going to be pushing
some mutexes into the right places, and putting one around the cache
fill is an obvious place.

> Loading the cache explicitly up-front would avoid that, and improves
> performance a bit in my (very limited) tests on an SSD.  Demo patch for
> next at the bottom.  How does it do against your test cases?

It's going to do badly on corner cases where we don't need to load every
object subdirectory, and one or more of them are big. I.e., if I look up
"1234abcd", the current code only needs to fault in $GIT_DIR/objects/12.
Pre-loading means we'd hit them all. Even without a lot of objects, on
NFS that's 256 latencies instead of 1.

-Peff
