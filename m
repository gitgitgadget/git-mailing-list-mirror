Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD814B097
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464645; cv=none; b=AdB/5uxlU+uH5ajeVV76LB6pFhYVJ1aKLq2uEM0hLuDwku9j4cNGYnf9pOBIakubrUtRjm3fAvT6Yg2b5KSREHip3aS2XdRpxVbkYncyqrCSKEzmUQV3zkmNg3BnL0NX3iE0W9e76/BKaZzbpvn6/KkojPPWZJbyYkyK/LXcACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464645; c=relaxed/simple;
	bh=KeUhYfSgG2kNOcQRbCvf4YN2jhacVyd7Daq/GCs8PAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=km+NO/lyr46vBkgW3DyAGcW2LykM6Y8fgdmjxKFFFQZd5SinnKJDeupXL04Yh0UlocUZp/NsZ++RxeCplv48TL/ktvOC3vosv2LRKv3MWtA6Zwh8kCnb5KJhbnux0OwtxVefsFlm7YHaoUh/ydsyhtmN50Jo8VnGnogcqGGJeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L+xtDBFV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L+xtDBFV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 036A83C680;
	Wed, 31 Jul 2024 18:24:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KeUhYfSgG2kNOcQRbCvf4YN2jhacVyd7Daq/GC
	s8PAc=; b=L+xtDBFVycyruVDR7e7ku9EomEbiQf3RSoceJsHAFTi0X3+9yiEVOa
	vYSlBoAaLSsfOIw15Foh4SIzL3oVnmRwBOOk9whpjqdBDSLfYAtPQ/AElm+g5qcR
	e9TY1M2p1l0vd35aAMdavkTqGBx1T1u2N3BF25M1Ue6lI8bElVXzs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF7233C67F;
	Wed, 31 Jul 2024 18:24:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 662D33C67E;
	Wed, 31 Jul 2024 18:24:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http: do not ignore proxy path
In-Reply-To: <pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com> (Ryan
	Hendrickson via GitGitGadget's message of "Wed, 31 Jul 2024 16:01:15
	+0000")
References: <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com>
	<pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com>
Date: Wed, 31 Jul 2024 15:24:01 -0700
Message-ID: <xmqqle1hyzcu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 97030184-4F8B-11EF-9E82-BAC1940A682E-77302942!pb-smtp2.pobox.com

"Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -5,8 +5,8 @@ http.proxy::
>  	proxy string with a user name but no password, in which case git will
>  	attempt to acquire one in the same way it does for other credentials. See
>  	linkgit:gitcredentials[7] for more information. The syntax thus is
> -	'[protocol://][user[:password]@]proxyhost[:port]'. This can be overridden
> -	on a per-remote basis; see remote.<name>.proxy
> +	'[protocol://][user[:password]@]proxyhost[:port][/path]'. This can be
> +	overridden on a per-remote basis; see remote.<name>.proxy

OK.

> diff --git a/http.c b/http.c
> index 623ed234891..a50ba095889 100644
> --- a/http.c
> +++ b/http.c
> @@ -1227,6 +1227,7 @@ static CURL *get_curl_handle(void)
>  		 */
>  		curl_easy_setopt(result, CURLOPT_PROXY, "");
>  	} else if (curl_http_proxy) {
> +		struct strbuf proxy = STRBUF_INIT;
>  		if (starts_with(curl_http_proxy, "socks5h"))
>  			curl_easy_setopt(result,
>  				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);

In a block with local variable decl, be more friendly to readers by
having a blank line between the end of declarations and the first
statement.

> +		strbuf_addstr(&proxy, proxy_auth.host);
> +		if (proxy_auth.path) {
> +			curl_version_info_data *ver = curl_version_info(CURLVERSION_NOW);
> +			if (ver->version_num < 0x075400)
> +				die("libcurl 7.84 or later is required to support paths in proxy URLs");
> +
> +			if (!starts_with(proxy_auth.protocol, "socks"))
> +				die("Invalid proxy URL '%s': only SOCKS proxies support paths",
> +				    curl_http_proxy);
> +
> +			if (strcasecmp(proxy_auth.host, "localhost"))
> +				die("Invalid proxy URL '%s': host must be localhost if a path is present",
> +				    curl_http_proxy);

We insist that it must be "localhost", so let's not do strcasecmp()
but just do strcmp().

> diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
> index bb35b87071d..7fcffba67a2 100755
> --- a/t/t5564-http-proxy.sh
> +++ b/t/t5564-http-proxy.sh
> @@ -39,4 +39,50 @@ test_expect_success 'clone can prompt for proxy password' '
>  	expect_askpass pass proxuser
>  '
>  
> +start_socks() {
> +	mkfifo socks_output &&
> +	{
> +		"$PERL_PATH" "$TEST_DIRECTORY/socks4-proxy.pl" "$1" >socks_output &
> +		socks_pid=$!
> +	} &&
> +	read line <socks_output &&
> +	test "$line" = ready
> +}
> +
> +test_expect_success PERL 'try to start SOCKS proxy' '
> +	# The %30 tests that the correct amount of percent-encoding is applied
> +	# to the proxy string passed to curl.
> +	if start_socks %30.sock
> +	then
> +		test_set_prereq SOCKS_PROXY
> +	fi
> +'

Making it a regular test_expect_success would mean GIT_SKIP_TEST
mechansim can be used to skip it, which is probably not what you
want.  Can't this be a more common test_lazy_prereq, perhaps like

	test_lazy_prereq SOCKS_PROXY '
		# useful comment about 30% here ...
		test_have_prereq PERL &&
		start_socks %30.sock
	'

or something?

Thanks.
