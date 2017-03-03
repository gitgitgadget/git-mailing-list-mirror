Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A4B2023D
	for <e@80x24.org>; Fri,  3 Mar 2017 11:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbdCCLlU (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 06:41:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:37951 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbdCCLlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 06:41:20 -0500
Received: (qmail 25412 invoked by uid 109); 3 Mar 2017 09:53:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 09:53:53 +0000
Received: (qmail 26368 invoked by uid 111); 3 Mar 2017 09:54:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 04:54:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 04:53:51 -0500
Date:   Fri, 3 Mar 2017 04:53:51 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] config: check if config path is a file before
 parsing it
Message-ID: <20170303095351.rgifjpfuvafx33jy@sigill.intra.peff.net>
References: <20170303094252.11706-1-pclouds@gmail.com>
 <20170303094252.11706-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170303094252.11706-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 04:42:51PM +0700, Nguyễn Thái Ngọc Duy wrote:

> If a directory is given as a config file by accident, we keep open it
> as a file. The behavior of fopen() in this case seems to be
> undefined.
> 
> On Linux, we open a directory as a file ok, then get error (which we
> consider eof) on the first read. So the config parser sees this "file"
> as empty (i.e. valid config). All is well and we don't complain
> anything (but we should).
> 
> The situation is slighly different on Windows. I think fopen() returns
> NULL. And we get a very unhelpful message:
> 
>     $ cat >abc <<EOF
>     [include]
>         path = /tmp/foo
>     EOF
>     $ mkdir /tmp/foo
>     $ git config --includes --file=abc core.bare
>     fatal: bad config line 3 in file abc
> 
> Opening a directory is wrong in the first place. Avoid it. If caught,
> print something better. With this patch, we have
> 
>     $ git config --includes --file=abc core.bare
>     error: '/tmp/foo' is not a file
>     fatal: bad config line 3 in file abc
> 
> It's not perfect (line should be 2 instead of 3). But it's definitely
> improving.
> 
> The new test is only relevant on linux where we blindly open the
> directory and consider it an empty file. On Windows, the test should
> pass even without this patch.

I'm mildly negative on this approach for two reasons:

  1. It requires doing an _extra_ check anywhere we want to care about
     this. So if we care about file/directory confusion, we're going to
     sprinkle these is_not_file() checks all over the code base.

     I think we're much better to just do the thing we want to do (like
     open the file), and deal with the error results. I'm on the fence
     on whether we want to care about the fopen behavior on Linux here
     (where reading a directory essentially behaves like an empty file,
     because the first read() gives an error and we don't distinguish
     between error and EOF).  But if we do, I think we'd either want to:

       a. actually check ferror() after getting EOF and report the read
          error. That catches EISDIR, along with any other unexpected
	  errors.

       b. use an fopen wrapper that checks fstat(fileno(fh)) after the
          open, and turns fopen(some_dir) into an error.

  2. It doesn't address the root problem for git_config_from_file(),
     which is that it is quiet when fopen fails, even if the reason is
     something interesting besides ENOENT. The caller can't check errno
     because it doesn't know if fopen() failed, or if the config
     callback returned an error.

     There's an attempt to protect the call to git_config_from_file() by
     checking access(), but that breaks down when access() and fopen()
     have two different results (which is exactly what happens on
     Windows in this case).

-Peff
