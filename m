Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D1AC433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 04:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35D5206E2
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 04:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgFAEpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:45:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:33130 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFAEpM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 00:45:12 -0400
Received: (qmail 25586 invoked by uid 109); 1 Jun 2020 04:45:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jun 2020 04:45:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9301 invoked by uid 111); 1 Jun 2020 04:45:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jun 2020 00:45:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Jun 2020 00:45:11 -0400
From:   Jeff King <peff@peff.net>
To:     Jan Christoph Uhde <Jan@UhdeJc.com>
Cc:     git@vger.kernel.org
Subject: Re: mmap failure in master 1aa69c73577df21f5e37e47cc40cf44fc049121e
Message-ID: <20200601044511.GA2529317@coredump.intra.peff.net>
References: <54a3a798-0387-64df-be20-af69db124042@UhdeJc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54a3a798-0387-64df-be20-af69db124042@UhdeJc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 31, 2020 at 12:46:30PM +0200, Jan Christoph Uhde wrote:

> lstat("gcc/testsuite/gdc.test/fail_compilation/b3841.d", {st_mode=S_IFREG|0644, st_size=2643, ...}) = 0
> openat(AT_FDCWD, "gcc/testsuite/gdc.test/fail_compilation/b3841.d", O_RDONLY) = 3
> mmap(NULL, 2643, PROT_READ, MAP_PRIVATE, 3, 0) = -1 ENOMEM (Cannot allocate memory)
> openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
> write(2, "fatal: mmap failed: Cannot alloc"..., 43fatal: mmap failed: Cannot allocate memory
> ) = 43

So we open a file in the working tree, and that mmap fails. I guess this
is probably the call to xmmap() in diff_populate_filespec(). That file
isn't particularly large.

Is it possible that your local repository has large number of packs? Git
will leave open maps to each pack's index file, plus some packs
themselves (ones we're accessing, plus we map+close small ones), plus
whatever maps are used by libc to malloc.  The kernel default limit for
the number of maps is 65530. If you have on the order of 30,000 packs
you might run into this limit.

You can check the number of packs with "git count-objects -v", and the
map limit with "sysctl vm.max_map_count".

If that's the problem, the solution is to repack (which should also
generally improve performance). If you have trouble repacking due to the
limits, you can overcome the chicken and egg with:

  sysctl -w vm.max_map_count=131060

-Peff
