Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D56120986
	for <e@80x24.org>; Tue,  4 Oct 2016 14:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbcJDOAO (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 10:00:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:52022 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbcJDOAO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 10:00:14 -0400
Received: (qmail 22551 invoked by uid 109); 4 Oct 2016 14:00:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 14:00:13 +0000
Received: (qmail 5167 invoked by uid 111); 4 Oct 2016 14:00:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 10:00:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 10:00:11 -0400
Date:   Tue, 4 Oct 2016 10:00:11 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 17/18] sha1_file: always allow relative paths to
 alternates
Message-ID: <20161004140011.ueptwobup3n6indy@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203622.7uz76ay5f7bqqpfm@sigill.intra.peff.net>
 <CA+P7+xr9ugWWcoyQ6dToFacwff8rGJhYJNxy+E5_iGjubONLPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xr9ugWWcoyQ6dToFacwff8rGJhYJNxy+E5_iGjubONLPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 11:50:30PM -0700, Jacob Keller wrote:

> > Note that our normalization doesn't actually look at the
> > filesystem, so it can still be fooled by crossing symbolic
> > links. But that's also true of absolute paths, so it's not a
> > good reason to disallow only relative paths (it's
> > potentially a reason to switch to real_path(), but that's a
> > separate and non-trivial change).
> 
> Hmm, ya using real_path would fix that but I definitely agree that's
> not trivial and can be done in the future if we think it is or becomes
> necessary.

I did look into this briefly. The trick is that real_path() assumes
relative paths are relative from the current directory (and does chdir()
trickery to get the filesystem to resolve things for us). So you'd
really need a "real_path_from" that chdirs to the relative base, issues
the real_path() from there, and then chdirs back to the original cwd.

Which I guess is no less gross than what real_path() is doing itself
internally, but it's definitely something for another patch. Given the
fact that we don't check it now and nobody has complained leads me to
believe that nobody really cares.

Actually, given the fact that we didn't allow relative bases in
recursive alternates, I suspect that very few people are using
complicated alternate setups in the first place.

-Peff
