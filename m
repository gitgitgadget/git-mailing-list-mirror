Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22B627FC
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145933; cv=none; b=n0Sq1Fgxe9AyV9kiTBHJYMCD+vDjzXic7zWH15sRXcmcgHSGO+S4W1Hp+fYWiqap+gUukOWH9Q1rLF1a0yZBasqlbHEfE/U5quSvNNcAi8z15jiYaAKjupqZYRPc7hcg1enUG0M1w5WMW5lR8+WScZswM8WnRjQgLxGuS+u54QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145933; c=relaxed/simple;
	bh=U/+YTUpM7UQ2XRhIae8V90Tdc6iKkSQokmsPCDFl5p4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VftDGFGlRUifXqJVnhuLlm4pOjkq2g/F7P/BgbQE6eev41dbu5f98LnDxrq0dRVWjbXZXTLDeUzViJyNNoC7HzCilICtHUtp+d0cn5OqHP11dY0mwbTvRG2SZYUPjIDT5t+FujDGpPg6rmyyfG1Mfi+wuq928KEQZzlPdp4zMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=uXNtxYB4; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="uXNtxYB4"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 8F97319FD49E
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 23:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711145927; bh=U/+YTUpM7UQ2XRhIae8V90Tdc6iKkSQokmsPCDFl5p4=;
	h=Date:To:From:Subject;
	b=uXNtxYB48lH7jVdpSb2p4aLuZIWSh9/obIZc0iQaIVsVGSAaupIa51f3kkznMVI1q
	 T102/vHZ+DVgpraluPQMre4b7HVpHjW97CkgJB72F2Vdj/qMtJIWZUZV1o/TYLzbPN
	 D8VvlcF1sBWTv6GaLzpymUl/LUFfC0eLLlOKeHKQ=
Message-ID: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
Date: Fri, 22 Mar 2024 23:18:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: nl, en-US
From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Allow git bisect to auto-skip
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

In some cases, we know a commit will always break bisect. This is bad 
and evil but sometimes needed.

An example, in my particular case, when OpenWRT does a kernel bump, 
patches and config files get copied to the new version. This is fine, 
but there is not git copy (one could also see that as an individual 
feature request which would solve the actual issue for now :p). Since 
the files are copied, git treats them as new files, without history. 
This makes tracking history almost impossible (config-4.14 -> config 
5.15 -> config 6.6 etc). People have found out, there's some tricks to 
apply where we can make git not see the copy as such, and we'll have our 
history of both files [0]. In short, this hack is used to create two 
commits.

git checkout -b _tmp
git mv old new
git commit -m 'copy old to new' -m 'GIT_SKIP_BISECT'
git checkout HEAD~ old
git commit -m 'restore old'
git switch _tmp
git merge _tmp

and to remove the ugly merge commit

git rebase HEAD~1

which surely is a hack :p

But, it's a `git cp` if you will.

Now this does break git bisect, when the commit with the move comes in, 
things are broken until the next commit. It would be very nice if we can 
have a special marker keyword (GIT_SKIP_BISECT) in the commit message 
for example, to force git bisect to just skip this commit. It will fail, 
it is designed to fail.

There's probably also other very useful cases, but this is just one example.

And hey, if this leads to two patches, where a second one introduces 
`git cp` I'd be even more happy :)

Olliver

[0]: https://github.com/openwrt/openwrt/blob/main/scripts/kernel_bump.sh
