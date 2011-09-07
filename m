From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] date.c: Support iso8601 timezone formats
Date: Wed, 07 Sep 2011 10:00:55 -0700
Message-ID: <7vaaag4794.fsf@alter.siamese.dyndns.org>
References: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
 <1315374407-30828-1-git-send-email-lihaitao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Haitao Li <lihaitao@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:01:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LVO-0002Hl-R5
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab1IGRBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:01:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459Ab1IGRA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:00:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96E1F36E0;
	Wed,  7 Sep 2011 13:00:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W6tFt0P55A6f4oN5XzdlG9HLmdw=; b=nA16k1
	EtbndBODvO2R9ZXT6EI8FuDMbCFRD2KYSLRFpDrFcig0f8hGXfiWN/zuQFtnoJUS
	Oo9/UCKloRJsxYN1En5mBoorZT8Rs3f1Xq2UQPUSV0annO32ykrRKYt0CXRyWzs1
	wi2hhT+URgGFHSyWhdQ24I11ms/1fm/TfcUKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EiXwvFE1KMYUPZB42D9LmKs7ROtYb6fv
	sJeAj/UZ0xx/nF92Jj6h63LTW25hjrs2O2e0cU/Gm2e3cLzsi5Qnfr3/JKYIIm66
	aKdAyyAc3+kJV2BiUDNgn9MLre99pEWH+8LM2UZEhxRhj4IRtasZsZA6RNEz8Yg9
	oRrEifqi4as=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E5EE36DF;
	Wed,  7 Sep 2011 13:00:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A6A936DE; Wed,  7 Sep 2011
 13:00:56 -0400 (EDT)
In-Reply-To: <1315374407-30828-1-git-send-email-lihaitao@gmail.com> (Haitao
 Li's message of "Wed, 7 Sep 2011 13:46:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F45FD39A-D972-11E0-A6C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180872>

Haitao Li <lihaitao@gmail.com> writes:

> diff --git a/date.c b/date.c
> index 896fbb4..f970ea8 100644
> --- a/date.c
> +++ b/date.c
> @@ -556,15 +556,35 @@ static int match_tz(const char *date, int *offp)
>  	int min, hour;
>  	int n = end - date - 1;
>  
> -	min = offset % 100;
> -	hour = offset / 100;
> +	/*
> +	 * ISO8601:2004(E) allows time zone designator been separated
> +	 * by a clone in the extended format
> +	 */
> +	if (*end == ':') {
> +		if (isdigit(end[1])) {
> +			hour = offset;
> +			min = strtoul(end+1, &end, 10);
> +		} else {
> +			/* Mark as invalid */
> +			n = -1;
> +		}
> +	} else {
> +		/* Only hours specified */

That comment belongs to inside the following if() {...}.

> +		if (n == 1 || n == 2) {

... i.e. here.

> +			hour = offset;
> +			min = 0;
> +		} else {
> +			hour = offset / 100;
> +			min = offset % 100;
> +		}
> +	}
>  
>  	/*
> +	 * Don't accept any random crap.. We might want to check that
> +	 * the minutes are divisible by 15 or something too. (Offset of
> +	 * Kathmandu, Nepal is UTC+5:45)
>  	 */
> -	if (min < 60 && n > 2) {
> +	if (n > 0 && min < 60 && hour < 25) {

What is this "hour < 25" about? Aren't we talking about the UTC offset
value that come after the [-+] sign?

I do not mind adding a new check, but I do mind if it adds a check with
not much value.  Even at Pacific/Kiritimati, the offset is 14; the new
check seems a bit too lenient.

>  		offset = hour*60+min;
>  		if (*date == '-')
>  			offset = -offset;
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index f87abb5..5235b7a 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -40,6 +40,11 @@ check_parse 2008-02 bad
>  check_parse 2008-02-14 bad
>  check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
>  check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
> +check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
> +check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 -0500'
> +check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
> +check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
> +check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
>  check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
>  
>  check_approxidate() {
