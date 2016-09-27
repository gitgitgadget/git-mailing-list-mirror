Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ACD620986
	for <e@80x24.org>; Tue, 27 Sep 2016 18:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755567AbcI0S7a (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 14:59:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:49009 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbcI0S72 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 14:59:28 -0400
Received: (qmail 2307 invoked by uid 109); 27 Sep 2016 18:59:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 18:59:27 +0000
Received: (qmail 18901 invoked by uid 111); 27 Sep 2016 18:59:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 14:59:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 14:59:25 -0400
Date:   Tue, 27 Sep 2016 14:59:25 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] tree-walk: be more specific about corrupt tree
 errors
Message-ID: <20160927185925.hkqlq63oeafldnrz@sigill.intra.peff.net>
References: <1474989806-5002-1-git-send-email-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1474989806-5002-1-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 11:23:24AM -0400, David Turner wrote:

> +test_expect_success 'malformed mode in tree' '
> +	hex_sha1=$(echo foo | git hash-object --stdin -w) &&
> +	bin_sha1=$(echo $hex_sha1 | perl -ne "printf \"\\\\%03o\", ord for /../g") &&

Sorry, the perl snippet I posted earlier was totally braindead. It gives
you the octal for the raw bytes, but we really just want to convert the
hex to octal (we could also print the raw bytes from the hex, but I
didn't want to take chances on shells that can't handle NULs in
environment variables).

I also find it helps to define a helper function outside of the test
block to avoid quoting hell. So something like:

  hex2oct () {
	perl -ne 'printf "\\%03o", hex for /../g'
  }

  test_expect_success ... '
	bin_sha1=$(echo $hex_sha1 | hex2oct)
  '

-Peff
