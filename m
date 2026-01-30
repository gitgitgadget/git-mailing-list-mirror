Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8D32E723
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769766945; cv=none; b=cf6OcCZyy3aXub1u32ncadT2Qic1y7BcH7fHvl+oXGzJJFIR2iZIuLfnybAiVL4Oz6mcCoqxeJLXtFgQZwIt+53Eb6Qcavnplj7rNNb8QWLtsrX5XtKpSwvMdnz9JwWEdCrfYdRar4MRDBx9csqV6Casqg8qjIif72MEXZDie1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769766945; c=relaxed/simple;
	bh=O4Inxh3eRN9Gz0PBhTZTHdOvuqVNH/S5UPH/jj5J0lA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CUs+Y0yiMFX8cIiZihkYfioIQfMQ72pVF9vHd5QTThwR3DFZjbOhrigZngxrUeBUS1Wjf0wqZYjw9Rr63zEo3u29hMQSiHsN1T49vlu6P4OU5msNCCm1f9OV8yXJaEPXiU08Z6HIUmPshyUJRCLEm0a18HsbSirzFt3XBJt1Hvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4f2Wbb62N5zRpLH;
	Fri, 30 Jan 2026 10:55:39 +0100 (CET)
Message-ID: <edc47d68-7e34-49af-b719-cef3076f6eeb@kdbg.org>
Date: Fri, 30 Jan 2026 10:55:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] t/perf/p3400: speed up setup using fast-import
From: Johannes Sixt <j6t@kdbg.org>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
References: <20260126165618.596944-1-a3205153416@gmail.com>
 <20260128160717.611391-1-a3205153416@gmail.com>
 <04005f67-3ec5-4fa7-9fd7-37ef9034286a@kdbg.org>
Content-Language: en-US
In-Reply-To: <04005f67-3ec5-4fa7-9fd7-37ef9034286a@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 30.01.26 um 07:41 schrieb Johannes Sixt:
> Am 28.01.26 um 17:07 schrieb Tian Yuchen:
>> +
>> +	(
>> +		for i in $(test_seq 100)
>> +		do
>> +			...
>> +			cat content_rev &&
>> +			echo "EOF" || return 1
> 
> This is an incorrect use of `return` outside a function. This must be
> `|| exit 1` (or just `|| exit`) to actually break out of the loop.

I am wrong here, because my earlier tests were too narrow. This use of
`return` actually does work as intended, because it happens inside a
function. Neither the subshell nor being in the upstream of a pipe
negates this fact.

The rest of the comment still stands, though.

> Of course, the error code is ignored, because it is in the upstream of a
> pipe, so in order to fail the complete command, it would be necessary
> that the original error left an incorrect fast-import stream such that
> the down-stream `git fast-import` fails. Otherwise, the entire command
> can complete successfully in an unexpected way.
> 
> Maybe instead of a pipe, dump the stream into a temporary file, so that
> the loop's exit code can be captured?
> 
>> +		done
>> +	) | git fast-import &&
-- Hannes

