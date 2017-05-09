Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21FDD2018D
	for <e@80x24.org>; Tue,  9 May 2017 22:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdEIWYg (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 18:24:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:48409 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbdEIWYf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 18:24:35 -0400
Received: (qmail 22849 invoked by uid 109); 9 May 2017 22:24:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 22:24:34 +0000
Received: (qmail 29160 invoked by uid 111); 9 May 2017 22:25:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 18:25:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 May 2017 18:24:32 -0400
Date:   Tue, 9 May 2017 18:24:32 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: [BUG] :(attr) pathspecs can die("BUG") in the tree-walker
Message-ID: <20170509222432.3dxt7osjt2zjtaiw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was playing with the new :(attr) pathspecs in the upcoming v2.13
today, and noticed:

  $ git ls-files -- ':(attr:-diff)'
  t/t0110/url-1
  t/t0110/url-10
  [etc]

So far so good.

  $ git ls-tree HEAD -- ':(attr:-diff)'
  fatal: :(attr:-diff): pathspec magic not supported by this command: 'attr'

Bummer, but I understand that sometimes the options need to be plumbed
through to work everywhere.

  $ git log HEAD -- ':(attr:-diff)'
  fatal: BUG:tree-walk.c:947: unsupported magic 40

Whoops. This is presumably ls-tree is protected, but I think we are
missing a GUARD_PATHSPEC call somewhere.

This isn't a huge deal, as the correct behavior is probably to die like
ls-tree does, but we probably shouldn't be hitting BUG assertions as a
general rule.

-Peff
