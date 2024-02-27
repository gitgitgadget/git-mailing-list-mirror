Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95595161
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993131; cv=none; b=figqtWJnn8fQ+/sUU65s/l7xBGeKc6NTTDseZ0w3B3jnA959dDPYP7S0o8Ru6qO86IQCwwFoQC5mU0U8c4Z7o+9pEv9dNRmmDI+gnQ0lg2Z4oNLySobtdrLhAwU1nGWfoNuMNCb/vc41x65FyBeO0Kkfklmp6Em2kwoysASp9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993131; c=relaxed/simple;
	bh=elkOVC5SEjxCTh47nx4UrdMk5EndHVEbt8mp6E1XdC0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=k+M5XjX3z9gqMaq0OtxN7sIzBmfvNoUGXOHnV65cR5r4r1SZYdOxKkYml4LzvJxBHiwuNMW7PzH7L29YeHtRKZo7NihrgrvKKiOpxaWk3Stj7jgso3+jEp7FjUkBc8B7nLshiO95Pw73LRWPh/4a3eNjx16jGGfjHzNVyCXQBlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41R0Ijtn2243400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 00:18:45 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Randall S. Becker'" <the.n.e.key@gmail.com>
Cc: <git@vger.kernel.org>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>	<20240226220539.3494-5-randall.becker@nexbridge.ca> <xmqqr0gyixuu.fsf@gitster.g>
In-Reply-To: <xmqqr0gyixuu.fsf@gitster.g>
Subject: RE: [PATCH v1 4/4] builtin/unpack-objects.c: change xwrite to write_in_full to allow large sizes.
Date: Mon, 26 Feb 2024 19:18:40 -0500
Organization: Nexbridge Inc.
Message-ID: <027201da6912$872779d0$95766d70$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFCEXZVVjijNd8r2UxZXOALnJerBgM8p9xoAdrZHy2yJUWZ0A==

On Monday, February 26, 2024 6:56 PM, Junio C Hamano wrote:
>"Randall S. Becker" <the.n.e.key@gmail.com> writes:
>
>> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>>
>> This change is required because some platforms do not support file
>> writes of arbitrary sizes (e.g, NonStop). xwrite ends up truncating
>> the output to the maximum single I/O size possible for the destination
device.
>>
>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> ---
>>  builtin/unpack-objects.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>The same comment as [1/4].  Perhaps your MAX_IO_SIZE should be tuned
downwards, so that xwrite() works as it was designed to
>work.

I am considering undoing this one, other than ensuring that the error code
is checked and returned. The MAX_IO_SIZE is sufficient. I think the actual
fail was in the original repack.c not this one.

>
>> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c index
>> e0a701f2b3..6935c4574e 100644
>> --- a/builtin/unpack-objects.c
>> +++ b/builtin/unpack-objects.c
>> @@ -680,7 +680,7 @@ int cmd_unpack_objects(int argc, const char
>> **argv, const char *prefix UNUSED)
>>
>>  	/* Write the last part of the buffer to stdout */
>>  	while (len) {
>> -		int ret = xwrite(1, buffer + offset, len);
>> +		int ret = write_in_full(1, buffer + offset, len);
>>  		if (ret <= 0)
>>  			break;
>>  		len -= ret;

