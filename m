Received: from mail-01.sigsum.org (mail-01.sigsum.org [91.223.231.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168B1547EE
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.223.231.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008245; cv=none; b=Htc6+ThH1pZYydOayIJ4T81r/3XfLjUUjtE1jRMFsojEyy5H41LmKCKv0wigpr+kaVt7hWFi5DHcINpXxq1Obwhsj5Tb5/8OkWvJKXFlU+aBrv4t7lKxwuD2qBnMhncboIyzuV0t1t3zPk3FXYVYzthPGth+EM9ou5KxrGR3+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008245; c=relaxed/simple;
	bh=uH1CCUzjtbvJ7Ntz1Zzi3saqidAm8k0nU2N4MK6SYSw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J/DIFu5IPasdQulDCvR9PZUGvCG4kGZ0Hn9PFsOZx3E+1NwTDRWfY32mVVEoAn1y+80ckWxqiwCYNQ7VXe0lne065GZmX/mxGjnwQzIb+KbLWCH96bmyUsGj13of2TvGJpoaYQBPutTcjXxh4oh98mIdi7YNxtWrAqOYQBfFcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glasklarteknik.se; spf=pass smtp.mailfrom=glasklarteknik.se; dkim=pass (2048-bit key) header.d=glasklarteknik.se header.i=@glasklarteknik.se header.b=AXk+oXgP; arc=none smtp.client-ip=91.223.231.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glasklarteknik.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glasklarteknik.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=glasklarteknik.se header.i=@glasklarteknik.se header.b="AXk+oXgP"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54F80C083C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 10:17:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glasklarteknik.se;
	s=dkim; t=1732007854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sJQKXFYT0x1Xy9u3ViiQfBg2RJ9E0+UtNPXoermGF3g=;
	b=AXk+oXgPDfNBVxn5mOblBoNFbfMPle1eGOwW63XGSQuBHt/Odm3lVfhDjw6S0wMPWSmCu4
	vgu6LntqE+KMjghDcQ8hTJXmYEIOUmbuxLJAZWBke0CagGKMQzgynSepijMJ4qYUBbAAgH
	sD808v5b/fMw+RdVpWONy35sB2wGTd5u88uFHBkSctN9H9RmS7G/8bFGehQ8yfPhPwqd3i
	4lkPifiSkRQ0rppeAu9aBK/MmjsPraemteGCvlb0WWlqOSmIPmkhFEvxNgte5/2LqpXXOu
	HmUNac1eXPmRltyFHAmh5fJx3vppxfcFyKaZwyyUFHm5XLGsx8lf78VfXhCmew==
From: =?utf-8?Q?Niels_M=C3=B6ller?= <nisse@glasklarteknik.se>
To: git@vger.kernel.org
Subject: Unexpected effect of log.showSignature on tformat:%H.
Date: Tue, 19 Nov 2024 10:17:33 +0100
Message-ID: <87cyirtweq.fsf@localhost>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

I had expected the output of git show -s --format=3D'tformat:%H' to be
always the same, and was surprised to find that scripts using this
construction started to fail after I set log.showSignature true.

See filled out bugreport form below, including a repro script.

Regards,
/Niels M=C3=B6ller

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

  git config --global log.showSignature true

  I'm trying this out to get to see in git log which commits are
  signed.

What did you expect to happen? (Expected behavior)

  That git show -s --format=3D'tformat:%H' SOME_COMMIT
  should still output the commit hash and nothing more.=20

What happened instead? (Actual behavior)

  I get an extra "No signature" line in the output (on stdout, not
  stderr), when looking at a signed commit.

What's different between what you expected and what actually happened?

  The extra output line.

Anything else you want to add:

Here's a small script to reproduce the problem:

-----8<-----
#! /bin/sh

set -eu

export GIT_CONFIG_GLOBAL=3D"$(pwd)/git.config"
git config --global log.showSignature true

git clone https://git.glasklar.is/glasklar/trust/audit-log.git
cd audit-log

hash=3D$(git show -s --format=3D'tformat:%H' e36424e5688572c196d658a5df8c04=
c20de7606a)

echo "Hash is: |$hash|"
-----8<-----

This is what it looks when I run it:

-----8<-----
$ ./repro.sh=20
Cloning into 'audit-log'...
remote: Enumerating objects: 143, done.
remote: Counting objects: 100% (8/8), done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 143 (delta 1), reused 0 (delta 0), pack-reused 135 (from 1)
Receiving objects: 100% (143/143), 347.00 MiB | 107.22 MiB/s, done.
Resolving deltas: 100% (59/59), done.
error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh =
signature verification
Hash is: |No signature
e36424e5688572c196d658a5df8c04c20de7606a|
-----8<-----

I would have expected the output

Hash is: |e36424e5688572c196d658a5df8c04c20de7606a|

[System Info]
git version:
git version 2.39.5
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.0-26-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.112-1 (2024-0=
9-30) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
