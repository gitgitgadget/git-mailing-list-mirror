Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71421F4B7
	for <e@80x24.org>; Tue,  3 Sep 2019 21:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfICV01 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 17:26:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55506 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICV00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 17:26:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C80BB1910D;
        Tue,  3 Sep 2019 17:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XjHAoJyAGw2T6BofdLXFKRvak7I=; b=MmZx5G
        AOU+L9jtQeEv3QWscZwsHm/AWWmrrDPKkatFwZdU/ksz4Kp07b1YiBERPcRHcfxq
        rjqCiA2eb4knlBKG22I2zMN8ILkLOS8C7dhcG/gKpsNicMlf/z6ENLkIeHZxSSSr
        /3zbusIfarzHCCQ3J44PAIQK30onxeUVJ9DPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JtwJLyvYuvGliy1M33pHXxKuo/83Bn25
        e+2MunHVR5OgQonI2tBTwcMJY2j2rt1qyi97rBVX0vTpJiWSIH1DmBkJpAuu68M0
        FrG8TtdwFl4kdO8iMFcxNs4gs65+DBeoLpYZP4CqfaAKdrjmoWcZpJe5BKSAJADb
        uq5zG0IdK1E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDCCC1910C;
        Tue,  3 Sep 2019 17:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA64A1910B;
        Tue,  3 Sep 2019 17:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 2/4] t3427: accelerate this test by using fast-export and fast-import
References: <20190828002210.8862-1-newren@gmail.com>
        <20190903185524.13467-1-newren@gmail.com>
        <20190903185524.13467-3-newren@gmail.com>
Date:   Tue, 03 Sep 2019 14:26:22 -0700
In-Reply-To: <20190903185524.13467-3-newren@gmail.com> (Elijah Newren's
        message of "Tue, 3 Sep 2019 11:55:22 -0700")
Message-ID: <xmqqsgpdrs01.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AF2F0A6-CE91-11E9-B007-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +extract_files_subtree () {
> +	git fast-export --no-data HEAD -- files_subtree/ |
> +		sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" |
> +		git fast-import --force --quiet
> +}

Clever, if a bit filthy ;-).  We expect to see something like

	M 100644 dead...beef files_subtree/bar
	M 100755 c0f.....fee files_subtree/foo

in the --no-data output, and the assumption here is that 40-hex
followed by " files_subtree/" would never appear anywhere in the
stream other than these tree dump, so the sed script can rewrite
the above to

	M 100644 dead...beef bar
	M 100755 c0f.....fee foo

by getting rid of the leading directory name (plus the slash at the
end).

Thanks.
