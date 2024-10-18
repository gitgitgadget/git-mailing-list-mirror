Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89820B0F
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253023; cv=none; b=CnaH8IuAYHl8TrY290JkwB4RyCZC/kAnxTvTobzElc7Pitj3fcxFA1fKpLzTv+kHV8ZW1u0oy9f95GabZCRcKAjbccWWVAAe1SAogyGNgeOBa22/mQtkpvlbaae1j2ZPIaWf6m13McLDrUGk9lQ1A9XCTKlI78PnnXMMMm7fiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253023; c=relaxed/simple;
	bh=rIQLb3y9sb7Qfs2k69gzQP1o1vDG1sQbWjwp9ISrrzc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BuInYxjFNB3tAo+Hvh0ukgIRo4b4GxcJ0ue/clyeyopWE2vCAri2x55+37+AkX9n5X2vM+kJYx2h657twriSAL9+nEk9Cc1RYH9ugROFdw9eNg4cDPA9/44jI6lmnYMtX6cMYEkdvTgnaPcsT6ItmGdR9W3W3oAuxPHwSYqX5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=q8zxEQNN; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="q8zxEQNN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1729253018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Tdz+u1KkHA41YW+JZLDy08hBGeanWM5dPwzaiZA43M=;
	b=q8zxEQNN8QLZVg5BKjsuxnBcSRYnWGtpMn3BAHBL22SXqmWLSqPvlNZZMhDAcJXev3GfzY
	Vi6Xcw0wdMwFC1wzZqR9obOOszId5d1goze33vGreRtMnKSdUw06WZrF7zK8rdLMmH//a1
	LkqsFllscnJExsF9Jyd26FOPUo+9t5M=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 10/21] trailer: fix leaking trailer values
In-Reply-To: <ca5370d572d5750e5fb21c84d4a4134669e7e3c1.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <ca5370d572d5750e5fb21c84d4a4134669e7e3c1.1728624670.git.ps@pks.im>
Date: Fri, 18 Oct 2024 14:03:26 +0200
Message-ID: <878quld3e9.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Fix leaking trailer values when replacing the value with a command or
> when the token value is empty.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> diff --git a/trailer.c b/trailer.c
> index 682d74505bf..5c0bfb735a9 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1124,7 +1131,7 @@ void format_trailers(const struct process_trailer_options *opts,
>  			 * corresponding value).
>  			 */
>  			if (opts->trim_empty && !strlen(item->value))
> -				continue;
> +				goto next;

While this is technically correct, I found it rather hard to understand
what's happening. What do you think about instead turning the `if` below
in an `else if` ?

>  
>  			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
>  				if (opts->separator && out->len != origlen)
> @@ -1145,9 +1152,10 @@ void format_trailers(const struct process_trailer_options *opts,
>  				if (!opts->separator)
>  					strbuf_addch(out, '\n');
>  			}
> +
> +next:
>  			strbuf_release(&tok);
>  			strbuf_release(&val);
> -
>  		} else if (!opts->only_trailers) {
>  			if (opts->separator && out->len != origlen) {
>  				strbuf_addbuf(out, opts->separator);
> -- 
> 2.47.0.dirty

--
Toon
