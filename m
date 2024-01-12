Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8B25602
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pe5cHmrH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52C781C3922;
	Fri, 12 Jan 2024 13:13:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=04f/H7DzByL06G0aGJ5gF4JbUEmTotDm3WI89O
	BgzT0=; b=Pe5cHmrH7Lg2K4I98phUReStOaXtW4r75U37X2EGou6H3iQ2Pt4id4
	DIMzaanzE9v528V4bQBENNhqb/Nr7BR7dqZlE3mltwhI4kN5ud9yP0m1XJZCiIOg
	KYg9LcqGKMQMd7Sw4xpUVdQ2CKsnaXVJCpFxF+AMRt4bgsAWioRAI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A9BA1C391E;
	Fri, 12 Jan 2024 13:13:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD7C01C3915;
	Fri, 12 Jan 2024 13:13:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  wanja.hentze@bevuta.com
Subject: Re: [PATCH v3] builtin/revert.c: refactor using an enum for cmd-action
In-Reply-To: <20240112072404.GF618729@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 12 Jan 2024 02:24:04 -0500")
References: <xmqqsf33fy3t.fsf@gitster.g>
	<20240111200627.64199-1-mi.al.lohmann@gmail.com>
	<20240112072404.GF618729@coredump.intra.peff.net>
Date: Fri, 12 Jan 2024 10:13:03 -0800
Message-ID: <xmqqil3ybets.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3C2CB61E-B176-11EE-8F20-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> But your way of seeing it also makes sense to me. I think I just find
> the "START" name jarring because we do not use that word elsewhere to
> describe the action.

Thanks.  I forgot to say that I share the same feeling, both about
"NONE could mean no-op" (but then seriously why would anybody sane
want that?) and "START is not how we spell these things".  I can see
how DEFAULT could make sense, but if somebody picked DEFAULT between
two sensible choices NONE and DEFAULT here, especially if they claim
that they started this enum to mimick what is done in another place,
and after they were told that the other place they are imitating
follows the convention of using NONE for "nothing specified, so use
default", I would have to say that they are trying to be different
for the sake of being different, which is not a good sign.  I'd want
our contributors to be original where being original matters more.

>> +{
>> +	switch (cmd) {
>> +	case ACTION_CONTINUE: return "--continue";
>> +	case ACTION_SKIP: return "--skip";
>> +	case ACTION_ABORT: return "--abort";
>> +	case ACTION_QUIT: return "--quit";
>> +	case ACTION_START: BUG("no commandline flag for ACTION_START");
>> +	}
>> +}
>
> I find this perfectly readable, and is likely the way I'd write it in a
> personal project. But in this project I find we tend to stick to more
> conventional formatting, like:
>
>   switch (cmd) {
>   case ACTION_CONTINUE:
> 	return "--continue";
>   case ACTION_SKIP:
> 	return "--skip";
>   ...and so on...

Same.  I try to do the latter while working on this project, but I
do admit I use the former in small one-page tools I write outside
the context of this project.

>> +	if (cmd != ACTION_START)
>
> Likewise here I'd probably leave this as "if (cmd)".

I 100% agree with the suggestion to explicitly define something to
be 0 when we are going to use it for its Boolean value.  So an
alternative would be to treat all ACTION_* enum values the same, and
not define the first one explicitly to 0.  

Especially in the context of a patch that wants to turn if/elseif
cascades to switch, I would suspect that the latter, as switch/case
does not special case the falsehood among other possible values of
integer type, might be easier to maintain in the longer term.

Thanks.

