Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5D22641C6
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106535; cv=none; b=ajQyb9TVzFQd9FCXHpWZHAjQ/FNUQGlfuYmU3ruuyDOUyelLJEaJUEHNPUCFCnPUhGEmsByua9MgLy41/3Y7HSY4kFnQyzdV80aE7Vqyvvauhoyr5Bd+5zP9YY89UX9bR7GSyStB+RVb0xoDDTScznyKB/IW1r/svDKhqOgKAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106535; c=relaxed/simple;
	bh=tDj9V1h1WOvC9FtYNBnJt+i+DXrq5L79xtcw1C81kN8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=N8YhDwZBSPQelDFl6XKXOwu3hYR8SYyrwcdYSDi7Nr1aQZwepiOxAKQAymnMgbgduEOtPtwENreUdWCP8KypMi4tBIe+ufsu8SzWMHGisxUC+rn9TPVfhSWP8i4GKiC30swqCCc+hYo7HXNduoizhuAi+iajOTHHwX3aLJarb9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; dkim=pass (1024-bit key) header.d=rawbw.com header.i=@rawbw.com header.b=EWwT4k/r; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rawbw.com header.i=@rawbw.com header.b="EWwT4k/r"
Received: from [192.168.5.3] ([24.6.215.85])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 67J2HVWs044761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 19:17:31 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rawbw.com; s=apr2026;
	t=1787105852; bh=tDj9V1h1WOvC9FtYNBnJt+i+DXrq5L79xtcw1C81kN8=;
	h=Date:To:From:Subject;
	b=EWwT4k/ra1PoG0LLNJvv65kBAv10iqH/MojGGU9pMhShKlcybQ1mu+P7QBl5AFFle
	 sBXWfCnPENc2i/kSlQNA5b4SVpkRuxE9LZXQDbBL0wEvWpqU82LP9nuVaQq/9m5uWK
	 eoyBtirTAELHtdtye5BAElpsB2F8tlwOiSKUS/IM=
X-Authentication-Warning: shell1.rawbw.com: Host [24.6.215.85] claimed to be [192.168.5.3]
Message-ID: <6b5dbe00-690e-402f-9f55-ba708c3a4ef5@rawbw.com>
Date: Tue, 18 Aug 2026 19:17:30 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git Mailing List <git@vger.kernel.org>
From: Yuri <yuri@rawbw.com>
Subject: 'git stash' is not atomic: it leaves both an invalid stash and file
 changes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

My repository had many untracked files that were accidentally added, one 
of them was 2GB.
My first attempt failed:
$ git stash push ../../ -m "all-accidentally-added"
Saved working directory and index state On main: all-accidentally-added
fatal: unable to generate diff for misc/linux-rl9-cuda13/libcuda.txt

Two problems with this:
1. it didn't say why did it fail to generate diff.
It should have said "fatal: unable to generate diff for 
misc/linux-rl9-cuda13/libcuda.txt: file is 2GB which is larger than the 
limit 1GB"
2. This command left both stash and file changes. If the command has 
failed, why does it leave stash then?


After removing the large file 'git stash' still failed:
$ git stash push ../../ -m "all-accidentally-added-final"
Saved working directory and index state On main: 
all-accidentally-added-final
error: patch too large

Again: "patch too large" needs to specify the limit, and the transaction 
should be atomic.


Please consider improving error messages to be more informative as for 
the reasons of failure. Also please consider making stash atomic. The 
stash that was left was obviously invalid because it didn't contain at 
least one file.


Yuri




