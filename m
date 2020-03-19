Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C185C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 15:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286A320724
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 15:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCSPvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:51:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:43912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727395AbgCSPvh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 11:51:37 -0400
Received: (qmail 25694 invoked by uid 109); 19 Mar 2020 15:51:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 15:51:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28085 invoked by uid 111); 19 Mar 2020 16:01:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 12:01:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 11:51:36 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] fix test failure with busybox
Message-ID: <20200319155136.GA3513282@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1584625896.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 09:00:01PM +0700, Đoàn Trần Công Danh wrote:

> Despite some non-compiance from busybox's sh(1), grep(1), diff(1),
> Alpine Linux is still a popular choice for container these days.
> 
> Fix false-positive failure in testsuite when run in Alpine Linux.
> 
> t5703.{4,5,6,7} is still failing.
> Despite git pack-objects behaves correctly,
> upload-pack.c works incorrectly on this platform.
> 
> I haven't dig deeper, yet.

I was able to reproduce the problems on Debian (with busybox installed)
with:

  mkdir /tmp/bb
  (cd /tmp/bb
   bb=$(which busybox)
   for i in $($bb --list); do
     ln -s $bb $i
   done)
  PATH=/tmp/bb:$PATH make test TEST_SHELL_PATH=/tmp/bb/sh

The issue in t5703 is the sed call in get_actual_commits(). It's trying
to cut off the early (text) part of the file, and pass through the
binary goo of the packfile. Presumably busybox's sed isn't binary-clean.

Our usual strategy here would be to switch to perl, which is more
predictable about binary bytes.

We're also feeding this into a test-tool helper. It's possible that
helper could be made smart enough to replace both this sed invocation
and the one in get_actual_refs().

-Peff
