Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECB7C54EAA
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 09:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbjAZJQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 04:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbjAZJQh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 04:16:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505735AB6A
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 01:16:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u186-20020a2560c3000000b007c8e2cf3668so1276928ybb.14
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 01:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ML31MY5qC32drBIi7aZq92GZ3Y4zD2RvC6r4nnV83KU=;
        b=e+dAWLaRO7bblvmj9lxw4h2PMqSGLVaEhze8qtjtH4UojgCZ1399VC+sUpnBOwSsxB
         hKV8q5X58OEMrJCyOpx9xFwna2uhYTKQo/JHhMNaukpu6goLD3EQ9TB2s4fpnKCNmKQq
         GdwADThERLdrl9H7GFZ7e02QNKnSD81ohNbZtjLBiV32BDB+egY2pv1vUOHb7cpCSLl6
         S5/X53kFSgqa2P9p4Ia9A72oLkCQYJlGo+6PGaAKxNam8Jj5ssX66cB0saz3YZVdnkhJ
         DVkPa4s8Tt1VzDEcslnugBtW0ZkFwLb3q5FFqyU5t3TuyCpWFAjwVd77mKVmqruendtI
         +ScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ML31MY5qC32drBIi7aZq92GZ3Y4zD2RvC6r4nnV83KU=;
        b=lKjjK09bzHUy08VKLRdsHhfICSllYbfoGR8rOjfxJxY5GZmV/xuhjyNR+tCdfB9mu6
         E9//PBRpGXHImc9bvI6BglpoIuBXC3khu8zEG9gPpSDsZ7toH7FVMvPBcrX1hUyHHPTk
         JssD+n2V3W5yOICrhsrgX2dIz4KOZrXpUIYd0An/xCDSUUwF7ie/rVlnCqyR4S0YhhM7
         pX8V9m02QzBu2ZxAr+VtsO2B0/U/uSyMrqFiEsnwZm3rmX44sG/i3IcF8oN9k7wXaVzc
         WbaNXF8PQC6Ix1eYIrLO+VCkg3iuDltRzJs72DQhOyh8WYiYFMrAVrYWO0QjVNJRB4C0
         BLjw==
X-Gm-Message-State: AO0yUKXSk80oRw1NCVNSs1sR2+MehIwiM+kBoW3OQgGHPVoipkotb4Of
        z3HvpQGR2+W0PZaZmxq1PBTV3eZEsNBL8A==
X-Google-Smtp-Source: AK7set/4QKEzmen47JsRTwKmrV12GHLTBg/fYtdkqozb6jxvbf2jjpNde2yfLryoPYWzSw82rTA7VRjoJVG6pg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:86c2:0:b0:80b:7e2e:f94 with SMTP id
 y2-20020a2586c2000000b0080b7e2e0f94mr839755ybm.273.1674724595542; Thu, 26 Jan
 2023 01:16:35 -0800 (PST)
Date:   Thu, 26 Jan 2023 17:16:33 +0800
In-Reply-To: <20230117193041.708692-6-calvinwan@google.com>
Mime-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com> <20230117193041.708692-6-calvinwan@google.com>
Message-ID: <kl6lilgtveoe.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 5/6] diff-lib: parallelize run_diff_files for submodules
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Calvin Wan <calvinwan@google.com> writes:

> @@ -226,6 +242,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			newmode = ce->ce_mode;
>  		} else {
>  			struct stat st;
> +			unsigned ignore_untracked = 0;
> +			int defer_submodule_status = !!revs->repo;

What is the reasoning behind this condition? I would expect revs->repo
to always be set, and we would always end up deferring.

>  			newmode = ce_mode_from_stat(ce, st.st_mode);
> +			if (defer_submodule_status) {
> +				struct submodule_status_util tmp = {
> +					.changed = changed,
> +					.dirty_submodule = 0,
> +					.ignore_untracked = ignore_untracked,
> +					.newmode = newmode,
> +					.ce = ce,
> +					.path = ce->name,
> +				};
> +				struct string_list_item *item;
> +
> +				item = string_list_append(&submodules, ce->name);
> +				item->util = xmalloc(sizeof(tmp));
> +				memcpy(item->util, &tmp, sizeof(tmp));

(Not a C expert) Since we don't return the string list, I wonder if we
can avoid the memcpy() by using &tmp like so:

  struct string_list_item *item;
  item = string_list_append(&submodules, ce->name);
  item->util = &tmp;

And then when we call string_list_clear(), we wouldn't need to free the
util since we exit the stack frame.

> +test_expect_success 'diff in superproject with submodules respects parallel settings' '
> +	test_when_finished "rm -f trace.out" &&
> +	(
> +		GIT_TRACE=$(pwd)/trace.out git diff &&
> +		grep "1 tasks" trace.out &&
> +		>trace.out &&
> +
> +		git config submodule.diffJobs 8 &&
> +		GIT_TRACE=$(pwd)/trace.out git diff &&
> +		grep "8 tasks" trace.out &&
> +		>trace.out &&
> +
> +		GIT_TRACE=$(pwd)/trace.out git -c submodule.diffJobs=0 diff &&
> +		grep "preparing to run up to [0-9]* tasks" trace.out &&
> +		! grep "up to 0 tasks" trace.out &&
> +		>trace.out
> +	)
> +'
> +

Could we get tests to check that the output of git diff isn't changed by
setting parallelism? This might not be feasible for submodule.diffJobs >
1 due to raciness, but it would be good to see for submodule.diffJobs =
1 at least.

>  test_expect_success 'git diff --raw HEAD' '
>  	hexsz=$(test_oid hexsz) &&
>  	git diff --raw --abbrev=$hexsz HEAD >actual &&
> diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
> index d050091345..52a82b703f 100755
> --- a/t/t7506-status-submodule.sh
> +++ b/t/t7506-status-submodule.sh
> @@ -412,4 +412,23 @@ test_expect_success 'status with added file in nested submodule (short)' '
>  	EOF
>  '
>  
> +test_expect_success 'status in superproject with submodules respects parallel settings' '
> +	test_when_finished "rm -f trace.out" &&
> +	(
> +		GIT_TRACE=$(pwd)/trace.out git status &&
> +		grep "1 tasks" trace.out &&
> +		>trace.out &&
> +
> +		git config submodule.diffJobs 8 &&
> +		GIT_TRACE=$(pwd)/trace.out git status &&
> +		grep "8 tasks" trace.out &&
> +		>trace.out &&
> +
> +		GIT_TRACE=$(pwd)/trace.out git -c submodule.diffJobs=0 status &&
> +		grep "preparing to run up to [0-9]* tasks" trace.out &&
> +		! grep "up to 0 tasks" trace.out &&
> +		>trace.out
> +	)
> +'
> +

Ditto for "status".
