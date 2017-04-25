Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD7E207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 02:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980110AbdDYC4l (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:56:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:39494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S978270AbdDYC4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:56:40 -0400
Received: (qmail 15071 invoked by uid 109); 25 Apr 2017 02:56:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 02:56:37 +0000
Received: (qmail 22062 invoked by uid 111); 25 Apr 2017 02:57:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 22:57:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 22:56:35 -0400
Date:   Mon, 24 Apr 2017 22:56:35 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, j6t@kdbg.org, sbeller@google.com, e@80x24.org
Subject: Re: [PATCH v6 12/11] run-command: don't try to execute directories
Message-ID: <20170425025634.q3n3umu3trhycigm@sigill.intra.peff.net>
References: <20170424223752.GB105623@google.com>
 <20170424235042.26627-1-bmwill@google.com>
 <20170425001724.GG28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170425001724.GG28740@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 05:17:24PM -0700, Jonathan Nieder wrote:

> > This is due to only checking 'access()' when locating an executable in
> > PATH, which doesn't distinguish between files and directories.  Instead
> > use 'stat()' and check that the path is to a regular file.  Now
> > run-command won't try to execute the directory 'git-remote-blah':
> >
> > 	$ git ls-remote blah://blah
> > 	fatal: Unable to find remote helper for 'blah'
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> For the interested, the context in which this was reported was trying
> to execute a directory named 'ssh'.  Thanks for a quick fix.
> 
> Technically this bug has existed since
> 
> 	commit 38f865c27d1f2560afb48efd2b7b105c1278c4b5
> 	Author: Jeff King <peff@peff.net>
> 	Date:   Fri Mar 30 03:52:18 2012 -0400
> 
> 	   run-command: treat inaccessible directories as ENOENT
> 
> Until we switched from using execvp to execve, the symptom was very
> subtle: it only affected the error message when a program could not be
> found, instead of affecting functionality more substantially.

Yeah, I'm pretty sure I didn't think at all about access() matching
directories when doing that commit. Using stat() does seem like the
right solution.

-Peff
