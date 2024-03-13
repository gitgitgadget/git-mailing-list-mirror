Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3215C606
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710371201; cv=none; b=WIN0o3t1MuE/6typ5mLX463xr4wbfRKOat3iHZ3rI1pKnpdRM5vnQ52lWKROHM91El6HTQG82dCr2+8zp+wijrVflLIOWOpZTPJND0la92I2JcU1qJtR5+zejTfAJkjP9tzyBrrL7uLLH3slv5/FspfmuAd/JBLb/QQbuFa0ZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710371201; c=relaxed/simple;
	bh=VpO3g6g8nI26WHNlv9zhsjWH3FogKiGZAK7qN+/ikgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VQc4Azs3rZ9pSoNUwsy0jRizDrJTbl7FdwiUYdeQP8XQW//ZuiVLWeDX4AqQ+6PbhnE/5H1A3NGMtWFahox8klSFiGzgR/hSjy/1GTHVJAvGqwEt/YgqgpevghuZ1GBC+aS/2/dyCFBdmR3SanKlNaGJOO2dbLcUQr8taja3onY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hi4lKxAh; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hi4lKxAh"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BBCB1C6BF;
	Wed, 13 Mar 2024 19:06:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VpO3g6g8nI26WHNlv9zhsjWH3FogKiGZAK7qN+
	/ikgk=; b=Hi4lKxAhtNVzPCprz1FT5BXNSyEilDZDq6UdeMzdYa2lkGaBydpYUn
	gdmS7xpuYxLrYTvVi2D2TBeyVmZpDUirxEEK52tXwL4qpF4TfN9olIgcpCqUnG6L
	wNMV4ZkE3+E7TtYGmQRIpRVa/+UsOnNDP10/ou8GUVB5jculYVEQI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 03D391C6BE;
	Wed, 13 Mar 2024 19:06:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31CA11C6BC;
	Wed, 13 Mar 2024 19:06:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>,  Michael Osipov
 <michael.osipov@innomotics.com>
Subject: Re: [PATCH v3] date: make "iso-strict" conforming for the UTC timezone
In-Reply-To: <20240313225423.11373-1-dev+git@drbeat.li> (Beat Bolli's message
	of "Wed, 13 Mar 2024 23:54:23 +0100")
References: <xmqqmsr169e5.fsf@gitster.g>
	<20240313225423.11373-1-dev+git@drbeat.li>
Date: Wed, 13 Mar 2024 16:06:33 -0700
Message-ID: <xmqq5xxp68au.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 56C1C15C-E18E-11EE-AF8E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> ISO 8601-1:2020-12 specifies that a zero timezone offset must be denoted
> with a "Z" suffix instead of the numeric "+00:00". Add the correponding
> special case to show_date() and a new test.
>
> Changing an established output format which might be depended on by
> scripts is always problematic, but here we choose to adhere more closely
> to the published standard.

Perfect.  Thanks for following it through.  Will replace (I've
queued v2 already but it is easy to replace).

>
> Reported-by: Michael Osipov <michael.osipov@innomotics.com>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
> Changes from v2:
>
> - changed the rationale according to Junio's feedback
>
> Changes from v1:
>
> - added a comment why the change is fine
> - removed the Link: trailer
>
>  date.c          | 14 +++++++++-----
>  t/t0006-date.sh |  1 +
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/date.c b/date.c
> index 619ada5b2044..44cf2221d81f 100644
> --- a/date.c
> +++ b/date.c
> @@ -342,14 +342,18 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
>  				tm->tm_hour, tm->tm_min, tm->tm_sec,
>  				tz);
>  	else if (mode->type == DATE_ISO8601_STRICT) {
> -		char sign = (tz >= 0) ? '+' : '-';
> -		tz = abs(tz);
> -		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%c%02d:%02d",
> +		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d",
>  				tm->tm_year + 1900,
>  				tm->tm_mon + 1,
>  				tm->tm_mday,
> -				tm->tm_hour, tm->tm_min, tm->tm_sec,
> -				sign, tz / 100, tz % 100);
> +				tm->tm_hour, tm->tm_min, tm->tm_sec);
> +		if (tz == 0) {
> +			strbuf_addch(&timebuf, 'Z');
> +		} else {
> +			strbuf_addch(&timebuf, tz >= 0 ? '+' : '-');
> +			tz = abs(tz);
> +			strbuf_addf(&timebuf, "%02d:%02d", tz / 100, tz % 100);
> +		}
>  	} else if (mode->type == DATE_RFC2822)
>  		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
>  			weekday_names[tm->tm_wday], tm->tm_mday,
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index e18b1602864e..1d228a981ee9 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -46,6 +46,7 @@ check_show () {
>  TIME='1466000000 +0200'
>  check_show iso8601 "$TIME" '2016-06-15 16:13:20 +0200'
>  check_show iso8601-strict "$TIME" '2016-06-15T16:13:20+02:00'
> +check_show iso8601-strict "$(echo "$TIME" | sed 's/+0200$/+0000/')" '2016-06-15T14:13:20Z'
>  check_show rfc2822 "$TIME" 'Wed, 15 Jun 2016 16:13:20 +0200'
>  check_show short "$TIME" '2016-06-15'
>  check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
