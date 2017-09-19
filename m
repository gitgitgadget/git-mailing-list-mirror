Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C97520281
	for <e@80x24.org>; Tue, 19 Sep 2017 05:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdISFDT (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 01:03:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:42944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751040AbdISFDT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 01:03:19 -0400
Received: (qmail 2686 invoked by uid 109); 19 Sep 2017 05:03:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 05:03:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31917 invoked by uid 111); 19 Sep 2017 05:03:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 01:03:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Sep 2017 01:03:17 -0400
Date:   Tue, 19 Sep 2017 01:03:17 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] read_info_alternates: read contents into strbuf
Message-ID: <20170919050316.nfbk6wckgdtmzvvd@sigill.intra.peff.net>
References: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
 <20170918155429.hgql4ngayun5nbyd@sigill.intra.peff.net>
 <20170919024253.GC175206@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919024253.GC175206@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2017 at 07:42:53PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  sha1_file.c | 29 +++++++++--------------------
> >  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> Thanks for tracking it down.

To be fair, Michael did most of the work in identifying and bisecting
the bug. He even wrote a very similar patch in parallel; I just swooped
in at the end.

> >  	path = xstrfmt("%s/info/alternates", relative_base);
> > -	fd = git_open(path);
> > -	free(path);
> > -	if (fd < 0)
> > -		return;
> > -	if (fstat(fd, &st) || (st.st_size == 0)) {
> > -		close(fd);
> > +	if (strbuf_read_file(&buf, path, 1024) < 0) {
> > +		free(path);
> >  		return;
> 
> strbuf_read_file is careful to release buf on failure, so this doesn't
> leak (but it's a bit subtle).

Yep. I didn't think it was worth calling out with a comment since the
"don't allocate on failure" pattern is common to most of the strbuf
functions.

> What happened to the !st.st_size case?  Is it eliminated for
> simplicity?

Good question, and the answer is yes. Obviously we can bail early on an
empty file, but I don't think there's any reason to complicate the code
with it (the original seems to come from d5a63b9983 (Alternate object
pool mechanism updates., 2005-08-14), where it avoided a corner case
that has long since been deleted.

-Peff
