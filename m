Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9491F406
	for <e@80x24.org>; Wed,  3 Jan 2018 22:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeACWIY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 17:08:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51731 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750979AbeACWIU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 17:08:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B553D2864;
        Wed,  3 Jan 2018 17:08:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RF7YsbFy1La0eF/MuWBNaschGVc=; b=MuYVIO
        rf4D2Sw/X/b0KP1dvlkyuvbL7ljUHGcXm8BdUYfEQT3/qRAaRQJu0PdE8HBlRHtf
        dIdcsTnjvDd0dAYQYJx7Aj15merJpSF/R/iQ4PPK7OkA+xW5B5yCYV9UQNUnmrhX
        2q8c3EH+E0wShvdt+y5X47HF7JBoYBRB3y6Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XWIQoqFXnNuRXK8YS9ZcNH7z+mkobKsh
        0jpaIzq+ySOifurzKEd4k1NftQg+wMMMbiCVl0qYlxdoRmTG9/C9dC5f6XyoCQj4
        U/E65LR5Ybwzhm8MIeS9e1stPABES1Yvu6Z2PKiU1OOQtCB64oIe3r+AB8v3RKpG
        e22EN2DvkdA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7143CD2863;
        Wed,  3 Jan 2018 17:08:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB7C1D2861;
        Wed,  3 Jan 2018 17:08:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] diff: properly error out when combining multiple pickaxe options
References: <20180103004624.222528-1-sbeller@google.com>
        <20180103004624.222528-6-sbeller@google.com>
Date:   Wed, 03 Jan 2018 14:08:17 -0800
In-Reply-To: <20180103004624.222528-6-sbeller@google.com> (Stefan Beller's
        message of "Tue, 2 Jan 2018 16:46:24 -0800")
Message-ID: <xmqq7esyh9ym.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9ACEF21A-F0D2-11E7-AA23-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

;
> +	count = 0;
> +
> +	if (options->pickaxe_opts & DIFF_PICKAXE_KIND_S)
> +		count++;
> +	if (options->pickaxe_opts & DIFF_PICKAXE_KIND_G)
> +		count++;
> +	if (options->pickaxe_opts & DIFF_PICKAXE_KIND_OBJFIND)
> +		count++;
> +	if (count > 1)
> +		die(_("-G, -S, --find-object are mutually exclusive"));

I thought the reason you defined pickaxe-kind bitmask was so that
you can mask this field to grab these (and only these) bits.
Once you have that mask, you should be able to use HAS_MULTI_BITS()
on the masked result without counting, no?
