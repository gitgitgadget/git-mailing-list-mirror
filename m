Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E2320229
	for <e@80x24.org>; Tue,  1 Nov 2016 19:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbcKATQB (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 15:16:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50426 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753280AbcKATP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 15:15:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 731744AD00;
        Tue,  1 Nov 2016 15:15:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XuF5dvrnlBskQ1VwRj0OqlTgVTw=; b=RitGvw
        UMhnPkxZm6I65MsgovwgQLWsLRiYNkL1TOZz5uYAqYne6RNhZuIDUpcmfsMzQ3FY
        aJuQW3CSpPSw0WjCMmtJ3DOofJsepCYa0WvUJutjMF+iCSRzlN1BeJfKkQ1bctsA
        VnrBo3am0j5ahGpcNhtGwkIpyISWfzUxgQjH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OHHnVc35OAP80qxO7Kh/CQsihxJQX2oK
        0O1OUNReF7QHhctiWsC1suXWP7YEJWFVBZEhZgGTxT7We0GlSrr1y/oho7h1dLH+
        XP5Ui+VvUMpavEHb5H3yP7ccm/qX9bSxmCVdhBokvhZYG1EkM+HoW6khVB1Qbn6E
        MDrOs7Mw9UM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B1E44ACFF;
        Tue,  1 Nov 2016 15:15:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC0114ACFE;
        Tue,  1 Nov 2016 15:15:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 11/19] t1700: add tests for splitIndex.maxPercentChange
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-12-chriscool@tuxfamily.org>
Date:   Tue, 01 Nov 2016 12:15:56 -0700
In-Reply-To: <20161023092648.12086-12-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 23 Oct 2016 11:26:40 +0200")
Message-ID: <xmqqd1ifovtf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E4ACC6E-A067-11E6-A343-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t1700-split-index.sh | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 507a1dd..f03addf 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -238,4 +238,76 @@ EOF
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'set core.splitIndex config variable to true' '
> +	git config core.splitIndex true &&
> +	: >three &&
> +	git update-index --add three &&
> +	BASE=$(test-dump-split-index .git/index | grep "^base") &&
> +	test-dump-split-index .git/index | sed "/^own/d" >actual &&
> +	cat >expect <<EOF &&
> +$BASE
> +replacements:
> +deletions:
> +EOF

Using <<-EOF lets us indent the above four lines with a horizontal
tab to align with the remainder of this test_expect_success block,
so let's do that.

