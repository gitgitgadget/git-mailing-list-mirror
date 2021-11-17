Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2127C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADE361A38
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhKQDmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKQDmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 22:42:45 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A6C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 19:39:47 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnBnT-005ap5-Bw; Wed, 17 Nov 2021 03:39:43 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnBnO-009hm5-SQ; Wed, 17 Nov 2021 12:39:38 +0900
Date:   Wed, 17 Nov 2021 12:39:38 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Makefile: fix parallel build race
Message-ID: <20211117033938.r3wsv3znxva7smgy@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com>
 <YZR0djZbRUicXcQm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZR0djZbRUicXcQm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 10:18:14PM -0500, Jeff King wrote:
> On Wed, Nov 17, 2021 at 08:25:55AM +0700, Đoàn Trần Công Danh wrote:
> 
> > * builtin/bugreport.c includes hook-list.h, hence generated files from
> > it must depend on hook-list.h
> 
> Good catch. This is trivially reproducible with:
> 
>   make clean
>   make builtin/bugreport.o
> 
> The problem comes from cfe853e66b (hook-list.h: add a generated list of
> hooks, like config-list.h, 2021-09-26), as you might expect.
> 
> > diff --git a/Makefile b/Makefile
> > index 241dc322c0..413503b488 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2222,6 +2222,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
> >  
> >  help.sp help.s help.o: command-list.h
> >  hook.sp hook.s hook.o: hook-list.h
> > +builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
> 
> This fix looks correct. I grepped for other similar cases, but this is
> the only file that needs it.
> 
> Curiously, the existing hook.c does not seem to include hook-list.h,
> even though you can see a dependency in the context above. Nor does
> help.c, which gained a similar dependency in cfe853e66b. Those seem
> superfluous, but maybe I'm missing something.

Neither does builtin/help.c. This was discussed in the subthread
starting at https://lore.kernel.org/all/20211115220455.xse7mhbwabrheej4@glandium.org/
and is covered by https://lore.kernel.org/all/patch-v3-19.23-234b4eb613c-20211116T114334Z-avarab@gmail.com/
(to which I responded that the line for hook.o can be removed too)

Mike
