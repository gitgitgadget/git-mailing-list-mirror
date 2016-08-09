Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B881D1FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 06:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbcHIGvM (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 02:51:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:51772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751337AbcHIGvM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 02:51:12 -0400
Received: (qmail 5553 invoked by uid 109); 9 Aug 2016 06:51:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 06:51:10 +0000
Received: (qmail 17876 invoked by uid 1000); 9 Aug 2016 06:51:10 -0000
Date:	Tue, 9 Aug 2016 02:51:10 -0400
From:	Jeff King <peff@peff.net>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160809065110.GB17777@peff.net>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
 <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
 <20160808203224.GA28431@tb-raspi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160808203224.GA28431@tb-raspi>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 08:32:24PM +0000, Torsten Bögershausen wrote:

> > The verbose output is not very exciting, though:
> > 
> > 	expecting success: 
> > 	                check_warning "$lfwarn" ${pfx}_LF.err
> > 
> > 	--- NNO_attr_auto_aeol_crlf_false_LF.err.expect 2016-08-08 15:26:37.061701392 +0000
> > 	+++ NNO_attr_auto_aeol_crlf_false_LF.err.actual 2016-08-08 15:26:37.061701392 +0000
> > 	@@ -1 +0,0 @@
> > 	-warning: LF will be replaced by CRLF
> > 	not ok 114 - commit NNO files crlf=false attr=auto LF
> [...]
> The warning is missing, but should be there:
> 
> The file has LF, and after commit and a new checkout these LF will
> be convertet into CRLF.
> 
> So why isn't the warning there (but here on my oldish machines)

To be clear, the warning _is_ there when I just run t0027 by itself, and
the test passes.  It's only under heavy load that it isn't. So it's a
race condition either in the test script or in git itself.

Usually race conditions like these are due to one of:

  - git dying from SIGPIPE before it has a chance to output the command.
    But I don't see any pipes being used in the test script.

  - index raciness causing us to avoid reading file content. For
    example, if you do:

      echo foo >bar
      git add bar

    Then _usually_ "bar" and the index will have the same mtime. And
    therefore subsequent commands that need to refresh the index will
    re-read the content of "bar", because they cannot tell from the stat
    information if we have the latest version of "bar" in the index or
    not (it could have been written after the index update, but in the
    same second).

    But on a slow or heavily loaded system (or if you simply get unlucky
    in crossing the boundary to a new second), they'll have different
    mtimes. And therefore git knows it can skip reading the content from
    the filesystem.

    So if your test relies on git actually re-converting the file
    content, it would sometimes randomly fail.

The second one seems plausible, given the history of issues with
changing CRLF settings for an existing checkout. I'm not sure if it
would be feasible to reset the index completely before each tested
command, but that would probably solve it.

-Peff
