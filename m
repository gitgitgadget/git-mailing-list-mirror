Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2472C20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 21:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbcF2VT7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 17:19:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751230AbcF2VT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 17:19:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 300EA28B77;
	Wed, 29 Jun 2016 17:19:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hQbSuZsjX7o7RJCcrrn84leRJbg=; b=h7/zef
	GQ8UuhNgnhCg/cIs1LpC73hJwB1pmW5J8QbCYuVMSnggtV8VUsRP7NQWNw3Fx421
	6Uw2VGC1wynMKe7K/iQSIiiVMC/Pbqvi2C9/8U0Rc9XtYuazRoRCsfv1+BvBUV9G
	lEwCASK5h6iSefwCbgmb773jqN/c0TLRWeoBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n2ldblgGFfaX9A2MTlM2MDsaLPXRqMaQ
	Hp8Q6VeUWCa4ehDqeYp1Ymzix3dDoYA2p7MP5gIKEE5+YzjibB+/vzwiZl81KRZD
	0QjSua3DBsp8UMjSkuKcjL1MOMtL8qzc/rXZOhlFUYgLH5mq7YPoCeXsKDRS2hqL
	tlMm7eh6G4k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 27DA928B75;
	Wed, 29 Jun 2016 17:19:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F52028B74;
	Wed, 29 Jun 2016 17:19:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 8/9] merge-recursive: switch to returning errors instead of dying
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<06c09ab4d684c239ae4ae03373c7cc7afb3be60b.1467199553.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 14:19:55 -0700
In-Reply-To: <06c09ab4d684c239ae4ae03373c7cc7afb3be60b.1467199553.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 13:37:09 +0200
	(CEST)")
Message-ID: <xmqq7fd73d6s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B17E8E6-3E3F-11E6-AFF0-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -743,6 +741,8 @@ static int update_file_flags(struct merge_options *o,
>  			      int update_cache,
>  			      int update_wd)
> ...
> +			ret = error_errno(_("do not know what to do with %06o %s '%s'"),
> +				mode, sha1_to_hex(sha), path);
>  free_buf:

OK, with a few more users of this label, it no longer looks so
strange to me to have this label here.

At least, match the indentation level to the existing one we see
below, though?

>  		free(buf);
>  	}
>   update_index:
> -	if (update_cache)
> +	if (!ret && update_cache)
>  		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);

Unlike my reaction to "if (!ret) do this" in an earlier patch, I do
think this change is sensible.  We wouldn't have reached here in the
original code if we saw errors, and some of the variable used to
call add_cacheinfo() at this point may be garbage when ret is
non-zero, i.e. we know we earlier saw an error.

> -	return 0;
> +	return ret;
>  }
> ...
>  			if ((merge_status < 0) || !result_buf.ptr)
> -				die(_("Failed to execute internal merge"));
> +				ret = error(_("Failed to execute internal merge"));
>  
> -			if (write_sha1_file(result_buf.ptr, result_buf.size,
> +			if (!ret && write_sha1_file(result_buf.ptr, result_buf.size,
>  					    blob_type, result->sha))

Likewise.

> @@ -1861,7 +1867,7 @@ static int process_entry(struct merge_options *o,
>  		 */
>  		remove_file(o, 1, path, !a_mode);
>  	} else
> -		die(_("Fatal merge failure, shouldn't happen."));
> +		return error(_("Fatal merge failure, shouldn't happen."));

Isn't this BUG()?

