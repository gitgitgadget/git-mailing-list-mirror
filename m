Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F801F453
	for <e@80x24.org>; Sat,  9 Feb 2019 23:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfBIXcs (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 18:32:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:38856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726956AbfBIXcs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 18:32:48 -0500
Received: (qmail 8205 invoked by uid 109); 9 Feb 2019 23:32:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Feb 2019 23:32:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1121 invoked by uid 111); 9 Feb 2019 23:32:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Feb 2019 18:32:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Feb 2019 18:32:46 -0500
Date:   Sat, 9 Feb 2019 18:32:46 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, 'Duy Nguyen' <pclouds@gmail.com>
Subject: Re: [Possible Breakage] t1308 - Bad return value from test-tool
Message-ID: <20190209233246.GB7135@sigill.intra.peff.net>
References: <004901d4bff7$2e17dc50$8a4794f0$@nexbridge.com>
 <20190209042404.GA18286@sigill.intra.peff.net>
 <000501d4c0a2$683b78f0$38b26ad0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000501d4c0a2$683b78f0$38b26ad0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 09, 2019 at 01:08:01PM -0500, Randall S. Becker wrote:

> > It sounds like you might need to set FREAD_READS_DIRECTORIES in your
> > config.mak.
> 
> Setting FREAD_READS_DIRECTORIES = UnfortunatelyYes

Silly question, but you did rebuild after setting that, not just re-run
the tests, right?

> still results in 
> 
> Value not found for "foo.bar"
> test_expect_code: command exited with 1, we wanted 2 test-tool config configset_get_value foo.bar a-directory
> not ok 23 - proper error on directory "files"
> #
> #               echo "Error (-1) reading configuration file a-directory." >expect &&
> #               mkdir a-directory &&
> #               test_expect_code 2 test-tool config configset_get_value foo.bar a-directory 2>output &&
> #               grep "^warning:" output &&
> #               grep "^Error" output >actual &&
> #               test_cmp expect actual
> #
> 
> I don't think that helped. While fopen can open a directory, fread
> does not return any data in this platform. readdir or nftw/ftw are
> pretty much the only options. However, the code still goes down the
> goto exit1 path in this situation.

Hrm. That's the exact case FREAD_READS_DIRECTORIES is supposed to help.
It does an fstat() after fopen()ing the file to see if it points to a
directory, and if so closes it immediately and returns EISDIR.

Can you confirm via debugger (or printf statements) that we make it into
git_fopen, and what the resulting st.st_mode we see looks like?

-Peff
