Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3627460
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597498; cv=none; b=HJNoErCrMy8HxSC4c3iUE8jV47PbI/KzlkwvBWQwZ/JmWfFc5jzcIKFTnIK0zQQiGf+XAJ988orFM7RSV3uNqruutAByq/KkoD+aMgVMnoUFQ9Efg4dhE8TzRKBp59vAfFhO+gOB7vH+JeeZCMo1bxA1acPkrZLuJ6IOhrSVYMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597498; c=relaxed/simple;
	bh=vThvb3Uu6zWA7xi0MG6etQJOsFHWUMVs+tQES5gDgk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KKzYgFqgGDuOERBQcjppBXibSeditbC+amUlfACbj0tnmpaKpld8gsxX1h4HGlTcgOrJkqT/XmjcTJOCIv7Q6Mgt3lg3IWFK9LM/oNBzbcdAnX7KuyyF4kK/wakjWblvty5S9T8oh8Feso01WAC933ZrkDogClkBeclBtOHy2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eC79iad4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eC79iad4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8D3F1DA381;
	Mon,  8 Apr 2024 13:31:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vThvb3Uu6zWA7xi0MG6etQJOsFHWUMVs+tQES5
	gDgk0=; b=eC79iad4AVXbUAaJCJXhAjaTn6OYo5zQpoSBYDRmQSSUuqdk67J8VE
	Anshom2WRqBTxNXbVKdZShUiC3WIkz/eRzHUs9tq7YQK7jvxHoU4gjPDc5FIYDR2
	o9nrBtd4LfP0krfer6C0tPKnMQPhcSWPO9ZBq88jSTEZ7wFsuWT/U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C15981DA37E;
	Mon,  8 Apr 2024 13:31:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 318B41DA37C;
	Mon,  8 Apr 2024 13:31:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] t: teach lint that RHS of 'local VAR=VAL' needs to
 be quoted
In-Reply-To: <20240407014344.GF1085004@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 6 Apr 2024 21:43:44 -0400")
References: <20240406000902.3082301-1-gitster@pobox.com>
	<20240406000902.3082301-7-gitster@pobox.com>
	<20240407014344.GF1085004@coredump.intra.peff.net>
Date: Mon, 08 Apr 2024 10:31:34 -0700
Message-ID: <xmqqa5m3damh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D8F66FDA-F5CD-11EE-9140-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Fri, Apr 05, 2024 at 05:09:02PM -0700, Junio C Hamano wrote:
>
>> Teach t/check-non-portable-shell.pl that right hand side of the
>> assignment done with "local VAR=VAL" need to be quoted.  We
>> deliberately target only VAL that begins with $ so that we can catch
>> 
>>  - $variable_reference and positional parameter reference like $4
>>  - $(command substitution)
>>  - ${variable_reference-with_magic}
>> 
>> while excluding
>> 
>>  - $'\n' that is a bash-ism freely usable in t990[23]
>>  - $(( arithmetic )) whose result should be $IFS safe.
>>  - $? that also is $IFS safe
>
> Hmm. Just porting over my comment from the other thread (before I
> realized you'd written this series), this misses:
>
>   local foo=bar/$1
>
> etc. Should we look for the "$" anywhere on the line? I doubt we can get
> things foolproof, but requiring somebody to quote:
>
>   local foo=$((1+2))
>
> does not seem like the worst outcome. I dunno.

Looking at the output from

    $ git grep -E -e 'local [a-zA-Z0-9_]+=[^"]*[$]' t/

the listed ones in the proposed commit log message are the false
positives.  Luckily we didn't have anything that tries to
concatenate parameter reference to something else.

But with the pattern we do miss

    local var=$*

and possibly many others.  So I am not sure.  The false positives
do look moderately bad, so I'd rather start with the simplest one
proposed in the patch.

