Received: from mail-cvk-ext.charite.de (mail-cvk-ext.charite.de [193.175.73.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE6E188CBA
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.73.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042721; cv=none; b=pUyoztPnxYwuhbzp8odu4KDR/GbsEBhaGFdV2JfePP1AwoAwmwKp16OPT6i+yFWmRILtFwMQ7uFbzmKiMC68s5m1aFl9uh+WVZXWUgj7X5I70cNqIHFXfxOhDwi/DjbtYwV2/vX2mR9aQgOmz5p9KOD71xZroCAMO1G68bQB1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042721; c=relaxed/simple;
	bh=O4/Dd0rLK3h6Fr/VS1HgLtYhmDmXXxy9N6QUaHp6reU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=iWls8qdtnt/OzM6+7kGXAU9OqQvifpXzzBZ4qG/rbOFh04pBd330HuNYVBBttsoLhfNBc999dtWrtsDzE4CVj7jPP86IVTPRiVNHPKUAJ9eX8WiGwEBAALqZpfV/hFIjM+x1j+aEdohbGapBF44LEwlTjznoWQtbgEsJQvQjL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=charite.de; spf=pass smtp.mailfrom=charite.de; dkim=pass (1024-bit key) header.d=charite.de header.i=@charite.de header.b=5tjIfrf1; arc=none smtp.client-ip=193.175.73.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=charite.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charite.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=charite.de header.i=@charite.de header.b="5tjIfrf1"
Received: from mail-cbf-ext.charite.de (mail-cbf-int.charite.de [141.42.5.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by mail-cvk.charite.de (Postfix) with ESMTPS id 4WN08r6W4kz1Z7XP
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 13:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=charite.de; s=jun2018;
	t=1721042373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MJkNrLt93Zbi+CCFCV+HFhVgGgPtPQkYOfo2fZHsp4w=;
	b=5tjIfrf1sfFPDkdcenRfIgMHiYPiwyaC+degOGdbqwcietyj4PM4UvIdk5HBfCFuH4iQJs
	valVV3uSMlkCm7NzDchY+fnXiLmCaYnfSCwxzf8c/BIYX9XI32UlsARFmPYiH0eDxUjKHX
	49Hc9H0MoXQU0pTX594q1nNzpOuJ5zo=
Received: from [172.29.32.143] (vpn-32-143.vpn.charite.de [172.29.32.143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by smtp-out-sv.charite.de (Postfix) with ESMTPS id 4WN08j0529zT2
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 13:19:32 +0200 (CEST)
Message-ID: <0cc13c53-1d8d-4501-89f2-e8329bc95485@charite.de>
Date: Mon, 15 Jul 2024 13:19:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Nikolai Zaki <nikolai-waleed.zaki@charite.de>
Subject: bug: `git pull` does not clean up after itself if it fails
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

What did you do before the bug happened? (Steps to reproduce your issue)
In your local repo have a directory that you cannot write to.
Pull from a remote that has changes/new files in that directory.

What did you expect to happen? (Expected behavior)
The pull fails and the local repo in the same state as before.

What happened instead? (Actual behavior)
All changes to writeable files are applied and all new files in 
writeable dirs are added.
The local HEAD however remained the same.

What's different between what you expected and what actually happened?
A failed `git pull` inadvertently creates changes and untracked files.

Anything else you want to add:
I created this bugreport on my local machine, but I first noticed this 
on git version 2.25.1 under Ubuntu (uname: Linux s-c05-mvi-civdb 
5.4.0-174-generic #193-Ubuntu SMP Thu Mar 7 14:29:28 UTC 2024 x86_64 
x86_64 x86_64 GNU/Linux)

[System Info]
git version:
git version 2.45.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.9.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 28 Jun 2024 
04:32:50 +0000 x86_64
compiler info: gnuc: 14.1
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/zsh

-- 
Best,
Nikolai
