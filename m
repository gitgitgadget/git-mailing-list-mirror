Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B5396579
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886723; cv=none; b=U6XoeBkuFWqB8Ax/XcQ/lCRK2KY/mQ+Kr70An6W3uxrEFVuo0WpTGxqne+38TFl0M5af+lpON3h5huRn26hQ6mbTtQMCNig8YgMcS4HE1HaPdLs5X2OHDrJdrLkRvl2nQbKtPUsTqIhu4cgZRh8Q8UkF8ZvJk3xzbG6L04z/JAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886723; c=relaxed/simple;
	bh=rFCi/t46UV+Y+V3e3gPHGwqc/8mOdM7awbIyBRCSWss=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=b2K2Bd6SyTKEgyPhJFz2vJYnSC+qRIXWKsSaZnRIrhQIPTk5VV3cNF2Z8YQTVVDPGl03jRecsPU88h5GR7t2+buDxuR+dkg2PGSSiT4RKJYazDrCDdQ8VXedfzV/hOLEBGu5mGIwHJA4v/XSJr5yHF8NdoIYwJ0mY7y1cEp35SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MXLzNFWB; arc=none smtp.client-ip=109.224.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MXLzNFWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=etssas5hlbgirghps2azk4ufa4.protonmail; t=1781886714; x=1782145914;
	bh=rFCi/t46UV+Y+V3e3gPHGwqc/8mOdM7awbIyBRCSWss=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MXLzNFWBwUSdNIVEcqMb7MlOhE/w73HVUE9fz/D7hP/uu3FoPPZfqz295EOEIfQTq
	 xPyxUfjjg+9VEn44nmsTDB7YYiNw1ikBrQyEjsnenJRK3yRJqbkTmZoo5gD38UTzcW
	 G+5FcETOfFt8BFye21vuvBwsDJssQAIaDKbC+EBoIGnCUwuF5EKYhGLJ4gJ3SHwYS8
	 QkzdAqFJPNgkHpmBE4nEMVCR5FBHph3K2f7uR5rt+hBeF2RCL59tjy0J0TxNZg57pN
	 x1lmQtUrH6K5g1G0zETw+vSJxY6ci69sGhEEnfPju1hR2aYs1v8HJGvSvCzy4obQTl
	 6IFuMazVZgJEw==
Date: Fri, 19 Jun 2026 16:31:49 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: charmocc <charmocc@proton.me>
Subject: Bug: Checkout in sparse mode can overwrite uncommited files
Message-ID: <15FXjc8hV3WTRkSg1-PMUqlEFqWxJ5iw5qVbO9WoMX0NEyB4l1AOGSOhtBsxZbgTYGjzZfLJoFr9cyaL9_5Jazwa1OQGPzS7_MCTnkfUJvQ=@proton.me>
Feedback-ID: 101377472:user:proton
X-Pm-Message-ID: 63e3f2108bdc2fbb0a6bb1f76bdd9d4bbc3d7d3f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hey. Today I discovered inconsistent behavior in sparse mode that may lead =
to data loss during initial checkout. Please have a look.

What did you do before the bug happened? (Steps to reproduce your issue)

$ git init foo
$ cd foo
$ echo 1 > file
$ git add file
$ git commit -m 'test'
$ cd ..

$ git clone --no-checkout foo bar
$ cd bar
$ echo 2 > file
$ git checkout
error: The following untracked working tree files would be overwritten by c=
heckout:
=09file
Please move or remove them before you switch branches.
Aborting
$ cat file
2
$ git sparse-checkout set
$ git checkout
warning: The following paths were already present and thus not updated desp=
ite sparse patterns:
=09file

After fixing the above paths, you may want to run `git sparse-checkout reap=
ply`.
Your branch is up to date with 'origin/master'.
$ cat file
1

What did you expect to happen? (Expected behavior)

Checkout should fail due to uncommited changes

What happened instead? (Actual behavior)

After enabling sparse mode checkout overwrites file in working directory

What's different between what you expected and what actually happened?

In normal mode checkout is aborted correctly but in sparse it overwrites da=
ta and gives misleading message

Anything else you want to add:

[System Info]
git version:
git version 2.53.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
gettext: enabled
libcurl: 8.18.0
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.0.0-22-generic #22-Ubuntu SMP PREEMPT_DYNAMIC Mon May 25 15:=
54:34 UTC 2026 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.43
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

