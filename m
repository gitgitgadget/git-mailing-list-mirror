Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803F1C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D466146E
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhF3R2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:28:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:37558 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3R2v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 13:28:51 -0400
Received: (qmail 24552 invoked by uid 109); 30 Jun 2021 17:26:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 17:26:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9045 invoked by uid 111); 30 Jun 2021 17:26:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Jun 2021 13:26:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Jun 2021 13:26:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 1/3] bundle cmd: stop leaking memory from
 parse_options_cmd_bundle()
Message-ID: <YNypPeoZTRiOxPPQ@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
 <patch-1.3-3d0d7a8e8b5-20210630T140339Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.3-3d0d7a8e8b5-20210630T140339Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 04:06:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Fix a memory leak from the prefix_filename() function introduced with
> its use in 3b754eedd5 (bundle: use prefix_filename with bundle path,
> 2017-03-20).
> 
> As noted in that commit the leak was intentional as a part of being
> sloppy about freeing resources just before we exit, I'm changing this
> because I'll be fixing other memory leaks in the bundle API (including
> the library version) in subsequent commits. It's easier to reason
> about those fixes if valgrind runs cleanly at the end without any
> leaks whatsoever.

Thanks, this looks good to me.

One thing, though...

> An earlier version of this change went out of its way to not leak
> memory on the die() codepaths here, but that was deemed too verbose to
> worry about in a built-in that's dying anyway. The only reason we'd
> need that is to appease a mode like SANITIZE=leak within the scope of
> an entire test file.

Obviously you changed this as I asked, but this final sentence makes me
think we're not on the same page with respect to die(). I don't think
any kind of mode matters here. When we call die(), whatever we have on
the stack is _not_ a leak, by LSan's or valgrind's standards. Because we
still have access to those bytes. And nor can we ever get rid of such
cases. If we ever do:

  void foo(const char *str)
  {
	char *x = xstrdup(str);
	bar(x);
	free(x);
  }

  void bar(const char *x)
  {
	if (!strcmp(x, "foo"))
		die("whatever");
  }

Then "x" will always still be allocated when we die(). We cannot free it
in bar(), where it is read-only. We cannot free it in foo() before we
call bar(), because it is needed there. But control never returns to the
free() statement.

So this code is perfectly fine and unavoidable. In the case you were
touching it was foo() that was calling die() directly, so we could work
around it with some conditionals. But from the leak-checker's
perspective the two cases are the same.

-Peff
