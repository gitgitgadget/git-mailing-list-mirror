Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF55C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 00:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A9722795
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 00:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhAXAWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 19:22:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63215 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbhAXAWu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 19:22:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 245AB11AE12;
        Sat, 23 Jan 2021 19:22:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zxb52/4BPvLzmnMP7lCb67VRwD8=; b=C7e1yU
        4HZUbGBjcrRKqw9FgdxpK+h4vIw5DtfPIVa1K0hMaLGEfpcSOtJjnynZwq52Daqj
        S9Y3ph0pycf/fIGnQEvPXfA806yqtxylvhPQpbOZlomGAuXeYRsmRsBjZC3gfnNN
        f4JDSKwaBklWD8YN/AHpyni4FOgMWjO23uD1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hv40rE/bF2f5FFlQJcgpW/VNBg5SLZaZ
        3Z40oQ+ZaVZffYjGecazaQIJgl5BWYkR7t8Dpx6RCT+oXG88ZkhDk+tNzuNAvFaO
        JVt5EMOCm9g/XgxapL6wC+ShNn8kP8wzfSjqORbAPruS30FddiH08D4/q047fInh
        tYZAOgh3DGA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CF3111AE11;
        Sat, 23 Jan 2021 19:22:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 633BE11AE10;
        Sat, 23 Jan 2021 19:22:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v3 2/7] bisect--helper: reimplement `bisect_replay`
 shell function in C
References: <20210123154056.48234-1-mirucam@gmail.com>
        <20210123154056.48234-3-mirucam@gmail.com>
Date:   Sat, 23 Jan 2021 16:22:03 -0800
In-Reply-To: <20210123154056.48234-3-mirucam@gmail.com> (Miriam Rubio's
        message of "Sat, 23 Jan 2021 16:40:51 +0100")
Message-ID: <xmqq35yr2nh0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FFB4006-5DDA-11EB-A00B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Reimplement the `bisect_replay` shell function in C and also add
> `--bisect-replay` subcommand to `git bisect--helper` to call it from
> git-bisect.sh
> ...
> +static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
> +{
> +	const char *p = line->buf + strspn(line->buf, " \t");
> +
> +	if ((!skip_prefix(p, "git bisect", &p) &&
> +	!skip_prefix(p, "git-bisect", &p)) || !isspace(*p))
> +		return 0;
> +	p += strspn(p, " \t");
> +
> +	char *word_end = (char*)p + strcspn(p, " \t");
> +	char *rev = word_end + strspn(word_end, " \t");

Are these lines new in this round?

These break builds with -Werror=declaration-after-statement.

