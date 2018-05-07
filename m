Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971F91F42E
	for <e@80x24.org>; Mon,  7 May 2018 09:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeEGJIJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 05:08:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:58584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751940AbeEGJII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 05:08:08 -0400
Received: (qmail 1041 invoked by uid 109); 7 May 2018 09:08:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 May 2018 09:08:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24935 invoked by uid 111); 7 May 2018 09:08:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 May 2018 05:08:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2018 05:08:06 -0400
Date:   Mon, 7 May 2018 05:08:06 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/4] run-command: use BUG() to report bugs, not die()
Message-ID: <20180507090806.GB367@sigill.intra.peff.net>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
 <cover.1525253892.git.johannes.schindelin@gmx.de>
 <91ddc7ed5ce0279c5d48bbed595d932d985465c4.1525253892.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91ddc7ed5ce0279c5d48bbed595d932d985465c4.1525253892.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 02, 2018 at 11:38:31AM +0200, Johannes Schindelin wrote:

> The slightly misleading name die_bug() of the function intended to
> report a bug is actually called always, and only reports a bug if the
> passed-in parameter `err` is non-zero.
> 
> It uses die_errno() to report the bug, to helpfully include the error
> message corresponding to `err`.
> 
> However, as these messages indicate bugs, we really should use BUG().
> And as BUG() is a macro to be able to report the exact file and line
> number, we need to convert die_bug() to a macro instead of only
> replacing the die_errno() by a call to BUG().
> 
> While at it, use a name more indicative of the purpose: CHECK_BUG().

Hrm, at first glance these _don't_ seem like BUGs, because we're
checking the value of errno. I guess the argument is that for these
_particular_ syscalls, we know that they can only complain with EINVAL,
and only when we feed them junk. And therefore any such error return is
a bug.

I guess I buy that line of reasoning for pthread_setcancelstate(). But I
think pthread_sigmask() could return an error based on in-kernel
limitations of sigsetsize. I suppose that's pretty unlikely.

But what I'm suggesting is that these probably should not have been
die("BUG") in the first place. And that the rule of thumb should
probably be that anything relying on system calls or errno should not
BUG(), but be a regular die().

-Peff
