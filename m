Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCC1DC9B3
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773825; cv=none; b=WDo5/rmv/EMH09NnN7El1ax5q4CPUFZwwUNCNyA9jOCtPPXzpRWj3pwRNeo/y1uGq3UFNWiTngyNe7/mXhVmWY+wkClLcM0kEO0OX+Pjki/e9jBxK4Wq4FEr7SElL9wkfidVJqxBTqimmM5uxJ6zmLYAR3nFLHmW1kT62e6RuAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773825; c=relaxed/simple;
	bh=TF33L2XrVO9W6S88qwYdc4WWD3tqvRCQE9bf5Z6m31Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K2NRLjDsNTCr363t9U0sqf7G7plj9k3/ur3a9OlV4+xjPiL5dv7+2/gyOpZR08SPe5JR+PlI2piiRf6Y7yONJrXuEjeSS6iV3OLNm1jvwH2tMTsIhzoZ4a/RibW7JT8tAPfd5o37LEF68AkN+322mZcntvGI2P01bWrA1ZmZKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=4oq80iCi; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="4oq80iCi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738773815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/7ZDLlHuCyYf3L5L2xnWlIR/JPzzk7wxER1U6xDMVH4=;
	b=4oq80iCi2Z3VoTl0Gz8LwbS7bKoQErC9gHOvDZHwuJk7rfxMsudChn3R5foonFBCCXncZy
	p7h6fhclpi4y7KNOZHJRaxIAYzLBQ16Gg44Dxxazc5wLYZ3c7SmlvL6KtYFgdERX4mXq/q
	bSh9/wLLAmBuBsJBUnEq1HR3bQFHF00=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 7/7] builtin/clone: teach git-clone(1) the
 --revision= option
In-Reply-To: <Z6MbUbi1A6pTmRdx@pks.im>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
 <20250204-toon-clone-refs-v5-7-37e34af283c8@iotcl.com>
 <Z6MbUbi1A6pTmRdx@pks.im>
Date: Wed, 05 Feb 2025 17:43:17 +0100
Message-ID: <87frks4a1m.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 04, 2025 at 10:34:06PM +0100, Toon Claes wrote:
>> @@ -580,8 +581,9 @@ static void update_head(const struct ref *our, const struct ref *remote,
>>  			install_branch_config(0, head, remote_name, our->name);
>>  		}
>>  	} else if (our) {
>> -		struct commit *c = lookup_commit_reference(the_repository,
>> -							   &our->old_oid);
>> +		struct commit *c = lookup_commit_or_die(&our->old_oid,
>> +						        our->name);
>> +
>>  		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
>>  		refs_update_ref(get_main_ref_store(the_repository), msg,
>>  				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
>
> I wonder: is this fixing a potential segfault? If so, it might make
> sense to split this out into a separate commit and provide a test that
> demonstrates the issue. If it doesn't, then the change shouldn't be
> necessary, unless I misunderstand.

This potential segfault would occur for the added test case:
'clone with --revision being a tree hash'

So I can't really split out this change in a separate commit, but the
change is still needed.

-- 
Toon
