Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC825282E1
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492261; cv=none; b=G9PsgZTX/rAXqcD7Bzmy6mQVH/a+u/M5skDGCxUTwd4Q7FqMFOZ96XcpKt3k8ASrFhLDlICsamlu+C+c4QUZCvkvAlnLU3HNiLo0/xzp8PAFk1e9j6Y5GlUtLmzTecO2EHej9k+Jzg77NZFQhFA0dL68rT8AZZA94SdhuOsdlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492261; c=relaxed/simple;
	bh=5x/truAyFzzqr8gmDbDX2ELEeIXALL9qH5mmNgd/E2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0WLRpJPzKS88e6+fuTwkpQJME0yfR/qGPGq90PqageeMofoUH3UaklfKoweYUSK/UmbaPjOwi48qDCaTeh8Mtk5VinsqkslSaHsvDm3JRDLCMDqfbO/Wq8ZFYHyVDcvUCb3M5AdNF3TPi44mJki2i4sOm9lmws4N+7oFNMylPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14767 invoked by uid 109); 1 Aug 2024 06:04:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 06:04:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27483 invoked by uid 111); 1 Aug 2024 06:04:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 02:04:22 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 02:04:18 -0400
From: Jeff King <peff@peff.net>
To: Ryan Hendrickson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: Re: [PATCH v4] http: do not ignore proxy path
Message-ID: <20240801060418.GB621899@coredump.intra.peff.net>
References: <pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com>
 <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>

On Thu, Aug 01, 2024 at 05:22:56AM +0000, Ryan Hendrickson via GitGitGadget wrote:

> From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
> 
> The documentation for `http.proxy` describes that option, and the
> environment variables it overrides, as supporting "the syntax understood
> by curl". curl allows SOCKS proxies to use a path to a Unix domain
> socket, like `socks5h://localhost/path/to/socket.sock`. Git should
> therefore include, if present, the path part of the proxy URL in what it
> passes to libcurl.
> 
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>

Thanks for crediting me. I'll add my:

 Signed-off-by: Jeff King <peff@peff.net>

to be explicit that the proxy script is under the DCO.

> -		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
> +		strbuf_addstr(&proxy, proxy_auth.host);
> +		if (proxy_auth.path) {
> +			curl_version_info_data *ver = curl_version_info(CURLVERSION_NOW);
> +
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
> +
> +			strbuf_addch(&proxy, '/');
> +			strbuf_add_percentencode(&proxy, proxy_auth.path, 0);

This all looks good to me. I wondered briefly whether
proxy_auth.protocol could ever be NULL, but I think we refuse to parse
such a URL.

> +start_socks() {
> +	mkfifo socks_output &&
> +	{
> +		"$PERL_PATH" "$TEST_DIRECTORY/socks4-proxy.pl" "$1" >socks_output &
> +		echo $! > "$TRASH_DIRECTORY/socks.pid"
> +	} &&
> +	read line <socks_output &&
> +	test "$line" = ready
> +}
> +
> +# The %30 tests that the correct amount of percent-encoding is applied to the
> +# proxy string passed to curl.
> +test_lazy_prereq SOCKS_PROXY 'test_have_prereq PERL && start_socks "$TRASH_DIRECTORY/%30.sock"'

OK, I see you figured out that the lazy prereq requires giving the full
path to the socket. :) I had forgotten that we also run the prereq in a
subshell to avoid side effects, but you caught that, as well.

All of this to me is good evidence that the non-lazy version you had
originally is a better approach. But I don't think it's worth spending
time fighting over, so I'm OK either way.

> +test_atexit 'test ! -e "$TRASH_DIRECTORY/socks.pid" || kill "$(cat "$TRASH_DIRECTORY/socks.pid")"'

Ah, good. I had meant to mention cleaning up at the end (as we do for
git-daemon and apache), but forgot. I'm glad you included it here.

> +test_expect_success SOCKS_PROXY 'clone via Unix socket' '
> +	test_when_finished "rm -rf clone" &&
> +	test_config_global http.proxy "socks4://localhost$PWD/%2530.sock" && {
> +		{
> +			GIT_TRACE_CURL=$PWD/trace git clone "$HTTPD_URL/smart/repo.git" clone 2>err &&
> +			grep -i "SOCKS4 request granted." trace
> +		} ||
> +		grep "^fatal: libcurl 7\.84 or later" err
> +	}
> +'

Looks good. Usually I do not bother with escaping "." in grep messages,
as it is already a loose match and it keeps the test easier to read. But
it is OK to do so.

We do have a test_grep wrapper which gives nicer output when the match
fails, but maybe that is a bad choice here, since we accept either of
the two messages. (Likewise for using test_cmp, I suppose).

The use of "||" in the command-chaining is unusual enough that it's
probably worth calling out either in a comment or in the commit message.

> +test_expect_success 'Unix socket requires socks*:' '
> +	! git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
> +		grep "^fatal: Invalid proxy URL '\''localhost/path'\'': only SOCKS proxies support paths" err ||
> +		grep "^fatal: libcurl 7\.84 or later" err
> +	}
> +'
> +
> +test_expect_success 'Unix socket requires localhost' '
> +	! git clone -c http.proxy=socks4://127.0.0.1/path https://example.com/repo.git 2>err && {
> +		grep "^fatal: Invalid proxy URL '\''socks4://127\.0\.0\.1/path'\'': host must be localhost if a path is present" err ||
> +		grep "^fatal: libcurl 7\.84 or later" err
> +	}
> +'
> +

Likewise here, I'd probably just match the single-quotes with "." for
readability (but it's OK to write it as you did). You can (since a week
or so ago) also use a here-doc body like:

  test_expect_success 'Unix socket requires socks*:' - <<\EOT
	...
	test_grep "^fatal: Invalid proxy URL 'localhost/path': only SOCKS proxies support paths" err ||
	...
  EOT

but I'm OK with it either way. The same "||" comment applies.

-Peff
