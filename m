Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928823E95A1
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451444; cv=none; b=ANQGONsjjdH07XCH1LQSvYmU4FCLwa7Zo96ilHjL2+NRwSR4M9Rl/+q4nM72+HLFWoKBj56bOjmndpJ60JvoAbybwItPgXykcVciVx5W9U967hihk7/NaQnwyua5V0PYkK5zculfdBUxa4UJFxDjsR9g+6ffsOG4BOlO8FlttpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451444; c=relaxed/simple;
	bh=nhHlyDgeP0DFDxJVOHLWKIFS2GsFESrgN3vQLQ2RHDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pVauwyLpvI7uQ6rRCh3c6pvb+jjItPK2WGrYdHVELfYdBF5JDFyuNX66Youg6vSXH1jXnpa3Kfa67CmzbsHvQHzLuanOgfqMqGpt6C5vp0pc7JcIGkI0CgJpTGsPD0kfCUg+PchphaFqbL0BF0oKaaHZ5ZFi+MAuCdUUnz0izvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=JBJVKv5S; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="JBJVKv5S"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774451438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gcTB6bJjqlFJSfGx0yxPeBvoA10KK6FKGgPJFRHZq4Q=;
	b=JBJVKv5ScqbAuTFIIGiACd58HRGWQG5qtfwG10W6tT3QuAWRqwy0KTY1TS4UokFAQRWiRX
	U4NUhutlHGwoyUi/qG+kv9VGFOe2IBiwTHdr6qBRyX4V21hMw0wgg+Uid2KVixdQLTZnjz
	D9eZGSXvWf1cFtBxO7pKttn+1C24Z8s=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Siddharth Asthana
 <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, phillip.wood123@gmail.com, karthik.188@gmail.com,
 johannes.schindelin@gmx.de
Subject: Re: [PATCH v5 2/2] replay: add --revert mode to reverse commit changes
In-Reply-To: <xmqqh5q4xvyw.fsf@gitster.g>
References: <20260313054035.26605-1-siddharthasthana31@gmail.com>
 <20260324220401.47040-1-siddharthasthana31@gmail.com>
 <20260324220401.47040-3-siddharthasthana31@gmail.com>
 <xmqqh5q4xvyw.fsf@gitster.g>
Date: Wed, 25 Mar 2026 16:10:30 +0100
Message-ID: <87cy0s0wt5.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> diff --git a/builtin/replay.c b/builtin/replay.c
>> index 2cdde830a8..d3c1d920f0 100644
>> --- a/builtin/replay.c
>> +++ b/builtin/replay.c
>> @@ -83,7 +83,7 @@ int cmd_replay(int argc,
>> ... 
>>  	/* Parse ref action mode from command line or config */
>>  	ref_mode = get_ref_action_mode(repo, ref_action);
>>  
>> +	/*
>> +	 * Cherry-pick/rebase need oldest-first ordering so that each
>> +	 * replayed commit can build on its already-replayed parent.
>> +	 * Revert needs newest-first ordering (like git revert) to
>> +	 * reduce conflicts by peeling off changes from the top.
>> +	 */
>> +	int desired_reverse = !opts.revert;
>> +
>
> Compiler notices -Werror=declaration-after-statement error here.

That's basically the only comment I have on this series.

Except for one micro-hit on the existing docs about <revision-range>:

    <revision-range>::
    	Range of commits to replay; see "Specifying Ranges" in
    	linkgit:git-rev-parse[1]. In `--advance <branch>` mode, the
    	range should have a single tip, so that it's clear to which tip the
    	advanced <branch> should point. Any commits in the range whose
    	changes are already present in the branch the commits are being
    	replayed onto will be dropped.

Next to --advance, we should also mention --revert. But that's totally
not worth a reroll and can be addressed in any other later series.

-- 
Cheers,
Toon
