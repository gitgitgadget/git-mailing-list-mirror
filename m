Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7BAC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 17:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjEQRwp convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 17 May 2023 13:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjEQRwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 13:52:45 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797DC2696
        for <git@vger.kernel.org>; Wed, 17 May 2023 10:52:22 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7576deacbd6so62761485a.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 10:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345941; x=1686937941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARdbtBmYytExCrpVMyPOLmBGXi1shTuZhbkSK4IEP+4=;
        b=GpNWYLNCaYCoIi5sLbWfa83XhLqcsBf/+ZYOcNkD9/IoFb2vUW41GHXUr/Z24rRyor
         K2m8aFN8lhWCwhtiyf8ALcUaDz4G/6SnVYt9ZdN8EUjLMFSPSCO1Mo3h/8EEBDwiWCrZ
         hlKAtnbBgB5Uq/KcsS05LuVkQXeH1cB92DvOvtKgT3nf9zUypnVN7z+HjloQ5lN+4j6N
         M9v0F//dYbntqPhsxUetXKmALBYvMRu93D4gaW84mdBWqDbPaZE48tUbcj6RS0mU9Ec9
         7VPFBmIyHoqzoyGfv+4SU0UzXU4bPfeKtbweMpjHwUB17i9mRazcSJTRw0igQ2cNU9em
         q9sw==
X-Gm-Message-State: AC+VfDw4Kpyy+7E2cfJuKdD2oT8B/gHsx7jf2g6EEIwoF3OKqbwIZ7Of
        VihLTJZYt/1fI8PVdbMhye5IcvL7UWK2zD44gJQ=
X-Google-Smtp-Source: ACHHUZ7gPKE68rzlDebmbkuz/yhxfzhp8oAD3Ddsj6xZGwJKJeDWHtsz5Mq8WSikJ+Vkhu/uQew2Kj16eq0HSTxYOmY=
X-Received: by 2002:a05:6214:401d:b0:5f1:5ed3:dd82 with SMTP id
 kd29-20020a056214401d00b005f15ed3dd82mr709754qvb.48.1684345941570; Wed, 17
 May 2023 10:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684067644.git.code@khaugsbakk.name> <20230517093214.GA527234@coredump.intra.peff.net>
 <xmqqo7mjq779.fsf@gitster.g> <20230517173709.GA535409@coredump.intra.peff.net>
In-Reply-To: <20230517173709.GA535409@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 17 May 2023 13:52:10 -0400
Message-ID: <CAPig+cSxbsqqQ1qDAw5Mo_yT5u6wzgoXSvPc51=RDVV-EBPhvg@mail.gmail.com>
Subject: Re: [PATCH 0/3] tag: keep the message file in case ref transaction fails
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 1:40 PM Jeff King <peff@peff.net> wrote:
> One thing I wondered is whether the obvious command to retry:
>
>   git tag -F .git/TAG_EDITMSG foo
>
> would work, or if we would overwrite the file before it is read. But it
> does work, which is good. I wonder if we:
>
>   b. want to tell users that is a good way to recover (though maybe that
>      is a rabbit hole of details as one subtlety is that it will be
>      overwritten by an unrelated tag command).

If that route is taken, then making the advice worktree-friendly would
probably be a good idea:

    git tag -F $(git rev-parse --git-path TAG_EDITMSG) foo
