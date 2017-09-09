Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEFE2202A4
	for <e@80x24.org>; Sat,  9 Sep 2017 10:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757441AbdIIKbe (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 06:31:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:33276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756989AbdIIKbd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 06:31:33 -0400
Received: (qmail 30526 invoked by uid 109); 9 Sep 2017 10:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Sep 2017 10:31:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13844 invoked by uid 111); 9 Sep 2017 10:32:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Sep 2017 06:32:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Sep 2017 06:31:31 -0400
Date:   Sat, 9 Sep 2017 06:31:31 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/12] Clean up notes-related code around `load_subtree()`
Message-ID: <20170909103131.pppm346qbj2cdxuo@sigill.intra.peff.net>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 26, 2017 at 10:28:00AM +0200, Michael Haggerty wrote:

> It turns out that the comment is incorrect, but there was nevertheless
> plenty that could be cleaned up in the area:
> 
> * Make macro `GIT_NIBBLE` safer by adding some parentheses
> * Remove some dead code
> * Fix some memory leaks
> * Fix some obsolete and incorrect comments
> * Reject "notes" that are not blobs
> 
> I hope the result is also easier to understand.
> 
> This branch is also available from my Git fork [1] as branch
> `load-subtree-cleanup`.

FYI, Coverity seems to complain about "pu" after this series is merged, but
I think it's wrong.  It says:

  *** CID 1417630:  Memory - illegal accesses  (OVERRUN)
  /notes.c: 458 in load_subtree()
  452     
  453     			/*
  454     			 * Pad the rest of the SHA-1 with zeros,
  455     			 * except for the last byte, where we write
  456     			 * the length:
  457     			 */
  >>>     CID 1417630:  Memory - illegal accesses  (OVERRUN)
  >>>     Overrunning array of 20 bytes at byte offset 20 by dereferencing pointer "&object_oid.hash[len]".
  458     			memset(object_oid.hash + len, 0, GIT_SHA1_RAWSZ - len - 1);
  459     			object_oid.hash[KEY_INDEX] = (unsigned char)len;
  460     
  461     			type = PTR_TYPE_SUBTREE;
  462     		} else {
  463     			/* This can't be part of a note */

I agree that if "len" were 20 here that would be a problem, but I don't
think that's possible.

The tool correctly claims that prefix_len can be up to 19, due to the
assert:

     3. cond_at_most: Checking prefix_len >= 20UL implies that prefix_len may be up to 19 on the false branch.
  420        if (prefix_len >= GIT_SHA1_RAWSZ)
  421                BUG("prefix_len (%"PRIuMAX") is out of range", (uintmax_t)prefix_len);

Then it claims:

    13. Condition path_len == 2 * (20 - prefix_len), taking false branch.
  430                if (path_len == 2 * (GIT_SHA1_RAWSZ - prefix_len)) {
  431                        /* This is potentially the remainder of the SHA-1 */

So we know that either prefix_len is not 19, or that path_len is not 2
(since that combination would cause us to take the true branch here).
But then it goes on to say:

    14. Condition path_len == 2, taking true branch.
  442                } else if (path_len == 2) {
  443                        /* This is potentially an internal node */

which I believe must mean that prefix_len cannot be 19 here. And yet it
says:

    15. assignment: Assigning: len = prefix_len. The value of len may now be up to 19.
  444                        size_t len = prefix_len;
  445
  [...]
     17. incr: Incrementing len. The value of len may now be up to 20.
     18. Condition hex_to_bytes(&object_oid.hash[len++], entry.path, 1), taking false branch.
  450                        if (hex_to_bytes(object_oid.hash + len++, entry.path, 1))
  451                                goto handle_non_note; /* entry.path is not a SHA1 */

I think that's impossible, and Coverity simply isn't smart enough to
shrink the set of possible values for prefix_len based on the set of
if-else conditions.

So nothing to see here, but since I spent 20 minutes scratching my head
(and I know others look at Coverity output and may scratch their heads
too), I thought it was worth writing up. And also if I'm wrong, it would
be good to know. ;)

-Peff
