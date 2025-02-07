Received: from smtp.zfn.uni-bremen.de (smtp.zfn.uni-bremen.de [134.102.50.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C772A1D8
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.102.50.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960810; cv=none; b=D58UCuzHRjMIlsTZ0AUWWMDsnVji36g5ANUsUdz0F2Vv5wtKoOKD7ILf6czpuzQTUIcheg8GprObNzgbycw95eeFBhY7hy4VuQzLNv9gbIvsFa9STPGAz/1VGwjQrkMr+u0u2JJKUsH7iHa1RxGiH1cqo+e8MuuhxUV1aisjUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960810; c=relaxed/simple;
	bh=5LnsQyuSrTsZOOEBjlUaYy3Ses8dEfXBGLDDGjESp20=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=g2x8id5eEnyszupxXt1saWnYuJoZHFh0Ea88lH+9tFvBimWObYEI86K+15qo15lmrtFj+KOhMxlGzDxgPlo+Fz1AVw5wf3u1cyoa3D6QhgUCWMeDNcY0igB5WCPng9CbitP3jhJJnlbfxBmj1T2F7pW/Tupfmw7LeSVVwXT5S2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-bremen.de; spf=pass smtp.mailfrom=uni-bremen.de; dkim=pass (2048-bit key) header.d=uni-bremen.de header.i=@uni-bremen.de header.b=k2U13pSA; arc=none smtp.client-ip=134.102.50.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-bremen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uni-bremen.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-bremen.de header.i=@uni-bremen.de header.b="k2U13pSA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uni-bremen.de; s=2019;
	t=1738959276; bh=5LnsQyuSrTsZOOEBjlUaYy3Ses8dEfXBGLDDGjESp20=;
	h=Date:To:From:Subject;
	b=k2U13pSAShLRn9w453/Y+F4AYBzn558FL5JwsUHhEpABNFsl8/5oVvl4qqwdiqrur
	 ED5ggL7vVWb0d1hR4z50n5i9WpKqKkGqWIlaswy0fo/Jmc+glD73nRVPvsiKjQjeuA
	 phR44dzs1tmd72eJzS+2wVxyXU6Ataq0YMp0MOaQMA7dUff/ud0D9+KYBwr3XyO0HR
	 /FaM0sd4edYLKNumeTA0sl/640lnz2qmCxtGTNWqv8vFXA4tkDEHVtomQhJSM60S2U
	 VCPZ1AgqNpVVhShQTiRCHSCD9UpXuOtzHkwi599Lo5824qQfkvADmBkAnue8jAG8rd
	 rBLLqhvWXdszg==
Received: from [192.168.1.104] (ip5f5bc496.dynamic.kabel-deutschland.de [95.91.196.150])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.zfn.uni-bremen.de (Postfix) with ESMTPSA id 4YqQDX22w6zDCdD
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 21:14:36 +0100 (CET)
Message-ID: <7d2cf91f-c4ac-41de-966d-3681ac549ef0@uni-bremen.de>
Date: Fri, 7 Feb 2025 21:14:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US, de-DE
From: Jan Berges <jan.berges@uni-bremen.de>
Subject: git clean -Xdf affects parent and sibling directories
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Git Developers,

This is probably not a bug, but a potentially dangerous behavior.

What did you do before the bug happened? (Steps to reproduce your issue)
Run git clean -Xdf in a subdirectory of a directory ignored by Git.

What did you expect to happen? (Expected behavior)
All contents of this subdirectory are removed. From the man page:
"Cleans the working tree [...], starting from the current directory"

What happened instead? (Actual behavior)
Ignored contents of parent and sibling directories are also removed.

Anything else you want to add:
The behavior can be reproduced using the following lines.

mkdir git_clean_test/
cd git_clean_test/

git init -q

mkdir -p dir1/sub1/
mkdir -p dir1/sub2/
mkdir -p dir2/sub1/
mkdir -p dir2/sub2/

touch dir1/sub1/file
touch dir1/sub2/file
touch dir2/sub1/file
touch dir2/sub2/file

echo -e "file\ndir1" > .gitignore

for dir in dir1/sub1/ dir2/sub1/
do
     cd $dir
     pwd
     git clean -Xdn
     cd ~-
done

Output of the above lines:

/home/jan/git_clean_test/dir1/sub1
Would refuse to remove current working directory
Would remove ../sub1/file
Would remove ../sub2
/home/jan/git_clean_test/dir2/sub1
Would refuse to remove current working directory
Would remove ./file

Thanks and kind regards,

Jan

[System Info]
git version:
git version 2.48.1.575.g74a3c43834
cpu: x86_64
built from commit: 74a3c43834882219aa12aa1815d441a1762ba558
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 7.88.1
OpenSSL: OpenSSL 3.0.15 3 Sep 2024
uname: Linux 6.1.0-30-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.124-1 
(2025-01-12) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash
