Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD71161
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708992965; cv=none; b=kgG6DB5XV7St93zUSRoCxD662S5Y1KGZ8cGGWkBYJFsq9RHSwnTu5ydc04AC0sdhxh6mb+x4UNGwlkcfrpLNulc8Y3B9xKkhF/iCDDMZLf7wK1Pm5CfyxnvTlm4nBwLpZvRJNDImafD6jdBRJtUIJlxwf3mfPJiGBaoLz3iiqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708992965; c=relaxed/simple;
	bh=QIuh2kJCSqwjhZZnyZkdYHAIdDrtOZqjGalD2JaMn8E=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrN/VshvoFKQ2M5AqF8vHsvjUFR04YdByJQKFLxqCvWretjPLH3Btqu6InTiqf5vewFaWAxOyefKl4eNmK9rKZEmHn4tdFvuxfIewjhkqi7bnGWGo+2RZzO/0m7a/yJkUmb+v4+FOwYhf7yM134Fe2EHRtUtnHoGMNOJwzBCNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41R0Fw1n2243107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 00:15:58 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Randall S. Becker'" <the.n.e.key@gmail.com>
Cc: <git@vger.kernel.org>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>	<20240226220539.3494-3-randall.becker@nexbridge.ca> <xmqq34tekcoo.fsf@gitster.g>
In-Reply-To: <xmqq34tekcoo.fsf@gitster.g>
Subject: RE: [PATCH v1 2/4] builtin/receive-pack.c: change xwrite to write_in_full to allow large sizes.
Date: Mon, 26 Feb 2024 19:15:53 -0500
Organization: Nexbridge Inc.
Message-ID: <027101da6912$23cf31c0$6b6d9540$@nexbridge.com>
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
Thread-Index: AQFCEXZVVjijNd8r2UxZXOALnJerBgFnNa3tA03NVzKyKFhhAA==

On Monday, February 26, 2024 6:51 PM, Junio C Hamano wrote:
>"Randall S. Becker" <the.n.e.key@gmail.com> writes:
>
>> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>>
>> This change is required because some platforms do not support file
>> writes of arbitrary sizes (e.g, NonStop). xwrite ends up truncating
>> the output to the maximum single I/O size possible for the destination
device.
>
>As msg[] here is 4k on-stack buffer, if the I/O size is small enough, the
above may happen, and I think write-in-full is warranted here.  If
>your I/O must be done in 1k chunks, it would be very slow to run things
like writing a pack stream to clone any non-toy projects,
>though X-<.

On the x86 platform, we get a size large enough not to trigger the failure
in t7704. However, on ia64, the limit is 56Kb, which apparently does. I'm
hoping no one else has a 1Kb limit - although some TCP stacks might
experience it. Either way, truncating a package is bad. Fortunately the I/O
subsystem on NonStop is very fast (basically DMA) between process memory
space.

>
>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> ---
>>  builtin/receive-pack.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c index
>> db65607485..5064f3d300 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -455,8 +455,9 @@ static void report_message(const char *prefix,
>> const char *err, va_list params)
>>
>>  	if (use_sideband)
>>  		send_sideband(1, 2, msg, sz, use_sideband);
>> -	else
>> -		xwrite(2, msg, sz);
>> +	else {
>> +		write_in_full(2, msg, sz);
>> +	}
>>  }
>>
>>  __attribute__((format (printf, 1, 2)))

