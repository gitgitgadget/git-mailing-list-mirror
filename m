Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29450201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 01:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752912AbdBRBmV (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 20:42:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:57902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752597AbdBRBmV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 20:42:21 -0500
Received: (qmail 7442 invoked by uid 109); 18 Feb 2017 01:42:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Feb 2017 01:42:20 +0000
Received: (qmail 11230 invoked by uid 111); 18 Feb 2017 01:42:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 20:42:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 20:42:17 -0500
Date:   Fri, 17 Feb 2017 20:42:17 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170218014217.sil4jyukkbqguxfz@sigill.intra.peff.net>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
 <20170218000652.375129-3-sandals@crustytoothpaste.net>
 <3630da01-5af3-bc02-3a8c-1e3495512279@ramsayjones.plus.com>
 <20170218012607.kdisudmmponvts35@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170218012607.kdisudmmponvts35@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 18, 2017 at 01:26:07AM +0000, brian m. carlson wrote:

> > > +	struct object_id oid;
> > >  	struct tree *tree2;
> > > -	if (len != 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha1))
> > > +	const int chunksz = GIT_SHA1_HEXSZ + 1;
> > > +	if (len != 2 * chunksz || !isspace(line[chunksz-1]) ||
> > > +		get_sha1_hex(line + chunksz, oid.hash))
> > 
> > I'm not sure that this is an improvement. The input expected in 'line'
> > is supposed to look like: '<sha1> + <space> + <sha1> + <\n>'. So your
> > 'chunk' would be a <sha1> plus one 'char' of some sort. Except that the
> > caller of this function has already replaced the newline character with
> > a '\0' char (so strlen(line) would return 81), but still passes the
> > original line length! Also, note that this (and other functions in this
> > file) actually test for 'isspace(char)' rather than for a ' ' char!
> > 
> > Hmm, maybe just:
> > 
> > if (len < (2 * GIT_SHA1_HEXSZ + 1) || line[GIT_SHA1_HEXSZ] != ' ' ||
> >     get_sha1_hex(line + GIT_SHA1_HEXSZ + 1, oid.hash))
> > 
> > (or, perhaps, still call isspace() in this patch ...)
> 
> Well, I think it's strictly an improvement in that we have avoided
> writing hardcoded constants[0].  I did intend it as a "hash plus one"
> chunk, which is actually quite common throughout the code.
> 
> I'm wondering if parse_oid_hex could be useful here as well.

I know I haven't looked at this chunk nearly as carefully as you have,
but it seems somewhat crazy to me that these functions get the original
"line" in the first place. Shouldn't they get line+40 from the caller
(who in turn should be using parse_oid_hex to compute that)?

And then each function should subsequently parse left-to-right with
a mix of isspace() and parse_oid_hex(), and probably doesn't even need
to care about the original "len" at all (yes, you can quit early if you
know your len isn't long enough, but that's the unusual error case
anyway; it's not a big deal to find that out while parsing).

In general, I think this sort of left-to-right incremental pointer
movement is safe and simple. There may be a few cases where it doesn't
apply (i.e., where you need to look at the end of the string to know how
to parse the beginning), but that should be relatively rare.

> [0] If we change the hash size, all of the GIT_SHA1_HEXSZ constants can
> be replaced with a variable that varies based on hash size, and the code
> still works.

I am happy to see fewer magic numbers. But I think with incremental
pointer-movements, we don't even need to use the numeric constants,
either. If one day we can parse "sha256:1234abcd..." as an oid, then the
existing code would "just work".

-Peff
