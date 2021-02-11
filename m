Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A32C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 17:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D6664E8A
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 17:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhBKRfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 12:35:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59920 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhBKRdh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 12:33:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D3C9A2341;
        Thu, 11 Feb 2021 12:32:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ObaGOuPc9YmbmG1kWeADQ8B65MI=; b=ll1h0o
        LTbvcEFM4hCHrJguv1GkJ3j6xRihWwDakTtitz+sH32R/gFnDoAVxcjw4fxhkUPl
        ZO6bz5arcWEvddOPbTukbHVq+HxvaEM1rxMamrV/4UZD+iSeaMKlqdhp1WxxbzzI
        /8N0pIJvujHVFBvN16mgz6yQ6lgGF7Mhpur08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pmFDBj/uhcM9ZRwgTt0lPUjcEN1bL0az
        0wohdI1eCNFEr225IhCVDEyzsaEtJcRg20wxr7Sq+RLgfNJwC8JX/Zrzea7+lNwN
        MaYQ4AuwwA5tAUIL+UGlbeij/iAw4WATcAHQSrOC2ENHcO9OPWGAxhX6+enveR0L
        VN0jto8yr2c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53E79A2340;
        Thu, 11 Feb 2021 12:32:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3F12A233F;
        Thu, 11 Feb 2021 12:32:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] commit-graph: when incompatible with graphs, indicate why
References: <pull.875.git.1613057954213.gitgitgadget@gmail.com>
        <aa368496-2875-c383-e862-06e9c587af60@gmail.com>
Date:   Thu, 11 Feb 2021 09:32:37 -0800
In-Reply-To: <aa368496-2875-c383-e862-06e9c587af60@gmail.com> (Derrick
        Stolee's message of "Thu, 11 Feb 2021 11:17:47 -0500")
Message-ID: <xmqq5z2yy0ga.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2252521E-6C8F-11EB-9543-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 2/11/21 10:39 AM, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> When `gc.writeCommitGraph = true`, it is possible that the commit-graph
>> is _still_ not written: replace objects, grafts and shallow repositories
>> are incompatible with the commit-graph feature.
>> 
>> Under such circumstances, we need to indicate to the user why the
>> commit-graph was not written instead of staying silent about it.
>
> This feedback is valuable for these corner cases, especially now
> that the commit-graph is getting less and less "optional" as time
> goes on.
>
>> +		if (hashmap_get_size(&r->objects->replace_map->map)) {
>> +			warning(_("repository contains replace objects; "
>> +			       "skipping commit-graph"));
> ...
>> +		warning(_("repository is shallow; skipping commit-graph"));
>
> These warnings make sense to me.

I take that as your Acked-by.

Thanks, both.
