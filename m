Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78025CD6E63
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 12:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjJKMd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjJKMd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 08:33:28 -0400
X-Greylist: delayed 133095 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Oct 2023 05:33:25 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B6E9E
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 05:33:25 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S5By86D82z9sr8;
        Wed, 11 Oct 2023 14:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
        t=1697027600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+zAtu5HjARHu/ccEVGF4MTMnkHbtsio16BqPx2297k=;
        b=HHoK4Ds1yBlMxt+7taOFXxFF6Sr6j8zqx4Vnf+GdC77OgFlHjvQNUbwNzkMaQcZqDua+5Y
        ktM7p36ckkD+t5zyejbp1bsnF0BvorffR1U8/oG2vZfSVd7cC2jFPZdL0tWHzqsLy5k01z
        gxVAmLMyuVJIfaF+XRVQ1EnSpRNKW7jOEUUoAcqlVlQAMhqk58omNAOi0IGvqTj8xvLPqJ
        Ye9UBSjEFXvRUda7zsx0gm85sYREXpniA4SPD/xJQO4KKpe80NCVYlvQVh2x7j8l919KZf
        ijj0mTYDCMBujMuT++wuiRywOB8kbJOoCU4F5ECagHq9reF/kHvlZnFKb8rcAw==
Date:   Wed, 11 Oct 2023 13:33:19 +0100 (WEST)
From:   Hugo Sales <hugo@hsal.es>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Message-ID: <1384513657.119681.1697027599941@office.mailbox.org>
In-Reply-To: <xmqq1qe3wbt1.fsf@gitster.g>
References: <20231009233458.1371351-1-hugo@hsal.es>
 <xmqq1qe3wbt1.fsf@gitster.g>
Subject: Re: [PATCH 0/3] Add `-p' option to `git-mv', inspired by `mkdir'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: 4S5By86D82z9sr8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 10/10/2023 12:39 AM GMT Junio C Hamano <gitster@pobox.com> wrote:
> 
> Is there a reason why somebody benefits by us retaining the current
> behaviour, where
> 
>     $ git mv file no/such/dir/yet/file
> 
> fails with "No such file or directory", and they are forced to say
> either
> 
>     $ mkdir -p no/such/dir/yet
>     $ git mv file no/such/dir/yet/file
> 
> or
> 
>     $ git mv -p file no/such/dir/yet/file

Somewhat, as it could be a typo, so if you actually want to create a new folder, you have to be explicit. I wouldn't be opposed to removing the need for the flag, but if we did, I think we should warn the user that a new directory was created.

> Imagine there is no "no" directory (so nothing under it
> exists), and you did this (you do have a regular file "file").
> 
>     $ git mv [-p] file no/such/dir/yet
> 
> What should happen?  Would we do the equivalent of
> 
>     $ mkdir -p no/such/dir && git mv file no/such/dir/yet
> 
> or are we doing
> 
>     $ mkdir -p no/such/dir/yet && git mv file no/such/dir/yet/file
> 
> Both are plausible, and "mkdir -p" does not have such a nasty
> ambiguity.  That is what makes me unsure about the new feature
> (again, either with required "-p" or with implied "-p").

I think the ambiguity is resolved by the inclusion of lack thereof of a trailing `/`. This is what the implementation already does, too, before this patch. So

     $ git mv [-p] file no/such/dir/yet

would be the same as

     $ mkdir -p no/such/dir && git mv file no/such/dir/yet

and

     $ git mv [-p] file no/such/dir/yet/

would be the same as

     $ mkdir -p no/such/dir/yet && git mv file no/such/dir/yet/

Moving `file` to `no/such/dir/yet/file`

Thanks for the feedback,
Hugo

P.S. Apologies for the duplicated email, Junio, I did a Reply instead of a Reply All
