Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16F1A9B46
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772923088; cv=none; b=GJc/Ti75oqS2gCgDMNQXYtxaO+Pr/TW0c0pUAS5f2jqMCXPcnzTXF241ECVmhHwXxBXcRfyA/xvJs/m8ZXqSv1n+vrXRTvZdKcbBwgYn2i1NIl/5mF1MLWVJkytIoQO2pyPXtv5BbRztLvK8UBxbgzFZ3PxndZ3GivdQMDoXWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772923088; c=relaxed/simple;
	bh=7TiAN3TmfDSLSr20xU1B90CeiENYIYWouPqT3eq/XUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAUPZAwWxSNTeawOuV/mqafkcsdS3nK8d/+4dIN6rZBod/USA+7S7HAkppOa+Ac0K6vFVBLzb57XGt/BqDNi+sntzKP8LxjNuntNUcxKGyeemxuxlHKdNVz7TsScwNvpLEY6FIX4sNEH26gP88dyoDf+4065aCixyODgqISYIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4fSypX4byHzRnlX;
	Sat,  7 Mar 2026 23:37:56 +0100 (CET)
Message-ID: <40ccd060-e6f7-4130-a25e-3c2f65df8eb7@kdbg.org>
Date: Sat, 7 Mar 2026 23:37:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] run auto maintenance in git-gui
To: Junio C Hamano <gitster@pobox.com>
Cc: Wolfgang Faust <contrib-git@wolfgangfaust.com>,
 Birger Skogeng Pedersen <birger.sp@gmail.com>,
 Pratyush Yadav <me@yadavpratyush.com>, Marc Branchaud
 <marcnarc@xiplink.com>, git@vger.kernel.org
References: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
 <e17f094f-f869-4cc9-b59c-091b7e61a021@kdbg.org> <xmqqms0jti24.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqms0jti24.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.03.26 um 23:01 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> However, the consequences for users need to be considered. You replace
>> the custom implementation of `git gc` with `git maintenance run --auto`.
>> The latter CAN do a lot more than the former. It turns out, that Git GUI
>> already calls into `git maintance` indirectly via `git merge` and `git
>> fetch`. So, users who set gui.gcwarning to false (myself included) were
>> already prone to occasional inadvertent cleanups.
>>
>> So, users that are hurt by this new change are those where all these
>> conditions are true:
>> ...
>> How many could this be? Not many, I guess. The conservative safe
>> approach would be to treat gui.gcwarning=false as an indication that
>> automatic cleanup is not desired.
> 
> Hmph, if you are _declining_ to see the warning, isn't it a sign
> that you are getting these warnings and got annoyed enough to find
> out about the settings and turned it to "false" to squelch?

The option does not only control whether or not a warning appears, but
also whether garbage collection happens or not. When it is set to false,
then in addition to squelching the warning, garbage collection does
*not* happen. The option is on by default, so if we find it off, the
user must have set it explicitly, a clear sign (IMO) that Git GUI should
not do the garbage collection.

>  And if
> we make pruning more aggressive, wouldn't gui.gcwarning explicitly
> set to false be a sign that you'd be more likely to be in the
> affected poulation?
I think so, too. For this reason, my implied suggestion was to protect
the new call of `git maintenance` with a check whether gui.gcwarning is
enabled. Then we don't make anything worse for those who have it disabled.

-- Hannes

