Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FCA11F453
	for <e@80x24.org>; Thu, 14 Feb 2019 10:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405603AbfBNKyh (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 05:54:37 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40987 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfBNKyg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 05:54:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id v10so6278496qtp.8
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 02:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6Gvr3DZN8lEPqEzvCs87EzfkFC8MpY5VSteuKH4rsk=;
        b=DrI60IX12bysYBRp5PRqBw2n6DHDVLAmRazch/vymvThP92H0qRrK5JSPHw3x8P35x
         +mafDzszqLmr/TNKVNaBVGG3mizG14Q4vLQ/M8bvVrrBw2hrKybkrhr/Tr414MKjlZr3
         190u2x1ThV06Exmjc3g1BPGUBrvu0VFTpGy0JBHZYH0koOzkC34W4grRbPtH9DNDzQaw
         p2cJFaDJGBLHJZEmb0tvq24TvsNQXjeIsLVJsC3OSgkxRGHGy9auFmLu0tK6mda594ga
         D8ly2VaC9AV1YaAkFQEdqF0cSXch6mOoB7vc+1YJnYCnybzfryeJ6Lt2XE+G1GpGamWB
         1ZeA==
X-Gm-Message-State: AHQUAuaPEyszDjUXh2jP6JRpC11wFQbYD80a/TljnGMdk6Vw5lTeFKa/
        uJuo+U64iHAxZzYPreAJ8hR7f6jgVVoxZt1ZJsVeAQ==
X-Google-Smtp-Source: AHgI3IYdigMDrSUL5Ww0hqCliIR+67r9g/wfzHaWGB2Ow3BfX4l3Vxw5fGHMkzWeFmRF7r0SUt30JmK0hHWWEKBxWSc=
X-Received: by 2002:ac8:2847:: with SMTP id 7mr2376192qtr.335.1550141675784;
 Thu, 14 Feb 2019 02:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20190214043127.GA19019@sigill.intra.peff.net> <20190214043522.GA19183@sigill.intra.peff.net>
In-Reply-To: <20190214043522.GA19183@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 14 Feb 2019 05:54:25 -0500
Message-ID: <CAPig+cQVUZT4ZyMeP5xDcvypjucVeRUP2cN=tL9c5DVoONSNng@mail.gmail.com>
Subject: Re: [PATCH 1/3] prune: lazily perform reachability traversal
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 11:35 PM Jeff King <peff@peff.net> wrote:
> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> @@ -274,6 +274,18 @@ test_expect_success 'prune .git/shallow' '
> +test_expect_success 'prune .git/shallow when there are no loose objects' '
> +       SHA1=$(echo hi|git commit-tree HEAD^{tree}) &&

Perhaps name this variable 'oid' rather than 'SHA1' to make brian happy.

> +       echo $SHA1 >.git/shallow &&
> +       git update-ref refs/heads/shallow-tip $SHA1 &&
> +       git repack -ad &&
> +       # verify assumption that all loose objects are gone
> +       git count-objects | grep ^0 &&
> +       git prune &&
> +       echo $SHA1 >expect &&
> +       test_cmp expect .git/shallow
> +'
