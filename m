Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C75C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 18:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCISs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 13:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCISs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 13:48:26 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165ABA8EAC
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 10:48:24 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h8so2983706plf.10
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 10:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678387703;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KN+dZ/8kP5trrtbzA+CigBoWGqAl1lSuveu1AsURwY=;
        b=e3KS3QFRyjyUWTP09yv2Ip4ARLrngVlKiKIh37uK9jZloEVSvnHQMTjxp6PU4Qu3KW
         o5UXeHBYNRUi04x0PthwObv+xGSSy6yvzMNslIS4aEKub8DNywiXa5qeHBghfeWmJJDN
         IoEcQ2CWbM7sxDeJ2IFsLd0LADCg/UI1h0IGxXXmVM+wePaV480mLicrY8SlAysxz9W5
         +Oq3TtX2lmi1Kb1eSZUEOAqY9rPrwLM2OgWIqD5dcYqOmw1cUyORrW4ZQayo3bfum2MJ
         f5cEoz+HweHu4Th4WLyFY4Ko8fc5Xrt4Y2usvmtXN+pvWHtgRBUt9llzT3TB2hoPvjbd
         mDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678387703;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0KN+dZ/8kP5trrtbzA+CigBoWGqAl1lSuveu1AsURwY=;
        b=1O8qILhiSnMXYiPXyN04RhnIvc0ki6k3k8+vxiD/eZSFdPaF965DDKmu9wo6jHbpXK
         HzgFMhZczSXjihH1uJzIk+kLhmMsyA+EugE4Nraab2da7+VNteCPTiDM9+aQL3SqaZWw
         sya8xO9+qJRi1GwmVG0+O+857lgeTWO7zyW0qPO/3RkfL+Uj0fP42Yq/Dx1RGR2xOY2n
         Zfb+16eaqCLO/yQLa8rWPCjuL7uY6NRYCpqobTHuGYI4TtifNGYXZlfrUUJk4PkRNjhu
         yM//L3ywkdFoOj1unLHjZoSL6OVq1tIpyjyvHKYj1alO2Yw2IxfrLo6VnWDUjkwctKxU
         /baQ==
X-Gm-Message-State: AO0yUKVH0PsFdV6RPAB7AsFlELP1fffKOxZi942fddIzZROWr4vMrXUW
        dEqwMQKeMmjRtZj+Q/D+fSI=
X-Google-Smtp-Source: AK7set9nB1QzBJ45FO94H+F0mjpOkykBBwLxcwMvft2vtDyWMePDw+ed4YXa5HKD23MAzkMFOGT3cw==
X-Received: by 2002:a17:90b:4aca:b0:235:9d0c:6e3f with SMTP id mh10-20020a17090b4aca00b002359d0c6e3fmr22987483pjb.31.1678387703472;
        Thu, 09 Mar 2023 10:48:23 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id mv5-20020a17090b198500b00233aacab89esm246122pjb.48.2023.03.09.10.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 10:48:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] receive-pack: fix stale packfile locks when dying
References: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
Date:   Thu, 09 Mar 2023 10:48:22 -0800
In-Reply-To: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 9 Mar 2023 14:09:23 +0100")
Message-ID: <xmqqsfedahhl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index cd5c7a28ef..0a6030d775 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2186,6 +2186,12 @@ static const char *parse_pack_header(struct pack_header *hdr)
>  
>  static const char *pack_lockfile;
>  
> +static void unlink_pack_lockfile(void)
> +{
> +	if (pack_lockfile)
> +		unlink(pack_lockfile);
> +}
> +
>  static void push_header_arg(struct strvec *args, struct pack_header *hdr)
>  {
>  	strvec_pushf(args, "--pack_header=%"PRIu32",%"PRIu32,
> @@ -2281,6 +2287,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>  		if (status)
>  			return "index-pack fork failed";
>  		pack_lockfile = index_pack_lockfile(child.out, NULL);
> +		atexit(unlink_pack_lockfile);

Hmph, why isn't this a straight application of tempfile API?
