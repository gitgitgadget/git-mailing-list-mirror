Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694D81FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 03:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbdDRD4g (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 23:56:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:35074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752485AbdDRD4f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 23:56:35 -0400
Received: (qmail 9559 invoked by uid 109); 18 Apr 2017 03:56:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 03:56:35 +0000
Received: (qmail 8481 invoked by uid 111); 18 Apr 2017 03:56:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Apr 2017 23:56:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Apr 2017 23:56:32 -0400
Date:   Mon, 17 Apr 2017 23:56:32 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        bert.wesarg@googlemail.com
Subject: Re: [PATCH 2/2] config: handle conditional include when $GIT_DIR is
 not set up
Message-ID: <20170418035632.y7rg3bu5oo6hqavk@sigill.intra.peff.net>
References: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
 <20170416104125.15300-1-pclouds@gmail.com>
 <20170416104125.15300-2-pclouds@gmail.com>
 <20170416155131.ppp5iakohiiphzmk@sigill.intra.peff.net>
 <20170417021335.GB8987@duynguyen.vn.dektech.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170417021335.GB8987@duynguyen.vn.dektech.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 09:13:35AM +0700, Duy Nguyen wrote:

> > So we call get_git_dir() always when we're not in early config. Even if
> > we don't have a git dir! Doesn't this mean that programs operating
> > outside of a repo will still hit the BUG? I.e.:
> > 
> >   git config --global includeif.gitdir:/whatever.path foo
> >   cd /not/a/git/dir
> >   git diff --no-index foo bar
> > 
> > ?
> > 
> > I think instead the logic should be:
> > 
> >   if (opts->git_dir)
> > 	strbuf_add_absolute_path(&text, opts->git_dir);
> >   else if (have_git_dir())
> > 	strbuf_add_absolute_path(&text, get_git_dir());
> >   else
> > 	goto done;
> 
> Do we care about the case when the override instruction is "we don't
> have $GIT_DIR, act as if it does not exist, even though have_git_dir()
> returns true"?
> 
> I'm guessing no, we won't run into that situation (and am inclined to
> restructure the code as you suggested). Just throwing it out there if
> I'm mistaken.

I can't think of a case where that would matter. We're always prodding
the function to look at something it might not, and I don't think there
would be any need to convince it _not_ to look at something.

-Peff
