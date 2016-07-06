Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D7B2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 19:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbcGFTd4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 15:33:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752141AbcGFTd4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 15:33:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E66FF29EB6;
	Wed,  6 Jul 2016 15:33:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cvhDZSR2gUZc
	1SN5EWh1cjepzWw=; b=bNN4MPM7sT4q7EHrqeJCYae1rxgrhNpu4iBH53g9HeVO
	KJ9MWLTB31G+h0Y+FqUTkSy8HQ/gFjyQyvDyy8dNGyckhIBcHnd1vtStH54m7HI4
	U2iMV6K1Ns2vW+rjvKh2p3sfNp+mUU9Dygd+m/SZkNqSCgAMnPFCQk0859w3OX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=H/02Tf
	6uRXLAWIlzAUKiV5sjaJEG2BRRMApQ5JcdRsi9mYVANFxCGAZ5YxwUOlp8CPNnIY
	w8tVGn+PsjS3PMJWQJWBws626sE7Y5xuhPUu4PAYP6waHybJDIN1SKd1zryEKd5s
	OrRx1KB5ZXnFG9oPCCZE0GsGQB4A5gvtvlV5k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD32829EB5;
	Wed,  6 Jul 2016 15:33:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6002229EB4;
	Wed,  6 Jul 2016 15:33:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] config.c: fix potential number truncation in git_parse_signed()
References: <20160702131333.8418-1-pclouds@gmail.com>
Date:	Wed, 06 Jul 2016 12:33:52 -0700
In-Reply-To: <20160702131333.8418-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
	Duy"'s message of "Sat, 2 Jul 2016 15:13:33 +0200")
Message-ID: <xmqqa8husgrj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 932F898C-43B0-11E6-B02A-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> clang -Wabsolute-value on IA-32 architecture complains that "absolute
> value function 'labs' given an argument of type 'intmax_t' (aka 'long
> long') but has parameter of type 'long' which may cause truncation of
> value". Very unlikely for this code though. Nevertheless, add an
> explicit check for truncation to shut clang up and error out.

Thanks.  It however makes me wonder if it is a better approach to
avoid downcasting intmax_t to long by using imaxabs()?

>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  config.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index d7ce34b..880bd4a 100644
> --- a/config.c
> +++ b/config.c
> @@ -503,6 +503,7 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>  		intmax_t val;
>  		uintmax_t uval;
>  		uintmax_t factor = 1;
> +		long int lival;
>  
>  		errno = 0;
>  		val = strtoimax(value, &end, 0);
> @@ -512,9 +513,14 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>  			errno = EINVAL;
>  			return 0;
>  		}
> -		uval = labs(val);
> +		lival = (long int)val;
> +		if (lival != val) {
> +			errno = ERANGE;
> +			return 0;
> +		}
> +		uval = labs(lival);
>  		uval *= factor;
> -		if (uval > max || labs(val) > uval) {
> +		if (uval > max || labs(lival) > uval) {
>  			errno = ERANGE;
>  			return 0;
>  		}
