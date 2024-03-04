Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A798048CC7
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578998; cv=none; b=LrZ2friZ7KX0B3lEYSHWzYoNSzE3OBwKeUkXLMF1vpofmUOZK21drPE4kML5LUuYHUTh42RGosuWmaIOuA+g5SNPyqEQUDskXLHxBpOvosVc7tndzHxe3iGFEi65RjleoGYn04pQKpSmiey/Bx+BIdXqn3gnaOjiP03Rcvo3BpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578998; c=relaxed/simple;
	bh=6RUBVjLcM+tvnprk/p6FO5KcwMTBdBIeennnA24qeBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m9NEqzhI+b1vjaj+zbQTmFuEcS5xpVhbV4OrK9pOzcgvdvDOrHtSCO8HegwBsH3t5OKAd29nGG1vwWtDoHFOYJl0D3o08W/5eZLZ+uklUcnKYPHNavJGhauVWFw15k47+ee0C3Or8UgsvVAz7HOEPHZMd++CuOphojvDrSJEM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kZAorwfs; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kZAorwfs"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 672E11F39D5;
	Mon,  4 Mar 2024 14:03:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6RUBVjLcM+tvnprk/p6FO5KcwMTBdBIeennnA2
	4qeBo=; b=kZAorwfsgCLtlkCUVspZC0iFSfQUVI6r/D5xZrtMp5RK8UlCYBkMyA
	82w0BTIzKoZBGkXgf11qTT2wnej4LDbk4xj5ZW85Z1Z/tXOKjWup5TMHu17+tVMg
	FLmbr5NkX6IKFCFKe/y6T3e2BPPX/h5I24xX1Tul3QpfnVhAAteHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DCD01F39D4;
	Mon,  4 Mar 2024 14:03:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B835D1F39D3;
	Mon,  4 Mar 2024 14:03:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <avila.jn@gmail.com>,  "Kristoffer
 Haugsbakk" <code@khaugsbakk.name>
Subject: Re: [PATCH v2] clean: improve -n and -f implementation and
 documentation
In-Reply-To: <87h6hl96z7.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
	04 Mar 2024 21:39:40 +0300")
References: <7le6ziqzb.fsf_-_@osv.gnss.ru>
	<20240303220600.2491792-1-gitster@pobox.com>
	<87h6hl96z7.fsf@osv.gnss.ru>
Date: Mon, 04 Mar 2024 11:03:13 -0800
Message-ID: <xmqqo7btom4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA7E98DA-DA59-11EE-BE7C-25B3960A682E-77302942!pb-smtp2.pobox.com

Sergey Organov <sorganov@gmail.com> writes:

>> The reason for the behaviour can be explained this way:
>>
>>  * "git clean" (with neither -i nor -n.  The user wants the default
>>    mode that has no built-in protection will be stopped without -f.
>>
>>  * "git clean -n".  The user wants the dry-run mode that has its own
>>    protection, i.e. being always no-op to the files, so there is no
>>    need to fail here for the lack of "-f".
>>
>>  * "git clean --interactive".  The user wants the interactive mode
>>    that has its own protection, i.e. giving the end-user a chance to
>>    say "oh, I didn't mean to remove these files, 'q'uit from this
>>    mistake", so there is no need to fail here for the lack of "-f".
>
> Well, if we remove -i from error message as well, then yes, this makes
> sense.
> ...
> I then suggest to consider to remove mention of -i from
> clean.requireForce description as well.

The follow-up patch you just reviewed in the other thread does
exactly that.

This is a tangent, but before finalizing the version that complains
"clean.requireForce is in effect and you did not give me -f" without
mentioning "-i" or "-n", I asked gemini.google.com to proofread the
patch and and one of its suggestion was to use this:

    "clean.requireForce is true.  Use -f to override, or consider
    using -n (dry-run) or -i (interactive) for a safer workflow."

as a possibly cleaner message.  It is the opposite of what both of
us concluded to be good in this exchange, but in some sense, it does
sound more helpful to end users, which I somehow found amusing.


