Received: from mailout11.t-online.de (mailout11.t-online.de [194.25.134.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8E214204
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572955; cv=none; b=C81/JNeLKcJ64k6zBWci9YqmTU0LFVB8ZNaw7V+g5NnLCaaXm4pU/NclN9OmVwGhcKI+ph/OVxFQGpNn+sm5IdN04+K4pWe/3dZ4LD5blKJOvK3o8riawNphOCMwp4eOanG2kWZGfA+8JRkzDnBNeS5WFtjETERys8pps5QWFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572955; c=relaxed/simple;
	bh=skCrNoum77/XGG39CG2qKay29loShbnfmdmq8WAVwMM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JBNKDRmlgDYGWqbD0/8PtKhNPHuFekuy6wDaE6fCY94k4vqt0KcFDdoxLcjKanuS1AW1CQ4ihddC6liObxv/4Ws+wJLtUZQYmrYW00oZE2gt1+c8uFn7vk8V3JympWi3/YcH0uiP0rb94Wyv2uyt8p6Us5OcB1HbtEYLCAELSiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd79.aul.t-online.de (fwd79.aul.t-online.de [10.223.144.105])
	by mailout11.t-online.de (Postfix) with SMTP id 276E7219A
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 20:01:31 +0100 (CET)
Received: from [192.168.178.52] ([77.20.184.84]) by fwd79.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tafyk-0y5Sb20; Wed, 22 Jan 2025 20:01:30 +0100
Message-ID: <d7fd0b1c-98fe-4cc3-b657-c2c3d0bc5c47@t-online.de>
Date: Wed, 22 Jan 2025 20:01:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
From: Christian Reich <Zottelbart@t-online.de>
Subject: unlink errors under windows in git pack-refs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1737572490-5B7FD956-AAB9E2F7/10/3626336762 SUSPECT URL
X-TOI-MSGID: 1d7ecdc7-1bc8-4e9e-b317-77b2a4759508

What did you do before the bug happened? (Steps to reproduce your issue)

I have a git repository cloned which uses reftables.

git clone --ref-format=reftable https://github.com/eclipse-jgit/jgit.git

A jgit-program (java) is running and sleeping for 100seconds to 
demonstrate the problem.

         Git git = Git.init().setDirectory(new 
File("c:\\temp\\jgit")).call();

         FileRepository repo = (FileRepository) git.getRepository();

         try {
             Thread.sleep(100000);
         } catch (InterruptedException e) {
         }
         git.close();

While the jgit-program is sleeping in git-bash update a ref und pack the 
reftablefiles:

git update-ref refs/tags/test 939d321faccd12bff4cb13ce6358820297fbc78e

git pack-refs

What did you expect to happen? (Expected behavior)

git pack-refs should work without messages.

What happened instead? (Actual behavior)

git tries to unlink the reftable-files, but jgit hold windows-system 
lock, so the file can't be unlinked.
An answers 'n' for retry causes more asks. After the third try git give up.

Unlink of file 
'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref' 
failed. Should I try again? (y/n) n
Unlink of file 
'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref' 
failed. Should I try again? (y/n) n
Unlink of file 
'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref' 
failed. Should I try again? (y/n) n


What's different between what you expected and what actually happened?

I would expect, that git tries to unlink the files. But if this fails 
git should ignore this and try to delete the files next time on 
pack-files. Its documented in https://git-scm.com/docs/reftable

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.48.0.rc2.windows.1
cpu: x86_64
built from commit: 049f0cf1a5d000f1e24f0e80b79b0d043a8b83b2
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.11.1
OpenSSL: OpenSSL 3.2.3 3 Sep 2024
zlib: 1.3.1
uname: Windows 10.0 22631
compiler info: gnuc: 14.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
commit-msg

