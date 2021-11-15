Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC0C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60453619EA
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351113AbhKPAuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356964AbhKPAqc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 19:46:32 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486FAC04E20B
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:00:41 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mmkxp-001vd8-63; Mon, 15 Nov 2021 23:00:37 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mmkxk-009ER1-O2; Tue, 16 Nov 2021 08:00:32 +0900
Date:   Tue, 16 Nov 2021 08:00:32 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
Message-ID: <20211115230032.3or3qqlsdnxjtrol@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
 <20211115220455.xse7mhbwabrheej4@glandium.org>
 <211115.86k0h9qcf5.gmgdl@evledraar.gmail.com>
 <20211115224015.vzfevpvptysxzpaa@glandium.org>
 <211115.86bl2lqbbt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211115.86bl2lqbbt.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 11:49:31PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 16 2021, Mike Hommey wrote:
> 
> > On Mon, Nov 15, 2021 at 11:26:36PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> On Tue, Nov 16 2021, Mike Hommey wrote:
> >> 
> >> > On Thu, Sep 23, 2021 at 12:30:03PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> >> -builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
> >> >> +hook.sp hook.s hook.o: hook-list.h
> >> >> +
> >> >> +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
> >> >
> >> > hook-list.h is only included from buitin/bugreport.c, so
> >> > builtin/bugreport.o should be the one with the hook-list.h dependency,
> >> > shouldn't it?
> >> 
> >> Well spotted, yes. This is a mistake. I think from some earlier WIP
> >> version of the series.
> >> 
> >> In practice we don't really miss dependencies due to these sorts of
> >> mistakes since we use the .depends files, i.e. GCC & Clang figure this
> >> out for us:
> >> 
> >>     $ grep hook-list .depend/* */.depend/*
> >>     builtin/.depend/bugreport.o.d: compat/compiler.h git-compat-util.h hook.h hook-list.h
> >>     builtin/.depend/bugreport.o.d:hook-list.h:
> >
> > But aren't those .depends files are only created when compiling object
> > files, such that builtin/.depend/bugreport.o.d wouldn't exist until
> > bugreport.c is compiled, which would fail if hook-list.h wasn't created
> > before that?
> 
> Fail how?
> 
> I don't think it could fail, because the purpose of these dependency
> relationships is to avoid needless *re*builds. So if you're building for
> the first time it doesn't matter, your compiler will find the relevant
> things to include for you. It doesn't need what's in the Makefile to do
> that.
> 
> See [1], what I said about LIB_H there applies more generally for the
> .depends files.
> 
> It will only fail in the sense that it over-depends, i.e. if you do:
> 
>     git clean -dxf; make builtin/help.o

Try

    git clean -dxf; make builtin/bugreport.o

It fails with:

      CC builtin/bugreport.o
  builtin/bugreport.c:7:10: fatal error: hook-list.h: そのようなファイルやディレクトリはありません
      7 | #include "hook-list.h"
        |          ^~~~~~~~~~~~~
  compilation terminated.
  make: *** [Makefile:2500: builtin/bugreport.o] エラー 1

The only reason I can see why it builds at all normally is that hook.o
is built soon enough that by the time builtin/bugreport.o is built
hook-list.h has already been generated.

Mike

