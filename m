Received: from mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0501477E48
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254077; cv=none; b=HQ17lCBjNqVHEuDBstozR9xvTyjcgByM+zEczLdvpRyiyV5Ti7BrIV51zVWQemEsWE39haIZMhxiqkcvgT1/Z2AT8lMoadGxsIROS/Y09yXQbl5Sn073t9CdwYaiThIlmd7OXxVIqo/JclIpM34ga1dATWfPVfO8NpWApH3Z0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254077; c=relaxed/simple;
	bh=aQzXPtu+Vun7IXOmGSdml8dJxqkTJvpHPYcRh4xb0ro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tpvBdzvSs3DP1sb6R5nxEXexj/uYUUJGEE1Uyqrw3CjGBXGeNiO1U23zUvNxmXq7K+Q05VzkmH0+LxQM0blxZIbVkNzG14RFyU866+5x4I0XiD94PNpkLRmsEeZaIlEx8z1ObQ3zvnfj15K0SdRTtEIbqC5Dzh047qkpJCrA8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=dUTyaZeq; arc=none smtp.client-ip=91.218.175.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="dUTyaZeq"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aQzXPtu+Vun7IXOmGSdml8dJxqkTJvpHPYcRh4xb0ro=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788254071; v=1; x=1788858871;
 b=dUTyaZeqzq8LopsHpc85uh0NgYI2T4GO26O7FqDEZz5y817H7P89kG3nr5ipQpRJqvB6wEz1
 c7rtWh31ot/bca8wTdP7v81W7fL0YBncjiDwp3COfjJYZD+vcMK14EF/kXgJqh03v1Nu9QSLYds
 xrIP4zs3lfZtyCgj+JDOMTJM=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id fa86a767dbd38d20;
	Tue, 01 Sep 2026 09:14:21 +0000
X-Mizu-Trace-ID: fa86a767dbd38d20
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>, Jeff King
 <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 6/6] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
In-Reply-To: <xmqq8q5lvc1i.fsf@gitster.g>
References: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
 <20260831-toon-speed-up-last-modified-v3-6-2bbb864acf93@iotcl.com>
 <xmqq8q5lvc1i.fsf@gitster.g>
Date: Tue, 01 Sep 2026 11:14:13 +0200
Message-ID: <87mru1wcyi.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
>> index df73c7d0d0..75b18ee83b 100755
>> --- a/t/t8020-last-modified.sh
>> +++ b/t/t8020-last-modified.sh
>> @@ -290,6 +290,32 @@ test_expect_success 'last-modified with Bloom filters and --show-trees' '
>>  	)
>>  '
>>  
>> +test_expect_success 'last-modified with Bloom filters and top-level wildcard' '
>> ...
>> +		GIT_TRACE2_PERF="$(pwd)/off.perf" \
>> +			git -c core.commitGraph=false last-modified -r HEAD \
>> +			-- "*.c" >expect &&
>> +		test_grep "data .* bloom_queries:0$" off.perf &&
>
> Ah, OK.  With GIT_TEST_COMMIT_GRAPH=1 exported from the test harness
> environment, 'git -c core.commitGraph=false' would not be effective
> here.  You would need to do something like:
>
> 		GIT_TEST_COMMIT_GRAPH=0 GIT_TRACE2_PERF="$(pwd)/off.perf" \
> 			git -c core.commitGraph=false last-modified -r HEAD \
> 			-- "*.c" >expect &&
>
>> +		GIT_TRACE2_PERF="$(pwd)/on.perf" \
>> +			git -c core.commitGraph=true last-modified -r HEAD \
>> +			-- "*.c" >actual &&
>
> And in the case where GIT_TEST_COMMIT_GRAPH=0 comes from the
> environment, you might want to be explicit about setting the
> variable here as well.

Thanks for this suggestion. Yeah, I didn't notice it makes CI fail.

But a little bit of a followup question, I noticed I also should be
setting these in [PATCH 5/6], but test don't fail if not set
appropriately.

I just sent out version 4, but to make it really waterproof, test case
'last-modified with Bloom filters and --show-trees' also should use
trace2 counters. Although I wasn't convinced it's worth it?

-- 
Laters,
Toon
