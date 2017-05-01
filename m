Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66B1B1F78F
	for <e@80x24.org>; Mon,  1 May 2017 22:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbdEAW2C (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 18:28:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:43455 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbdEAW2B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 18:28:01 -0400
Received: (qmail 30874 invoked by uid 109); 1 May 2017 22:28:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 22:28:01 +0000
Received: (qmail 6962 invoked by uid 111); 1 May 2017 22:28:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 18:28:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 18:27:58 -0400
Date:   Mon, 1 May 2017 18:27:58 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/53] fast-import: convert to struct object_id
Message-ID: <20170501222758.fzhrwg4w3p3ayxhg@sigill.intra.peff.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-12-sandals@crustytoothpaste.net>
 <165f4108-267b-f522-d78d-36b0064ee48c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165f4108-267b-f522-d78d-36b0064ee48c@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 03:07:22PM -0700, Jonathan Tan wrote:

> > @@ -2298,8 +2296,12 @@ static uintmax_t do_change_note_fanout(
> >  static uintmax_t change_note_fanout(struct tree_entry *root,
> >  		unsigned char fanout)
> >  {
> > -	char hex_sha1[40], path[60];
> > -	return do_change_note_fanout(root, root, hex_sha1, 0, path, 0, fanout);
> > +	/*
> > +	 * The size of path is due to one slash between every two hex digits,
> > +	 * plus the terminating NUL.
> > +	 */
> > +	char hex_oid[GIT_MAX_HEXSZ], path[GIT_MAX_HEXSZ * 3 / 2];
> 
> If your comment is correct, shouldn't the size of path be 61 (that is, add
> "+ 1")? I took a look at do_change_note_fanout() and your comment seems
> correct.

If you have 40 hex digits, then you have 20 hex pairs. But delimiting
them all takes only 19 slashes, since they only go in between pairs[1].

So the fully expanded formula is:

  GIT_MAX_HEXSZ +               (1) actual hex bytes
  (GIT_MAX_HEXSZ / 2) - 1 +     (2) internal slashes between pairs
  1                             (3) NUL terminator

which simplifies to 3/2 GIT_MAX_HEXSZ. It may be better to write it out
(the compiler can simplify) or explain that in the comment, though. It
took me a minute to figure out that it was correct, too.

-Peff

[1] This is sort of a reverse-fencepost error:
    https://en.wikipedia.org/wiki/Off-by-one_error#Fencepost_error
