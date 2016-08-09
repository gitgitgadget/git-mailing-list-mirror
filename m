Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F19661FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 07:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbcHIHDt (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 03:03:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:51779 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751522AbcHIHDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 03:03:48 -0400
Received: (qmail 6301 invoked by uid 109); 9 Aug 2016 07:03:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 07:03:47 +0000
Received: (qmail 18124 invoked by uid 111); 9 Aug 2016 07:03:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 03:03:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 03:03:45 -0400
Date:	Tue, 9 Aug 2016 03:03:45 -0400
From:	Jeff King <peff@peff.net>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160809070345.rpdxjvmb6ujeefhv@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
 <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
 <20160808203224.GA28431@tb-raspi>
 <20160809065110.GB17777@peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160809065110.GB17777@peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 02:51:10AM -0400, Jeff King wrote:

>   - index raciness causing us to avoid reading file content. For
>     example, if you do:
> 
>       echo foo >bar
>       git add bar
> 
>     Then _usually_ "bar" and the index will have the same mtime. And
>     therefore subsequent commands that need to refresh the index will
>     re-read the content of "bar", because they cannot tell from the stat
>     information if we have the latest version of "bar" in the index or
>     not (it could have been written after the index update, but in the
>     same second).
> 
>     But on a slow or heavily loaded system (or if you simply get unlucky
>     in crossing the boundary to a new second), they'll have different
>     mtimes. And therefore git knows it can skip reading the content from
>     the filesystem.
> 
>     So if your test relies on git actually re-converting the file
>     content, it would sometimes randomly fail.
> 
> The second one seems plausible, given the history of issues with
> changing CRLF settings for an existing checkout. I'm not sure if it
> would be feasible to reset the index completely before each tested
> command, but that would probably solve it.

And indeed, this seems to fix it for me (at least it has been running in
a 16-way loop for 5 minutes, whereas before it died after 30 seconds or
so):

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 2860d2d..9f057ff 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -120,6 +120,7 @@ commit_chk_wrnNNO () {
 		cp $f $fname &&
 		printf Z >>"$fname" &&
 		git -c core.autocrlf=$crlf add $fname 2>/dev/null &&
+		touch $fname && # ensure index raciness
 		git -c core.autocrlf=$crlf commit -m "commit_$fname" $fname >"${pfx}_$f.err" 2>&1
 	done
 

I'm not sure if there is a more elegant solution, though (for instance,
why not collect the output from "git add", which should have the same
warning, I would think).

-Peff
