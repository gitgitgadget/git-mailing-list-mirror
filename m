Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450FC1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 10:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfADKLw (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 05:11:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:54512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725958AbfADKLw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 05:11:52 -0500
Received: (qmail 31565 invoked by uid 109); 4 Jan 2019 10:11:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Jan 2019 10:11:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16684 invoked by uid 111); 4 Jan 2019 10:11:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 04 Jan 2019 05:11:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2019 05:11:50 -0500
Date:   Fri, 4 Jan 2019 05:11:50 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Masaya Suzuki <masayasuzuki@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/2] Change how HTTP response body is returned
Message-ID: <20190104101149.GA26185@sigill.intra.peff.net>
References: <20181228014720.206443-1-masayasuzuki@google.com>
 <20181229194447.157763-1-masayasuzuki@google.com>
 <20181229194447.157763-2-masayasuzuki@google.com>
 <xmqqtviph835.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtviph835.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 03, 2019 at 11:09:02AM -0800, Junio C Hamano wrote:

> > +	if (dest->file) {
> > +		/*
> > +		 * At this point, the file contains the response body of the
> > +		 * previous request. We need to truncate the file.
> > +		 */
> > +		FILE *new_file = freopen(dest->filename, "w", dest->file);
> 
> Now freopen() lets us restart the file anew with a new "FILE *".
> 
> > +		if (new_file == NULL) {
> > +			error("Unable to open local file %s", dest->filename);
> 
> error_errno(), perhaps?
> 
> At this point, I presume that dest->file is closed by the failed
> freopen(), but dest->file is still non-NULL and causes further calls
> to http_request() with this dest would be a disaster?  As long as
> the caller of this function reacts to HTTP_ERROR and kill the dest,
> it would be fine.

I also wondered what timing guarantees freopen() gives us (i.e., is it
possible for it to open and truncate the file, and then close the old
handle, flushing some in-memory buffer). C99 says:

  The freopen function first attempts to close any file that is
  associated with the specified stream. Failure to close the file is
  ignored. The error and end-of-file indicators for the stream are
  cleared.

So I think the order is OK for my concern, but not for yours. I.e., on
an error, dest->file is now undefined.

It might be nice to set "dest->file == NULL" in that case. There's no
guarantee that the caller did not hold onto its own copy of the handle,
but since this struct is only exposed internally within http.c, that's
probably OK.

The most robust thing would perhaps be:

  fflush(dest->file);
  ftruncate(fileno(dest->file), 0);

which leaves the handle intact.

(I agree with the rest of your review, especially that it would be
easier to read if this were split into separate refactor and
change-behavior steps).

-Peff
