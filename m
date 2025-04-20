Received: from mail.markus-raab.org (mail.permaplant.net [95.217.75.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662218E03A
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.75.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745156910; cv=none; b=txMN279B7rim2dsSpeQHRdunmBZFYf4jFZQfQiep5bF2rD6/UI7r367SwgTsC9ByuWdZYKE8Q2TRRhQuZqfsEgOieqBb+f1qH56yVPqiLnMbu0BWeYoqBuoTGCPnelR4rOxLq5sWX3PYckWv6FriiUvtANi8f1YczzjK+I2pePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745156910; c=relaxed/simple;
	bh=46awsYfU8uKAbg2eYjg1tlTSnXyyt862ahYRDjcimbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TH15XWFhiPia7usHzB7wxKwXkWjUwpjTZtzIgmVGcaD/sZlgwyIxWgw9hPDNGUuZUvzGy2N9jFRAgCMPSdEozkwQ72DgKmYRT9+nzxv9/+ODmNiMeLFb4fxDjPv0GxiT/0kguG4IOLzr+yqeSUm1Rinpx3Ga/okqkSjpmyPla7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markus-raab.org; spf=pass smtp.mailfrom=markus-raab.org; arc=none smtp.client-ip=95.217.75.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markus-raab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markus-raab.org
Received: from [192.168.1.2] (h082218105086.host.wavenet.at [82.218.105.86])
	by mail.markus-raab.org (Postfix) with ESMTPSA id 6BC8BD83B7;
	Sun, 20 Apr 2025 15:48:25 +0200 (CEST)
Message-ID: <95f731c2-ad2f-40cc-a7d9-85f52cc16389@markus-raab.org>
Date: Sun, 20 Apr 2025 15:48:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unwanted interaction of git stash and cherry-pick --abort
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <d8c1df4e-a4d7-4c4c-be44-b13de3d9ffea@markus-raab.org>
 <aAT4kHFPEb5qwoMv@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Markus Raab <mailinglists@markus-raab.org>
In-Reply-To: <aAT4kHFPEb5qwoMv@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Brian,

Thanks for the quick reply.

Unfortunately, I forgot an essential line in my first e-mail, thus I've 
resent my e-mail shortly later again.

To "fix" your shell script (make the files get lost), git stash pop 
should be inserted before the last line:

----
#!/bin/sh

git init-db --object-format=sha256
git commit --allow-empty -m +
oid=$(git rev-parse HEAD)
echo a > a
echo b > b
git add a b # some arbitrary files with content
git stash
git cherry-pick $oid
git stash pop
git cherry-pick --abort
----

So it is basically about unexpected adding of files, that got discarded 
via a "git cherry-pick --abort".

Btw. the files can be recovered via

----
#!/usr/bin/env bash

headcommit="$(git log --format=format:%H)"
headcommitobject=".git/objects/${headcommit:0:2}/${headcommit:2}"
mkdir recovering_lost_files
find .git/objects/ -type f -daystart -ctime 0|while read -r path
do
     obj="${path#.git/objects/}"
     obj="${obj/\/}"
     git cat-file -p $obj > recovering_lost_files/$obj
done
----

best regards,
Markus


Am 20.04.25 um 15:37 schrieb brian m. carlson:
> On 2025-04-20 at 13:14:31, Markus Raab wrote:
>> Dear git maintainers,
>>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> git init-db
>> git commit --allow-empty # needed for git stash later
>> echo a > a
>> echo b > b
>> git add a b # some arbitrary files with content
>> git stash
>> git cherry-pick 170bbe5 # any commit that cannot be applied, e.g. the
>> initial commit here
>> git cherry-pick --abort
> 
> Here's the exact shell script I used to test this case:
> 
> ----
> #!/bin/sh
> 
> git init-db --object-format=sha256
> git commit --allow-empty -m +
> oid=$(git rev-parse HEAD)
> echo a > a
> echo b > b
> git add a b # some arbitrary files with content
> git stash
> git cherry-pick $oid
> git cherry-pick --abort
> ----
> 
>> What did you expect to happen? (Expected behavior)
>>
>> That a and b are still there or I am somehow informed that the files a and b
>> would get lost.
>>
>> What happened instead? (Actual behavior)
>>
>> The files a and b are lost.
>>
>> What's different between what you expected and what actually happened?
>>
>> Loss of data.
>>
>> Anything else you want to add:
>>
>> Everything fine, only the content of a and b is lost ;(
> 
> I don't think these are lost.  Because they were added, they were saved
> in the stash with `git stash` and can be recovered from there with `git
> stash pop`.  `git cherry-pick` won't have done anything to modify the
> stashes and in my test case, I can see `git stash list -p` shows both of
> those files.
> 
> Is this also the case for you or is your situation maybe a little
> different?


-- 
Best regards,
Markus Raab
