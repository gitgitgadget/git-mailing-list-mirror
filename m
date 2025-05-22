Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C628D832
	for <git@vger.kernel.org>; Thu, 22 May 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925109; cv=none; b=I9GUVg7IyiK0JhcndHbfI1PX62lWl8n8govNxYg7rX/Sj5ed3CdoHqbeG8Oi4YVwpf0FDIj/RmqdcqLf166KDqhtCaHk/6V75UxIrRNG85Xgon51MJ3l4q2dAhc3ORjsIF5GRRiZ9qJ+4K7OpZAeMZjhmbgVZqX3T5v/Ve//8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925109; c=relaxed/simple;
	bh=q5fTfPLULs/1S+U9da4KeAk78abVRcDxeKrA1BOErp8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=U5G7YxSpsiasUVPVNrgIRMSNO2qU3CPMLsCycboNI45+oWdSmLO3NGh3iRjZY2FiA/t7g4R/LywJNiRUWDkHL+pHKS9Ybf2ktOuMzNXNG2+eOmDUwkQqtCZBmGtNJuAYqvMidwXCRQuXV7Uic/NfYP5ASfdk9Vtz1YMJDpjrQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roelsengers.nl; spf=pass smtp.mailfrom=roelsengers.nl; dkim=pass (2048-bit key) header.d=roelsengers.nl header.i=@roelsengers.nl header.b=MAhM6x79; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roelsengers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roelsengers.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roelsengers.nl header.i=@roelsengers.nl header.b="MAhM6x79"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4b3B0F5t3nz9t46
	for <git@vger.kernel.org>; Thu, 22 May 2025 16:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roelsengers.nl;
	s=MBO0001; t=1747925101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rpLXRis6Uppfnaa/nVNBbKCOc1bX/X0qm9K4QgIUueE=;
	b=MAhM6x79PNjzaoWPwdI7zX+MBZ9rwt8Qm9E44EvmN/WK6N4m8bxBm8UWsBEdH96ts15Ea2
	dEBhM6/9dnMKHBlecG9aK/8wjsBj7Nwz8AgDE2HJILQDCcDcg3s5ACK73xDxUZcD0MAYc4
	zUgWSbM78Qi0I9wLGqaBSJPnlb7U5tb9tAFmQ936Js+PKmadztHXozWcyvkLXyIv1dhWqW
	YAAr1bHa+NXMfs5uKCMX5tDDE/yvOa9aihOUl9INyShqv76UnMa+5dmYdMhu3o0T6pgJno
	53FfxBm0Mbie4JOtGuiH8Y++Kbj7AFmGBqfdeypxSrpBOjbGrh3/CGOr3JJ4JA==
Message-ID: <195d93de-1d5d-40f3-8139-b73a447b356f@roelsengers.nl>
Date: Thu, 22 May 2025 16:45:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US, nl
To: git@vger.kernel.org
From: Roel Sengers <roel@roelsengers.nl>
Subject: [BUG] Hard links to large files cause unexpected refresh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4b3B0F5t3nz9t46

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

In my workflow there is a step which hard-links about 80GB of such files 
to locations where a 3rd party application can find them. However, after 
this hard-linking step, git status (or other git commands) hang for a 
long time. Note that making a copy of the file does not cause such 
slowdowns, which was surprising to me.

I am using Git with git-lfs for these large files, however I was able to 
reproduce this issue without LFS enabled.

The script below reproduces the environment which triggers the issue:

mkdir git-hardlink-test
cd git-hardlink-test

git init
echo ignore.bin > .gitignore
git add .gitignore
git commit -m 'Initial commit'

dd if=/dev/urandom of=file.bin bs=1M count=1000
git add file.bin
git commit -m 'Add file.bin'

# $ cp file.bin ignore.bin; time git status
# On branch main
# nothing to commit, working tree clean
#
# real	0m0,002s
# user	0m0,000s
# sys	0m0,002s

# $ ln file.bin ignore.bin; time git status
# Refresh index: 100% (2/2), done.
# On branch main
# nothing to commit, working tree clean
#
# real	0m16,100s
# user	0m15,700s
# sys	0m0,255s


What did you expect to happen? (Expected behavior)

After creating a hard link to a checked-in object, I expected the final 
git status to finish in a time that is barely noticeable.

The file itself is large, so having Git taking its time to refresh the 
state of the working directory would not be suspicious were it not for 
the fact that creating a copy of the same file does not suffer from the 
same performance penalty.

I expected Git to be as fast for both copied and hard-linked files.


What happened instead? (Actual behavior)

git status takes an unusual amount of time to complete when an 
uncommitted hard link is created to a prior committed file.

What's different between what you expected and what actually happened?

Timing git status tells me that it took 2 milliseconds to complete after 
a copy was made.

Running git status after creating a hard link took 16 seconds instead, I 
expected these times to be similar as the file contents do not differ.

The target file is also listed in .gitignore, so I would not expect Git 
to read it at all.


Anything else you want to add:

Making copies of these files instead is not desirable as this would 
double the storage capacity needed and copying itself would also take a 
long time.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.49.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /nix/store/xy4jjgw87sbgwylm5kn047d9gkbhsr9x-bash-5.2p37/bin/bash
libcurl: 8.13.0
OpenSSL: OpenSSL 3.4.1 11 Feb 2025
zlib-ng: 2.2.4
uname: Linux 6.12.28 #1-NixOS SMP PREEMPT_DYNAMIC Fri May  9 07:50:53 
UTC 2025 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /run/current-system/sw/bin/bash


[Enabled Hooks]


With kind regards,
Roel Sengers
