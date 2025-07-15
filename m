Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67C2D3235
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606775; cv=none; b=HHwWAkYiRTR47ZxXf+nuDna+tSGcY5gBci60SmPxnQtJVow+Jv0gwJp1tcxBt/CiCvX9ojUB5tLKWaWoAhpj3qibXIjpdcbzqrp0xyUt/4LBtNLelF6GPM2cjk6RoL9nDr9CP9/XSmbCyK/rFydjNDtpOX0C2aVHa8ng2efDNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606775; c=relaxed/simple;
	bh=wr2ZK21cdvtuVrrWOHSevlitlE+ToZYGqPM9nnl3gtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X55ScCg6QEucacr9O+vrs4eQWuOIsK0FOOsXLTK7xLGGK6mGDyBWbOmm8ipIZ5T9rq0N3RLaTWY6BJkjTY2bDaToiXmYZzvFhmoNqfrFtN7WPSlWG4PgmLmupoOkuOcbuY/I7etTzB04c+WvU5NLcjiNHhRnfQguTN1YYe3fYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=FHsU7vAa; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=guoGTWEX; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="FHsU7vAa";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="guoGTWEX"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id CA444604FB; Tue, 15 Jul 2025 21:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1752606771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ak/aCs8RjfsLC74erkJaLM0qiHIqOsVgntUn2aqEz3E=;
	b=FHsU7vAaUNIzsaYeX9K/S1xMvr8JQvY1hiVQyf2awqoGXItXLND2BDHR9jujXCSdRf5gig
	fxmsRTsBdKsFBBfyDCmnZp1D2q8lMj5wCaqUwcutStRshye+yfwjV18pHItPw/z2jMHj6n
	+i9JDnQYxAMEA5td9AChiYADkeitlRHHzDZFWrfOAEhtF0ze4UKrEjQG8r0P4FRKBfU9jf
	TV2iExSKP2Ke4/mo2zq00I/OhmdOe9paqzQuJN6KAwFjPmeczYwscXZkPtC1zRXQZwPrrw
	W2ob5lNZ56Ww2iLcjGTOJclpISvTYt84bkDOj8xuAeZ0x9P1XTggxlvS4VUlBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1752606771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ak/aCs8RjfsLC74erkJaLM0qiHIqOsVgntUn2aqEz3E=;
	b=guoGTWEXgZOEe00eIKN2UkHWCEFmTPwbRiwVT53GOwbLRhe0xkE8fisW8cj63ettVs/Z3m
	e2zQPJvjrgvcLeBg==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v3 0/5] bswap.h: Rework ntohl handling
Date: Tue, 15 Jul 2025 21:12:25 +0200
Message-ID: <20250715191230.12081-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

this series continues the rework of the bswap32/64()/ nothl() handling.=20

I've been looking at recent compiler and they manage to recognize the
manual shifting and use an optimize opcode if available. The ntohl
version provided by glibc already provides an "optimized" version which
makes an optimisation in git almost not needed.
One of the motivation behind overwriting/ providing an optimized
version was to provide a macro instead of using a function call. One
libc that is still providing ntohl as a function call is musl.

While ntohl() is provided by the libc, the ntohll() is not. I found it
only on Windows provided by winsock.h.

I haven't touched the put/get_be*() macros. gcc & clang are both smart
enough to swap the content accordingly and perform a single store/ load.
Only the msvc seems to strugle here and performs multiple bytes stores/
loads and shifts.

v2=E2=80=A6v3 https://lore.kernel.org/all/20250611221444.1567638-1-sebastia=
n@breakpoint.cc/
  - Fixed typos in the patch description

Sebastian Andrzej Siewior (5):
  bswap.h: Add support for __BYTE_ORDER__
  bswap.h: Define GIT_LITTLE_ENDIAN on msvc as little endian
  bswap.h: Always overwrite ntohl/ ntohll macros
  bswap.h: Remove optimized x86 version of bswap32/64
  bswap.h: Provide a built-in based version of bswap32/64 if possible

 compat/bswap.h | 114 +++++++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 66 deletions(-)

--=20
2.50.0

