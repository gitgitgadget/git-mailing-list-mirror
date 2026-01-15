Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BB3624CC
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476844; cv=none; b=CVOP/13Vj9QyHWSxfLODhu6pyQds9jVw8QpLY+azioLk8lhDwjdtSPW19rF12CyzP+3rSawgfqkkJlnsCLP6zOyMKLhP5b1DFtzDbF2qmgjpDnilVaBUGpFjJwjJDqW9sJnTWcGblaOnfRd+9pdD4CXTlK89PqeQY7lYuRPq+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476844; c=relaxed/simple;
	bh=GrDjBZTPm/2vx026viDlCaI3ryLN5vRbd48/eHfqqk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KNH1NdnLBypmLCmhl/bR1ABa/l93yUMRaZlP+rd++gvsmiauqkfPenELFg1XcfZCmz2WINU0yPsUwq2FfD5m2OZc6x3/adbw2quKFdk2Nk0++QBc97vYqqs71ZX26dWAx88Z/PyGGLpCoFMf7cCo1L7E0Iiu8XRqpRLA5EoVtxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0HeNHsCf; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0HeNHsCf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768476837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wgEaYVcas1fwkgNjCpRxV1ioqhVXiB9fbe8ISdUszNQ=;
	b=0HeNHsCfPTNdeTACHsp72UFnyKMXv4lEGxU8prvTpmvBWPpz3k71JkYoeXclhmzHI0Mdo/
	MewMM08dff37hMlq5zyL7Nch1Tas+HrHPgve937kvT+cuiBMH2Bso6PsJZj1Q67Q/aPZXm
	jjHX1MZqCIFA58adm/EkLqYUpy5e5jk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] last-modified: rewrite error message when more
 than one revision given
In-Reply-To: <aWd2SLrBQRBC1e2S@pks.im>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
 <aWd2SLrBQRBC1e2S@pks.im>
Date: Thu, 15 Jan 2026 12:33:36 +0100
Message-ID: <87jyxjjejz.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jan 14, 2026 at 11:24:45AM +0100, Toon Claes wrote:
>> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
>> index c80f0535f6..06e3f79aec 100644
>> --- a/builtin/last-modified.c
>> +++ b/builtin/last-modified.c
>> @@ -145,16 +145,20 @@ static int populate_paths_from_revs(struct last_modified *lm)
>>  		if (obj->item->flags & UNINTERESTING)
>>  			continue;
>>  
>> -		if (num_interesting++)
>> -			return error(_("last-modified can only operate on one tree at a time"));
>> +		if (num_interesting++) {
>> +			ret = error(_("last-modified can only operate on one revision at a time"));
>
> Do we maybe want to be a bit more specific and say committish instead of
> revision?

I was thinking about mentioning something like "commit-ish" instead, but
I felt "commit-ish" isn't a commonly used term toward end-users. Looking
at gitglossary(7), it says "revision" is a "synonym for commit". I'm
happy to change this message, but I'm not sure s/revision/commit-ish/ is
the best change for this.

>> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
>> index 50f4312f71..1183ae667b 100755
>> --- a/t/t8020-last-modified.sh
>> +++ b/t/t8020-last-modified.sh
>> @@ -12,7 +12,7 @@ test_expect_success 'setup' '
>>  	test_commit 3 a/b/file
>>  '
>>  
>> -test_expect_success 'cannot run last-modified on two trees' '
>> +test_expect_success 'cannot run last-modified on two revision' '
>
> Nit: s/revision/revisions/

Thanks.

>>  	test_must_fail git last-modified HEAD HEAD~1
>
> Another tiny nit: I'm always a bit wary around tests that don't verify
> the reason for failure. We might want to add:
>
>     test_grep "last-modified can only operate on one revision at a time" err

Okay, I'll rework this one and the one adding in the other commit.

-- 
Cheers,
Toon
