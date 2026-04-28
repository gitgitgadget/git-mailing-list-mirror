Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56126318146
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366213; cv=none; b=HV8uUyy6PewQwwykuCYT9xmNKQ/pSsvR17DU98ew82eZ3omFpqrDnZV++/Ov6agy7b36OOG18WpsFz4adwUAC6yzMFRAVgDlSAdBaCFSuW/b2MUPqU8g+sYBTxjzOl037DtA8qkqVCaWUiaq59sHVhICUPfB26v+wwMkEkY+60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366213; c=relaxed/simple;
	bh=NIM3cdfePgVj8FviujdkBHSoV0PI0Zz0jPU1FgBdATo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=ZJZAsh4EYv6Mrr+mG/zaz4I+qii6UYt+Mz1EvJ+WxHEpaNl94Bsd7zqnCbkJ2tzdWhzULkJiDm96kw9LeVv+YFpWYs0ADquvzLodq8SPCUh+5bHxiIfsWExIvB2cZyGHHvnYzM1x6P0WLhqOE8Pe7pJve8TZDfEPHxh5I3a6UJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 3DFBE3F209;
	Tue, 28 Apr 2026 10:40:08 +0200 (CEST)
Message-ID: <9030b26d-02ed-4452-b212-a69a4ff21e2d@hogyros.de>
Date: Tue, 28 Apr 2026 17:40:05 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git <git@vger.kernel.org>
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Git generated tarballs and Debian
Cc: Ian Jackson <ijackson@chiark.greenend.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

in Debian, we're shipping "original" tarballs for each software package, 
and the Debian specific changes in a separate file.

Historically, this users could do a bitwise comparison of the original 
tarball and the one in Debian to verify that these were unchanged.

With git, some authors have stopped releasing official tarballs, so 
we're using git-archive a lot -- but this is reproducible only by 
accident. GitHub also prepares some release tarballs that may or not be 
bitwise identical to what git archive produces.

I've written a small tool that generates the tree checksum for a given 
tarball (running inside a SECCOMP environment, not writing anything to 
disk), that already goes a long way to make tarballs verifiable: one can 
check whether that ID is the same as the one mentioned in a commit (and 
the comment inside a git-archive generated tarball is helpful in finding 
which commit).

The downsides of that are:

1. that you still need a copy of the commit to verify it, as it's not 
included in the tarball.

We could add an ancillary file that contains the commit object (its 
checksum being reproducible, and containing the tree checksum) and 
possibly a signed tag object as well, so that is solvable inside Debian.

Another option would be to extend the git-archive format to include them 
as a (longer) comment in the global pax header.

2. that it doesn't work for submodules

What we do currently is generate multiple archives with different 
prefixes, and concatenate them using tar. That loses all the pax global 
headers though, so commit information is lost. In addition, putting the 
actual contents into a subdirectory instead of a commit reference means 
that generating the tree object from the tarball contents means the 
checksum does not match.

What we could do is generate multiple archives, and keep them separate, 
but the Debian toolchain can only unpack additional archives into a 
direct subdirectory of the main archive (e.g. "orig.tar.gz" gets 
unpacked to "foo-1.0", then "orig-addon.tar.gz" gets unpacked into 
"foo-1.0/addon"). We can fix _that_ with symlinks, but it gets more and 
more hacky.

One thing we could do inside git here is add a method to create archives 
that include submodules (that gets rid of the concatenation), but in 
order for this to be easily verifiable, I still need to know where 
submodules are and what their commit objects are (so I know the commit 
checksum and can verify the tree checksum).

The goal is to extend what I can already do inside the Linux kernel:

$ git rev-parse HEAD
94dfcc4a99b0cece77e73dc3011284050f95da89
$ git rev-parse HEAD^{tree}
2d14d43ce9f062160262f4e4f162f5ff0ed91a5e
$ git archive --format=tar HEAD | git-treeof
Commit-Hint: 94dfcc4a99b0cece77e73dc3011284050f95da89
Tree-SHA1: 2d14d43ce9f062160262f4e4f162f5ff0ed91a5e

so the "Commit-Hint" can become a stronger statement "I have seen a 
commit object with this checksum that actually refers to the correct 
tree", and to allow this to work for repositories with submodules.

Does it make sense to extend git here to allow this, or should I try to 
solve this entirely within Debian?

    Simon
