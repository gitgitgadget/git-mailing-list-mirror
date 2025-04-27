Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA51CAA85
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745741927; cv=none; b=jWhkKCPIMTnmon8nBQXI2Ze8QeRjgoWVQSmeE1fAHvvpxqWhJ11UAsImqvr/mVHI0uRFSyGwTRj17IfghFQ/3nuleztJJrGUJ74NNYInhmYHbtidARcmgGcjhzKY8H/LyhxTnGP25KGFjbbptXIFll6Ev7rC92m4jr9WBb+IvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745741927; c=relaxed/simple;
	bh=a8ZqHKw+k5M3ozYcFROn2gJW2s3+PCFnOMGNdsngFPM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=EdKqKsig4IwY1zRZD/vJ3Rqy/puStLJ/XsXX5XPEFvLZWCq8o/iMMpOITWkoHFOtqW7Vo0QEfB8VjSsu/4SDhJAaF8jKvPKBpvM2vgOl0Jp3P3oVHX5vRtZOoWhQnRrrP/PXZRFj1eXpXLUNwi28ZZ8sZp0QqP/8GCkuZvS0Tug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engmark.name; spf=pass smtp.mailfrom=engmark.name; dkim=pass (2048-bit key) header.d=engmark.name header.i=@engmark.name header.b=cPwb1oL6; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engmark.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engmark.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=engmark.name header.i=@engmark.name header.b="cPwb1oL6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engmark.name; s=ds202412; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u9Mv0rasfZowMDrVObIDDWJ98z+OtJx5fh12m/fHhEs=; b=cPwb1oL6XgmVDI41sPwQgtAOpi
	dFeBCjdjYw7nEbK7AyF92gVJ5yCFCnbe5P2gi93TkmUZcFDpi3FxO1dLBNjTUFElfp4U3qiAwNpTA
	XznPKbDwLcnE8lYZw8ah44WkC9O0m0fmbGxsuUQztQ32PFrRqW+S3lqj5RNpfLHIvc+Yhe1rgGxBb
	RicT6yj1d3/VEWCfXQOmoHKP4WWIQzXCWd4E8HZ9NR2mX62NqdstfhLeMZF4nNS6uGtVD3FMvziC5
	oo4FTAz8HASrZVR1hKtq8lU07XmqlGs3mFNor4K+NPO4GY9nGlalh5p5mb9uPY4qx9h3B9UR95TjL
	s1RXY1xg==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1u8xDn-00COIS-6v
	for git@vger.kernel.org;
	Sun, 27 Apr 2025 10:18:43 +0200
Message-ID: <02671927-2e65-4bd3-904b-b564849d1fa5@engmark.name>
Date: Sun, 27 Apr 2025 10:18:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-CH, en-GB, en-NZ, nb-NO
To: git@vger.kernel.org
From: Victor Engmark <victor@engmark.name>
Subject: Workflow for bisecting with test in a branch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'd like to bisect using a test I've written in a different branch from 
the one I'm bisecting. But to do `git bisect run ./test.bash` I have to 
keep the new test file and an old test suite file the same during the 
whole `bisect` process. This turned out pretty cumbersome:

test.bash:

```
#!/usr/bin/env bash

set -o errexit

git show my-test-branch:test-suite-path > test-suite-path
mkdir -p test-dir
git show my-test-branch:test-dir/test-file > test-dir/test-file

run_test || exit_code=$?
git checkout .
exit "${exit_code-0}"
```

Console session:

```
git bisect start my-test-branch known-good-ancestor
git bisect run ./test.bash
```

Is there a more streamlined way to achieve the same thing, that is, 
forcing some checked-in files to not change while bisecting?

Kind regards
Victor Engmark
