Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F38F58
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263404; cv=none; b=pWyWIMUne7kgjc9sgKREolvpEzjjP96iphKWcd3tIo5ymbzf9qTUYA0J868P7Y321dV0sqSnmUocdAY9f6KCjdNbXKJlNdW6EEPYzeAaLoVoLQ1M0aXzdY6DjF5ZWCsNV3pXVHrSw2iiKW/MLaOkoS9d/7Y71jPfIp9t/SGj6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263404; c=relaxed/simple;
	bh=CRoBsDkRB7Glayb4+C6gE1yF1GYiDAPN0rWeeMIiDk4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fW8W+KLsm5QVx5N3MnlfGtfjY5N8zv3Xf1c+XJZgVaQFwtdZmS4nYQfc9/WlhThWfXpBo9YXohFM+iAxYNzJwX/Q2FWJukjujM6MvRDan9FnDzCw/bzQCtviW5u9HmTnoMhXdklZ+CU5e4cfTOl2VGL67G06OMsQz21Qim4k+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQ9iCTZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ9iCTZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AABC4CEE4
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 04:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730263404;
	bh=CRoBsDkRB7Glayb4+C6gE1yF1GYiDAPN0rWeeMIiDk4=;
	h=Date:From:To:Subject:From;
	b=FQ9iCTZShw93I5acygCP+Skl7XiF2e6Hxr/24q4APgUNiAtS3z/b9Hs0a2DR/rUJc
	 x801YyO1ZyGZP//itSDEYikxMfESl+4LVk/XVdXLSCaYRgckeRP8sEbA0bSMFycA74
	 aG9KQSdt43npwfqsQs2mh/iRK10fvwUCkJtsEWtM5+8xg/qnnRGeFtuyu4v4LdPQeQ
	 BPudKQ3VYHPBi5C7yof1Ysy7TpI9zGS1ce3vylx42Pq2cSYF1IFn/HuTq1OX0FpoNz
	 H+nWNcpPgJF1F//Sfo0kViAUoQrj+Ix9X0aEme6o+xSSFXyY+lYNsytNTZT3wc99XA
	 Vb6q5Mibnkvwg==
Date: Tue, 29 Oct 2024 21:43:22 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: git@vger.kernel.org
Subject: [BUG] "git describe --match" performance
Message-ID: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)

$ git clone https://github.com/torvalds/linux
$ cd linux
$ git checkout c61e41121036

$ time git describe --match=v6.10-rc7 --debug
describe HEAD
No exact match on refs or tags, searching to describe
finished search at d8470b7c13e11c18cf14a7e3180f0b00e715e4f0
 annotated       1844 v6.10-rc7
traversed 1282750 commits
v6.10-rc7-1844-gc61e41121036

real	0m9.243s
user	0m8.940s
sys	0m0.268s

$ time git describe
v6.10-rc7-1844-gc61e41121036

real	0m0.149s
user	0m0.111s
sys	0m0.036s

> What did you expect to happen? (Expected behavior)

I expected "git describe --match=v6.10-rc7" to be faster than plain "git
describe".

> What happened instead? (Actual behavior)

It takes over 9 seconds and traverses 1282750 commits.

(In my actual Linux git repo it's even worse at 15 seconds due to more
git history.)

> What's different between what you expected and what actually happened?

Over 9 seconds :-)

> Anything else you want to add:

I see this with both version 2.47.0 and the next branch.

This command is used by the kernel setlocalversion script, which is run
for every kernel build, so it adds 10-15 seconds to every build on an
untagged commit.

I suspect the problem is that there's only a single match for
"v6.10-rc7", but it tries to find 10 candidates so it ends up searching
the entire history.  But "--candidates=1" doesn't seem to help unless I
add a second match like so:

$ time git describe --match=v6.10-rc7 --match=v6.10-rc6 --candidates=1
v6.10-rc7-1844-gc61e41121036

real	0m0.112s
user	0m0.081s
sys	0m0.031s

> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.47.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.6.0
OpenSSL: OpenSSL 3.2.2 4 Jun 2024
zlib: 1.3.1.zlib-ng
uname: Linux 6.10.12-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 30 21:38:25 UTC 2024 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

-- 
Josh
