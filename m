Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84A1520193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966144AbcHDTky (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:40:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:54915 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965948AbcHDTkr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:40:47 -0400
Received: (qmail 11556 invoked by uid 102); 4 Aug 2016 19:40:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 15:40:47 -0400
Received: (qmail 15116 invoked by uid 107); 4 Aug 2016 19:41:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 15:41:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 15:40:43 -0400
Date:	Thu, 4 Aug 2016 15:40:43 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [BUG?] --boundary inconsistent with path limiting
Message-ID: <20160804194043.z4nbosr4wpbzljdl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Let's say I have a simple repo with three paths:

	git init -q repo
	cd repo
	for i in a b c
	do
		echo content >$i.t
		git add $i.t
		git commit -qm $i &&
		git tag $i
	done

If I ask for the top 2 commits, with the third as a boundary, I get the
expected output:

  $ git log --format='%m %s' --boundary a..c
  > c
  > b
  - a

If I limit the path to "b.t", I get:

  $ git log --format='%m %s' --boundary a..c -- b.t
  > b
  - a

That makes sense to me. We omit "c" because it doesn't touch "b.t", and
obviously include "b", which does. We _do_ include the boundary commit,
even though it doesn't touch the path, which makes sense to me. It
remains a boundary whether it touched the path or not, and without it,
we get no boundary at all.

But now if I limit to "a.t", I get no output at all:

  $ git log --format='%m %s' --boundary a..c -- a.t

whereas I would have expected "- a" to show the boundary.

Is this a bug, or are my expectations wrong?

-Peff
