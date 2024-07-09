Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA01DA303
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720509403; cv=none; b=VgvEOYi+hUScccyNfRX06h3RAr8NmjcXO1znghDK+vmNZ3c4SheZzDBXZZoF1iQYM8sUwaCVm/LEzrPQGPoCu7Q5AI1E7ntB5hEdMv/ySpWUEZj1sWGQcN+uv+aZWo3Zs2b5i9rI4Q1bQ/MOceZA1LXxXZFFSsu7GHFqlqXlmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720509403; c=relaxed/simple;
	bh=qJ65cBaFDPQ3FH57NcfvUbXaZ2eY13fdng1NIQJcQLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rbrtM8v5LmjGUTLs+BtVYuu37Y79MJZiwBv+dEWgYUCIyZ1Q2bbrgW8DqxCwr5aAECWTP5mjgmyuWbSSq5BAE5q8SpWgPqLUZJlIltKZuQBzODCyOMevPz9DaYs0xH012RAVHIk+6XzpdQKw4ey5GKndzSHGWWAtenlJdJIiWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=GbMnqJsy; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="GbMnqJsy"
X-Envelope-To: eric.peijian@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1720509398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lWoeHQbkuawKXpRQhgrxS14L84Z/MHI7ebx7ND+ZR0=;
	b=GbMnqJsy8v20Dlxh2vU8H8C7/JIQ+PpH0nykJKaICHqwyd7snO5KyIRjLgd3+1WHMtuFmX
	XHWKu9zdAviVbWvtZDqr1zowpt4WAuqG5B6M6QrVB2ubfi1uqpi5NCSGbBa/6o8p0KCJbA
	FDV9tQrQTR+CsvhFb9wZCqbOwNeUDh4=
X-Envelope-To: git@vger.kernel.org
X-Envelope-To: chriscool@tuxfamily.org
X-Envelope-To: calvinwan@google.com
X-Envelope-To: jonathantanmy@google.com
X-Envelope-To: johncai86@gmail.com
X-Envelope-To: eric.peijian@gmail.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon claes <toon@iotcl.com>
To: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan
 <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>, John Cai
 <johncai86@gmail.com>, Eric Ju <eric.peijian@gmail.com>
Subject: Re: [PATCH 6/6] cat-file: add remote-object-info to batch-command
In-Reply-To: <20240628190503.67389-7-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-7-eric.peijian@gmail.com>
Date: Tue, 09 Jul 2024 09:16:23 +0200
Message-ID: <87h6czqblk.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Eric Ju <eric.peijian@gmail.com> writes:

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 72a78cdc8c..34958a1747 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> ...
> +static int get_remote_info(struct batch_options *opt, int argc, const char **argv)
> +{
> +	int retval = 0;
> +	struct remote *remote = NULL;
> +	struct object_id oid;
> +	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
> +	static struct transport *gtransport;
> +
> +	/*
> +	 * Change the format to "%(objectname) %(objectsize)" when
> +	 * remote-object-info command is used. Once we start supporting objecttype
> +	 * the default format should change to DEFAULT_FORMAT
> +	*/

I believe this comment has become outdated, or got moved around
incorrectly.

> diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
> new file mode 100755
> index 0000000000..7a7bdfeb91
> --- /dev/null
> +++ b/t/t1017-cat-file-remote-object-info.sh
> ...
> +stop_git_daemon
> +
> +# Test --batch-command remote-object-info with 'http://' transport
> +
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd

start_httpd skips the remainder of the tests if it fails to start the
httpd server. That's why I see various other tests which have this at
the end:

  # DO NOT add non-httpd-specific tests here, because the last part of this
  # test script is only executed when httpd is available and enabled.

So I would suggest to add this comment as well, and move the file://
tests above start_httpd.


-- 
Toon
