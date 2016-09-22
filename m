Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6EB1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 20:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941140AbcIVU6M (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 16:58:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54538 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933377AbcIVU6K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 16:58:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC52C3F986;
        Thu, 22 Sep 2016 16:58:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a3prw1SnmqJtPKy4kYvofAmYNAA=; b=d2imgM
        4OP8wQEATlwkpgkOqhYO/1V+9A7Cc49OpQD2I6q5e7Lt2K4yE3hBTxYKcPgF65Cw
        4OfAMZVENvO8cZRe/nbg1wXqiZgJ0u1OfptykxCiNWD6lOHxP6HsnB/aRODQ2usW
        zKorv02wai8TIi5H9w2zWSPRNd6ON/5vuA9tU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DQiGAf4V8YFYmducZ2MO3m/uHpBcUV6+
        GlKqAVzDk2/M0Efx2pZgOlAcpiFolQ/7txRnRiXKLQ18GAHxHxlG+ZgWOqHerQ6f
        r/XVykdaHNtF5x+1QQm6IvB/SpmQg4vZMjCEcXFEvV98wOdXavL3HacS/78iJ3N8
        IeHif7VnnwM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A238F3F985;
        Thu, 22 Sep 2016 16:58:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24F253F984;
        Thu, 22 Sep 2016 16:58:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: Re: [PATCH 4/6] tag: add format specifier to gpg_verify_tag
References: <20160922185317.349-1-santiago@nyu.edu>
        <20160922185317.349-5-santiago@nyu.edu>
Date:   Thu, 22 Sep 2016 13:58:06 -0700
In-Reply-To: <20160922185317.349-5-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Thu, 22 Sep 2016 14:53:15 -0400")
Message-ID: <xmqqponv3b4x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43AEBB00-8107-11E6-9722-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> Calling functions for gpg_verify_tag() may desire to print relevant
> information about the header for further verification. Add an optional
> format argument to print any desired information after GPG verification.

> diff --git a/builtin/tag.c b/builtin/tag.c
> index dbf271f..94ed8a2 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -106,7 +106,7 @@ static int delete_tag(const char *name, const char *ref,
>  static int verify_tag(const char *name, const char *ref,
>  				const unsigned char *sha1)
>  {
> -	return gpg_verify_tag(sha1, name, GPG_VERIFY_VERBOSE);
> +	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
>  }
>  
>  static int do_sign(struct strbuf *buffer)
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index 99f8148..7a1121b 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -51,8 +51,10 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  		const char *name = argv[i++];
>  		if (get_sha1(name, sha1))
>  			had_error = !!error("tag '%s' not found.", name);
> -		else if (gpg_verify_tag(sha1, name, flags))
> -			had_error = 1;
> +		else {
> +			if (verify_and_format_tag(sha1, name, NULL, flags))
> +				had_error = 1;
> +		}

Revert the unnecessary reformatting here.

> @@ -56,6 +57,15 @@ int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
>  	ret = run_gpg_verify(buf, size, flags);
>  
>  	free(buf);
> +
> +	if (fmt_pretty) {
> +		struct ref_array_item *ref_item;
> +		ref_item = new_ref_item(name_to_report, sha1, 0);
> +		ref_item->kind = FILTER_REFS_TAGS;
> +		show_ref_item(ref_item, fmt_pretty, 0);
> +		free_ref_item(ref_item);
> +	}

I haven't seen 5/6 and 6/6, but if this is the only user of the 3/6,
it would be much better to have a single function to format a ref
exported from ref-filter.[ch] so that this one can say

	if (fmt_pretty)
        	format_ref(name_to_report, sha1, FILTER_REFS_TAGS);

or something like that, instead of doing three that will always be
used together in quick succession in the above pattern.
