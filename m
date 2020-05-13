Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32D8C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48E62053B
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbgEMXOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 19:14:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41214 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732136AbgEMXOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 19:14:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id h17so1511399wrc.8
        for <git@vger.kernel.org>; Wed, 13 May 2020 16:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77ptzoHswSbmGKhWsudbW0BmzmHl63xSkDLNeS55P64=;
        b=iTNraV5GV5TnNyIekOa33Y1UoAZ99oni6zF0Ih8tz+Q+RHJy36lDcpJiPzGIDnGLx+
         npiBdlbavTFM/SEso+BoBtICRUsOwP/6g3z8e84bDmrIWpHWg5aNPbebnryA97VVNOpd
         HBLuoqJfSSyeC1GNOKXU3IdLv8MBT47cvUntb79nYkze/RMmAjXSzUXnK6KwF1AH5srq
         HRY/f1MXwLGPBa7Xli8H0ES/Tioz3Vfy6XJ68+MnG7wuQtc/TIQ9Qgf45sLDM1EsIKTD
         ouVVUZUoMYjjkc+zUHdH/GWDv2CfGU4bTT+2bfw6Bs9dn3m02kn04agChjPZInUD1F58
         ofvg==
X-Gm-Message-State: AOAM531JEAPFlP0yQt+7DGNWv6inv3rYZ7MIPRn6caenA91N1u6xnBAt
        KHTletML3CxF1luRGugtvNa29OqSEtIPZDU1LkVoQJNr
X-Google-Smtp-Source: ABdhPJyDKE5yAqyfJZ/k9No4pteuq8OpbtW9FWbIEbt7dnSsA+dgIxwcJ9vduRSz/XQM6s5wn7ASpRkv1WZLvyhfoZU=
X-Received: by 2002:adf:fccd:: with SMTP id f13mr1947627wrs.386.1589411686805;
 Wed, 13 May 2020 16:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589393036.git.liu.denton@gmail.com> <c89c1841008dfc2d111369fb682b946a0c33b7be.1589393036.git.liu.denton@gmail.com>
In-Reply-To: <c89c1841008dfc2d111369fb682b946a0c33b7be.1589393036.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 May 2020 19:14:35 -0400
Message-ID: <CAPig+cQyCSMtSrdk54E6MVYL4prhNyWgBKkkBFHXo5hShqQ+=Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] transport: combine common cases with a fallthrough
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 2:07 PM Denton Liu <liu.denton@gmail.com> wrote:
> In the switch statement, the difference between the `protocol_v2` and
> `protocol_v{1,0}` arms is a prepatory call to die_if_server_options() in

What is "prepatory"?

More below...

> the latter. The fetch_pack() call is identical in both arms. However,
> since this fetch_pack() call has so many parameters, it is not
> immediately obvious that the call is identical in both cases.
>
> Rewrite the switch statement to fallthrough from the v{1,0} case to v2
> so that they share a common fetch_pack() call. This reduces duplication
> and makes the logic more clear for future readers.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/transport.c b/transport.c
> @@ -370,15 +370,11 @@ static int fetch_refs_via_pack(struct transport *transport,
>         switch (data->version) {
> -       case protocol_v2:
> -               refs = fetch_pack(&args, data->fd,
> -                                 refs_tmp ? refs_tmp : transport->remote_refs,
> -                                 to_fetch, nr_heads, &data->shallow,
> -                                 &transport->pack_lockfile, data->version);
> -               break;
> -       case protocol_v1:
>         case protocol_v0:
> +       case protocol_v1:
>                 die_if_server_options(transport);
> +               /* fallthrough */
> +       case protocol_v2:
>                 refs = fetch_pack(&args, data->fd,
>                                   refs_tmp ? refs_tmp : transport->remote_refs,
>                                   to_fetch, nr_heads, &data->shallow,

I can't say that I'm a fan of this change. While it may make it clear
that the two calls are identical, it makes it more difficult to reason
about the distinct v0, v1, and v2 cases. It also makes it more
difficult to extend or make changes to one or another case, should
that become necessary in the future.
