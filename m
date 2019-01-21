Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1553B1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 22:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfAUWKz (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 17:10:55 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34765 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfAUWKz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 17:10:55 -0500
Received: by mail-wr1-f53.google.com with SMTP id j2so25249005wrw.1
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nJ2b+DXErqqujMplduAvMgJhINV94Vc2F71q1mbccpA=;
        b=mr8Y3TcOF/MlFO/nvXebnxhs/xV7RpGfpNwQTK7ePrLGH0u8GpCk4oliZfrMfFsFZW
         CjBw4VcZtvGleSAzET5uv7NF2+o0FtUjXYcuPv20L5/PNmIAUetNw/UEgjTBsMvYeKWj
         vS2Ml4KiVJqnOdl1Gtddu5BjSzi8uIW2pSs9rDj/lC4BBwzu9qLtw7RXxsgGlnhCVjQr
         HB/G9kiOlNWfXA0gbhr2C0NlD5xem1HmftwoIQOmbqyZ5nohDwfJh5ZUh1wMUEFJcmfY
         Z/5r7x4SlopkEv+PLoa334q+ricmBMyYhwYrhqvj0kaE78smkkpdJm5C8QRZg8CT/fmq
         othw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nJ2b+DXErqqujMplduAvMgJhINV94Vc2F71q1mbccpA=;
        b=JpY14Eeff5Bf4ibqhh1pOuxHY9p2YOe+VOWPCQprOJ/IxjOgmjAbVaD/IxRSrMhIFv
         0WKT09qv7YpTvIV21da0iT+HVke9xRBf9b0kd67bq/C0x7UiSH2b2wJ8d11wwGem3Hb7
         bA/+m1aZpNeeW5c5D+thn4j8NhRRwoKRQWXbmEqqKDrnoCJw5zdCf9y03zG+e3Cgoyqd
         w7ldQrfG95RSuwbavv9SsLMISMFV9d7bnpNnQk2qtwcPe6kkhyUczmlDiczGdgVlIrNs
         58pOZ7SOdz1kPTnhTWKrkguv9ZRkx6o3rph2BcXRswjUGwPvUV3tSxvEgmU++S/OkHEg
         f7pw==
X-Gm-Message-State: AJcUukefGd9qA7+QmmtNWetTIb/Wz6+tSY1ROQMlQndZVd8GRxWex2G/
        VScaLpDNM/quNfxZveQjoi4xI9lPmRBuCKSjls7pZ8va
X-Google-Smtp-Source: ALg8bN6kMP//fKCkB5MnJH/9TSt1PIHk+N2eCrgJRLmhKSzDZ6iWk9RyDLCuVj4VJymDmc1QRGwXvArLkg2AqBzApeA=
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr31984082wrx.149.1548108653492;
 Mon, 21 Jan 2019 14:10:53 -0800 (PST)
MIME-Version: 1.0
From:   Alex Netkachov <alex.netkachov@gmail.com>
Date:   Mon, 21 Jan 2019 22:10:16 +0000
Message-ID: <CAGAu0HVeQFA_O8_hsZbzRi9X35fF3DAeUaSd993JF=NTwaZP1Q@mail.gmail.com>
Subject: Potential bug in pack-objects.c
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The most recent version of git crashes on gc command on my repository.
I've tracked it down to the segmentation fault in pack-objects.c while
running this command in the debugger:
gdb --args /usr/src/git/git-pack-objects.exe --local
--delta-base-offset .git/objects/pack/.tmp-14368-pack
--keep-true-parents --honor-pack-keep --non-empty --all --reflog
--indexed-objects --unpack-unreachable=2.weeks.ago --threads=1

It stops here:

#0  0x00007ff88b11de0e in ntdll!RtlLockHeap ()

   from C:\Windows\SYSTEM32\ntdll.dll

#1  0x00007ff88b11b7e4 in ntdll!RtlEnterCriticalSection ()

   from C:\Windows\SYSTEM32\ntdll.dll

#2  0x000000000047027c in oe_get_size_slow (pack=0x73fc20 <to_pack>,

    e=0x7ff5f7b03428) at builtin/pack-objects.c:1996

#3  0x000000000046ba27 in oe_set_size (pack=0x73fc20 <to_pack>,

    e=0x7ff5f7b03428, size=2987958784) at ./pack-objects.h:362

#4  0x000000000046f556 in check_object (entry=0x7ff5f7b03428)

    at builtin/pack-objects.c:1564

#5  0x000000000046ff63 in get_object_details () at builtin/pack-objects.c:1873

#6  0x0000000000471c11 in prepare_pack (window=10, depth=50)

    at builtin/pack-objects.c:2615

#7  0x0000000000474705 in cmd_pack_objects (argc=0, argv=0x2e30a48,

    prefix=0x0) at builtin/pack-objects.c:3491

#8  0x0000000000402e3b in run_builtin (p=0x680700 <commands+1728>, argc=12,

    argv=0x2e30a48) at git.c:421

#9  0x00000000004031f6 in handle_builtin (argc=12, argv=0x2e30a48)

    at git.c:653

#10 0x000000000040376b in cmd_main (argc=12, argv=0x2e30a48) at git.c:799

#11 0x00000000004bfb2f in main (argc=12, argv=0x2e30a48) at common-main.c:45


On the location builtin/pack-objects.c:1996 the code tries to set
read_lock (pthread_mutex_lock(&read_mutex)) and fails. I suspect that
read_mutex is not initialised yet. It is initialised in
init_threaded_search, which is called later in prepare_pack (through
ll_find_deltas).


Kind Regards,
Alex Netkachov
