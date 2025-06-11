Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6DA23AB94
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680104; cv=none; b=DaBXOjGfMYP2H01MD9ubd0VFdiGtvVLwtNrXuhLad55aiDailZe0jT5RikbHwag8fO1vIABZAd+SfavnR1zeZNkWL9uVRfomb0rxXDkY7619bovGK3a7eNS05IxRQbHml7KseAt+tB0eyvfd81ZVZDwV5OxLY/iiIZYRYLoM1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680104; c=relaxed/simple;
	bh=I6So/pq1XzhNi0fl3OSF89sWJHnQGlSZnTX3X4ESPWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPEa/mzkRFG9h72WxKs4uAAEuV/SBhn+shRDL8LrRmpPvbVfAp/AOPD22f7sh4qlAFRlF8qnYWzwY11rM0Pxi5JCG3JQWrxSbho8tYkOebkSuXvUIK81Kbndkz8yp3D1qWE6W5I5oS9rkkxrSOlgRaNcNamU8dp23Cw3POtjYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=IG7N2jra; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=ughexGVq; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="IG7N2jra";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="ughexGVq"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id 8FD0B612E3; Thu, 12 Jun 2025 00:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1749680092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YYhPI1uyrHQi2roe4XE8lu9U1ULObIQJR7Z1nL9ToA8=;
	b=IG7N2jragfrCXr/zVU/foZTsHcVQelew07Yv6vEZTJJi+nrjndYXPmZG3ZleBFowhNVbvn
	7/tQDHhwDILpP1FSRAVwdY775YCplkQVeOM8OT6+gSpPmYbv9n4nWiI8W9sOUpAgwhfQv/
	tX0dEJT6jPUc+QEKYCVanqiOfQCAZD3VxBnGpGFiU3AwPFszn4SVPscOiNoxMQyZIRXtuB
	iMMh7M6crGIMGM4NGoH5to7/fdxd13QruveI1jQfWQSZSAVBxkk0j6AZ+xjmB6kCX6mJga
	2d0isgbMAJJUD8CejW3PszGMZ3prAlKHtdXvbcu+RX/JBUcSRyTIbzm9YM8E9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1749680092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YYhPI1uyrHQi2roe4XE8lu9U1ULObIQJR7Z1nL9ToA8=;
	b=ughexGVqAyKXnjut4QRA+y5D5MuHRLQMVxSx1sXURMKh+nsZSqlxBTeujMoQdVn/EtU5sz
	gYrXdqcHVNVLgZCQ==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v2 0/6] bswap.h: Rework ntohl handling
Date: Thu, 12 Jun 2025 00:14:36 +0200
Message-ID: <20250611221444.1567638-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

since the add of bswap32/64() support based on __builtin support, the
usage of ntohl() macros is broken on big endian machines because the
macros are always overwritten providing a swap.

The first patch in the series reverts the change and the following
patches try to improve the situation by allowing to always provide an
optimized version.

I've been looking at recent compiler and they manage to recognize the
manual shifting and use an optimize opcode if available. The ntohl
version provided by glibc already provides an "optimized" version which
makes an optimisation in git almost not needed.
One of the motivation behind overwriting/ providing an optimized
version was to provide a macro instead of using a function call. One
libc that is still providing ntohl as a function call is musl. So it
might makes sense to keep it.
While ntohl() is provided by the libc, the ntohll() is not. I found it
only on Windows provided by winsock.h.

I haven't touched the put/get_be*() macros. gcc & clang are both smart
enough to swap the content accordingly and perform a single store/ load.
Only the msvc seems to strugle here and performs multiple bytes stores/
loads and shifts.

Sebastian Andrzej Siewior (6):
  Revert "bswap.h: add support for built-in bswap functions"
  bswap.h: Add support for __BYTE_ORDER__
  bswap.h: Define GIT_LITTLE_ENDIAN on msvc as little endian
  bswap.h: Always overwrite ntohl/ ntohll macros
  bswap.h: Remove optimized x86 version of bswap32/64
  bswap.h: Provide a built-in based version of bswap32/64 if possible

 compat/bswap.h | 118 ++++++++++++++++++-------------------------------
 1 file changed, 44 insertions(+), 74 deletions(-)

--=20
2.49.0

