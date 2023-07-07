Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6A9EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 19:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjGGTbE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 7 Jul 2023 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjGGT3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 15:29:01 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF12213D
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 12:28:54 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-63770af327fso14504966d6.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 12:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758133; x=1691350133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn6MuUELS3Dl7koMC/o8VuqeTxX6FYAO2nCXIHDFV7o=;
        b=Z/L5XKBLWdFA+2g4fQzIafEwxks6Z99goWDoCZULZwuLydSXB7KVx6jnrK19xt93sT
         e0x5nYGUwyrV1CxjDfOEzhOQ3jzwKqeA63rDux3SIvyo1dRPJu+PcudgKGZud2lp8DI1
         3OEOKYuEBaTVDvFuFQinZf6jGpL88teGLaEc0aZeluYfil+8rb7FWWMLmmlsp2vQupQx
         rP2YYYFUrGOsnu3XiOQO0/ZtRX5nXb1D4qn86oM9lIsy/BN3/rarY6b5qztIKr+YOvdM
         HvLtym+w+HtDUS5yIewHFlFV4298wigN31qulpzHakM+njgNZLER+AiUT541RqnZe6OI
         4KrA==
X-Gm-Message-State: ABy/qLbUyUyrTXmhfWxDVJI3IwuiI+NNwkEFe7z3UmInYWW89GRlpYH9
        uWr7Z8x3+HzEkvo1lRug6PtcFk1LQI8wweDYxBQeVCpOaWU=
X-Google-Smtp-Source: APBJJlHEkAyeFIEPnvCeZkshMxHYS2e6mdz/LpGqP1OUA4AHPvQuyuDSV+H+iSYq0Gx2rbD/kOvx7twCti4Y+mDeZQ8=
X-Received: by 2002:a0c:b410:0:b0:626:1ba1:70ae with SMTP id
 u16-20020a0cb410000000b006261ba170aemr5214198qve.33.1688758133394; Fri, 07
 Jul 2023 12:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzX-aD1wfgp8AvNNfCXVM3jAaAjK+uFTqS2XP4CJbVvFr2BtQ@mail.gmail.com>
 <xmqq7crddjtq.fsf@gitster.g> <CAEzX-aC=UDkf6nevLbN0bNyGXujZVDuqtCp3YcYhAPD6zvYZiQ@mail.gmail.com>
 <xmqqjzvcbvqd.fsf@gitster.g> <CAEzX-aCnp0avSbMdyFQz=3s4-hjdeVwnndR5b7UeZo4oNMnv7A@mail.gmail.com>
 <xmqq1qhjbpoz.fsf@gitster.g>
In-Reply-To: <xmqq1qhjbpoz.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Jul 2023 15:28:42 -0400
Message-ID: <CAPig+cSo8+bh7vHBchwLfpdxehHmRFnbsOKOCpKoYGd=bzO_ig@mail.gmail.com>
Subject: Re: Expected behaviour for pathspecs matching attributes in subdirectories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Hughes <mhughes@uw.co.uk>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 7, 2023 at 1:26 PM Junio C Hamano <gitster@pobox.com> wrote:
> +test_expect_success 'reading from .gitattributes in a subdirectory' '
> +       test_when_finished "rm -f sub/.gitattributes" &&
> +       test_write_lines "fileSetLabel label1" >sub/.gitattributes &&
> +
> +       git ls-files ":(attr:label1)" >actual &&
> +       test_write_lines "sub/fileSetLabel" >expect &&
> +       test_cmp expect actual &&
> +
> +       git ls-files ":(attr:label1)sub" >actual &&
> +       test_write_lines "sub/fileSetLabel" >expect &&
> +       test_cmp expect actual &&
> +
> +       git ls-files ":(attr:label1)sub/" >actual &&
> +       test_write_lines "sub/fileSetLabel" >expect &&
> +       test_cmp expect actual
> +'

Perhaps shave off a bit of cognitive overhead by using `echo` for
these rather than `test_write_lines`. For instance:

    echo "fileSetLabel label1" >sub/.gitattributes &&
    ...
    echo "sub/fileSetLabel" >expect &&

and so on.
