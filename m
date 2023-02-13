Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315DEC636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 13:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBMNpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 08:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBMNpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 08:45:31 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957DE83D3
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 05:45:27 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id m2so13540748plg.4
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 05:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7w5ZUJlLBxpNwVlyrAnNUxwm7sBuhVGlkAtDTqOp98=;
        b=LgxmYxKzwP8iG9+lNTDYHB7n0Gd599zGXUmHn7XIzuaLiRESBd1t5xlsRTlUJ/IkTx
         P5ZKe5pWsowvVDnVe98wW5cecK3vIeChPCy1SiDUUSBCZQi3vaSx93UxFeQ3cyrgLbgK
         4v3L5SOSBUEDNDzStkcDojx7GU3X4F1YLGNMf6BuRcboKjKj+3VHzY1EW8l+/3zSdzOu
         7/60VzUm2cFRQMdl6qbdJmmtaKDRxBLhqXCqLdhnR+Cv3j8eazXpMKzlTfkJQYfg4f77
         1RoXk8++1iSwdCWwyhyFCUrMV+vC/nDnNixafhfxNZIZAZpuiv0d9klWro1B50huxOmu
         eNkw==
X-Gm-Message-State: AO0yUKUFuonyGnQnBlIGCfebCYEJTDQC2nvhneeNqA3Q2Lfz5rcLSiCy
        ouj5rmhsYnCDtsbFm8E7/zucIkNXXFEi/wAcEuJunPxcP/M=
X-Google-Smtp-Source: AK7set8KUAMmgvEvmvGgjQZFL2ccAEovcKlauj4OYMrh6ADD5o87DqgyjF96ytbJv01bjjXLdXVtBCQIe5GwO9G02qY=
X-Received: by 2002:a17:90b:a56:b0:234:190f:87e6 with SMTP id
 gw22-20020a17090b0a5600b00234190f87e6mr203290pjb.8.1676295927020; Mon, 13 Feb
 2023 05:45:27 -0800 (PST)
MIME-Version: 1.0
References: <623b0b8a-a5b3-408c-b924-9f88d9763b0e@app.fastmail.com>
In-Reply-To: <623b0b8a-a5b3-408c-b924-9f88d9763b0e@app.fastmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Feb 2023 08:45:15 -0500
Message-ID: <CAPig+cRotsJZHnRMUqWaYz=nw1sBRsW5ms7WWuApviG2be2GTQ@mail.gmail.com>
Subject: Re: [PATCH] Use correct default remote for fetching in submodule.
To:     Mara <mara@marabos.nl>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 8:31 AM Mara <mara@marabos.nl> wrote:
> "git submodule update" first tries a regular "git fetch"
> to fetch the commit, but when that doesn't retrieve the commit
> it wants, it tries "git fetch <remote> <commit>".
> For <remote>, it used the wrong default remote: the default
> remote of the outer repository, rather than the default remote
> of the submodule.
>
> Signed-off-by: Mara Bos <mara@marabos.nl>
> ---

I'm not a submodule user and I don't have any particular familiarity
with this code, so I may be wrong, but...

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4c173d8b37..50b96e0b9d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2225,7 +2225,10 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
> -               char *remote = get_default_remote();
> +               char *remote;
> +               int code = get_default_remote_submodule(module_path, &remote);
> +               if (code)
> +                       return code;
>                 strvec_pushl(&cp.args, remote, hex, NULL);
>                 free(remote);

... it looks like this change may introduce a memory leak. Digging
down through get_default_remote_submodule() and the functions it
calls, it appears that repo_get_default_remote() can return a non-zero
code _after_ it has allocated memory for `remote`. If I'm reading this
correctly, then the above should probably be:

    char *remote = NULL;
    int code = get_default_remote_submodule(module_path, &remote);
    if (code) {
        free(remote);
        return code;
    }

Also, if possible, add a new test, perhaps to
t/t7406-submodule-update.sh, demonstrating that this change fixes the
problem and to ensure that it doesn't get broken again. If you have a
minimal-reproduction recipe which exhibits the problem, then you may
be able to turn it into an actual test.
