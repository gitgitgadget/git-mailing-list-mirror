Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFECC433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 22:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3B522B2D
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 22:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgLVWqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 17:46:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55054 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgLVWqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 17:46:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF92F914D6;
        Tue, 22 Dec 2020 17:45:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WQ3BCY9cBfrh
        ZU72LvSvjLL0Hos=; b=uOzl3A6ZO7BnsD0n9vOMoqRValeCFA+qlRAtLWmz3x4D
        mob5V7pf/30war+9SBNY3XK6gVB20TywsOin9EKFaav2I1uYlTf4Byjcv+XgFZwP
        0YYa8N8B5cdOFKg4eWyTHSHkb3j/3KD86pm/LbZpBAHdkiGuu3WrZf/nT7KRQ+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MtgfGz
        S0pJ2tardTt03bfrOWTOOUsHPMz34Q7/DauoS85HzFkExIwhK+LLRvCO9op0bsBC
        6gPM4jBZ6B5H2LvR/xuavTfZWjwO/7kpXv/slN9ssoX8SUB+kXcoca/nrsWTB8kT
        ImEtdF0Ukne8nMRFkkv1hYaQBexld/DlOuHeA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A80D6914D5;
        Tue, 22 Dec 2020 17:45:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E64A0914D4;
        Tue, 22 Dec 2020 17:45:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] gc: fix handling of crontab magic markers
References: <cover.1608585497.git.martin.agren@gmail.com>
        <689d3150e9822eeccac0e1d07c2ba26dac47b4c9.1608585497.git.martin.agren@gmail.com>
Date:   Tue, 22 Dec 2020 14:45:30 -0800
In-Reply-To: <689d3150e9822eeccac0e1d07c2ba26dac47b4c9.1608585497.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 21 Dec 2020 22:26:32
 +0100")
Message-ID: <xmqqsg7xfoj9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 64FF26D8-44A7-11EB-8D1F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On `git maintenance start`, we add a few entries to the user's cron
> table. We wrap our entries using two magic markers, "# BEGIN GIT
> MAINTENANCE SCHEDULE" and "# END GIT MAINTENANCE SCHEDULE". At a later
> `git maintenance stop`, we will go through the table and remove these
> lines. Or rather, we will remove the "BEGIN" marker, the "END" marker
> and everything between them.
>
> Alas, we have a bug in how we detect the "END" marker: we don't. As we
> loop through all the lines of the crontab, if we are in the "old
> region", i.e., the region we're aiming to remove, we make an early
> `continue` and don't get as far as checking for the "END" marker. Thus,
> once we've seen our "BEGIN", we remove everything until the end of the
> file.
>
> Rewrite the logic for identifying these markers. There are four cases
> that are mutually exclusive: The current line starts a region or it end=
s
> it, or it's firmly within the region, or it's outside of it (and should
> be printed).
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  t/t7900-maintenance.sh | 7 +++++++
>  builtin/gc.c           | 7 +++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index d1e0c8f830..4bbfce31e9 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -446,6 +446,13 @@ test_expect_success 'start preserves existing sche=
dule' '
>  	grep "Important information!" cron.txt
>  '
> =20
> +test_expect_success 'stop preserves surrounding schedule' '
> +	echo "Crucial information!" >>cron.txt &&
> +	GIT_TEST_CRONTAB=3D"test-tool crontab cron.txt" git maintenance stop =
&&

31345d55 (maintenance: extract platform-specific scheduling,
2020-11-24) in ds/maintenance-part-4 needs to adjust this
exported variable for the tests to pass in 'seen'

Is it just the matter of replacing it with

	GIT_TEST_MAINT_SCHEDULER=3D"crontab:test-tool crontab ..."

or is there more to it?

Thanks
