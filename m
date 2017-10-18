Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8025A1FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 01:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755192AbdJRBEH (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 21:04:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58996 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754127AbdJRBEG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 21:04:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D69A49EB23;
        Tue, 17 Oct 2017 21:04:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I5TEqbsMdAvC6KBtqHcfN/uPUhg=; b=IV0tS1
        cDLY++Qlps9I5lHU+RT0d2YwRC3981wQEITKN8vCgsyCCfaIzAfBf5uB92dWMN2d
        T7Izwvakwuk2T3CkzwYeB8IcxfRMsgmP48lEjI52oI2rc3b/hyMQo3kkgBfBbYGE
        A8pKgyvOh33KVepjxxajtVcFpxyUVbxFHpA10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RA7tixSp6V9EwCYOJYPp+XPQEECUuv/r
        UJh1fWBk2BTJcuw81Scb8ylWsszw9lqRaJQTPa/gsXr+Gml5a6iWu5zcMQl5PVHE
        Bikp+7CMvBVZCA6WF/wKVkq/0JhXqrMamruRLw5N0OBKisD3EVI0bKG+cPRZocZZ
        AtA3Lc+ogsI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD9989EB22;
        Tue, 17 Oct 2017 21:04:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 368499EB21;
        Tue, 17 Oct 2017 21:04:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     Thais Diniz <thais.dinizbraz@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Added support for new configuration parameter push.pushOption
References: <CAK7vU=1LGTLrEkRYS=autkDHmJAeq9=qa5jfx=DE+acPLsCqTg@mail.gmail.com>
        <xmqqvajdl1hn.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 18 Oct 2017 10:04:04 +0900
In-Reply-To: <xmqqvajdl1hn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 18 Oct 2017 09:54:12 +0900")
Message-ID: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CB960E4-B3A0-11E7-8479-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> base to show an incremental improvement, but here is how I would do
> the "code" part.
>
>  builtin/push.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 03846e8379..89ef029c67 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -32,6 +32,8 @@ static const char **refspec;
>  static int refspec_nr;
>  static int refspec_alloc;
>  
> +static struct string_list push_options_config = STRING_LIST_INIT_DUP;
> +
>  static void add_refspec(const char *ref)
>  {
>  	refspec_nr++;
> @@ -503,6 +505,13 @@ static int git_push_config(const char *k, const char *v, void *cb)
>  		int val = git_config_bool(k, v) ?
>  			RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
>  		recurse_submodules = val;
> +	} else if (!strcmp(k, "push.pushoption")) {
> +		if (!v)
> +			return config_error_nonbool(k);
> +		else if (!*v)
> +			string_list_clear(&push_options_config, 0);
> +		else
> +			string_list_append(&push_options_config, v);

Here needs to be

		return 0;

as there is no point in falling through to call
git_default_config().

>  	}
>  
>  	return git_default_config(k, v, NULL);
