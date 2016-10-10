Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380DE20989
	for <e@80x24.org>; Mon, 10 Oct 2016 22:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbcJJW4S (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 18:56:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63910 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751743AbcJJW4R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 18:56:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D9214489D;
        Mon, 10 Oct 2016 18:56:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gdl93/UYoozFnJ7D3aWNdA8A5I0=; b=wgd0is
        3IL+/ikMdnvAII4aNli9sPIcsm3caSqqXdDvH57dYdZE7UiBbfcJKCE6+p06wOmb
        ZsFYcIAoASBF/irqoVhA6pWi1Yjry7jqU24PCd0yudBVWiRx9M6cfiVos890y8O4
        xd+u6IGP9g7BCJaMVRfl584HRmSpSuUG4QuzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TaWgFmSK476xzaQMcQG3JEl0iYD3/Rvg
        +v5SwocNG41dR4TDW1NIi9pICG8Js/7k3wdGKMpoFUfTj1LLqZj9kndIBE76IhqL
        zWXsuZ+5DX1bf1TtWCrLcZbjiEVE152q1Hbw5bEEV6uQQqipPrGmjzMOWivDe2YJ
        jdC+c8bZnkM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 057D14489C;
        Mon, 10 Oct 2016 18:56:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79C894489B;
        Mon, 10 Oct 2016 18:56:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org, Jens.Lehmann@web.de,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 3/3] batch check whether submodule needs pushing into one call
References: <cover.1475851621.git.hvoigt@hvoigt.net>
        <cover.1475851621.git.hvoigt@hvoigt.net>
        <67d4c48dc0129f20041c88d27a49c7a21188c882.1475851621.git.hvoigt@hvoigt.net>
Date:   Mon, 10 Oct 2016 15:56:13 -0700
In-Reply-To: <67d4c48dc0129f20041c88d27a49c7a21188c882.1475851621.git.hvoigt@hvoigt.net>
        (Heiko Voigt's message of "Fri, 7 Oct 2016 17:06:36 +0200")
Message-ID: <xmqqlgxvbype.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF8AF55C-8F3C-11E6-8FBC-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> -static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
> +static int check_has_hash(const unsigned char sha1[20], void *data)
>  {
> -	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
> +	int *has_hash = (int *) data;
> +
> +	if (!lookup_commit_reference(sha1))
> +		*has_hash = 0;
> +
> +	return 0;
> +}
> +
> +static int submodule_has_hashes(const char *path, struct sha1_array *hashes)
> +{
> +	int has_hash = 1;
> +
> +	if (add_submodule_odb(path))
> +		return 0;
> +
> +	sha1_array_for_each_unique(hashes, check_has_hash, &has_hash);
> +	return has_hash;
> +}
> +
> +static int submodule_needs_pushing(const char *path, struct sha1_array *hashes)
> +{
> +	if (!submodule_has_hashes(path, hashes))
>  		return 0;

Same comment about naming.  

What do check-has-hash and submodule-has-hashes exactly mean by
"hash" in their names?  Because I think what is checked here is
"does the local submodule repository have _all_ the commits
referenced from the superproject commit we are pushing?", so I'd
prefer to see "commit" in their names.

If we do not even have these commits locally, then there is no point
attempting to push, so returning 0 (i.e. it is not "needs pushing"
situation) is correct but it is a but subtle.  It's not "we know
they already have them", but it is "even if we tried to push, it
won't do us or the other side any good."  A single-liner in-code
comment may help.

Thanks.
