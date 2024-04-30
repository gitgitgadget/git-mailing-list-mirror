Received: from mta-sndfb-w04.biglobe.ne.jp (mta-sndfb-w04.biglobe.ne.jp [27.86.113.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526A10A01
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=27.86.113.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447967; cv=none; b=GvLcl1KajNpQH9rI7oU8RDAncRCAeRL0jKgj1GysgsqLN7dUZbUB7B7VsIqAEqp+T/hgheVKcUyMEuSL82cvs95wK5bP6tlXLiOkP47I6EMbQ/zT/kNj5EPqUJih+A3tc+ONjxQZA6FoQTnpBYauZzbBBBlYGKHzfVK2f1apyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447967; c=relaxed/simple;
	bh=2P6ywOUchG3Nb7Z0XY3zLYvBeLymK/TOuLP0cbd/3G8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=TLZaH/6iIAIIKFogFDPZYUSYGQiAx2Pk4dz1FtiyPcWMyCrL12rKDDXtLAQ7eSmJCibDC30zynheL6ITL2JOYSvmVfnRAqtcUh0Nnx2XoZzOw0TUTZIt6Xbiz9DmD9a3s0T+5hUZilkMm3G8kQE3n1NG/FKj9iQs+KPStecS7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kba.biglobe.ne.jp; spf=pass smtp.mailfrom=kba.biglobe.ne.jp; dkim=pass (2048-bit key) header.d=kba.biglobe.ne.jp header.i=@kba.biglobe.ne.jp header.b=H+a3D3kI; arc=none smtp.client-ip=27.86.113.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kba.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kba.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kba.biglobe.ne.jp header.i=@kba.biglobe.ne.jp header.b="H+a3D3kI"
Received: from mail.biglobe.ne.jp by mta-snd-w11.biglobe.ne.jp with ESMTP
          id <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
          for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:27:17 +0900
From: Jun T <takimoto-j@kba.biglobe.ne.jp>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: [BUG] 'ls-files path' fails if absolute path of workdir contains NFD
 (macOS)
Message-Id: <55D75808-70E0-46FA-906D-C00CD612A262@kba.biglobe.ne.jp>
Date: Tue, 30 Apr 2024 12:27:02 +0900
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6)
X-Biglobe-Sender: takimoto-j@kba.biglobe.ne.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kba.biglobe.ne.jp; s=default-1th84yt82rvi; t=1714447637;
 bh=v0zqzU5Eksf0ZrTswUK0rJjQT193ClKY5s73oKILEAw=;
 h=From:Subject:Date:To;
 b=H+a3D3kII9H6o0MzDhWkx9Mj2GpTRxqpx90m/uxOUHMlijHlS1vtYwtBzLVkVkK27w+Jxdo1
 smtfMCi3LPJgVm5zaj7Mui7v0vZA1uz8DzcDuEKQ0ErBsmOfV/eFYIofZ1W+PfDhOdHzOqKGrQ
 uRF52ZEOVn8r2PD19IkyeKwSmrMU16PZxNzCCoxd5gHtLNKaTMn/BwKaME3eVjEr0JFvvuyCjS
 wnbXylQMy7vf3nE8t4e7aIu8p28xfA3toDrjvNK6uA21/0GNYarAuHqN4DMTMGZVG3hC7UPddP
 xizpogWEmxZ0AkusGRDt1lKYePyCKV5fMc2fi9OlQ0gDzdxg==

On macOS, 'git ls-files path' does not work (gives an error)
if the absolute 'path' contains characters in NFD (decomposed).
I guess this is a (minor) bug of git.

[1] How to reproduce the problem

On macOS, git 2.39.3 or 2.45.0.219.gb9fe23f5ca(next branch),
file system can be APFS or HFS.

with zsh or bash:
% cd /somewhere         # some safe place, /tmp or ~/tmp etc.
% mkdir $'u\xcc\x88'    # =C3=BC in NFD
% cd =C3=BC                  # or cd $'u\xcc\x88' or cd $'\xc3\xbc'
% git init
% git ls-files $'/somewhere/u\xcc\x88'   # NFD
fatal: /somewhere/=C3=BC: '/somewhere/=C3=BC' is outside repository at =
'/somewhere/u=CC=88'
% git ls-files $'/somewhere/\xc3\xbc'    # NFC
(the same error as above)

In the 'fatal:' error message, there are three =C3=BC;
the 1st and 2nd are in NFC, the 3rd is in NFD.

[2] Some analysis

The path on the command line $'/somewhere/u\xcc\x88'
is converted to NFC by precompose_argv_prefix(),
called at git.c:451 in run_builtin().

But get_git_work_tree() (called at setup.c:50, in
abspath_part_inside_repo()) returns the work_tree in NFD,
and comparing it with the path in NFC (setup.c:92) fails.

I'm not familiar with git internals, but maybe
get_git_work_tree() should return NFC (on macoS)?

--
Jun (Jun-ichi Takimoto)=
