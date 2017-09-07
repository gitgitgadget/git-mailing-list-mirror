Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1447620281
	for <e@80x24.org>; Thu,  7 Sep 2017 04:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbdIGEd4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 00:33:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:59308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753398AbdIGEd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 00:33:56 -0400
Received: (qmail 26812 invoked by uid 109); 7 Sep 2017 04:33:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 04:33:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28397 invoked by uid 111); 7 Sep 2017 04:34:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 00:34:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 00:33:54 -0400
Date:   Thu, 7 Sep 2017 00:33:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rene Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 27/34] shortlog: release strbuf after use in
 insert_one_record()
Message-ID: <20170907043354.fwxiifzbqf3yt5rr@sigill.intra.peff.net>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
 <20170830180037.20950-8-l.s.r@web.de>
 <xmqqtw0f61xr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw0f61xr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2017 at 04:51:12AM +0900, Junio C Hamano wrote:

> > diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> > index 43c4799ea9..48af16c681 100644
> > --- a/builtin/shortlog.c
> > +++ b/builtin/shortlog.c
> > @@ -50,66 +50,67 @@ static int compare_by_list(const void *a1, const void *a2)
> >  static void insert_one_record(struct shortlog *log,
> >  			      const char *author,
> >  			      const char *oneline)
> >  {
> > ...
> >  	item = string_list_insert(&log->list, namemailbuf.buf);
> > +	strbuf_release(&namemailbuf);
> 
> As log->list.strdup_strings is set to true in shortlog_init(),
> namemailbuf.buf will leak without this.
> 
> An alterative, as this is the only place we add to log->list, could
> be to make log->list take ownership of the string by not adding a
> _release() here but instead _detach(), I guess.

I agree that would be better, but I think it's a little tricky. The
string_list_insert() call may make a new entry, or it may return an
existing one. We'd still need to free in the latter case. I'm not sure
the string_list interface makes it easy to tell the difference.

> It is also curious that at the end of shortlog_output(), we set the
> log->list.strdup_strings again to true immediately before calling
> string_list_clear() on it.  I suspect that is unnecessary?

I think so. I was curious whether I might have introduced this weirdness
when I refactored this code a year or so ago. But no, it looks like it
dates all the way back to the very first version of shortlog.c.

-Peff
