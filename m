Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A635D20A17
	for <e@80x24.org>; Mon, 16 Jan 2017 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdAPVlO (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 16:41:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:39880 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbdAPVlO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 16:41:14 -0500
Received: (qmail 21296 invoked by uid 109); 16 Jan 2017 21:41:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 21:41:14 +0000
Received: (qmail 12458 invoked by uid 111); 16 Jan 2017 21:42:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 16:42:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 16:41:11 -0500
Date:   Mon, 16 Jan 2017 16:41:11 -0500
From:   Jeff King <peff@peff.net>
To:     Bernd Kuhls <bernd.kuhls@writeme.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] configure.ac: fix old iconv check
Message-ID: <20170116214111.v2imkedzyofcpt6b@sigill.intra.peff.net>
References: <20170116195638.3713-1-bernd.kuhls@writeme.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116195638.3713-1-bernd.kuhls@writeme.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2017 at 08:56:37PM +0100, Bernd Kuhls wrote:

> According to
> https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Running-the-Compiler.html
> the parameter syntax of AC_COMPILE_IFELSE is
> 
> (input, [action-if-true], [action-if-false])
> 
> Displaying "no" when the test was positive and enabling support for old
> iconv implementations by OLD_ICONV=UnfortunatelyYes when the test fails
> it obviously wrong. This patch switches the actions to fix the problem.

Hrm. But the test code is:

  # Define OLD_ICONV if your library has an old iconv(), where the second
  # (input buffer pointer) parameter is declared with type (const char **).
  AC_DEFUN([OLDICONVTEST_SRC], [
  AC_LANG_PROGRAM([[
  #include <iconv.h>
  
  extern size_t iconv(iconv_t cd,
                      char **inbuf, size_t *inbytesleft,
                      char **outbuf, size_t *outbytesleft);
  ]], [])])

Which will compile correctly for the _new_ code, but not the old. So
when the test is positive, then "no", we do not need to set the
OLD_ICONV flag.

The logic would probably be clearer if the test were reversed. It would
mean that other compilation problems (e.g., you do not have iconv.h at
all) would fail to see OLD_ICONV, but that seems reasonable.

-Peff
