Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746CC4332D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246D723122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437050AbhALVh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52721 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437095AbhALU74 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:59:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 575629D542;
        Tue, 12 Jan 2021 15:59:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JKxuDHiGTQ1souFqFlQeO03bvNE=; b=L0AaEf
        NH4AbqBYgPdaMDdT4wYD9Ywub0J4cc0ZDNiqX5/oLzycq04xH39EE4F07wEXsS+z
        PEZd/SoqOPe78vkGYbcIBlFxG76a38N/wTbrMb3sq5AHIDtT7t4CHVYnF70uJ6YP
        uCq1MS8n8kx5fZG7xnJsMwFep3k20mqvvm+Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=crTpGf6hPKFELCI+gzNDSDaPSR+Z0qsu
        hZff5TK3lOUnSq0kFpvrYSNBxxdp6pc9EZsd7JiMe0SPpWUo93EmsvHDR8fLfdeS
        ShHm3zUe82QMaQ9WD1LMAB/3Wtz36SpnflnL9/vcVOuq6/O069aipE6j0HA6vspT
        huezWzXzoOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ED839D541;
        Tue, 12 Jan 2021 15:59:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC8539D540;
        Tue, 12 Jan 2021 15:59:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] fetch-pack: refactor writing promisor file
References: <20210112082159.2277214-1-chriscool@tuxfamily.org>
        <20210112082159.2277214-2-chriscool@tuxfamily.org>
Date:   Tue, 12 Jan 2021 12:59:13 -0800
In-Reply-To: <20210112082159.2277214-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 12 Jan 2021 09:21:59 +0100")
Message-ID: <xmqqwnwh3m8u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 069F534C-5519-11EB-AB27-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
> +{
> +	int i;
> +	FILE *output = xfopen(promisor_name, "w");
> +
> +	for (i = 0; i < nr_sought; i++)
> +		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
> +			sought[i]->name);
> +	fclose(output);
> +}

Ah, nevermind.  This has its output format baked into the code and
it wants to show object name and which ref it is on, so as long as
we are happy with the format (do we read the contents and use it in
any way, by the way?), it is reasonable to expect any new caller to
have "struct ref" or an array of it.

Thanks.
