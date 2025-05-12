Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF0A1E1E1F
	for <git@vger.kernel.org>; Mon, 12 May 2025 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747016041; cv=none; b=KosrdQLYJKxM7J1Mqxfw2OhSR4kEdY4vqMpq706Mi94h/8ILYlbjdQEXqqMOD9+El0DDGZPOvefOJ770eqXSZmj0a+YdxJVcZojRyCzSMEPfWlkYTd1YV5LGwUpKJckH+zWexmGw8bpfGdJFI6RPIVPw3Z6y/hQLBsQsROAMcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747016041; c=relaxed/simple;
	bh=5aK7BTdoZSG4JofxKUAE8MWA1OcgjshqAd0wkwW7Hwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r43I8aqcSamh7FNugzclCRjfEK61+Qj1fc6DySNW+DLFLqjALbxAMZAUGCfWu605yFH7wfI4HLBd7/9Cn1/ChRrEgpB7GHJYktDBSxyG0CnWIo56aj7p92DSgA8tSKi0wdtwWD+qnG+/lSJtIn1FsbLh/SjKz7MOtixFD5LzSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=o75js/Rx; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="o75js/Rx"
Date: Sun, 11 May 2025 22:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1747016036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQWZ53kf/WisJVyqiF9S/8SdghP7n8SmOamn1qKGDVc=;
	b=o75js/Rx5OIAzdvZmwlz8V7YMcXk6+rjjtKVHVzcNPB+qyrNbVRW9xJvIsAGpJ3OGC4Ymw
	goU4Y8iLP/6tXuDJEbwdap3fweyxw/b92QMACz6CQpCYNIqCIkxrESSaj5aj0B/i19y2pE
	3C3aPn1SfjiQsPJeet8XP8qev0aQN4w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Jason Cho <jason11choca@proton.me>, 
	"aclopte@gmail.com" <aclopte@gmail.com>, Ryan Hodges <rhodges@cisco.com>
Subject: Re: [PATCH 2/5] apply: read in the index in --intent-to-add mode
Message-ID: <gz4sl3e3nqmkamkfmoktlqaefxteamj6v3fcs7dbavgys7ubng@utz2i5ahl77f>
References: <4e2szrowd43w6lrzawqtddamdxvp6ke65jkzmdoru4gjin7xhn@kaqe7skrktgt>
 <20250511003955.242889-1-ray@ameretat.dev>
 <20250511003955.242889-3-ray@ameretat.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511003955.242889-3-ray@ameretat.dev>
X-Migadu-Flow: FLOW_OUT

On 25/05/10 08:36PM, Raymond E. Pasco wrote:
> diff --git a/apply.c b/apply.c
> index 5e39cadde4..3bde54a04a 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4837,7 +4837,7 @@ static int apply_patch(struct apply_state *state,
>  					       LOCK_DIE_ON_ERROR);
>  	}
>  
> -	if (state->check_index && read_apply_cache(state) < 0) {
> +	if (state->update_index && read_apply_cache(state) < 0) {
>  		error(_("unable to read index file"));
>  		res = -128;
>  		goto end;
> -- 
> 2.49.0.1106.gc0efa3ba58
> 
> 

For some reason, this causes checkout -p to break in a way which which I
don't understand. Directly using (state->check_index || state->ita_only)
doesn't break it, but because it doesn't seem logically possible to me
for this to change any behavior besides behavior when ita_only is on
(the update_index flag is in fact set just a few lines above!), I want
to investigate a bit further to find out what I'm confused about.

Either way, reroll coming, though I'd still appreciate review on the
series in general.
