Received: from mx.42d6.com (static.238.157.47.78.clients.your-server.de [78.47.157.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611E6190045
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.157.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729380654; cv=none; b=srfSN6o34GMWfzmSBxREEa440Y76irqmH4qIG0gFDkJC/FBmKlQuBE1H3Jp7yZfjg+31Wk/5nMiRTdpOiVmnd/pQeSexfefle6c2VCu/lwqD6iiDpY1KJy3o0bv5NFJTmHPW1prM4XxRReP7PQqbVTkMcZBII8CL/LiV9ZlLqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729380654; c=relaxed/simple;
	bh=rxoyTivuvMnmSvcvogMjJWZkSakfdV5d8Kq6urJ8rCo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=k0SqkxV/NTUWyzvSd08QXn51qiCr+UrjDDOJjPLW7N8FiIJk+qpaTI/DZNWKHHB7knd0ZfYOd2DvfDDWf4Li/dyuVgz1dVdspMFhlRxMdIko9cK+u2JaxgyKoO/Dx6XstBgUEvVxnRIFu8CBX0g35DPWaSjxqbhHyUwBh01HtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=townlong-yak.com; spf=pass smtp.mailfrom=townlong-yak.com; dkim=pass (2048-bit key) header.d=townlong-yak.com header.i=@townlong-yak.com header.b=JBGY8qbB; arc=none smtp.client-ip=78.47.157.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=townlong-yak.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=townlong-yak.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=townlong-yak.com header.i=@townlong-yak.com header.b="JBGY8qbB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=townlong-yak.com;
	s=2208; t=1729380165;
	bh=rxoyTivuvMnmSvcvogMjJWZkSakfdV5d8Kq6urJ8rCo=;
	h=From:Subject:Date:To:From;
	b=JBGY8qbBGmSVkvK5FSsHlv5bv7Pt61+nEuJgJvtiIJzhZ1eQ+W7lTKVDCjLNlWRQK
	 IBLsTaZkPLHSBrWTFq/+TrJSz8FYirhXEKMSf3GqMFUKFi7tvIV0VRX0c2xLNNhryR
	 1RJEOCL3xy7CD+hH9aVif/pT0HH6TymEc61nyR4zysn8PaaLtsOSIqkSzcv7HfV1wa
	 pKIh4bx5DvVXyNAwUXo7Un1yVnyFVuxTV8xzw0z4URScwOBuRm4qKuYkRmTVRn1Qhd
	 +hhwgwOCx6MeepQ61dusZJXwjsCRiIr5RFKwdAWMBG93gaiuZ+VXgdq9Gtc5dVRMsP
	 gI0DFOwKGavYA==
From: fox <fox.gbr@townlong-yak.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Bug report: v2.47.0 cannot fetch version 1 pack indexes
Message-Id: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
Date: Sun, 20 Oct 2024 01:22:34 +0200
To: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

1. Run git clone https://www.townlong-yak.com/test.git


What did you expect to happen? (Expected behavior)

A local "test" folder to be created with a clone of the remote =
repository.


What happened instead? (Actual behavior)

The command produces the following output:
Cloning into 'test'...
error: files '/Users/me/test/.git/objects/pack/tmp_idx_WT81vv' and =
'/Users/me/test/.git/objects/pack/pack-427331d91391b00844273eeb3879cb479ce=
2c995.idx' differ in contents
fatal: unable to rename temporary '*.idx' file to =
'/Users/me/test/.git/objects/pack/pack-427331d91391b00844273eeb3879cb479ce=
2c995.idx'
error: Unable to find 6261a9d9f7704c02a5421ff733919ab18793aa7d under =
https://www.townlong-yak.com/test.git
Cannot obtain needed object 6261a9d9f7704c02a5421ff733919ab18793aa7d
error: fetch failed.


What's different between what you expected and what actually happened?

The clone fails and no test folder exists after the command completes.


Anything else you want to add:

This scenario works correctly with git v2.46.2 and earlier versions, and =
began failing with v2.47.0.

Running git-bisect identifies b1b8dfde6929ec9463eca0a858c4adb9786d7c93 =
as the first bad commit,
suggesting that the .idx file downloaded from the remote is now expected =
to be byte-for-byte
identical with a locally-generated version; due to format differences, =
they are not.

The remote idx is in the original (version 1) format, and git =
verify-pack seems satisfied with it.
Did v2.47.0 intend to block fetching such indices?

[System Info]
git version:
git version 2.47.0.163.g1226f6d8fa
cpu: x86_64
built from commit: 1226f6d8faf60d03cbb3b021c68d48364bf67ac0
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
uname: Darwin 24.0.0 Darwin Kernel Version 24.0.0: Tue Sep 24 23:36:30 =
PDT 2024; root:xnu-11215.1.12~1/RELEASE_X86_64 x86_64
compiler info: clang: 16.0.0 (clang-1600.0.26.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

