Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4E30B506
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098483; cv=none; b=T8tpSAI4guEGqII2II9254fIDzvm5XS2yrLt46Wpj2Vtn5X1rq+GiKBdKejySRBL/GS299G1hSoEJ9I8BxzFP3GvgbEyY3cuLdB+sh1CC0c6H3xfS3HvXqSES+mDzWwM+uJCjoZXYu7BX0NaUAKpYv3q5qY2l/8bfOjXLGnr9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098483; c=relaxed/simple;
	bh=UMG9vC47cXlNbtSo4yraDdis5dAcGb8SpI2w579vLHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LJ4OZ7DZgXbGqsF1ho87z3tqYhv9aGL/nddnOTJHG/TWDHeyxLOfw5mL53Oph6XVGkvap/Dkyo3v7nZaOTwsjP5nMLEFlKbCACIerTN6OGzsFsVW5e18bSZ8ktXjPKuEnCKBSAvVEL7VZut0SXHj/q/QlKXn+Y0qjr7SpPZ18PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=qGP8/AJL; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="qGP8/AJL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1758098475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S0mvPJgoVfeBFOPPVt7OddPLDrl7VJkz1kKrN/JRwbY=;
	b=qGP8/AJLZcpzM7U0ZVQWWLZB1why9b8RgEUq9nXwQzkRMjrGAh28eCfvUupeZrXcVRqcbX
	tEntG57lKOZTgPE5EVZPLsfB01KgicJF8UI5lWa+jg/Wa4pBNaHPB9pmiwjrZTiPuwPBzP
	aFvSvb1lH/7orTmnOYT65lRBZEt/AiE=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] bundle-uri: do not abort on invalid packet line
In-Reply-To: <yqyn5w6oq47lhrcbuziip5tajzrpylirswr5kyfyu35n3k7vgj@jn4rc7cwqwow>
References: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
 <20250912-b4-toon-bundle-uri-no-uri-v1-2-f4525a406df8@iotcl.com>
 <yqyn5w6oq47lhrcbuziip5tajzrpylirswr5kyfyu35n3k7vgj@jn4rc7cwqwow>
Date: Wed, 17 Sep 2025 10:40:59 +0200
Message-ID: <878qido4is.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> Is there any reason that the server should be expected to invalid data
> to the client?

You mean "should be sending"? Well, at $DAYJOB we've had some
unintentional misconfiguration that led to a similar failure[1]. I
wasn't able to reproduce the exact same failure in test, because it
requires to pass different configuration to the `GET info/refs` and
`POST upload-pack` handlers, but the effect is the same.

[1]: https://gitlab.com/gitlab-org/git/-/issues/564

> If the server is misconfigured, I wonder if it should
> instead handle this issue by not sending the invalid bundle-uri in the
> first place and printing a warning message on the server-side. From
> client perspective, if it's a server-side issue there may not be much
> they can do about the error and it could cause some confusion.

I can include a server-side fix in this series as well, but that doesn't
hold back there might be servers out there in the field that don't have
that fix and still serve invalid data. I think ideally we should fix it
on both sides.


>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>>  connect.c                   |  4 ++--
>>  t/t5558-clone-bundle-uri.sh | 25 +++++++++++++++++++++++++
>>  2 files changed, 27 insertions(+), 2 deletions(-)
>> 
>> diff --git a/connect.c b/connect.c
>> index 8352b71faf..d2e2bd8cce 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -536,8 +536,8 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
>>  		if (!bundle_uri_parse_line(bundles, line))
>>  			continue;
>>  
>> -		return error(_("error on bundle-uri response line %d: %s"),
>> -			     line_nr, line);
>> +		warning(_("ignore invalid bundle-uri response line %d: %s"),
>> +			    line_nr, line);
>
> If I'm understanding correctly, an error here indicates some sort of
> issue between the client and remote Git server while figuring out the
> bundle-uri capability.


> I think it is reasonable for the client to always
> expect the server to communicate in a way it understands and IMO should
> probably be handled by fixing the server-side instead.

Ideally yes, but broken servers exist now. Having clients deal with it
properly is anyway advised in my opinion.

-- 
Cheers,
Toon
