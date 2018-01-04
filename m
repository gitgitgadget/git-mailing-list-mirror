Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F17AB1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 23:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbeADXyQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 18:54:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:53786 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751272AbeADXyO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 18:54:14 -0500
Received: (qmail 25481 invoked by uid 109); 4 Jan 2018 23:54:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Jan 2018 23:54:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11447 invoked by uid 111); 4 Jan 2018 23:54:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Jan 2018 18:54:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jan 2018 18:54:12 -0500
Date:   Thu, 4 Jan 2018 18:54:12 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Stephan Janssen <sjanssen@you-get.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] clone: factor out dir_exists() helper
Message-ID: <20180104235412.GA3474@sigill.intra.peff.net>
References: <20180102210753.GA10430@sigill.intra.peff.net>
 <20180102211014.GC22556@sigill.intra.peff.net>
 <xmqqbmi9dw55.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmi9dw55.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 04, 2018 at 03:47:18PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Two parts of git-clone's setup logic check whether a
> > directory exists, and they both call stat directly with the
> > same scratch "struct stat" buffer. Let's pull that into a
> > helper, which has a few advantages:
> >
> >   - it makes the purpose of the stat calls more obvious
> >
> >   - it makes it clear that we don't care about the
> >     information in "buf" remaining valid
> >
> >   - if we later decide to make the check more robust (e.g.,
> >     complaining about non-directories), we can do it in one
> >     place
> >
> > Note that we could just use file_exists() for this, which
> > has identical code. But we specifically care about
> > directories, so this future-proofs us against that function
> > later getting more picky about seeing actual files.
> 
> It leaves funny taste in my mouth to see that dir_exists() does call
> stat() but does not check st.st_mode to see if it is a directory,
> but for this particular caller, we want dest_exists() to be true
> even when the thing is a non-directory, so that !is_empty_dir(dir)
> call is made on the next line to trigger "exists but not an empty
> dir" error.  After all, what this caller really wants to ask is "is
> something sitting there?" and the answer it expects under normal
> condition is "no, there is nothing there".

Yeah, that was part of the reason I left this as file-local instead of
adding it globally.

> If we really want to be anal, perhaps a new helper path_exists()
> that cares only about existence of paths (i.e. the implementation of
> these two helpers they currently have), together with update to
> check the st.st_mode for file_exists() and dir_exists(), may help
> making the API set more rational, but I do not think it is worth it.

Yep, I also considered that file_exists() probably wants to be
path_exists() with its current implementation. We'd probably want to
review all of the callers.

Anyway, I tried to do the minimal refactoring here, with no change in
behavior. I'm not opposed to calling this dir_exists() as path_exists()
and making it globally available (as you note, I don't think we'd want
to use a true dir_exists() here).

-Peff
