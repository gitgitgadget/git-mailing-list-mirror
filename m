Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FD1DFEF
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017916; cv=none; b=sm6G4jD4taojm24CQ1skqXw3TC6JwFPi6o/TQxUalw4ltSUXceMKIxS/Rf0egGmxCmHiFbmXzEOJB6dlxSFQNawy+AYUu7J1K0qpYUp6E/zls9NDlYZMZYzfa/5wpD3sCe8nLyfd++8SvaVzIs724gW9qGpV7Etfoecyfbm7tbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017916; c=relaxed/simple;
	bh=9PpYQ9pgJlGDuK0SQj8z2rVuJUA4KBOQ+IMtMoN69zc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=QTr0AT1Wib4WAJfQJ+krwsuPLOlwBQcQTh9cPI+RXMQ4YYPAbiy4ZbmAfZ1cNOy5NoFKhLl7uSVhwjz5nrApVITQ1sC6LV8UsytmUZqlCV/Y6nxFKqbjx9qz9Ex3y1VS1yT19S3XthVXl1JGy6mwQ3hatakiwVQjIIegq4KKddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=1tsg4hTM; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="1tsg4hTM"
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
 <0552123fa30243d6d8d6b378991651dd6ade7de3.1704877233.git.ps@pks.im>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1706017910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOErb6vKMlFVxxzCiF6GCo7bycFsFw4VWdoJua//VEA=;
	b=1tsg4hTMd3Vo3nPAG5iyCcVsUf3w3PuQysq3tAQfRqExwLk9FuVymhbW1P1oDVPTdHq4Y5
	GNPtK8INvJW8fObI6fekXCzZjKL3JgVuAQzqUjPxh5la40f032Qq7lvbyK9yin+RMejwdN
	FOIYerZPPxLWDbvr/ap790/pJoyZdN4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/6] t1300: make tests more robust with non-default
 ref backends
Date: Tue, 23 Jan 2024 14:41:17 +0100
In-reply-to: <0552123fa30243d6d8d6b378991651dd6ade7de3.1704877233.git.ps@pks.im>
Message-ID: <87ede8qhw9.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


Patrick Steinhardt <ps@pks.im> writes:

> [[PGP Signed Part:Undecided]]
> [1. text/plain]
> The t1300 test suite exercises the git-config(1) tool. To do so we
> overwrite ".git/config" to contain custom contents. While this is easy
> enough to do, it may create problems when using a non-default repository
> format because we also overwrite the repository format version as well
> as any potential extensions. With the upcoming "reftable" ref backend
> the result is that we may try to access refs via the "files" backend
> even though the repository has been initialized with the "reftable"
> backend.
>
> Refactor tests which access the refdb to be more robust by using their
> own separate repositories, which allows us to be more careful and not
> discard required extensions.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

> @@ -2009,11 +2020,11 @@ test_expect_success '--show-origin getting a single key' '
>  '
>
>  test_expect_success 'set up custom config file' '
> -	CUSTOM_CONFIG_FILE="custom.conf" &&
> -	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
> +	cat >"custom.conf" <<-\EOF &&
>  	[user]
>  		custom = true
>  	EOF
> +	CUSTOM_CONFIG_FILE="$(test-tool path-utils real_path
>  custom.conf)"
>  '

From the commit message it was not clear to me this change was needed.
Do you think it's worth it to add something to the commit message
explaining you now need to copy the custom.conf into each seperate
repository?


--
Toon
