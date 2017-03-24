Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED76820958
	for <e@80x24.org>; Fri, 24 Mar 2017 04:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935724AbdCXEAA (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 00:00:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:50798 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbdCXD77 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 23:59:59 -0400
Received: (qmail 15800 invoked by uid 109); 24 Mar 2017 03:59:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 03:59:57 +0000
Received: (qmail 14548 invoked by uid 111); 24 Mar 2017 04:00:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 00:00:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 23:59:54 -0400
Date:   Thu, 23 Mar 2017 23:59:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] tests: lint for run-away here-doc
Message-ID: <20170324035954.aejqfadvxms2qfsf@sigill.intra.peff.net>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <xmqq7f3ghhc7.fsf_-_@gitster.mtv.corp.google.com>
 <xmqqshm4fszt.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshm4fszt.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 10:43:18PM -0700, Junio C Hamano wrote:

> -		test_eval_ "(exit 117) && $1"
> -		if test "$?" != 117; then
> -			error "bug in the test script: broken &&-chain: $1"
> +		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
> +		then
> +			error "bug in the test script: broken &&-chain or run-away HERE-DOC: $1"

This looks good. I had pondered how we might do this but was worried
that it would have to end up actually executing the test contents. But
this leverages the fact that the problem is syntactic and that the shell
will parse the complete &&-chain before executing any of it. Clever.

-Peff
