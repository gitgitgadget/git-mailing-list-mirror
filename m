Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160581F859
	for <e@80x24.org>; Thu, 25 Aug 2016 18:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbcHYSOw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 14:14:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57457 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754179AbcHYSOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 14:14:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA32937820;
        Thu, 25 Aug 2016 14:06:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9p3mqOBk8l7FLQyO2w7wMnlhCqI=; b=KCQVcr
        DMDxw4NLDHyfumdeFyOHPuVv4E/vng7ftLPUaUK1SxoZzIlJEsgWAJRZTIAXtRwH
        IRIsbjXVRAnMu+BhKwQdXpJpGcuaTS4y27za5nMYaIlCcGKpvKnQ9sOIlf7qR66P
        eU9w73khOexXxVmTC72PvkZLYIe2JIo64u8oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=roEFyn4HehVTJ9rFqBHhE1gtMFOzz59X
        riqHa0agKoLlpjtzX/LZi2tggC2l7TWxkOTKpiWP8P85GFMKhHcCS1EDECOh5W/Y
        BDK0uy9BcN7ishuhYlGi9LGAcUjyTcJdytiL0x+SnLEFFsLhhB5rCAjq1NXXWsRX
        EUaLkv546S0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E13123781F;
        Thu, 25 Aug 2016 14:06:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F008A3781C;
        Thu, 25 Aug 2016 14:06:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 12/27] bisect--helper: `get_terms` & `bisect_terms` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6b3-3ccd9de5-604d-4e7d-919d-a3adae869ebf-000000@eu-west-1.amazonses.com>
Date:   Thu, 25 Aug 2016 11:05:58 -0700
In-Reply-To: <01020156b73fe6b3-3ccd9de5-604d-4e7d-919d-a3adae869ebf-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqqmvk0n2pl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94A4D514-6AEE-11E6-9A52-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
> +{
> +	int i;
> +
> +	if (get_terms(terms)) {
> +		fprintf(stderr, _("no terms defined\n"));
> +		return -1;
> +	}
> +	if (argc == 0) {
> +		printf(_("Your current terms are %s for the old state\nand "
> +		       "%s for the new state.\n"), terms->term_good.buf,
> +		       terms->term_bad.buf);
> +		return 0;
> +	}
> +
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(argv[i], "--term-good"))
> +			printf("%s\n", terms->term_good.buf);
> +		else if (!strcmp(argv[i], "--term-bad"))
> +			printf("%s\n", terms->term_bad.buf);
> +		else
> +			printf(_("invalid argument %s for 'git bisect "
> +				  "terms'.\nSupported options are: "
> +				  "--term-good|--term-old and "
> +				  "--term-bad|--term-new."), argv[i]);
> +	}

The original took only one and gave one answer (and errored out when
the user asked for more), but this one loops.  I can see either way
is OK and do not think of a good reason to favor one over the other;
unless there is a strong reason why you need this extended behaviour
that allows users to ask multiple questions, I'd say we should keep
the original behaviour.

