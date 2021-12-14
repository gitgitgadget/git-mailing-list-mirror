Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C228CC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 20:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhLNUFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 15:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhLNUFB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 15:05:01 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACAEC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 12:05:00 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id 8so19564836qtx.5
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 12:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6tC6m0q7SJ+js/4YpNmnajwtdbA5vyta22YDRiJdkQ=;
        b=A+crw7vbjO6hu15vjOh23yEZnfhGWRq5+QtZcbCSRhI9fEAVMV3JVuQH78dhJjcrgt
         U88uvFvKLpsGCkw7p9leirVulo9c5AvuWfajpTy/u5WTj3uz7MgXVFrxmcX6wmL+FZOO
         uw9CtfnNwOiT6AI9nh8pXx88JeZwRBuTsR4ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6tC6m0q7SJ+js/4YpNmnajwtdbA5vyta22YDRiJdkQ=;
        b=AkkJA523VzYVMzLd0gMVjoF3UnCdVhs1g19OgsG5q7y7N+dBzsWbTAczBB2oIqekUF
         gMaTZI5xFFBifBh6ZejJfmllw0+fAiJLt52aIYAryZ98ElAe60t1vOFgkYgcn2XF/Crr
         Z5iAPLnloGtWJE+4bwQBZDOt52MnwZEnQuXkE4qlMzNbzCO15ccV8a8mIBDkiR30Tqpk
         nn+obye9w6Mq/05A1gMrPVjFzqCeksGOt7oEGCyAxF3eczAGt66ypIcUGATKtuRvCZXI
         /artlQ4JHlE2/5nUrDDFubrpLDWeY4UTV2eIRnvWOimgkVdqlGQQY8lYIlZUMSq09Zme
         NZXg==
X-Gm-Message-State: AOAM530ubdUD3Owr4acu71X7lk2X//L3SMGln6Thrx5PFG6FpzCKRDOL
        58hwh83i+RVrfKMs9Gntkxn/++6tCR4o3U7SYEefVhj5Vh9ujQ==
X-Google-Smtp-Source: ABdhPJxUtp2FHF/cQ7REkrZ6ZQUOn+CMLyrV36Wz5xVOORnahDJE7AURPLMGPBMx1blfhEKvJAf14bfmRGc2yEITbmE=
X-Received: by 2002:a05:622a:1310:: with SMTP id v16mr8496485qtk.431.1639512300025;
 Tue, 14 Dec 2021 12:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20211213132345.26310-1-jacob@gitlab.com> <20211213132345.26310-2-jacob@gitlab.com>
 <Ybi6SwndUHLs27bO@coredump.intra.peff.net>
In-Reply-To: <Ybi6SwndUHLs27bO@coredump.intra.peff.net>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Tue, 14 Dec 2021 21:04:49 +0100
Message-ID: <CADMWQoOaPQaCQa5V+1Dujc6A=+f8rnv7MG+fP1mZi1kwm=d3fQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] upload-pack.c: make output buffer size configurable
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 14, 2021 at 4:37 PM Jeff King <peff@peff.net> wrote:
>
> It gets about 2.3GB/s with the tip of 'master' and 3.2GB/s with the
> equivalent of your patch (using LARGE_PACKET_DATA_MAX). So definitely an
> improvement.
>
> Without the cached case (so actually running pack-objects, albeit a
> pretty quick one because of bitmaps and pack-reuse), the timings are
> about the same (171MB/s versus 174MB/s, but really it's just pegging a
> CPU running pack-objects). So it would be fine to just do this
> unconditionally, I think.

Thank you for validating this!

> Looking at strace, the other thing I notice is that we write() the
> packet header separately in send_sideband(), which doubles the number of
> syscalls. I hackily re-wrote this to use writev() instead (patch below),
> but it doesn't seem to actually help much (maybe a curiosity to explore
> further, but definitely not something to hold up your patch).

Those double writes bug me too. Getting rid of them was one of the
things I liked about using stdio here. Curious now if writev will make
an impact in my benchmarks. As your experiments indicate, the double
writes may not be a problem in real life. Either way, I also feel it
is not something to rope into this patch set.
