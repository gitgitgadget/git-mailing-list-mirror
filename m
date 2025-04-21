Received: from mail.markus-raab.org (mail.permaplant.net [95.217.75.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A74A3C
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.75.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745213900; cv=none; b=la+oX/x/Y3Lep/idA7fDv3rmzlV1W6X+tBrTLCZJdUMBc3rnpQeLwzQf+I6iXyZfeP+7sWz6TMz39NybQL24wr00t0njniWwGAhm81vEmIQfqLJ3prePxkuxzafHUx1cq6r6P3v2aSaMhnnlmiyf45nGbDu8xbiKSRHnp61YmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745213900; c=relaxed/simple;
	bh=yGtNfNRVfcC+2Exve4xc2kFY8Jh8n57Oy/hDJjiwgnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsPzCeMKR9T8SM64Mcq4rBixzoJObx2Kc5jmn/HPUq/HjxFqW7HvsB74jda4rwpcr27/5KKxX9+iplkkzGFswQcKyQMQTF9mu0aIJWjENXC2TnO5spn5DAJ5KCfSrtX5dIRxAo/TyWeRinwQldtNLdw0fHxM5Wo0HHiclojhmPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markus-raab.org; spf=pass smtp.mailfrom=markus-raab.org; arc=none smtp.client-ip=95.217.75.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markus-raab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markus-raab.org
Received: from [192.168.1.2] (h082218105086.host.wavenet.at [82.218.105.86])
	by mail.markus-raab.org (Postfix) with ESMTPSA id 36117CA1EA;
	Mon, 21 Apr 2025 07:38:14 +0200 (CEST)
Message-ID: <033e4524-d169-4003-9e2c-aa32797a67b5@markus-raab.org>
Date: Mon, 21 Apr 2025 07:38:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unwanted interaction of git stash and cherry-pick --abort
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <d8c1df4e-a4d7-4c4c-be44-b13de3d9ffea@markus-raab.org>
 <aAT4kHFPEb5qwoMv@tapette.crustytoothpaste.net>
 <95f731c2-ad2f-40cc-a7d9-85f52cc16389@markus-raab.org>
 <xmqqjz7e8rxa.fsf@gitster.g>
Content-Language: en-US
From: Markus Raab <mailinglists@markus-raab.org>
In-Reply-To: <xmqqjz7e8rxa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear maintainers,

Am 20.04.25 um 23:05 schrieb Junio C Hamano:
> Markus Raab <mailinglists@markus-raab.org> writes:
>> To "fix" your shell script (make the files get lost), git stash pop
>> should be inserted before the last line:
>>
>> ----
>> #!/bin/sh
>>
>> git init-db --object-format=sha256
>> git commit --allow-empty -m +
>> oid=$(git rev-parse HEAD)
>> echo a > a
>> echo b > b
>> git add a b # some arbitrary files with content
>> git stash
>> git cherry-pick $oid
>> git stash pop
>> git cherry-pick --abort
>> ----
> 
> So, this is not limited to stash at all.

Yes, it is just how I ran into it. It is neither limited to stash nor 
cherry-pick --abort.

> When you start "cherry-pick", which cannot complete without your
> help (most often, this happens when the cherry-picked change
> conflicts with what you have in the current commit), the command
> stops and gives control back.

This is fine and expected.

> At that point, it is up to you to do anything to bring your index
> into a shape that you desire the "cherry-picked" commit to have.
> You'd do so by editing working tree files (often with conflicts),
> creating new files, removing unneeded files, etc., and then updating
> your index with these changes, and then "cherry-pick --continue" to
> conclude.
> 
> Or, after mucking your working tree and index to "correct" the
> stalled "cherry-pick", you may decide that it is not a good idea to
> cherry-pick the commit after all.  You say "cherry-pick --abort" and
> you expect your index to be clean relative to HEAD, and working tree
> files also adjusted for it. 

What I additionally would have hoped for (hence this bug report) was 
some way to undo the "cherry-pick --abort". A "help for undoing" would 
actually be helpful for many other operations, too.

Actually, I later on found how to undo it, so you might also consider to 
do nothing here.

But if you want to become even more user friendly, you could also 
consider to print a message which would help the user to recover the 
state/files which might have been lost accidentally.

E.g. "git rebase" could print which sha256 was the HEAD before rebase 
and "cherry-pick --abort" could print how to recover the added files 
that were reset etc.

Or an alternative approach would be some "git recover-recent-files", 
"git recover-recent-commits" etc. commands so that the user does not 
have to fiddle manually in .git/objects. Similar to the "go back in 
time" feature in vim (which I rarely use, though).

> Instead of doing "git stash pop" there, you could have added
> arbitrary files with content, or edited working tree files, or
> any other changes manually, and "cherry-pick --abort" would have
> removed such changes to your index and your working tree files, just
> the same way.

Yes, it is the same and I agree the main problem was in the front of the 
keyboard. But things like this happen ;)

> "git stash pop" will remove the stash entry after updating your
> index and your working tree files, and unless you save them away
> elsewhere, if you make further changes to these files, there is no
> easy way to get that exact change you took out of the stash entry
> back.

Yes, so you could take my story as hint to improve the "undo-ability" of 
git in such scenarios.

> So one lesson we can learn from this episode is
> 
>      Never use "git stash pop" WHEN IT IS POSSIBLE YOU MAY LATER
>      CHANGE YOUR MIND.  "pop" applies and then drops the stash entry,
>      so what you will have in your index and working tree will become
>      the ONLY copy of the change you previously stashed.

Yeah, thanks to clearly state it.

> Of course, you need to remember at some point to drop the entry you
> no longer need with "git stash drop" if you take that approach.

Exactly, also a failed "git stash pop" won't get removed, so there 
easily accumulate "forgotten" things in git stashes. But much better to 
have a bit less tidiness then lost files after "git gc". So I think the 
behavior of "git stash pop" itself actually has good "undo-ability".

-- 
Best regards,
Markus Raab
