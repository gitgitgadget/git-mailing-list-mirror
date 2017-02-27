Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91106201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 10:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbdB0KAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 05:00:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:34663 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbdB0J62 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 04:58:28 -0500
Received: (qmail 20736 invoked by uid 109); 27 Feb 2017 09:58:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 09:58:27 +0000
Received: (qmail 30909 invoked by uid 111); 27 Feb 2017 09:58:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 04:58:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 04:58:25 -0500
Date:   Mon, 27 Feb 2017 04:58:25 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de, e@80x24.org,
        jnareb@gmail.com, ttaylorr@github.com
Subject: Re: [PATCH v2] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170227095825.jhdspwy6oa6mvvvm@sigill.intra.peff.net>
References: <20170226184816.30010-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170226184816.30010-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 26, 2017 at 07:48:16PM +0100, Lars Schneider wrote:

> +If the request cannot be fulfilled within a reasonable amount of time
> +then the filter can respond with a "delayed" status and a flush packet.
> +Git will perform the same request at a later point in time, again. The
> +filter can delay a response multiple times for a single request.
> +------------------------
> +packet:          git< status=delayed
> +packet:          git< 0000
> +------------------------
> +

So Git just asks for the same content again? I see two issues with that:

  1. Does git have to feed the blob content again? That can be expensive
     to access or to keep around in memory.

  2. What happens when the item isn't ready on the second request? I can
     think of a few options:

       a. The filter immediately says "nope, still delayed". But then
          Git ends up busy-looping with "is this one ready yet?"

       b. The filter blocks until the item is ready. But then if other
	  items _are_ ready, Git cannot work on processing them. We lose
	  parallelism.

       c. You could do a hybrid: block until _some_ item is ready, and
          then issue "delayed" responses for everything that isn't
	  ready. Then if you assume that Git is looping over and over
	  through the set of objects, it will either block or pick up
	  _something_ on each loop.

	  But it makes a quadratic number of requests in the worst case.
	  E.g., imagine you have N items and the last one is available
	  first, then the second-to-last, and so on. You'll ask N times,
	  then N-1, then N-2, and so on.

I think it would be much more efficient to do something like:

  [Git issues a request and gives it an opaque index id]
  git> command=smudge
  git> pathname=foo
  git> index=0
  git> 0000
  git> CONTENT
  git> 0000

  [The data isn't ready yet, so the filter tells us so...]
  git< status=delayed
  git< 0000

  [Git may make other requests, that are either served or delayed]
  git> command=smudge
  git> pathname=foo
  git> index=1
  git> 0000
  git< status=success
  git< 0000
  git< CONTENT
  git< 0000

  [Now Git has processed all of the items, and each one either has its
   final status, or has been marked as delayed. So we ask for a delayed
   item]
  git> command=wait
  git> 0000

  [Some time may pass if nothing is ready. But eventually we get...]
  git< status=success
  git< index=0
  git< 0000
  git< CONTENT
  git< 0000

From Git's side, the loop is something like:

  while (delayed_items > 0) {
	/* issue a wait, and get back the status/index pair */
	status = send_wait(&index);
	delayed_items--;

	/*
	 * use "index" to find the right item in our list of files;
	 * the format can be opaque to the filter, so we could index
	 * it however we like. But probably numeric indices in an array
	 * are the simplest.
	 */
	assert(index > 0 && index < nr_items);
	item[index].status = status;
	if (status == SUCCESS)
		read_content(&item[index]);
  }

and the filter side just attaches the "index" string to whatever its
internal queue structure is, and feeds it back verbatim when processing
that item finishes.

-Peff
