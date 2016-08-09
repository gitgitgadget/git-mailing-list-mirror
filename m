Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1421FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbcHILtl (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:49:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:51956 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750825AbcHILtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:49:41 -0400
Received: (qmail 23119 invoked by uid 109); 9 Aug 2016 11:49:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 11:49:40 +0000
Received: (qmail 20060 invoked by uid 111); 9 Aug 2016 11:49:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 07:49:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 07:49:38 -0400
Date:	Tue, 9 Aug 2016 07:49:38 -0400
From:	Jeff King <peff@peff.net>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
 <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
 <20160808203224.GA28431@tb-raspi>
 <20160809065110.GB17777@peff.net>
 <20160809113337.GA1143@tb-raspi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160809113337.GA1143@tb-raspi>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 11:33:37AM +0000, Torsten Bögershausen wrote:

> > The second one seems plausible, given the history of issues with
> > changing CRLF settings for an existing checkout. I'm not sure if it
> > would be feasible to reset the index completely before each tested
> > command, but that would probably solve it.
> The content of the file has been changed (we appended the letter 'Z' to it,
> so even if mtime is the same, st.st_size should differ.
> And it seems as if the commit is triggered, see below.

I don't think I made myself clear. It's not a question of whether there
is something to commit. It's that when git asks the index "what is the
sha1 of the content at this path?", the index may be able to answer
directly (the file is up-to-date, so we return the index value), or it
may have to go to the filesystem and read the file content. It is this
latter which triggers convert_to_git(), which is what generates the
message in question.

For a more stripped-down example, try:

  git add foo
  git commit -m msg

versus:

  git add foo
  sleep 1
  git commit -m msg

In the latter case, we should not generally need convert_to_git() in the
"commit" step. It was already done by "git add", and we reuse the cached
result.

Whereas in the first one, we may run into the racy-index problem and
have to re-read the file to be on the safe side.

-Peff
