Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893B261595
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532383; cv=none; b=oIp4uRenexcKRvP+sCtH9CcbVlwckp6+6nvbZgenX9FUPff48bThlcxbuF8nT5OAYL3l+A3zsr194rEtZUPZHEHMsjDChGJhyDJng2ueFaoUN6uhvMxbpA9qIdLDCfg80WoR2qS39cmxvA26BE44ItbUZiVqhJxBltgT+4WGhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532383; c=relaxed/simple;
	bh=1rSejXwIAfXWsVTDPVl3PFoiPIVJ5tRNfA3nHFLnmqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9pdeYhTaXBG1F7IeonUIJUPIgty415EpHckYbSPypAtfTEZBGjLEqpmCdyGzveHzNBBPD4kME7pVDadeMV1EwLTBHgz1QHMP2gk9znZqvM53rM8jB5pcsumISXrCwrn7g3YI70Jxk9RRAj+ZIyHMl7hcjmYlwFBLmW5jouwrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2hw4HHY9; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2hw4HHY9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1739532375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFahB93+RdNp+GqnzpImgx/m78XjPTyo0v6ZwhI1Zq0=;
	b=2hw4HHY9gi42YWI3mh5sQMiQi8aDvwaV6pEHsevOMvrdY8z0T5BegKK7pw8q4mp2jphKMG
	39pD0bG3zA88vwbC3RWfzhmECic62bUI1OVHW8Mdw7ie63oFqRNwPAij7JcXEZzXuaqoE7
	+LW2ltpmCOH6/kcMIpI/hAELxNop/7I=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] bundle-uri: enable git-remote-https progress
In-Reply-To: <20240509164646.GB1708095@coredump.intra.peff.net>
References: <20240508124453.600871-1-toon@iotcl.com>
 <20240508124453.600871-5-toon@iotcl.com>
 <20240509164646.GB1708095@coredump.intra.peff.net>
Date: Fri, 14 Feb 2025 12:26:03 +0100
Message-ID: <87o6z43gz8.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hi Peff,

I am attempting to revive this patch series, and ran into your valuable
feedback below:

Jeff King <peff@peff.net> writes:

> On Wed, May 08, 2024 at 02:44:53PM +0200, Toon Claes wrote:
>
>> diff --git a/bundle-uri.c b/bundle-uri.c
>> index ca32050a78..462f00f668 100644
>> --- a/bundle-uri.c
>> +++ b/bundle-uri.c
>> @@ -293,7 +293,6 @@ static int download_https_uri_to_file(const char *file, const char *uri)
>>  	int found_get = 0;
>>  
>>  	strvec_pushl(&cp.args, "git-remote-https", uri, NULL);
>> -	cp.err = -1;
>>  	cp.in = -1;
>>  	cp.out = -1;
>
> This is the cause of at least one test failure in t5558, I think. We
> spawn a remote-https to try to download the bundle, but it may not be
> present, and we continue without it. In that case, the child
> remote-https says something like:
>
>   fatal: failed to download file at URL 'http://127.0.0.1:5558/bundle-5.bundle'
>
> and then the caller says:
>
>   warning: failed to download bundle from URI 'http://127.0.0.1:5558/bundle-5.bundle'
>
> Prior to this patch, the "fatal" part coming from the child process was
> suppressed (and the test checks that this is so, which is why it fails,
> even though the clone itself works fine).
>
> Obviously you need to enable stderr to see the progress, so I'm not sure
> how to resolve it. In an ideal world, you'd ask for the two over
> separate descriptors, but I think run_command() only supports 0/1/2
> stdio due to portability limitations for Windows.
>
> One option is that remote-https could ferry machine-readable output back
> to the parent over stdout, which could then format it for the user.
>
> Another is that we could somehow ask remote-https to squelch
> non-progress errors, though that feels a bit weird (and awkward to
> implement, since the message comes from a die() call).

I've been playing around with things and I haven't found a good way
forward with this. We could have the parent process ingest stderr of
git-remote-https and swallow messages that match `/^fatal:/`, but that
feels like a hack and not foolproof.

I was thinking if we could override `die()` in the child process to have
it not print anything, but because git-remote-http basically can call
die() basically from anywhere in the codebase, I don't think we can
ensure the silenced die() function is called.

Or what do you mean by "squelch non-progress errors"?

And yes, sending progress logging over a separate fd seems like the
ideal approach, but I haven't tried it yet. I'm afraid it's not worth
attempting so.

So I think that leaves us with your suggestion to "ferry
machine-readable output back to the parent". If I understand correctly
you mean the child process will not write progress logging to stderr but
to stdout (with some kind of command prefix the parent process knows
what to do with this)?

I imagine communication between parent and child will then look
something like this:

-> capabilities
<- stateless-connect
<- fetch
<- get
<- option
<- push
<- check-connectivity
<- object-format
-> option progress true
<- ok
-> get http://example.com git.bundle
<- progress 123 345 40
<- progress 234 345 50
<- progress 345 345 40

~fin~

But then we need to decide on the format the child sends back to the
parent. In the above example it's something like `progress <size>
<total> <throughput>`. An alternative proposal could be:

<- log Downloading via HTTP: 
<- log Downloading via HTTP: 200.00 KiB | 100.00 KiB/s
<- log Downloading via HTTP: 300.00 KiB | 100.00 KiB/s
<- log Downloading via HTTP: 400.00 KiB | 100.00 KiB/s
<- log Downloading via HTTP: 400.00 KiB | 100.00 KiB/s, done.

So the child sends the progress text with a `log` prefix, which the
parent simply has to send that logging to where it wants it to go.

Or am I completely misunderstanding your proposal? Do you maybe happen
to have any examples of a similar solution?


--
Toon
