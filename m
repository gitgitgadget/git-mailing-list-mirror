Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07F2201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdBXUf3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:35:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:33555 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbdBXUf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:35:28 -0500
Received: (qmail 10696 invoked by uid 109); 24 Feb 2017 20:35:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 20:35:25 +0000
Received: (qmail 27945 invoked by uid 111); 24 Feb 2017 20:35:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 15:35:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 15:35:23 -0500
Date:   Fri, 24 Feb 2017 15:35:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: Re: fatal error when diffing changed symlinks
Message-ID: <20170224203523.mdoh4ivhwflmpr6j@sigill.intra.peff.net>
References: <CAC0icTZ87yeYndPFyjD4nkJBcw5SC-bgUJYbEzYqH7YhSFZvuQ@mail.gmail.com>
 <xmqqshn34gsh.fsf@gitster.mtv.corp.google.com>
 <xmqqtw7j1i6d.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw7j1i6d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 11:51:22AM -0800, Junio C Hamano wrote:

> > A slightly worse is that the upcoming Git will ship with a rewritten
> > "difftool" that makes the above sequence segfault.
> 
> The culprit seems to be these lines in run_dir_diff():
> 
> 		if (S_ISLNK(lmode)) {
> 			char *content = read_sha1_file(loid.hash, &type, &size);
> 			add_left_or_right(&symlinks2, src_path, content, 0);
> 			free(content);
> 		}
> 
> 		if (S_ISLNK(rmode)) {
> 			char *content = read_sha1_file(roid.hash, &type, &size);
> 			add_left_or_right(&symlinks2, dst_path, content, 1);
> 			free(content);
> 		}
> 
> When viewing a working tree file, oid.hash could be 0{40} and
> read_sha1_file() is not the right function to use to obtain the
> contents.
> 
> Both of these two need to pay attention to 0{40}, I think, as the
> user may be running "difftool -R --dir-diff" in which case the
> working tree would appear in the left hand side instead.

As a side note, I think even outside of 0{40}, this should be checking
the return value of read_sha1_file(). A corrupted repo should die(), not
segfault.

-Peff
