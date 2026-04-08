Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC2296BAF
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663566; cv=none; b=o4qnKmGqjmJCWXpvUHDDZGOZc2YMvvfsnFbl3NEYAEmv/vO9lUF4mjIKLfvgPoTbyIl5AAgUjgAmnz6fRx8/JvoJj1R6hyskms+7GukSP4zbGiXR+QjLEzTTld9YaTVWfjA6iFs2wjnpx6YT994/HaYooYJ32zTpP7J5mmL6jFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663566; c=relaxed/simple;
	bh=Q/3TzxmGyTsUPLswYm7Go13NHhT441eYUNm1h5IebJs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwwdLpufrkroCh79L+hN23uahwl/o/BUQhFVBXq6j2wGjzN4DrpGi7l/jhHlxg9v5zv+ba8Auu5jRQiDsI0GblWC+vO/3NWaT5SpdO0zfBazjS9Digyt/JQ7XXkhV5k/inup/VLV8zA7kEj7v7cqIleoMdqHWu2dmb1JH2HVTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 638FqeQH3304024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 15:52:40 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Adrian Ratiu'" <adrian.ratiu@collabora.com>,
        "'Jeff King'" <peff@peff.net>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com> <20260408052031.GB1324339@coredump.intra.peff.net> <20260408054347.GA2284358@coredump.intra.peff.net> <871pgp3byq.fsf@collabora.com>
In-Reply-To: <871pgp3byq.fsf@collabora.com>
Subject: RE: Help needed on 2.54.0-rc0 t5301.13 looping.
Date: Wed, 8 Apr 2026 11:52:34 -0400
Organization: Nexbridge Inc.
Message-ID: <012101dcc76f$bae10a80$30a31f80$@nexbridge.com>
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
Thread-Index: AQHvBjVJZsXG7N1gHKdCJ4V3u2kT9AFYabqHAkdaE8oCPPreZ7WB63cA
X-Antivirus: Norton (VPS 260408-0, 4/7/2026), Outbound message
X-Antivirus-Status: Clean

On April 8, 2026 7:53 AM, Adrian Ratiu wrote:
>To: Jeff King <peff@peff.net>; rsbecker@nexbridge.com
>Cc: Junio C Hamano <gitster@pobox.com>; git@vger.kernel.org
>Subject: Re: Help needed on 2.54.0-rc0 t5301.13 looping.
>
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

This fix, however, causes an unreported infinite loop in t5571:

expecting success of 5571.11 'sigpipe does not cause pre-push hook failure':
        test_hook --clobber pre-push <<-\EOF &&
        exit 0
        EOF
        git push parent1 "refs/heads/b/*:refs/heads/b/*"

Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
<and hung>

