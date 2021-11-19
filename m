Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5223EC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F9E6128A
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhKSH1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 02:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhKSH1J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 02:27:09 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D018FC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 23:24:07 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnyFf-00CQrs-6M; Fri, 19 Nov 2021 07:24:03 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnyFZ-00BusI-V5; Fri, 19 Nov 2021 16:23:57 +0900
Date:   Fri, 19 Nov 2021 16:23:57 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on
 msys2
Message-ID: <20211119072357.oxl5caye742blz5j@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20211005063936.588874-1-mh@glandium.org>
 <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
 <20211118030255.jscp2zda4p2ewact@glandium.org>
 <CAPUEspg-5+YdfTJ6zi9hdDqF=KV2LJFCtqmECSss9Kfpn6sGrQ@mail.gmail.com>
 <20211118053415.4axljmr4s6kmqmms@glandium.org>
 <CAPUEsphf0d90HGg64j=jZnt-Xuhs_bwmeOyoUnmzesp_k2c4JA@mail.gmail.com>
 <20211118090542.rcaggue6zpd7r3ht@glandium.org>
 <CAPUEspjZmwoOWSJHBrykOfNEv=zLi2nQLs1EkUPTPr-nSNf08Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUEspjZmwoOWSJHBrykOfNEv=zLi2nQLs1EkUPTPr-nSNf08Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 09:38:00PM -0800, Carlo Arenas wrote:
> On Thu, Nov 18, 2021 at 1:05 AM Mike Hommey <mh@glandium.org> wrote:
> > Oh my bad, I overlooked an important part of the build log: it was a
> > mingw32 build, not minwg64. Mingw64 builds fine without
> > -D_POSIX_THREAD_SAFE_FUNCTIONS=200112L. Mingw32 requires it (because
> > the ifdefs are for mingw64)
> 
> Can you confirm the version of the winpthread library in your SDK? and
> output of your headers, or something that could back up that statement
> of "ifdefs are for mingw64"?.

The ifdef around gmtime_r and localtime_r in mingw.h is for __MINGW64_VERSION_MAJOR.
The ifdef around _POSIX_C_SOURCE in git-compat-util.h is for
__MINGW64__.
I'd imagine that plays a role.

winpthreads version on my system is 9.0.0.6246.ae63cde27-1.

The /mingw32/i686-w64-mingw32/include/time.h section related to gtime_r
and localtime_r starts with:
```
#if defined(_POSIX_C_SOURCE) && !defined(_POSIX_THREAD_SAFE_FUNCTIONS)
#define _POSIX_THREAD_SAFE_FUNCTIONS 200112L
#endif
#ifdef _POSIX_THREAD_SAFE_FUNCTIONS
__forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
  return localtime_s(_Tm, _Time) ? NULL : _Tm;
}
__forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
  return gmtime_s(_Tm, _Time) ? NULL : _Tm;
}
```

Mike
