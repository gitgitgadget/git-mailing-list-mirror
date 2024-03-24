Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236C6FB1
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711305508; cv=none; b=axpzggmnIxcv0cTrL01Z3FlR127JyuBogLWLUt3HkjEMWN3UVi5ixJw47BTC7O3zta4Jwcdz3l9RzBBfBGSgT6RCffRkiDN6xpi+WrPL0UDwU8UupLs3aE7ygDwQnoJngpt2s13ktr0k1wznH/+iieVwsg9pAhMks3QGT5ClDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711305508; c=relaxed/simple;
	bh=A6E9v4RRBP8bitEg9ezVoRinlMB9VzSJwCCEKWVbIxM=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=jU1Gwtqo/3WFJnTEj3aNEYuCQx2jKo80EOId+YfKeSKpBBqEBJCT0uOjtbUoFjGGCD2CtDtlOOCpvaqb9LqJp+64NShNTK7ORV7WytOoDyqHJUXhnWrjqNlS73qBM5g1b8VvptV3I1qodweTSA8uPXeE7tR5JPT6lIsNVM8H0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rohdewald.de; spf=pass smtp.mailfrom=rohdewald.de; dkim=pass (2048-bit key) header.d=rohdewald.de header.i=@rohdewald.de header.b=X4gSLyB5; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rohdewald.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rohdewald.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rohdewald.de header.i=@rohdewald.de header.b="X4gSLyB5"
Received: from [10.210.137.29] (p4fd4440a.dip0.t-ipconnect.de [79.212.68.10])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 27996E02D2
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 19:28:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rohdewald.de;
	s=uddkim-202310; t=1711304902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4i1qldwgIUgcGQroTiQJrTgCOuheMArj3zOs9KgXlto=;
	b=X4gSLyB5loL/D9mTUmbasIj9l8nORYvw8CIHkpjsP/sxR2MtRxVLbOnrGJD9vNXYNT7zl9
	qPI0vkYMqcDoT+RKEBwN57g/HvfJLzatqAouEthnFhAYhdfXZVs9Q+RpTSUwbEO7sr1pW5
	xma2VBSrDNKHUmaiUKoEMf5qeOL2VOn0WhlCAfNzDyIhaPhJbDNaY9j9W6a7KGkoiOwVHS
	pYZHpVdAhFDsJx5/1RDLhg+jeLtj3aoqe8Qgtv5C0qDC10AWy3CuEa4SNptSlZdV9w7GqX
	R5GkBVls3VYDetOmAXS6FRjhRZW4UmwzijHvaGApI+DvGsWSSeGoxCMuQjib7Q==
Message-ID: <88a694de4a7f767613475ef1d19292a69eaccb07.camel@rohdewald.de>
Subject: segfault with git rebase --abort
From: Wolfgang Rohdewald <wolfgang@rohdewald.de>
To: git@vger.kernel.org
Date: Sun, 24 Mar 2024 19:28:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=wolfgang@rohdewald.de smtp.mailfrom=wolfgang@rohdewald.de

git rebase -i

git rebase --abort # boom

git status only shows changes to be committed
I can mail or upload the git archive, that would be 230MB

git fsck;git repack;git prune;git gc does not help

Happens with git 2.39 and with latest git commit 11c821f2f2a31e70fb5cc449f9=
a29401c333aad2, compiled with -g -O0

gdb:

Starting program: /home/wr/bin/git rebase --abort
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x00005555557ef89a in has_rerere_resolution (id=3D0x5555559f5950) at rerere=
.c:167
167             return ((id->collection->status[variant] & both) =3D=3D bot=
h);
(gdb) bt
#0  0x00005555557ef89a in has_rerere_resolution (id=3D0x5555559f5950) at re=
rere.c:167
#1  0x00005555557f249c in rerere_clear (r=3D0x5555559ea220 <the_repo>, merg=
e_rr=3D0x7fffffffc0a0) at rerere.c:1249
#2  0x000055555562388e in cmd_rebase (argc=3D0, argv=3D0x7fffffffd8b0, pref=
ix=3D0x0) at builtin/rebase.c:1315
#3  0x0000555555574b71 in run_builtin (p=3D0x5555559b6010 <commands+2256>, =
argc=3D2, argv=3D0x7fffffffd8b0) at git.c:469
#4  0x0000555555574f8c in handle_builtin (argc=3D2, argv=3D0x7fffffffd8b0) =
at git.c:724
#5  0x00005555555751b0 in run_argv (argcp=3D0x7fffffffd71c, argv=3D0x7fffff=
ffd710) at git.c:788
#6  0x0000555555575724 in cmd_main (argc=3D2, argv=3D0x7fffffffd8b0) at git=
.c:923
#7  0x0000555555673c7a in main (argc=3D3, argv=3D0x7fffffffd8a8) at common-=
main.c:62
(gdb) p id->collection->status
$2 =3D (unsigned char *) 0x0
(gdb) p *(id->collection)
$3 =3D {status_alloc =3D 0, status_nr =3D 0, status =3D 0x0, name =3D 0x555=
5559f5e80 "a8ec6f624ee23ef2e37148a8172ebac3c6639f93"}

there is no file named a8ec6f624ee23ef2e37148a8172ebac3c6639f93


[System Info]
git version:
git version 2.44.GIT
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.6.22-25 #1 SMP PREEMPT_DYNAMIC Sun Mar 17 12:35:12 CET 2024 =
x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

--=20
mit freundlichen Gr=C3=BCssen

Wolfgang Rohdewald
