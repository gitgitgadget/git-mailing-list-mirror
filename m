Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80EC12B77
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713709109; cv=none; b=a8FIn8gdwNgi5ExRPlAKu76W8hZO8h/EbB9GpG3TJPzX/EViZqVLGeZtKLiW5yNLJVLCpls80qL7Dq8B3PiqOFEcthsnXQ1bylR6F5Mgga7uPRVg8oSggQAMJqS3mO48sTeXVRwau2z9GaEcSjTej3HdhHOAaMvMlZraXWNrSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713709109; c=relaxed/simple;
	bh=ypavDAabfQJdezAB28T8my490xpbIFP4I5KsOh+08m0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lGRZ79A5peVLHdUVh4d/u4goRKrZSOgB9atHf+huLOybZJ4Yw0j9Kjb7pTCoZmHSKq8JbNaDH5dDwnzYhEUC88Gs9N5UXStSa6qGKDa332azVCNken5Qk8wu/YejgeWQl/pHK/+Qce16iJx4Y6KgX/mPORSDWxPZVZoBwukxlds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mAt8Uu+8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mAt8Uu+8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713709105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbzDQ/0ZxzrrYkz1JEsJvBbBJm71vFM0LaNiS4KF6Bw=;
	b=mAt8Uu+8G622/3vwHzmYMLM5fJNcz+x9zFA/E/bvrwibeZWRJ/IahcwFk+LliRfyP5BV3p
	Wd1KiU65LRPkks8VkvnC0KaeaIYXjBRPsbQshww0tQyz6TFFrhTf5Xn7Hqid4H9MFWddM+
	05dz/8q01ba14In5FZEEzd4l266fU+Ec3+/IQfVFlad5++2KgXIdWhOisgP2/beTWl93f7
	6m4BLv1jbcpBKUT13nFKB5tQWOYKwjaAVx5AZdcP4aq58Cj76Uc6Ixav3qUkEu1umq6pPg
	ECXdYyuZWT7JeZZOr7v9gOFhzI7OFl3s98BY9yWaK4TbLGxQuqvGDohh5JCWfw==
Date: Sun, 21 Apr 2024 16:18:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] format-patch: allow --rfc to optionally take a value,
 like --rfc=WIP
In-Reply-To: <xmqq1q71l1xz.fsf@gitster.g>
References: <xmqqzftqnuxq.fsf@gitster.g>
 <9f846a3d-5244-43ec-b392-156665be0929@gmail.com>
 <xmqq1q71l1xz.fsf@gitster.g>
Message-ID: <7a60e90310024a06ba105892b54965a8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-04-19 19:03, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> @@ -1932,7 +1944,9 @@ int cmd_format_patch(int argc, const char 
>>> **argv, const char *prefix)
>>>   			    N_("mark the series as Nth re-roll")),
>>>   		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
>>>   			    N_("max length of output filename")),
>>> -		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of 
>>> [PATCH]")),
>>> +		OPT_CALLBACK_F(0, "rfc", &rfc, N_("extra"),
>>> +			       N_("add <extra> (default 'RFC') before 'PATCH'"),
>>> +			       PARSE_OPT_NONEG|PARSE_OPT_OPTARG, rfc_callback),
>> 
>> This is a change in behavior as it looks like we previously accepted
>> "--no-rfc" is that deliberate?
> 
> I just matched the subject-prefix without thinking.  Will fix.
> 
> Here is what I plan to squash in, but we are about to enter the
> pre-release stabilization period, so the progress on this new
> feature will have to slow down.

Let me remind you about the need to also support "[PATCH RESEND]",
for example, in this new feature.  Please see my earlier response [1]
for a possible solution.

Even some instructions for submitting patches, in some projects,
specify "[PATCH RESEND]" as the expected prefix, not "[RESEND PATCH]".
Thus, suffixes for the prefix should be supported.

[1] 
https://lore.kernel.org/git/84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org/
