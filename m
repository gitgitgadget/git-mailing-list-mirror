Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70E1F4180
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663111; cv=none; b=nQeF7FTGPqy3H5JULoeg1Gz0cb6SM7V+smWh4Q/9OYmq1jZPuzkomEuMu1KCJ5F1T+852HPs4ncRTonSFDsehgZYurJVEjf3FQ5CFfKnPIPC1tSs36YWsGY1V1etbS/LRxm3UG0A0AiPkxl5lib3948RvCOPW6xDKZDWhpOd2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663111; c=relaxed/simple;
	bh=FycG1Ac1/6kW4f6287h/+N2A6rf+1HqE+Omelh40ETQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HrqAjqCNlMpuhjSDiH2IJYkzzgwT3wPMANBGs64JydxG3rKzF5Hmp8um86Ef6FjWgpZQh1kPqU2tSzmsTVNvyOcjVMXLP8xJP3+o1icTaWhQGZ36RqmaDiOi+I2W1ph3VT+JpjmGdViBmSxzt+I7tpjD9eCvKBh8SWS5jea9LQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 638Fj2763301749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 15:45:02 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Adrian Ratiu'" <adrian.ratiu@collabora.com>,
        "'Jeff King'" <peff@peff.net>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com> <20260408052031.GB1324339@coredump.intra.peff.net> <20260408054347.GA2284358@coredump.intra.peff.net> <871pgp3byq.fsf@collabora.com>
In-Reply-To: <871pgp3byq.fsf@collabora.com>
Subject: RE: Help needed on 2.54.0-rc0 t5301.13 looping.
Date: Wed, 8 Apr 2026 11:44:56 -0400
Organization: Nexbridge Inc.
Message-ID: <012001dcc76e$aa0449d0$fe0cdd70$@nexbridge.com>
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
Thread-Index: AQHvBjVJZsXG7N1gHKdCJ4V3u2kT9AFYabqHAkdaE8oCPPreZ7WB6jrA
X-Antivirus: Norton (VPS 260408-0, 4/7/2026), Outbound message
X-Antivirus-Status: Clean

On April 8, 2026 7:53 AM, Adrian Ratiu wrote:
>On Wed, 08 Apr 2026, Jeff King <peff@peff.net> wrote:
>> On Wed, Apr 08, 2026 at 01:20:31AM -0400, Jeff King wrote:
>>
>>> I suspect we could construct a related case that does fail on Linux
>>> without the patch above. Imagine we actually have two hooks running in
>>> parallel. The first one is fast and does not read its input, and the
>>> second one is slow. We'll get SIGPIPE writing to the first one, and then
>>> kill _both_ children. But that's wrong! There is no reason to kill the
>>> second hook, as our intent was to ignore SIGPIPE.
>>
>> This would require running hooks in parallel, which isn't implemented
>> yet for v2.54.0. But if I build on top of the ar/parallel-hooks topic,
>> then this test:
>>
>> diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
>> index 44ec875aef..97257763d3 100755
>> --- a/t/t5401-update-hooks.sh
>> +++ b/t/t5401-update-hooks.sh
>> @@ -139,4 +139,43 @@ test_expect_success 'pre-receive hook that forgets
to
>read its input' '
>>  	git push ./victim.git "+refs/heads/*:refs/heads/*"
>>  '
>>
>> +test_expect_success 'hooks in parallel that do not read input' '
>> +	# Add this to our $PATH to avoid having to write the whole trash
>> +	# directory into our config options, which would require quoting.
>> +	mkdir bin &&
>> +	PATH=$PWD/bin:$PATH &&
>> +
>> +	write_script bin/hook-fast <<-\EOF &&
>> +	# This hook does not read its input, so the parent process
>> +	# may see SIGPIPE if it is not ignored. It should happen
>> +	# relatively quickly.
>> +	exit 0
>> +	EOF
>> +
>> +	write_script bin/hook-slow <<-\EOF &&
>> +	# This hook is slow, so we expect it to still be running
>> +	# when the other hook has exited (and the parent has a pipe error
>> +	# writing to it).
>> +	#
>> +	# So we want to be slow enough that we expect this to happen, but
not
>> +	# so slow that the test takes forever. 1 second is probably enough
>> +	# in practice (and if it is occasionally not on a loaded system, we
>> +	# will err on the side of having the test pass).
>> +	sleep 1
>> +	exit 0
>> +	EOF
>> +
>> +
>> +	git init --bare parallel.git &&
>> +	git -C parallel.git config hook.fast.command "hook-fast" &&
>> +	git -C parallel.git config hook.fast.event pre-receive &&
>> +	git -C parallel.git config hook.fast.parallel true &&
>> +	git -C parallel.git config hook.slow.command "hook-slow" &&
>> +	git -C parallel.git config hook.slow.event pre-receive &&
>> +	git -C parallel.git config hook.slow.parallel true &&
>> +	git -C parallel.git config hook.jobs 2 &&
>> +
>> +	git push ./parallel.git "+refs/heads/*:refs/heads/*"
>> +'
>> +
>>  test_done
>>
>> fails reliably. And applying the patch I suggested earlier fixes it.
>>
>> So I think it's probably a good idea regardless, though I'm still
>> curious to see if it solves Randall's non-parallel case on NonStop.
>
>Thanks Peff for the in-depth analysis, fix and test.
>It is very much appreciated. I missed this case.
>
>I agree with your assesement: this must be fixed regardless if it also
>fixes Randall's case or not (might be a separate root cause).
>
>I would proceed like this (obviously crediting you for the fix & test):
>
>If it fixes Randall's case:
>   send a standalone bug-fix patch, then integrate the test into the
>   parallel series.
>else
>   integrate both the fix and the test into the parallel series.
>
>@Randall please let us know if the fix proposed by Peff in the other
>response works for you.

Yes, this fix worked on NonStop. Thanks Peff. The new test also passed.

