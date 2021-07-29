Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EA2C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4F060ED4
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhG2Tqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:46:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65321 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhG2Tqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:46:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CB06E24D7;
        Thu, 29 Jul 2021 15:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IU8ptNa9BaQEpV3B0KFk7S/fIdGeqfOsIlFQtB
        GKdXU=; b=ygML9XbxE9THbS4bWZ+HN8DFimj7Qjv4t3z+9PBf2Y/YfzJQdj6reb
        hTXf+BiK5G6lSFQHIRxW6yuOyQacsCsCe887pugZ+XIeP9gVKviR0bAJVioeujKF
        dGcvPcmzSeyHtNkL16xQPC4mvBytrCtZPVDEpudzM7Si4lLqBsVOk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23B55E24D6;
        Thu, 29 Jul 2021 15:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0720E24D5;
        Thu, 29 Jul 2021 15:46:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/7] Final optimization batch (#15): use memory pools
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
        <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
        <YQLVPN9n5E1Yvi/q@coredump.intra.peff.net>
        <YQLV/MTQ+MkxUBSn@coredump.intra.peff.net>
Date:   Thu, 29 Jul 2021 12:46:47 -0700
In-Reply-To: <YQLV/MTQ+MkxUBSn@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 29 Jul 2021 12:23:24 -0400")
Message-ID: <xmqq1r7g6gyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B67BA824-F0A5-11EB-9E4D-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 29, 2021 at 12:20:13PM -0400, Jeff King wrote:
>
>> I assume your tests are just done using the regular glibc allocator. I
>> also wondered how plugging in a better allocator might fare. Here are
>> timings I did of your mega-renames case with three binaries: one built
>> with USE_MEMORY_POOL set to 0, one with it set to 1, and one with it set
>> to 0 but adding "-ltcmalloc" to EXTLIBS via config.mak.
>
> Oh, btw, I wasn't able to apply your series from the list on top of
> en/ort-perf-batch-14 (there are some problems in patch 4, and "am -3"
> says my clone of git.git is missing some of the pre-image sha1s). I
> fetched ort-perf-batch-15 from https://github.com/newren/git and timed
> that, which I imagine is the same. But you may need to tweak the patches
> so that Junio can pick them up.

Thanks, but the batch #15 has been in 'seen' since 23rd ;-)
