Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6831F463
	for <e@80x24.org>; Thu, 12 Sep 2019 18:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfILSSM (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 14:18:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51559 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfILSSM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 14:18:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63F7326655;
        Thu, 12 Sep 2019 14:18:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NFx1yGN8Q5FKyGgLSuwkwVopzvU=; b=B3xSff
        OYplX6n2T+UWlQb21viNXKv9Glst0JIpw66qmLD9XxBKPBQ0U4goXKuvJE0Ng1Hm
        fkVsaurH7g7ifxUu+AVZWTpX0tooiqjXrv5utt+FTBBo5wrDLnc2MKzgCA3uCW0y
        4GcUCXCMHCT1ELecOBH2pyIokqpTTcATR5V+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tkf9GHaUJPZkfeIi/mfhj3Oh9Sh3u75H
        1LdEc/uUYHpp1E9SJzDoDSmK5nibo3nCsL7FxWtvdrVYJnSVln05O2HDgbBiJpVy
        ndZjjCVIOBTdEaJjkOwO4tuJKD8T20htPH6Jvy2pLu1er0SAmrZItoNC3ndEbDBE
        MQ3BX+iijq4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FBFB26654;
        Thu, 12 Sep 2019 14:18:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7571826653;
        Thu, 12 Sep 2019 14:18:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] Makefile: strip leading ./ in $(FIND_SOURCE_FILES)
References: <cover.1568101393.git.liu.denton@gmail.com>
        <cover.1568309119.git.liu.denton@gmail.com>
        <239ffa690cc0bf65e2ee7fbdbb9c481499e37020.1568309119.git.liu.denton@gmail.com>
Date:   Thu, 12 Sep 2019 11:18:03 -0700
In-Reply-To: <239ffa690cc0bf65e2ee7fbdbb9c481499e37020.1568309119.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 12 Sep 2019 10:28:32 -0700")
Message-ID: <xmqqzhj9fkf8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA3EB5D0-D589-11E9-BB82-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Unify the two possible invocations in $(FIND_SOURCE_FILES) by using sed
> to remove the `./` prefix in the $(FIND) case.

> diff --git a/Makefile b/Makefile
> index b88b42d7ed..e2c693440b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2610,6 +2610,7 @@ FIND_SOURCE_FILES = ( \
>  		-o \( -name 'trash*' -type d -prune \) \
>  		-o \( -name '*.[hcS]' -type f -print \) \
>  		-o \( -name '*.sh' -type f -print \) \
> +		| sed -e 's|^\./||' \
>  	)
>  
>  $(ETAGS_TARGET): FORCE

An extra process and piping is a bit unfortunate, but this is purely
a fallback position where it does not matter too much to expend
one-shot overhead; it would only be needed until the user has a
working "git ls-files" and starts hacking on our codebase, as this
is used only by the xtags targets, which are only for developers.

Thanks.  Will queue.


