Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266E61F462
	for <e@80x24.org>; Tue, 28 May 2019 09:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfE1Jhb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 05:37:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:39536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726279AbfE1Jhb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 05:37:31 -0400
Received: (qmail 29643 invoked by uid 109); 28 May 2019 09:37:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 09:37:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11641 invoked by uid 111); 28 May 2019 09:38:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 05:38:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 05:37:28 -0400
Date:   Tue, 28 May 2019 05:37:28 -0400
From:   Jeff King <peff@peff.net>
To:     "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Message-ID: <20190528093728.GA15106@sigill.intra.peff.net>
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 09:10:12AM +0000, Vanak, Ibrahim wrote:

> We are seeing issue with GIT 2.14 version. When we try to clone the
> repos, it is taking HUGE amount of time on HPUX, whereas on the linux
> machine with same network configuration, it's getting cloned in less
> than mins. So we want to know has anyone reported this issue? What is
> the fix for this? Has the fix been released for this? Whom should we
> contact for this?

I don't know about the slowness, but...

> Below is the HPUX system where we are seeing issue, it is taking 1 hr 45 mins and later it failed:
> 
> root@sstl002.in.rdlabs.hpecorp.net# uname -a
> HP-UX sstl002 B.11.31 U ia64 0158936019 unlimited-user license
> root@sstl002.in.rdlabs.hpecorp.net# time git clone git@github.hpe.com:HPUX/SysFaultMgmt.git
> Cloning into 'SysFaultMgmt'...
> remote: Enumerating objects: 63627, done.
> remote: Total 63627 (delta 0), reused 0 (delta 0), pack-reused 63627
> Receiving objects: 100% (63627/63627), 681.90 MiB | 111.00 KiB/s, done.
> fatal: pack is corrupted (SHA1 mismatch)
> fatal: index-pack failed

Git v2.14 uses the sha1collision-detection implementation of sha1 by
default. That has a bug that was fixed recently with:

  commit 4125f78222749cb8fc91115abec3ac83e5dfb194
  Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
  Date:   Tue May 14 00:17:01 2019 +0200
  
      sha1dc: update from upstream
      
      Update sha1dc from the latest version by the upstream
      maintainer[1]. See 07a20f569b ("Makefile: fix unaligned loads in
      sha1dc with UBSan", 2019-03-12) for the last update.
      
      This fixes an issue where HP-UX IA64 was wrongly detected as a
      Little-endian instead of a Big-endian system, see [2] and [3].
      
      1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/855827c583bc30645ba427885caa40c5b81764d2
      2. https://public-inbox.org/git/603989bd-f86d-c61d-c6f5-fb6748a65ba9@siemens.com/
      3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/50

which looks like it would impact your system. You can either:

  1. Try v2.22.0-rc1, which will be the first release with that fix.

  2. Try cherry-picking the various fixes on top of v2.14.0:

       git checkout v2.14.0
       git cherry-pick 23e37f8e9d5961c0c8d52ac481693d3fca5309ce
       git cherry-pick 07a20f569b4b1690e717eaac0954007a8edfbfc2
       git cherry-pick 4125f78222749cb8fc91115abec3ac83e5dfb194

  3. Compile with another sha1 implementation. E.g.:

       # if you have openssl available; otherwise,
       # try BLK_SHA1
       echo 'OPENSSL_SHA1 = Yes' >config.mak
       make

     Note that you won't be protected from collision attacks, but those
     are still impractically expensive to mount at this point. It may be
     a good tradeoff until you can upgrade to a more recent Git.

-Peff
