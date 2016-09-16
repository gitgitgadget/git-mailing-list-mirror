Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78393207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 22:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbcIPWpt (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 18:45:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55187 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750982AbcIPWpr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 18:45:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B8FF400DE;
        Fri, 16 Sep 2016 18:45:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k8JuIjlm2PyrKy2KQwSsOL/yUeY=; b=mUbuFJ
        F1LUYeP3W8WvhkUgTQSy/Bh545FZiaVsnOZy/XVA+MVS7oW39/NtaRGSRh4/14aP
        Npu866j1hj/mS2cWO3msPu/LwRAW+R0LZg8gQXPy0SS9ZR8xOCxjl58DVgvwAH7i
        HggDxjWWpxxkXuUg8zMM2cZD9NcF2yoVCsd+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MEW0HMoBzWUborX9xQw7UxsCZHTAnPAU
        ERJTwDw7nCQK2C9QVPCz2S6q8zV8HKDrxH34srHFG+feBZGgyexVMBj2c0ema7dj
        dlNF8dGwNLjTYStW8h5BvIXqLD0lh7H9Pu7vx0To+VbFumymLGKbMhlIXDVhjzUl
        LDIAyiwqs6U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 742D4400DD;
        Fri, 16 Sep 2016 18:45:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0416F400DC;
        Fri, 16 Sep 2016 18:45:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/11] Resumable clone: add resumable download to http/curl
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
        <1473984742-12516-8-git-send-email-kevin.m.wern@gmail.com>
Date:   Fri, 16 Sep 2016 15:45:44 -0700
In-Reply-To: <1473984742-12516-8-git-send-email-kevin.m.wern@gmail.com> (Kevin
        Wern's message of "Thu, 15 Sep 2016 20:12:18 -0400")
Message-ID: <xmqqfuozihuv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E63E19E-7C5F-11E6-B08E-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Wern <kevin.m.wern@gmail.com> writes:

> +int http_download_primer(const char *url, const char *out_file)
> +{
> +	int ret = 0, try_count = HTTP_TRY_COUNT;
> +	struct http_get_options options = {0};
> +	options.progress = 1;
> +
> +	if (file_exists(out_file)) {
> +		fprintf(stderr,
> +			"File already downloaded: '%s', skipping...\n",
> +			out_file);
> +		return ret;
> +	}
> +
> +	do {
> +		if (try_count != HTTP_TRY_COUNT) {
> +			fprintf(stderr, "Connection interrupted for some "
> +				"reason, retrying (%d attempts left)\n",
> +				try_count);
> +			struct timeval time = {10, 0}; // 1s

We do not use // comment.

> +			select(0, NULL, NULL, NULL, &time);
> +		}
> +		ret = http_get_file(url, out_file, &options);

I didn't realize that http_get_file() -> http_request() codepath,
when it is the output file, already can do the "ftell and request
the reminder".  Very nice.

> @@ -1136,7 +1138,10 @@ static int handle_curl_result(struct slot_results *results)
>  				curl_easy_strerror(results->curl_result),
>  				sizeof(curl_errorstr));
>  #endif
> -		return HTTP_ERROR;
> +		if (results->http_code >= 400)
> +			return HTTP_ERROR;
> +		else
> +			return HTTP_ERROR_RESUMABLE;
>  	}
>  }

Hmm, is "anything below 400" a good definition of resumable errors?
