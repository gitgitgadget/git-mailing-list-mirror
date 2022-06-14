Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B54C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 06:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245634AbiFNGWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 02:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiFNGWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 02:22:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB86B86B
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 23:22:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v19so10144025edd.4
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+8+Ee2zS8HFa3OTFOV4tvGVDZjh85nxSd47TJI1qfs=;
        b=bvEsmcdo7wCpVcB7guWQArU7sRMvJ5oMaTfXMZlYM4T3mFaQwgQJXvp+z18I+oQZNK
         PnzPhIVvb6xXhuPnmRApq1b4jNZWbpoHz1kavLk9Z+PI/iAqpdmhoNGdxEDJJdwBNaJ0
         pDwC0YdqvXkkpzB/yi/jp3G4AviubYD2h5M44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+8+Ee2zS8HFa3OTFOV4tvGVDZjh85nxSd47TJI1qfs=;
        b=XcbmHHvd/HQW4ZIzBTKS3d4SrtENdEdlSVDOaymzWxIa87JQgdrDZBh3FeppDXpgEZ
         3CfMk88qhL72dPlK0DL/C7jo9qPZkNDQKp//JHHvzQ2d+lFJTqnz3TaIQAEgF2+c2mUr
         kiyyp6cbB1y4vYra+koHjuFuO/fHCH/IP2LHXhfjvNbmO2OC2jdPw60Hjtvqv09lOSLf
         CHn8c+5jC8FTfeFpRdT6VVQqS7jJ6hGXAKcBg5dCHhD/J1edlC6CKmdA4PI/3bcdMAkJ
         6udOLSmI1O8vdVnuyS3N9X/znR7PmHabtq0ANgQ5evqwyC65G1TE8ZUoSLbEJKZV8RyO
         gK4Q==
X-Gm-Message-State: AOAM533jE+hyur+BGA2yYSWtQpigGgr20ngWsH3E4p4spR1hVaIBv5+m
        SN8EVREG2VduuiK9NkVTBSjnAjSfB1lFTHDnF8yfHw==
X-Google-Smtp-Source: ABdhPJxszE+bAzFFCSEX4ZOdfQXQQQvBfNLU3BuY5I1DKvfONAMocxzcqtQRnM6F/hh44uw7JuL/hlehNwflRZSIbu0=
X-Received: by 2002:a05:6402:6cc:b0:42d:bd2d:9f82 with SMTP id
 n12-20020a05640206cc00b0042dbd2d9f82mr3961182edy.59.1655187768564; Mon, 13
 Jun 2022 23:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
 <xmqqleu3au2n.fsf@gitster.g> <xmqqedzt8nfq.fsf@gitster.g>
In-Reply-To: <xmqqedzt8nfq.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 14 Jun 2022 08:22:37 +0200
Message-ID: <CAPMMpogcm36pd7fjvG64G7Vg29arukF-wzOKYbNYG9NOpVCXvQ@mail.gmail.com>
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive filesystems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 1:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > ...  I
> > do not think in_fn_table() pays attention to "ignore_case" option,
> > so there may be an existing bug there already, regardless of the
> > problem you are trying to address with your patch.
> >
> > And I wonder if doing case-insensitive match in in_fn_table() lets
> > us cover this new case as well as "fixing" the existing issue.
>
> While I still think in_fn_table() should be looked into for an
> existing case sensitivity bug, I think this one is different enough
> that in_fn_table() logic wouild not trigger for it, and a patch to
> add an extra piece of logic for renames is probably needed.
>

Having spent some time with this yesterday and today, I'm quite
confident not only that you were right about the general
case-sensitivity fix required here, but also that it fixes the
case-only rename issue. It turns it (on case-insensitive filesystems)
into a similar issue to the mode change, which is treated as a remove
and add of the same file.

As you suggested, it is possible to construct "case-differing file
swaps" which are not file swaps on a case-sensitive FS but are on a
case-insensitive one, and without a fix these fail. The same (very
small) change fixes both issues.

> It might be sufficient to tighten the condition so that it triggers
> only to the case you wanted to handle, i.e. a rename between the
> same name.
>
>         else if (ignore_case && old_name && new_name &&
>                  !strcasecmp(old_name, new_name))
>
> (the "both names must be non-NULL" check is new).
>

This was my original tack, but I think it makes more sense to make the
general fix and explain how it also handles this case.

New patch coming.

Thanks!
