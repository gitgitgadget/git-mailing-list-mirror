Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2B51FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 07:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbdFJHBg (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 03:01:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:37480 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbdFJHBg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 03:01:36 -0400
Received: (qmail 30654 invoked by uid 109); 10 Jun 2017 07:01:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 07:01:35 +0000
Received: (qmail 29078 invoked by uid 111); 10 Jun 2017 07:01:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 03:01:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 03:01:33 -0400
Date:   Sat, 10 Jun 2017 03:01:33 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] sha1_file: extract type and size from object_info
Message-ID: <20170610070133.boicdvkudifz7b4c@sigill.intra.peff.net>
References: <cover.1497035376.git.jonathantanmy@google.com>
 <b090fef9ff8593a6d77c3d3363b4af7e73ac12dc.1497035376.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b090fef9ff8593a6d77c3d3363b4af7e73ac12dc.1497035376.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 09, 2017 at 12:23:24PM -0700, Jonathan Tan wrote:

> Looking at the 3 primary functions (sha1_object_info_extended,
> read_object, has_sha1_file_with_flags), they independently implement
> mechanisms such as object replacement, retrying the packed store after
> failing to find the object in the packed store then the loose store, and
> being able to mark a packed object as bad and then retrying the whole
> process. Consolidating these mechanisms would be a great help to
> maintainability.
> 
> Such a consolidated function would need to handle the read_object() case
> (which returns the object data, type, and size) and the
> sha1_object_info_extended() case (which returns the object type, size,
> and some additional information, not all of which can be "turned off" by
> passing NULL in "struct object_info").

I like the idea of consolidating the logic. But I can't help but feel
that pulling these fields out of object_info is a step backwards. The
point of that struct is to let the caller specify which aspects of the
object they're interested in, and let the lookup function decide how
best to optimize the query.

So it seems like places which actually want to read the object should be
passing in a new field in the object_info for "yes, I actually want the
object contents, too", and then the consolidated function can decide
which approach to take based on whether or not the contents are
requested (e.g., unpacking the whole thing, or just the header).

If a caller asks for the contents but not the size, that's OK. We'd find
the size incidentally while unpacking the contents, but just not include
it in the returned object_info.

Another approach to this whole mess is to have a single function for
acquiring a "handle" to an object, along with functions to query aspects
of a handle. That would let callers iteratively ask for the parts they
care about, and we could lazily fill the handle info (so information we
pick up while servicing one property of the object gets cached and
returned for free if the caller asks for it later).

That's a much bigger change, though it may have other benefits (e.g., we
could be passing around handles instead of object buffers, which would
make it more natural to stream object content in many cases).

-Peff
