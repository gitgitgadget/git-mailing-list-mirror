Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7742018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbcF0Sn6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:43:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:33570 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751644AbcF0Sn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:43:58 -0400
Received: (qmail 2020 invoked by uid 102); 27 Jun 2016 18:43:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 14:43:57 -0400
Received: (qmail 12321 invoked by uid 107); 27 Jun 2016 18:44:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 14:44:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 14:43:54 -0400
Date:	Mon, 27 Jun 2016 14:43:54 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	marcnarc@xiplink.com
Subject: Re: [PATCH v4 0/5] Better ref summary alignment in "git fetch"
Message-ID: <20160627184354.GA9594@sigill.intra.peff.net>
References: <20160605031141.23513-1-pclouds@gmail.com>
 <20160626055810.26960-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160626055810.26960-1-pclouds@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 07:58:05AM +0200, Nguyễn Thái Ngọc Duy wrote:

> v4 is a cleaned up version of v3. Tests are added. Typos in
> git-fetch.txt are corrected. The "{ -> origin/}master" format is
> dropped.

Thanks for continuing to look into this.

I tried it on my most-horrible example case, and the results were...just
OK. Because the variable-length part of each line comes first, the
alignment code means that the "origin/$" bit of every line gets bumped
out. And if you have a single large branch name, then everybody gets
bumped out very far, even to the point of wrapping. E.g., I get
something like (with fetch.output=compact, obviously):

  From ...
   * [new branch]      branch1                      -> origin/$
   * [new branch]      branch2                      -> origin/$
   * [new branch]      some-really-long-branch-name -> origin/$
   + 1234abc..5678def  branch3                      -> origin/$ (forced
    update)
   * [new branch]      branch4                      -> origin/$

I've shrunk it a bit to fit in the email; my actual "long" name was much
larger. And the average length for the shorter ones is, too, but the
overall effect is the same; almost every line has a huge run of
whitespace. And some lines wrap that would not have even under the
normal, duplicated scheme.

One of the nice things about Junio's "{ -> origin/}" suggestion is that
it puts the variable-length part at the end, so there's no extra
alignment required. And you'd get something like:

  From ...
   * [new branch]      { -> origin/}branch1
   * [new branch]      { -> origin/}branch2
   * [new branch]      { -> origin/}some-really-long-branch-name
   + 1234abc..5678def  { -> origin/}branch3 (forced update)
   * [new branch]      { -> origin/}branch4

-Peff
