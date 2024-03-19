Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9AD2F5
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859961; cv=none; b=oS6jujzFjM2nJHd10Qt1xHI9eMWiE6GOQy0X6gfOYoFQ01zPEYhq+6IJYC/SNSFyw4Af8+c1zIKIu6Xyb8csmGmYzwYt9EMpzBxUL90xmIEyyYPyc+YLxrxiair37l3phpt2fl7DiDvIqKpu8Zn5X4VJ2o5djoLigBAnRRpfxkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859961; c=relaxed/simple;
	bh=nREMoS1LYbWHm2rAWvi6rVE/FpcUaKdzG27B0vA4LG4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HSuSHF/rSt/6kMkCnd63xLhDz0QGczK6TOMNt5Cy5CrGvJdM4/jF/3sNdRai8wHxxGXywVoRQ5JjnwgYlOC2Ze9ccybXYY2v/SujkoYMPko9tzyhX+VV+PWg/z7Wkof/cg8JhzSkGCWVIdNl8JWEAm4gKNZALN4PP47vemOB1A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=XMm3v8VK; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XMm3v8VK"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710859949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HL38rm103Ma1XLJhaq7Wr0+j8AfTLAILx2Cz5CuBO3w=;
	b=XMm3v8VKK9XYGA3mcWrzsyBxGsS0UEcx+WwtmV1uwWNpN29LqX2Ltr4KgrizUn81pMbGJR
	jBW+5IJ95GucgKVhDhrqpxcivvSj9MbqVw9EKbKPMpQM/qFtl9hSBYqLPgn+Ax1GHXawnK
	pP1mk/+CIiqYAp2r5SLHecDhI+luB5Otw+bwrVQqSoSXogyZK0a0QRbVJem9Wqg1fBNJOT
	Ir97gPwTUciqewNyQLI22bIzaiTO+kmN6xazC/XFJwrE/PDbKY8CVSkHRPx5b8E3lEgImr
	scnj5DX6xuZEP7+oKCCbJqW8oritZCneqg7uhxW11R3/0IXM1JjZ4iFLeE9+og==
Date: Tue, 19 Mar 2024 15:52:28 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] grep: introduce new config option to include
 untracked files
In-Reply-To: <xmqqil1is35i.fsf@gitster.g>
References: <cover.1710781235.git.dsimic@manjaro.org>
 <9f70eeb4f04a874a2036e1d8c61f3b7ec130663a.1710781235.git.dsimic@manjaro.org>
 <xmqqr0g7rqag.fsf@gitster.g> <923c5f84c44a195d6ba08503e28851af@manjaro.org>
 <xmqqil1is35i.fsf@gitster.g>
Message-ID: <a00f28ff137fa1d82d00151877f036fe@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-19 15:32, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>>> +	if (use_index && !cached)
>>>> +		git_config_get_bool("grep.includeuntracked", &untracked);
>>> Can this ever return an error?  E.g.
>>> 	[grep] includeuntracked = "not really"
>> 
>> After a brief inspection of the code in cache.c, git_config_get_bool()
>> always returns either 0 or 1, so we should be fine.  Thus, any
>> strangeness in a configuration file would end up not enabling
>> this option.
> 
> If that were the case, then it is not "fine".
> 
> When the user triggered an operation which *requires* us to parse
> and interpret the meaning of an entry in their configuration file
> correctly in order to carry it out, and if that entry has a value
> that we do not consider valid, we should notice and complain, before
> saying "Nah, this I do not understand, so I'll do one of the two
> things I would have done if the value were understandable and would
> not tell the user which one I did".
> 
> What makes it fine int his case is that git_config_get_bool() dies
> when the given value is not a Boolean ;-).  The returned value from
> the function can be used to tell if the variable does not exist and
> the caller should decide to stuff some default value to &untracked
> but in this case you do not need to.

I'm sorry for not being meticulous enough in my previous response.
What made me not pay enough attention is that it should all be already
covered properly with the already existing mechanisms for parsing the
git configuration files.

In other words, if invoking git_config_get_bool() over a user's
garbled git configuration file could cause any issues, that would've
been another, pretty much unrelated bug.
