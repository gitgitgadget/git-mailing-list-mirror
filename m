Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC3A202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 23:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966410AbdIYXZX (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:25:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:49894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965878AbdIYXZV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:25:21 -0400
Received: (qmail 11093 invoked by uid 109); 25 Sep 2017 23:25:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 23:25:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30514 invoked by uid 111); 25 Sep 2017 23:26:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 19:26:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 19:25:19 -0400
Date:   Mon, 25 Sep 2017 19:25:19 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 6/7] worktree: check the result of read_in_full()
Message-ID: <20170925232519.ljbt37r7qvb4or32@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925203156.boieic627t3dbpzd@sigill.intra.peff.net>
 <20170925221426.GE27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925221426.GE27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 03:14:26PM -0700, Jonathan Nieder wrote:

> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 2f4a4ef9cd..87b3d70b0b 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -59,7 +59,11 @@ static int prune_worktree(const char *id, struct strbuf *reason)
> >  	}
> >  	len = xsize_t(st.st_size);
> >  	path = xmallocz(len);
> > -	read_in_full(fd, path, len);
> > +	if (read_in_full(fd, path, len) != len) {
> > +		strbuf_addf(reason, _("Removing worktrees/%s: gitdir read did not match stat (%s)"),
> > +			    id, strerror(errno));
> 
> I'm a little confused.  The 'if' condition checks for a read error but
> the message says something about 'stat'.
> 
> If we're trying to double-check the 'stat' result, shouldn't we read
> all the way to EOF in case the file got longer?

If you wanted to really double-check the stat result, yes you'd want to
make sure there aren't extra bytes either. But really we're just making
sure we were able to read _enough_ bytes.

To be honest, I'm tempted to rip out the whole thing and replace it with
strbuf_read_file(), which seems more straightforward.

The function does seem to rely on the stat() to get the mtime, so we'd
have to leave that part in.

-Peff
