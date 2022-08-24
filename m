Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B121C04AA5
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 22:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiHXWC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 18:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiHXWC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 18:02:56 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3C1760FE
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:02:56 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id f8-20020aa79d88000000b0053641810e97so5525660pfq.9
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=p0oX4rBBtMMdyuVrhY/1KZvsnjED4Qlfgc+d2wQSa/Y=;
        b=p4YPKHhEPL3iy6QXz2VncdVbOc2RIlQx72h5kh61Qgu4gDTE8T47iIWbSCw/zH8BQ4
         6Zq8zMVvbZERgnkTEeZ+Tu48Fscz86EwQ6SIcMnG6/O4bwmIzZtDKkZg4Lq/JbtNksvP
         289SlG37EFUs/fp/PXBv3vFygsFHeNCOFWCphl0lwGyiqXCBIjeECAj9cx7/ZSXz8r1V
         F2Awx13JL7duREa8c9/nIHYNYyiKBcMVFskz6CqHbU7ZnwxN9TQb7ySPOUy6VkJIRHMy
         sL3eXBX/LTTabsW+Jyumvok3PvvgYrlsHj7QW9pShDXYlfXvZAbFkEyAzLoA7FRs0Mha
         avnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=p0oX4rBBtMMdyuVrhY/1KZvsnjED4Qlfgc+d2wQSa/Y=;
        b=fkSQ71ltcAkC36Fb5TSu1p2pPwuFPcsR1cM9+zFrzqnUrGox5/ZdXJyGhYyBEmXTa8
         KPOyCaxe/WeE7xkTiFu5ErkdlPeRtL7BQ+iO86vgj/cE+M9gq65GBu2eoemYcwM6mBhK
         pOnwwwIjuNAEGtleywwmFWoTq4lDtpg4OTXibToCeWK1X1y7UkjUpx6UOEDVh53u/adK
         oR8SQ/jDATgaqAWVRgZdi7gRpMb4Q7C4iFhI3p/vpNzZBO3ZJBdnMTddgBpE6KGFgIX+
         3v90SG7HY/LFQsZB6XBkHD8Wfh5nkTKqETqJL14XYvaRnVazdnETDdnJ3I+WSm0gMv+X
         sVrQ==
X-Gm-Message-State: ACgBeo3saGUPlgaiCxLFQhMhJaQPwhxqoK+6VrsQXUDqOZDlp/i1vYIR
        ZmOyEbdBiIolpr+s+Io3pmmYYLZ9Rg0/I7+B1WPs
X-Google-Smtp-Source: AA6agR7K2cGTSj5Mn0d41kpWYuLX6PqPoPjdhKigL/3Q3TtV+5rUqiRNElUmiqXghLRIJDGU/Yufnvs98ATecWhosmNQ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8430:0:b0:536:5173:a2c6 with
 SMTP id q16-20020aa78430000000b005365173a2c6mr1153309pfn.4.1661378575827;
 Wed, 24 Aug 2022 15:02:55 -0700 (PDT)
Date:   Wed, 24 Aug 2022 15:02:51 -0700
In-Reply-To: <019158db9d2dbb371705ba79a96a907e4a17cdb1.1660576283.git.gitgitgadget@gmail.com>
Message-Id: <20220824220251.1682480-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH 3/5] rebase: factor out merge_base calculation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -1668,7 +1678,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			die(_("Does not point to a valid commit '%s'"),
>  				options.onto_name);
>  	}
> -
> +	if (keep_base) {
> +		oidcpy(&merge_base, &options.onto->object.oid);
> +	} else {
> +		fill_merge_base(&options, &merge_base);
> +	}
>  	if (options.fork_point > 0)
>  		options.restrict_revision =
>  			get_fork_point(options.upstream_name, options.orig_head);

This patch makes sense, except for this part: why is fill_merge_base()
only called for non-keep_base, but it seemed to be unconditionally
called before? For what it's worth, all tests pass even with this diff:

  -       if (keep_base) {
  -               oidcpy(&merge_base, &options.onto->object.oid);
  -       } else {
  -               fill_merge_base(&options, &merge_base);
  -       }
  +       fill_merge_base(&options, &merge_base);
