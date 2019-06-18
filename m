Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6341F462
	for <e@80x24.org>; Tue, 18 Jun 2019 17:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfFRRET (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 13:04:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:58234 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729319AbfFRRES (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 13:04:18 -0400
Received: (qmail 7179 invoked by uid 109); 18 Jun 2019 17:04:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Jun 2019 17:04:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6637 invoked by uid 111); 18 Jun 2019 17:05:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Jun 2019 13:05:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2019 13:04:16 -0400
Date:   Tue, 18 Jun 2019 13:04:16 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] t: add helper to convert object IDs to paths
Message-ID: <20190618170416.GA14636@sigill.intra.peff.net>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net>
 <20190616185330.549436-2-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1906172102180.44@tvgsbejvaqbjf.bet>
 <20190618012943.GB8877@genre.crustytoothpaste.net>
 <c9be7464-21f3-6651-500d-14137f0f1c0f@kdbg.org>
 <nycvar.QRO.7.76.6.1906181647480.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906181647480.44@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 06:15:46PM +0200, Johannes Schindelin wrote:

> > And looking through this patch series, I see a gazillion of *new*
> > process substitutions $(test_something...) and $(basename $whatever).
> > Can't we do something about it?
> 
> I wish there was. Unix shell scripting has not evolved much in the past,
> what, 3 decades? So I don't really see a way to "pass variables by
> reference" to shell functions, short of calling `eval` (which buys
> preciously little as it _also_ has to spawn a new process [*1*]).

Really? An eval can impact the caller's state, so it _can't_ happen in a
sub-process in most cases.

E.g., if I run this:

-- >8 --
#!/bin/sh

# usage: test_oid_to_path <var> <oid>
# to set the variable <var> in the caller's environment to the path of <oid>
test_oid_to_path() {
	path="${2%${2#??}}/${2#??}"
	eval "$1=\$path"
}

test_oid_to_path foo 1234abcd
echo foo: $foo
-- >8 --

it all happens in a single process, under both bash and dash.

-Peff
