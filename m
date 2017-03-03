Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AE522013E
	for <e@80x24.org>; Fri,  3 Mar 2017 03:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbdCCDoi (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 22:44:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:37606 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbdCCDoh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 22:44:37 -0500
Received: (qmail 27969 invoked by uid 109); 3 Mar 2017 03:36:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 03:36:25 +0000
Received: (qmail 24491 invoked by uid 111); 3 Mar 2017 03:36:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 22:36:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 22:36:23 -0500
Date:   Thu, 2 Mar 2017 22:36:23 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/9] t7006: replace dubious test
Message-ID: <20170303033623.lfi7jhul6psbdde6@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
 <8f79df34e63a37c052437dd022269b4a6c495108.1488506615.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f79df34e63a37c052437dd022269b4a6c495108.1488506615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:04:02AM +0100, Johannes Schindelin wrote:

> The intention of that test case, however, was to verify that the
> setup_git_directory() function has not run, because it changes global
> state such as the current working directory.
> 
> To keep that spirit, but fix the incorrect assumption, this patch
> replaces that test case by a new one that verifies that the pager is
> run in the subdirectory, i.e. that the current working directory has
> not been changed at the time the pager is configured and launched, even
> if the `rev-parse` command requires a .git/ directory and *will* change
> the working directory.

This is a great solution to the question I had in v1 ("how do we know
when setup_git_directory() is run?"). It not only checks the
internal-code case that we care about, but it also shows how real users
would get bit if we do the wrong thing.

> +test_expect_failure TTY 'core.pager in repo config works and retains cwd' '
> +	sane_unset GIT_PAGER &&
> +	test_config core.pager "cat >cwd-retained" &&
> +	(
> +		cd sub &&
> +		rm -f cwd-retained &&
> +		test_terminal git -p rev-parse HEAD &&
> +		test -e cwd-retained
> +	)
> +'

Does this actually need TTY and test_terminal? You replace the pager
with something that doesn't care about the terminal, and "-p" should
unconditionally turn it on.

(Also a minor nit: we usually prefer test_path_is_file to "test -e"
these days).

-Peff
