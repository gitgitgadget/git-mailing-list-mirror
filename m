Received: from hu-is-mx-01.gaijin.team (hu-is-mx-01.gaijin.team [213.163.39.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C618A92B
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.163.39.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964679; cv=none; b=ZIJqX+V3gt6lLiiMY+w71QkkToWprjjk9eC4v9FRINTo2SxePVX0putBg2EjH+2owT/rHgbapb4f+mJvtAxMgXuAuGuGiBS3OL3fIT4/gkNs+kLtDuDtK/75HZzOeEPRP6Rj0WYN//UUYGTfK0Mrlz4FQEmVjtIR5+48FoXXmvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964679; c=relaxed/simple;
	bh=YwEDaDp20fmivKaLSMThz81isK1Wotk3RAU2h3LRV4c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=J5UduljgBfP7uREOo++PPd7HZe54zfBBSRRuqFu6/+LKGFM4quno9C3Y6wCeqBaTx/hiUDXFFXbIs4gwpZpWjj8J9wM2coPtpDHnRPW2meXzNIDXWjUS8gWHt/xGcHAqg/QC5/90yFkyNCvp6WcqNsaWyAJxzQidNcMTIOF2Flc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team; spf=pass smtp.mailfrom=gaijin.team; dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b=YLK56XP+; arc=none smtp.client-ip=213.163.39.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaijin.team
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b="YLK56XP+"
Message-ID: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
DKIM-Filter: OpenDKIM Filter v2.11.0 hu-is-mx-01.gaijin.team 3AA9B389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaijin.team; s=mail;
	t=1724964221; bh=Eh0M85M+j1e9CCUlaDPbaAfa27tI1od16iKsUa4UFxM=;
	h=Date:To:From:Subject:From;
	b=YLK56XP+NmY/KcETGFFEy5HTzUz+t7bpgjoYz21r1h9beNE7FBd35VB3L3cdIxS29
	 Ei+gV2Eii3j33bEvKQSwawuLHKJyB+y4sCjk1TJyavLbnNMKdtq7uMElQBCUJNsJM4
	 Y7yXfTiA8gf7bNa6N9uboEq1TvRxm4RZ4Vo+lmZ4=
Date: Thu, 29 Aug 2024 23:43:40 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Content-Language: en-US
From: Roman Sandu <r.sandu@gaijin.team>
Subject: Committing crimes with NTFS-3G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Good day!

I have a decently sized (80K files) monorepo on an NTFS drive that I 
have been working with for a while under Windows via git-for-windows. 
Recently, I had to (temporarily) switch to Ubuntu (24.04) via dual-boot 
for irrelevant reasons, and I decided that simply mounting my NTFS drive 
and using the monorepo from Ubuntu is a great idea, actually, as NTFS-3G 
allow for seamless interop with NTFS via UserMapping. And so that is 
exactly what I did and It Just Works!

Except it kind of does not. Every time I run `git status` it takes 8 
seconds, which is very painful when doing tricky history rewriting.

To diagnose the problem, I ran git status with GIT_TRACE_PERFORMANCE 
enabled, and what I see is that the "refresh index" region is taking up 
99% of the time. Digging further, `strace -fc git status` tells me that 
99% of the time is spent on newfstatat'ing files. Okay, makes sense, 
stat'ing files through FUSE is not all that quick. But how many files 
are we talking about? My repository has `feature.manyFiles` enabled in 
git, so I would expect `core.untrackedCache` make it so that `git 
status` skips basically everything except for the root folder which 
contains, what, 20 subfolders? But it actually does >96K stat calls! 
Which is more than the amount of files in the repository in total. 
Briefly looking at the output of `strace -f git status`, I see that git 
indeed goes through basically all of the repository, even things that 
have not changed for years, as if `core.untrackedCache` is not actually 
enabled. Manually enabling it on top of `feature.manyFiles` does not 
help. Note that `git update-index --test-untracked-cache` tells me that 
mtime does indeed work, and I've also manually stat'ed some folders 
which `git status` re-stats on every run and I see that the modify time 
is indeed a couple of hours ago, yet even when running `git status` 
several times in a row it re-scans the entire folder every time.

So, what do I do about this? It honestly looks like a git bug to me, 
maybe it silently fails to update the index with new timestamps because 
it was initially created on Windows? But I have no clue how to narrow 
this issue down further, so any ideas or suggestions would be appreciated!

Regards,
Roman Sandu
