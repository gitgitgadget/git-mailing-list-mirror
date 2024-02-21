Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03C4A1D
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553912; cv=none; b=q6YBd+uZVG1+u4CcKt+targWYRzr+mYP4Sff5XK41tB/ZkoGeugCVL1aLhLDo8cq3YbRjy+QK3XmG3U+bKJtpImY2yO7OPAnhuIbQ5Ev5zt2fryxx7/OboQltzz/UMyKb65KlORsdwZngiSSokZ49zu4Z/i5UcQELoAQqFopdCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553912; c=relaxed/simple;
	bh=GaBaq4qvE5S0TiblHrPxkvR16+7fruI51t7p3xuOFPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhQP8yqyhhABe7rFyOIJKGHRnuVtZ9aVT2pGyJzXgAJKAIXlLzSDhiAGXyAga97bpzQIOpfu1Sw2UZa5ioOD24O8kizsBNDxDWVMcbX+S1rYGdrjxatNOqX6aPjHN80zY92qcoOQtJ0mddtzGyebvkFTzKVkfbelFid4mptjL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97721F44D;
	Wed, 21 Feb 2024 22:09:45 +0000 (UTC)
Date: Wed, 21 Feb 2024 22:09:45 +0000
From: Eric Wong <e@80x24.org>
To: Leslie Cheng via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Leslie Cheng <leslie@lc.fyi>,
	Leslie Cheng <leslie.cheng5@gmail.com>
Subject: Re: [PATCH] Add unix domain socket support to HTTP transport.
Message-ID: <20240221220945.M686016@dcvr>
References: <pull.1681.git.git.1708506863243.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1681.git.git.1708506863243.gitgitgadget@gmail.com>

Leslie Cheng via GitGitGadget <gitgitgadget@gmail.com> wrote:

> Subject: Re: [PATCH] Add unix domain socket support to HTTP transport.

No need for trailing `.' in commit message titles

<snip>

> @@ -455,6 +458,20 @@ static int http_options(const char *var, const char *value,
>  		return 0;
>  	}
>  
> +	if (!strcmp("http.unixsocket", var)) {
> +#ifdef GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH
> +#ifndef NO_UNIX_SOCKETS
> +		return git_config_string(&curl_unix_socket_path, var, value);
> +#else
> +		warning(_("Unix socket support unavailable in this build of Git"));
> +		return 0;
> +#endif
> +#else
> +		warning(_("Unix socket support is not supported with cURL < 7.40.0"));
> +		return 0;
> +#endif
> +	}

Personally, I'd hoist the #ifdef part into a standalone function
since I find mixing CPP and C conditionals confusing.

disclaimer: I'm an easily confused person and don't usually
program in C, though.

<snip>

> --- /dev/null
> +++ b/t/t5565-http-unix-domain-socket.sh

<snip>

> +    nc -klU "$socket_path" <tcp_to_uds >uds_to_tcp &
> +    UDS_PID=$!
> +
> +    nc "$host" "$port" >tcp_to_uds <uds_to_tcp &

`nc' isn't widely installed, its supported flags vary between
implementations, and our test suite doesn't currently use it.
I suggest either using a small bit of Perl or writing a t/helper
program to do its job.

Finally, hard tabs should be used for indentation throughout.

I'll wait on others to comment since I haven't looked at git
hacking in a while.

Anyways, I think this feature could be useful for me, too :>
Thanks.
