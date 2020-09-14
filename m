Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF11C2BBD1
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34954215A4
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d8tTOF2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgINUby (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:31:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59887 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgINUbv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:31:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C9216A15B;
        Mon, 14 Sep 2020 16:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Kag+LWQi2Jz1oxF4rPLvh95sY44=; b=d8tTOF2TbTiSn1vQsT7P
        oFN4CqDiEFXRZiLXRS7pjT6hz635Rh1AZKAw4Gu7HX7zAAa4zNHxNVxg7XYSr6td
        tb4/Yrz12kF12YJQKg4YneY9K+7w5K+tmpSL5xQc13tN4VlNLbIPLaZFeeKgef/I
        djBGF/CNm6XrBIowBBJUvqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=bmbcB8hVZNLsZMNjkG3htXtFEjlScMGkvil+BJR4I480BD
        anxdZ+KPZwA58msc0SU7487/vkqIsbtcBW89b67GeuJgLtmEwY2Q9Eo59BfMwXe6
        l85AO45V3/m0zKyAddHG6asL8KViB8VgjofXCsPqaZmB97C4BcMowgRF6/1wk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 940256A159;
        Mon, 14 Sep 2020 16:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27DB06A157;
        Mon, 14 Sep 2020 16:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/7] remote: add reflog check for "force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
        <20200913145413.18351-2-shrinidhi.kaushik@gmail.com>
Date:   Mon, 14 Sep 2020 13:31:47 -0700
Message-ID: <xmqq5z8gje18.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50265A00-F6C9-11EA-A74E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> The struct "ref" has three new bit-fields:
>   * if_includes: Set when we have to run the new check on the ref.
>   * is_tracking: Set when the remote ref was marked as "use_tracking"
>                  or "use_tracking_for_rest" by compare-and-swap.

... meaning that --force-with-lease with an explicit "the tip must
still be at this exact commit" won't use the extra check to loosen
the condition?  That sounds sensible.

>   * unreachable: Set if the ref is unreachable from any of the "reflog"
>                  entries of its local counterpart.

The same comment applies on "reflog of which branch should we
check"; I suspect that checking HEAD and without checking merge base
may prove to be a good way to go.

> + */
> +void apply_push_force_if_includes(struct ref*, int);

SP between ref and '*'?
