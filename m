Received: from mail-cbf-ext.charite.de (mail-cbf-ext.charite.de [193.175.73.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590719A
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.73.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721207527; cv=none; b=qwXwLXS1M07+OqYze/bfMtoO4xhz7A7nl5l3ebeSRp75nE6VmRjbEU4w8zFxwK8geiJnMFllSgZGEfBLcnvolFoFkDO6varaXD2vkwnoJzO6A9c+41tLFo2Ak1I9EV6ZJGEuSbXVKy9Dh3UHvFYoLv0T6MmXq9iMWjzzYA/nXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721207527; c=relaxed/simple;
	bh=vtAClbJ8LGLExiq1ryFAW3C7cKWCKPUk3oyYW7wQ+kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYbnOvo+C3FfLFOFEkHUVSfKhuGX7SrbJI5CIywpA2Qwv6dH7jI0MKQpbRVbm5YHmkDIq7zc6kmanfE/49SGT3lqqWQde/MQAj4eqD3D9Mef6EjPYXH+USnP4QenOwuaI+qAerRXCSynQob8/r8F0OxgDuoEsdEhBAd0mINQQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=charite.de; spf=pass smtp.mailfrom=charite.de; dkim=pass (1024-bit key) header.d=charite.de header.i=@charite.de header.b=tRXZch7S; arc=none smtp.client-ip=193.175.73.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=charite.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charite.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=charite.de header.i=@charite.de header.b="tRXZch7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=charite.de; s=jun2018;
	t=1721207515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZelI2P7ipY8AY1XjdlIG1Na0z+ea+CictHS8EmHTYM=;
	b=tRXZch7SajbHhh208+KcXpWE4Yj7blmMdGMk2wv4Mw4dD16PGUzDF1UnvswMLTkgTY/3E1
	F8UdcbCu+mLRb2ICCSCPKeAG47a564ILzyOMNzpZ9UrvtMnVN9CxyGgHK8DGHqpXVphtFC
	QHrx6AfBOXloj1evC6+4XmEa83jBnB4=
Received: from [172.29.16.135] (vpn-16-135.vpn.charite.de [172.29.16.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by smtp-out-sv.charite.de (Postfix) with ESMTPS id 4WP9DW0m2Kz6p;
	Wed, 17 Jul 2024 11:11:54 +0200 (CEST)
Message-ID: <0a20d825-3430-4397-962c-a6b5e94d70eb@charite.de>
Date: Wed, 17 Jul 2024 11:11:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ext] Re: bug: `git pull` does not clean up after itself if it
 fails
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <0cc13c53-1d8d-4501-89f2-e8329bc95485@charite.de>
 <20240717055549.GD547635@coredump.intra.peff.net>
From: Nikolai Zaki <nikolai-waleed.zaki@charite.de>
In-Reply-To: <20240717055549.GD547635@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff,

thanks for your reply. You're right, the problem happens during merge.

Since merge already aborts if the index doesn't match HEAD though, 
couldn't it be as simple as saving the state of the worktree and then 
either restoring it in case of failure or applying the diff in case of 
success?

In terms of git commands I think the following would work:

When `git merge` is run first run `git stash --all` then `git merge` as 
usual.

If there are non-conflict errors: `git checkout .` and `git clean -f;

If there are no errors `git stash pop`.


On 7/17/24 07:55, Jeff King wrote:
> On Mon, Jul 15, 2024 at 01:19:32PM +0200, Nikolai Zaki wrote:
>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> In your local repo have a directory that you cannot write to.
>> Pull from a remote that has changes/new files in that directory.
>>
>> What did you expect to happen? (Expected behavior)
>> The pull fails and the local repo in the same state as before.
>>
>> What happened instead? (Actual behavior)
>> All changes to writeable files are applied and all new files in writeable
>> dirs are added.
>> The local HEAD however remained the same.
>>
>> What's different between what you expected and what actually happened?
>> A failed `git pull` inadvertently creates changes and untracked files.
> A pull is basically fetch followed by merge. So I'd expect us to fail in
> the merge step, at which point pull would generally leave the state
> as-is, because merge failures tend to be conflicts.
>
> So I guess doing what you expect would require a merge which hits a
> non-conflict error (like an unwriteable directory) to clean up after
> itself. That's probably not impossible, but it may be rather tricky,
> especially if we are concerned about unrelated changes in the working
> tree.
>
> -Peff
-- 
Best,
Nikolai
