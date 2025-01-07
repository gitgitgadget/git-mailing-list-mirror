Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD918E02A
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283806; cv=none; b=J/3k5+2Hh+9k0xbPi0oqzoLQoYx2s/r/4oQT5wOXPucC+HIkzh8lKe6KlSMi52rjPxue3TTe7jhSvkF4KG1gWbfCRFpSvxXcHIrJpaRu3qGKkyW3FIz9rjOS6foFujDT2edJPXvB3zx5Our3WAUfFYAdTwH2OML6bFDMB6wnSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283806; c=relaxed/simple;
	bh=epH6wHGBPKqRgcKoOqLHbbZhKpOw3tspGt25Q0W296w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=tB6EWXu3gIkz3b38IK1VWX92TNkQbLCTj5ADzGFfVwdtw/YzGoYh7rhsZNH/K0bI1V63LapAo5EmyaY2TYsnmTjMzP08171Kadyz+8OXD6KQ/oAYIxUtzHmg2+oz6vks6m/0j1FxsIcOrrnoLD76Inv9HTcoLYaNZnMsVpOkpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 507L3CNT1596071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 21:03:13 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: <git@vger.kernel.org>, "'Randall S. Becker'" <randall.becker@nexbridge.ca>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>	<20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im> <xmqqzfk2qr62.fsf@gitster.g>
In-Reply-To: <xmqqzfk2qr62.fsf@gitster.g>
Subject: RE: [PATCH 2/2] reftable/stack: accept insecure random bytes
Date: Tue, 7 Jan 2025 16:03:07 -0500
Organization: Nexbridge Inc.
Message-ID: <007f01db6147$90a24ed0$b1e6ec70$@nexbridge.com>
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
Thread-Index: AQKra1ik1fhxhiR8lx9L1yKHV+swtwKZ2O1MAlKwQdGxRFLnEA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250107-4, 1/7/2025), Outbound message
X-Antivirus-Status: Clean

On January 7, 2025 3:56 PM, Junio C Hamano wrote:
>Patrick Steinhardt <ps@pks.im> writes:
>
>> The report was for NonStop, which uses OpenSSL as the backend for
>> randomness. In the preceding commit we have adapted that backend to
>> also return randomness in case the entropy pool is empty and the
>> caller passes the `CSPRNG_BYTES_INSECURE` flag. Do so to fix the issue.
>
>No kidding.
>
>This is calling rand(3).  The use of the resulting value is to fuzz the
delay before
>retrying, which wants NO CRYPTOGRAPHIC randomness.
>This callsite does not require it, but rand(3) is perfect for ensuring
>predictability/repeatability as well (via srand(3)).
>
>And it is not allowed to fail.

I don't think rand() is what is failing here. The call into OpenSSL is using
randomness
from PRNGD. A poorly configured, or overloaded instance of it will cause
this situation.
The ia64 platform for NonStop is using a standard PRNGD but it is being
overloaded
with a large volume of uses hitting that server. I think this is more of a
canary-in-the-coalmine situation, where we have just brought something to
light
that otherwise would be hard to recreate.

>Yet a platform replaces it with a function that returns an error or aborts?
What kind
>of nonsense is that?  Do we really need to cater to such an insanity?

NonStop has not replaced this call. What we did in OpenSSL is to use the x86
hardware randomizer, which is highly reliable and does not show this
problem. In
ia64, in OpenSSL, the PRNGD is generating randomness and that seems to be
not
reliable enough for git or OpenSSL when under significant load.

>Use of git_rand() here goes backwards against the more recent trend in
reftable/
>directory to wean the code off of the rest of Git by getting rid of
unnecessary
>dependency, doesn't it?
>
>I think [PATCH 1/2] makes sense regardless, though.  But shouldn't we be
pushing
>back this step, with "fix your rand(3)"?
>
>Thanks.
>
>> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  reftable/stack.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/reftable/stack.c b/reftable/stack.c index
>>
>6d0aa774e7e29d5366ed55df19725944f8eef792..572a74e00f9ed6040534e060
>652e
>> 72c26641749d 100644
>> --- a/reftable/stack.c
>> +++ b/reftable/stack.c
>> @@ -493,7 +493,7 @@ static int reftable_stack_reload_maybe_reuse(struct
>reftable_stack *st,
>>  		close(fd);
>>  		fd = -1;
>>
>> -		delay = delay + (delay * rand()) / RAND_MAX + 1;
>> +		delay = delay + (delay * git_rand(CSPRNG_BYTES_INSECURE)) /
>> +UINT32_MAX + 1;
>>  		sleep_millisec(delay);
>>  	}
>>
>> @@ -659,7 +659,7 @@ int reftable_stack_add(struct reftable_stack *st,
>> static int format_name(struct reftable_buf *dest, uint64_t min,
>> uint64_t max)  {
>>  	char buf[100];
>> -	uint32_t rnd = (uint32_t)git_rand(0);
>> +	uint32_t rnd = git_rand(CSPRNG_BYTES_INSECURE);
>>  	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
>>  		 min, max, rnd);
>>  	reftable_buf_reset(dest);

--Randall

