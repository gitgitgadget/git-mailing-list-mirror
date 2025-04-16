Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D320FAA4
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845600; cv=none; b=LLzAvsVUQYFtEtWoQOlwi+ot7O9wGw+A4WkzIRILWY8xJsdV5GJqShDWG+jKrhsYylHxW2K18n2nvLnkA3Pi0foOLQ8c+Uf85dYFxoB8CZ8oirlQhQ4IQiHY5rEGr9B03YIhGtN0O20xwubDbkAT0Bhn3bsMXlNvRYL9woEsUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845600; c=relaxed/simple;
	bh=Xy3vqXP37uN4SoDdmWpy0RBdXf7YpCciWfo6zABuqWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM3n4EKhYGlIhEno5RQR0CFEA1YIAV9g4+RwkvjNJs4p7ev8EaThh5zBNSKaWPx1103gpVKxZxrZ/uvUtymcUTMYZHZlYqHm7fZVDO0PeibJ2gHH/TuIJj/IUiJ8bDaSE+AZFuZlcQZhPxIp4csJOnSgItzo5R51LmP2odrSp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=eMI6b7Nh; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="eMI6b7Nh"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2vu8KPu; Thu, 17 Apr 2025 00:19:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845597; bh=1FAl3cmC0P85NtdFo4zRYhpwyTCCCIfDtZ7HYzEpvls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eMI6b7Nh9Til4x2nfVgekTC7DNz+W0A41Xu27MFSnNAZ1+w4PGK/pXH7wKa149zTJ
	 MJXEsHqZ51vSWnn2V3v9xkfUgf3b4E+Glw/pRJpPYfHEakEwYIhyT88Wr8HzPpUryL
	 kJ/ZVrna9kSWufWRrxim5hsypI5NPDcpJ4726xcC9FbOo2VDHyDJ68BCyzKSpjqvct
	 VgrXB39jeL21kX4aCNwzUoab88ufpyPKAsXsasKoYRXcY1qbQw+e88UUrolilbtqae
	 SaewPg9rX12FJACy1SFV0kBBgvMN9GcO8p/2PQf7jdC2dZqGJ0q4ztmNTdcvE2jdUB
	 3QBzT7nSdnEyg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003b1d
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=mCKABES6tY-doaLBvqoA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 10/13] builtin/gc.c: correct RAM calculation when using sysinfo
Date: Thu, 17 Apr 2025 00:18:31 +0100
Message-ID: <20250416231835.2492562-11-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfM7sFFc965gPHMRwo1QRdBf1cV2LEpO5lTzSlORgOqa8MtELBJlNGP1exYar4NuhJEefZ6RSJgaKSl5PcjrtfaFQHRKdVlaijKSex6ODi9Qlf8QixGV/
 pKno+EVoCgoSOUnoClux/ZYn/Y//okBIl9iboLcCks40DxzOW9XMlja/0pKb0ukmB99mAwQJuAhAgY9WNe7NA6IDAlK5RD1PbiI=

The man page for sysinfo(2) on Linux states that (from v2.3.48) the
sizes of the memory and swap fields, of the returned structure, are
given as multiples of 'mem_unit' bytes. In earlier versions (prior to
v2.3.23 on i386 in particular), the 'mem_unit' field was not part of
the structure, and all sizes were measured in bytes. The man page does
not discuss the motivation for this change, but it is possible that the
change was intended for the, relatively rare, 32-bit platform with more
than 4GB of memory.

The total_ram() function makes the assumption that the 'totalram' field
of the 'struct sysinfo' is measured in bytes, or alternatively that the
'mem_unit' field is always equal to one. Having writen a program to call
the sysinfo() function and print the structure fields, it seems that, on
Linux x84_64 and i686 anyway, the 'mem_unit' field is indeed set to one
(note that the 32-bit system had only 2GB ram). However, cygwin also has
an sysinfo() implementation, which gives the following values:

  $ ./sysinfo
  uptime:      21381
  loads:       0, 0, 0
  total ram:   2074637
  free ram:    843237
  shared ram:  0
  buffer ram:  0
  total swap:  327680
  free swap:   306932
  procs:       15
  total high:  0
  free high:   0
  mem_unit:    4096

  total ram: 8497713152
  $

[This laptop has 8GB ram, so a little bit seems to be missing. ;) ]

Modify the total_ram() function to allow for the possibility that the
memory size is not specified in bytes (ie 'mem_unit' is greater than
one).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/gc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 99431fd467..cdcf1dc6e7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -373,8 +373,13 @@ static uint64_t total_ram(void)
 #if defined(HAVE_SYSINFO)
 	struct sysinfo si;
 
-	if (!sysinfo(&si))
-		return si.totalram;
+	if (!sysinfo(&si)) {
+		uint64_t total = si.totalram;
+
+		if (si.mem_unit > 1)
+			total *= (uint64_t)si.mem_unit;
+		return total;
+	}
 #elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM))
 	int64_t physical_memory;
 	int mib[2];
-- 
2.49.0

