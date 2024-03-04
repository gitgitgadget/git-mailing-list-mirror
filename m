Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E9134AD
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537398; cv=none; b=EUMIwE3lPcS2pAN8zaYiXLsPmIHw0Yzspjw0zqQjtQTpTSZlO6XqCqDnsBFS2TJ5th6LMbz5MhFS95dtPNz50qx+oIRJPED2FZByfCnLcRlg6t00sA1e2uFkxANQR/b80NWbxFTvH4jGDRSV242kFJC60/TaByQq6ralAIelvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537398; c=relaxed/simple;
	bh=DQ3y9umBxK0N9Q8sB4r6r6Zc060Nq4H/bSC0HkbjJf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=scLP0RgzM+JLQfhjp3p0cq7ih22BnWvqI+CMkIaqJIly7l8pTgBnx2EAgY6665jnko2J05Yr7LycNbvqeRKnNaKFMsZPb1wN+LmkaMyo7bWw6iTYn17Iz2S3OHFDOIOPjJeBD7jTuFQJwAJiyVdvWctrOAg6DnNtzXtP+dojiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iGa4dbs8; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iGa4dbs8"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FD3731E8C;
	Mon,  4 Mar 2024 02:29:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DQ3y9umBxK0N9Q8sB4r6r6Zc060Nq4H/bSC0Hk
	bjJf8=; b=iGa4dbs8ie1yE8XeiHsVMlexeSHGUYectgoFRA3qZUjRcwSbo7dTGx
	8jpz2BLW1nePUZ4usPmal87HicsHZGW9Y16otHnS0uhAkiZaRAd4VvIxcxGX/pwx
	31i19ccAfjVq+9HTRTurAxEmUoHmTJAj0gmlMkIpbg3Ebc5t5an3c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C24631E8B;
	Mon,  4 Mar 2024 02:29:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A527031E8A;
	Mon,  4 Mar 2024 02:29:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] unpack: replace xwrite() loop with write_in_full()
In-Reply-To: <ZeVxA1KvN18Y85J_@tanuki> (Patrick Steinhardt's message of "Mon,
	4 Mar 2024 07:58:11 +0100")
References: <20240302190348.3946569-1-gitster@pobox.com>
	<20240302190348.3946569-2-gitster@pobox.com> <ZeVxA1KvN18Y85J_@tanuki>
Date: Sun, 03 Mar 2024 23:29:48 -0800
Message-ID: <xmqqfrx6sbdf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FC874776-D9F8-11EE-A12F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> -		while (input_len) {
>> -			err = xwrite(1, input_buffer + input_offset, input_len);
>> -			if (err <= 0)
>> -				break;
>> -			input_len -= err;
>> -			input_offset += err;
>> -		}
>> +		/* Write the last part of the buffer to stdout */
>> +		write_in_full(1, input_buffer + input_offset, input_len);
>
> With this change we stop updating `input_len` and `input_offset`, both
> of which are global variables. Assuming that tests pass this must be
> okay right now given that this is the final part of what we are writing.
> But I wonder whether we shouldn't update those regardless just so that
> these remain consistent?

It is probably a good hygiene, even though it may not matter at all
for the correctness in the current code.

Thanks for your sharp eyes.

>> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
>> index e0a701f2b3..f1c85a00ae 100644
>> --- a/builtin/unpack-objects.c
>> +++ b/builtin/unpack-objects.c
>> @@ -679,13 +679,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
>>  	use(the_hash_algo->rawsz);
>>  
>>  	/* Write the last part of the buffer to stdout */
>> -	while (len) {
>> -		int ret = xwrite(1, buffer + offset, len);
>> -		if (ret <= 0)
>> -			break;
>> -		len -= ret;
>> -		offset += ret;
>> -	}
>> +	write_in_full(1, buffer + offset, len);
>
> Same here.
>
> Patrick
>
>>  	/* All done */
>>  	return has_errors;
>> -- 
>> 2.44.0-84-gb387623c12
>> 
>> 
