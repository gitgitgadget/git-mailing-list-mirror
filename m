Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20DCECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 20:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIPUPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 16:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiIPUPN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 16:15:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED652D1F1
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 13:15:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 854721BA7DA;
        Fri, 16 Sep 2022 16:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qrYZVLkim2/6w1KzCET694fXEVlWysm3+OFt1I
        Qvs/o=; b=OZG3UfCU7Ra65+1FCjcnkbTDAQhVgOHLTqLDx+Ayk07nb0TgXn/3RL
        QtINE6uQOwqexKAQUyi1dEkL3lntxfSSfLHaYQcP/AqycqvRfS2xVw5d+bVFBV9t
        NXU/x6c6dYfeFqaAcO36jDUkeBsB7785PDwlcGFmRPChx/Tc4bmuI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D69D1BA7D9;
        Fri, 16 Sep 2022 16:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1F4C41BA7D8;
        Fri, 16 Sep 2022 16:15:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v7 5/6] fsmonitor: deal with synthetic firmlinks on macOS
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
        <4d00adb1deb61c3af58bed81271dd3337db7037e.1663358014.git.gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 13:15:05 -0700
In-Reply-To: <4d00adb1deb61c3af58bed81271dd3337db7037e.1663358014.git.gitgitgadget@gmail.com>
        (Eric DeCosta via GitGitGadget's message of "Fri, 16 Sep 2022 19:53:33
        +0000")
Message-ID: <xmqqtu57f54m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41DE1040-35FC-11ED-AA30-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Starting with macOS 10.15 (Catalina), Apple introduced a new feature
> called 'firmlinks' in order to separate the boot volume into two
> volumes, one read-only and one writable but still present them to the
> user as a single volume. Along with this change, Apple removed the
> ...
> Therefore, in order to deal with synthetic firmlinks, the root directory
> is scanned and the first possible synthetic firmink that, when resolved,
> is a prefix of the worktree is used to map FSEvents paths to worktree
> paths.

The proposed log message for this step seems fairly similar to the
previous one.

> diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
> index e24838f9a86..98cbb430083 100644
> --- a/fsmonitor--daemon.h
> +++ b/fsmonitor--daemon.h
> @@ -170,5 +170,8 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
>   */
>  void fsmonitor_force_resync(struct fsmonitor_daemon_state *state);
>  
> +char *fsmonitor_resolve_alias(const char *path,
> +	struct alias_info *alias);
> +

After applying all the 6 steps, this function is declared here
without any implementation.  Should we drop this step, I have to
wonder.

Thanks.
