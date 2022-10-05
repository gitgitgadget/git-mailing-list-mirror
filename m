Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36495C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 19:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJETmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 15:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJETmB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 15:42:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7F7D1CB
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 12:41:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i6so16751749pfb.2
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aq9ntyLKh8AveT+DMFBtOecRzp9zmpKSc3DkNffBeA=;
        b=VVoJlV4xXntZsKGgfWoawGQsrkubR1orI7LgNyc51AapDqvEkibkKl3bnX/IAuEOx1
         BmEjmVpy9IOHtGwwLlEoAyY5SL2DxApCP6zisddYKOJ4Qfx2mJ5HlyyO0wH5eeH6dkK1
         on7JxT9ZOAnfUClPYQgCY5kl2CMHnG4pJVkmZWQFpxcW9h8H2EPyUlMkP8VYuIdH2E8I
         hk12DmkL7dVZtxcj3DyX9kriXyMouJjEnezWKQoO5b6hEnwI5WX1yCi7sPoLI3fmCC0m
         tnWmYEf7w8kED96OcATrJhEmSibiEbVdo+zskxJ94aG6AH5RkM+AAezjnLyNesoJkPEG
         JnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aq9ntyLKh8AveT+DMFBtOecRzp9zmpKSc3DkNffBeA=;
        b=hJCNqNUYUmCzt4BU1yFXjfj4yd1MZbCtSdbTmt9qDD05j1kTSSfXmWIwDwnrVha3RK
         RAiGuONAkh1UD4jRvMKMxdjEHyASs8N8Ktvdc/cGO7o7vwnAqxBy1/h4tGZHf8LWxQZb
         gTe4ZvulaaqSpSl9WJY46UiNWx6opPdGXgoaJNdMd2LOG54V9Vc4pr07+rafjpaKI9mn
         G8fT2KQUuxz2pETu7YpMjq9e5/asNASZoc+xzqk3/IID1eBt5XGIjz7ztqbuIwcX4c6F
         OUQkfO7RGq+ILhZFYgvMNaELLiZQ3uSapEoqXZxH2l1KMvUqu3hxAPFajkMc8PTWsSdT
         h75w==
X-Gm-Message-State: ACrzQf1uQQokgZSjLB6k5+hjNfzWY47NTsUPqm6ebZ2IZD6+y2EY33F0
        dMdmHCEWIILiGt+71kY3VEU=
X-Google-Smtp-Source: AMsMyM4ywt475sJRjEyL722yDvMIbjKu134V4xkV0usGWlCcryIDlbovBppba/1IxG5WNTkx1beMGA==
X-Received: by 2002:a63:581e:0:b0:43c:29a0:6390 with SMTP id m30-20020a63581e000000b0043c29a06390mr1219572pgb.552.1664998919232;
        Wed, 05 Oct 2022 12:41:59 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x24-20020a63db58000000b0042f62120c1bsm134454pgi.17.2022.10.05.12.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 12:41:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: PATCH] bisect--helper: plug strvec leak in bisect_start()
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
Date:   Wed, 05 Oct 2022 12:41:58 -0700
In-Reply-To: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 4 Oct 2022 18:06:28 +0200")
Message-ID: <xmqq4jwioy61.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> The strvec "argv" is used to build a command for run_command_v_opt(),
> but never freed.  Use the "args" strvec of struct child_process and
> run_command() instead, which releases the allocated memory both on
> success and on error.  We just also need to set the "git_cmd" bit
> directly.

Well reasoned and explained.

Thanks.

>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/bisect--helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 501245fac9..9fe0c08479 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -765,11 +765,12 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
>  		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>  		strbuf_trim(&start_head);
>  		if (!no_checkout) {
> -			struct strvec argv = STRVEC_INIT;
> +			struct child_process cmd = CHILD_PROCESS_INIT;
>
> -			strvec_pushl(&argv, "checkout", start_head.buf,
> +			cmd.git_cmd = 1;
> +			strvec_pushl(&cmd.args, "checkout", start_head.buf,
>  				     "--", NULL);
> -			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
> +			if (run_command(&cmd)) {
>  				res = error(_("checking out '%s' failed."
>  						 " Try 'git bisect start "
>  						 "<valid-branch>'."),
> --
> 2.37.3
