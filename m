Received: from defaultvalue.org (defaultvalue.org [45.33.119.55])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B8221FBF
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.119.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754429206; cv=none; b=aoTweAtgX26Qt6u8YgdQcSwJzPaJcimfQ2yiQCMm/di6Cbi1byJYQp/n5i+m0qDkUDY6liTTfbohu+d6Olq6CGjrX2QxJ7oh9TUSvx+R2PM2dENit4lo2SG9CAtLKicn/4LRinDMn7LLTvaDUv1TgrddXViC8efhU41AOdzvYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754429206; c=relaxed/simple;
	bh=jWV43pd8Kn/o0kyIV/HPRGT/yAG0UIQIJL3oA0jwZ4E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hPWCv7f1cU5WWFvkPowt5QDAuU6LcDb7S1Nd2HhknYtvjq8ru322BMhuywPFl42PgXeb6rDVsaCcoHIknokh4QREKtC4/VCuJKLK2+GwXatXsYbah0tFVfn5uTN3hutkz3LNMfbgknqS/FffQY6tASmpfHK6Rr3dET8wuXFnHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=defaultvalue.org; spf=pass smtp.mailfrom=defaultvalue.org; arc=none smtp.client-ip=45.33.119.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=defaultvalue.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defaultvalue.org
Received: from trouble.defaultvalue.org (localhost [127.0.0.1])
	(Authenticated sender: rlb@defaultvalue.org)
	by defaultvalue.org (Postfix) with ESMTPSA id AF9A22003D
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 16:21:36 -0500 (CDT)
Received: by trouble.defaultvalue.org (Postfix, from userid 1000)
	id 2204614E154; Tue, 05 Aug 2025 16:21:36 -0500 (CDT)
From: Rob Browning <rlb@defaultvalue.org>
To: git@vger.kernel.org
Subject: cat-file --batch-command info performance problem
Date: Tue, 05 Aug 2025 16:21:36 -0500
Message-ID: <871ppp1n33.fsf@trouble.defaultvalue.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


While doing some testing before a bup release, I ran in to a performance
problem that I've narrowed down to git (2.47.2) cat-file --batch-command
(currently, bup often relies on git cat-file).

I can reproduce the problem with a ~125GB (~3M object) repository on
an external SSD and a system with 16GB RAM via "git --batch-command <
fetch-oids" where fetch-oids contains 8k "info HASH" commands.

That process runs at 32 hashes/sec (overall average), with a cold
cache (echo 3 > /proc/sys/vm/drop_caches), and does not improve over
repeated runs.  While that's running, every time I check, git's
reading about 300-400+ MB/s.

That didn't seem right, so I wrote a test command that produces the same
information via direct index access and packfile reads/seeks. With a
cold cache, that runs at 1.5k hashes/sec (even from python), and on the
second or third run, 9 hashes/seck.  Interestingly, if I run cat-file
after the test command has warmed up the cache, cat-file then reaches
53k hashes/sec.

My current guess is that cat-file's approach (all mmap?) is causing
some kind of kernel derived read amplification that's vastly
increasing the working set.

This is easily repeatable here, so I'd be happy to help test if that's
desirable, and perhaps even to pursue it if I can, and if it seems like
something that could/should be addressed in git.

If not, that's also helpful to know, and then we'll just handle the
lookups ourselves.

Thanks
-- 
Rob Browning
rlb @defaultvalue.org and @debian.org
GPG as of 2011-07-10 E6A9 DA3C C9FD 1FF8 C676 D2C4 C0F0 39E9 ED1B 597A
GPG as of 2002-11-03 14DD 432F AE39 534D B592 F9A0 25C8 D377 8C7E 73A4
