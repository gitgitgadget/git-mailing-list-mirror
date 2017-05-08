Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CEE51FDEA
	for <e@80x24.org>; Mon,  8 May 2017 07:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdEHHmu (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 03:42:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:47249 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbdEHHmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 03:42:49 -0400
Received: (qmail 21788 invoked by uid 109); 8 May 2017 07:42:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 07:42:46 +0000
Received: (qmail 27098 invoked by uid 111); 8 May 2017 07:43:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 03:43:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 03:42:44 -0400
Date:   Mon, 8 May 2017 03:42:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Cc:     git@vger.kernel.org
Subject: Re: git clone -b
Message-ID: <20170508074244.tcu2ywil2m47375k@sigill.intra.peff.net>
References: <219f3882-ec66-5c36-a157-5b920a2e4d04@aegee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <219f3882-ec66-5c36-a157-5b920a2e4d04@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 08:30:49AM +0200, Дилян Палаузов wrote:

> why do these work:
> 
> git clone --bare -b 3.5 https://github.com/python/cpython A
> git clone -b 3.6 A B

From the description of --bare in "git help clone":

  [...]the branch heads at the remote are copied directly to
  corresponding local branch heads, without mapping them to
  refs/remotes/origin/. When this option is used, neither
  remote-tracking branches nor the related configuration variables are
  created.

So because the upstream has a refs/heads/3.6 branch, so too does the
bare clone "A". And thus when you clone it asking for that branch, Git
can find it.

But in your non-bare example:

> git clone -b 3.5 https://github.com/python/cpython C
> 
> but these not:
> 
> git clone -b 3.6 C D
> git clone --no-local -b 3.6 C D

In the non-bare clone C, there is no local 3.6 branch. You only have the
remote-tracking branch refs/remotes/origin/3.6. So when you try to clone
from it, Git can't find the branch:

  $ git clone -b 3.6 C D
  Cloning into 'D'...
  fatal: Remote branch 3.6 not found in upstream origin
  fatal: The remote end hung up unexpectedly

It works if you create a local branch based on upstream's branch:

  $ git -C C checkout 3.6
  Branch 3.6 set up to track remote branch 3.6 from origin.
  Switched to a new branch '3.6'

  $ git clone -b 3.6 C D
  Cloning into 'D'...
  done.

-Peff
