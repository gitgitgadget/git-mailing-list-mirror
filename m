Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2DF51F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 02:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfJCCLY (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 22:11:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50960 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfJCCLY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 22:11:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 621B084BBA;
        Wed,  2 Oct 2019 22:11:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=29UTmm0rGryBe3W9BHUTTjnbHaw=; b=QmHD/U
        2o69LmmpGaQd0mhmlAbv5jc3STtakpggUSk3byknXadeIzEXDWYr0ZxES+3zRnPE
        BaveCBu84mtA/BYUwO584CepYH9AC3e0XBY43eDi6eOh59LJ9hXTTjsuLHXyqgMK
        iInV/bHeeiM339GRV0uiN1kbTYSZuWIWoLLTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fD2oNB25tiFZ9azGe/2iWzOUB3AoI4xx
        HhtffEEtDtzvzPQ5Qg7VzcuzXbN+J1aZRmKkL1G9GU2wvh2NZ7dv6Obbu68ds9L9
        VCOQGunp8rUBez+9A6ZLyvnQAtJYrnuZVvYU9mzSK3/V0SpJDqA8JvnXgp9dCODY
        /lfedmlMUbc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44FBD84BB9;
        Wed,  2 Oct 2019 22:11:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 70D1184BB8;
        Wed,  2 Oct 2019 22:11:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] range-diff: internally force `diff.noprefix=true`
References: <pull.373.git.gitgitgadget@gmail.com>
        <pull.373.v2.git.gitgitgadget@gmail.com>
        <9993a607beaafc66f72e1be3f158074cd121b4bb.1570050645.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Oct 2019 11:11:17 +0900
In-Reply-To: <9993a607beaafc66f72e1be3f158074cd121b4bb.1570050645.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 02 Oct 2019
        14:10:47 -0700 (PDT)")
Message-ID: <xmqq1rvud1dm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16A32734-E583-11E9-9E8C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When parsing the diffs, `range-diff` expects to see the prefixes `a/`
> and `b/` in the diff headers.
>
> These prefixes can be forced off via the config setting
> `diff.noprefix=true`. As `range-diff` is not prepared for that
> situation, this will cause a segmentation fault.
>
> Let's avoid that by passing the `--no-prefix` option to the `git log`
> process that generates the diffs that `range-diff` wants to parse.
> And of course expect the output to have no prefixes, then.

Looks good.  Thanks.
