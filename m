Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74734241E5
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664792; cv=none; b=lmvKnrXIgP6cWsQd/08mOiCzSb8qyovKtzDv4JTYwkoMO+WhsncXtqqCTwKlwoa/l7VIyomMaZFhaa/v61CTOy+K6zuytlmw0B8yJ/ym9iG9+p1dsNS0MfgUahv7p3tzHSBv2tuTgbjvE5UJ5qzF9aGdqBfjfvTK2JL5R9Wg96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664792; c=relaxed/simple;
	bh=ic2RQDTs391Kf4ORVhJMfkkVpek970eW1oGrG/QwBn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xx23+u7QUdFmpCPxzF8a3SBB/ma7tIchy976ZnoIZ/VSxJOlgjXRxaXb0Ao+MtOqN/YiEBlMz9cWJOFyTj/BHODXPgXRyeANDBB743lhstclx8NHg1Itucfs8SXk9W6WbxMybFn0x9zIJC7W2sDdNt6xEgmlQZNjmHKgB8Ie1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CEhQvi/V; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CEhQvi/V"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C872F3ECD9;
	Tue,  5 Mar 2024 13:53:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ic2RQDTs391Kf4ORVhJMfkkVpek970eW1oGrG/
	QwBn0=; b=CEhQvi/Vshsd9EsQUkzSWdGUnEFvvjNbLMBfgyzdBf2FTmoe5dkl1x
	0A6aq/fFXLY79FU0GavWi9ke/+CNZ0Nh6EjF2gfPOmElHEyANc8b2R4WBoQ0mLSO
	9LNqNryaL1jyxHOGQP4ckjglZhbJvq6BC0o7esSQwq4kF+5WBwnBM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C05E33ECD7;
	Tue,  5 Mar 2024 13:53:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6527B3ECCE;
	Tue,  5 Mar 2024 13:53:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Atneya Nair <atneya@google.com>
Cc: git@vger.kernel.org,  jeffhost@microsoft.com,  me@ttaylorr.com,
  nasamuffin@google.com,  Tanay Abhra <tanayabh@gmail.com>,  Glen Choo
 <glencbz@gmail.com>
Subject: Re: [RFC PATCH 2/3] Make ce_compare_gitlink thread-safe
In-Reply-To: <xmqqwmqg38u2.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	05 Mar 2024 09:08:21 -0800")
References: <20240305012112.1598053-2-atneya@google.com>
	<20240305012112.1598053-4-atneya@google.com>
	<xmqqwmqg38u2.fsf@gitster.g>
Date: Tue, 05 Mar 2024 10:53:02 -0800
Message-ID: <xmqqsf141pf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 99B62B60-DB21-11EE-9CA5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> The use of strintern() comes originally from 3df8fd62 ...
> ..., so they may
> know how safe the change on the config side would be (I still do
> not understand why you'd want to do this in the first place, though,
> especially if you are protecting the callsites with mutex).

The risks of turning code that uses strintern() to use strdup() are

 * you will leak the allocated string unless you explicitly free the
   string you now own.

 * you may consume too much memory if you are creating too many
   copies of the same string (e.g. if you need filename for each
   line in a file in an application, the memory consumption can
   become 1000-fold).

 * the code may be taking advantage of the fact that two such
   strings can be compared for (in)equality simply by comparing
   their addresses, which you would need to adjust to use !strcmp()
   and the like.

I just checked to make sure that the last one is not the case for
our codebase, and you said you didn't see the second one is the case,
so the change may be a safe one to make.

One more thing.  Do not use strdup() without checking its return
value for failure.  It would be an easy fix to use xstrdup() instead.

Thanks.

>> diff --git a/config.c b/config.c
>> index 3cfeb3d8bd..d7f73d8745 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1017,7 +1017,7 @@ static void kvi_from_source(struct config_source *cs,
>>  			    enum config_scope scope,
>>  			    struct key_value_info *out)
>>  {
>> -	out->filename = strintern(cs->name);
>> +	out->filename = strdup(cs->name);
>>  	out->origin_type = cs->origin_type;
>>  	out->linenr = cs->linenr;
>>  	out->scope = scope;
>> @@ -1857,6 +1857,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn,
>>  
>>  	strbuf_release(&top->value);
>>  	strbuf_release(&top->var);
>> +	free(kvi.filename);
>>  
>>  	return ret;
>>  }

