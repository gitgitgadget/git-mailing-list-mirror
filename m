Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913801A5B98
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968402; cv=none; b=ioscCv2GJbItDN4rlX3INITeJUkDqsivBPPRBym9UWqIIvrb2FK30DX6lTq5az3Pm/tTOAx8c2rQpVp3JZK0hfpAlXM/oI6vKe5PE57vnui4dnctpjaeQcDF/b3hIJGi9pQzXl1jZ8awMg5pcVIB9Z3U1eNQEZ3jqDoJn2EeKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968402; c=relaxed/simple;
	bh=Xy3vqXP37uN4SoDdmWpy0RBdXf7YpCciWfo6zABuqWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8gdkWHCwWmu6iUP0yf4BEX/oYcGNV5MGbtk535YvuZPGV7/+rio8bjJ3FjTQzpF5rTV1U4v7TyG7qnjbESyp6IdxXo8gqRA4PT8M/v+Uci63JJ7XurLDmoqx2qq1qBmyaaFElCIalZV8mCNMk+jbiIF1reFMiRL3/UhG+v455g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=a43U8hL2; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="a43U8hL2"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VqZupkM8; Sun, 06 Apr 2025 20:40:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968400; bh=1FAl3cmC0P85NtdFo4zRYhpwyTCCCIfDtZ7HYzEpvls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a43U8hL2rajirH/PX7VClHaIE4cWHSz2315odsOlwuYjLjXLAj3v76sualTX1xrgm
	 +pH8yOiBkahVR8Uzbb/JKv144PraUZfFyNDd9Ou2WblZnViGTvMliJ1uNwosEdtzbP
	 OK+vMtDEQXI0pn/HrgAkiKj8Gu0UFvj4ITKcw26043QDiNAXVC/AJBifYiHOu5NIsy
	 MOouaQxGy3vFSyExztDcLfmCSgw5WXMJWlj6sHe1P7E5tLviBPrDjzic8Z5mkT/uIS
	 4C8t9DpObbGUIa1W59pvPYUdJ1aWL1E3Fawim6od1WqFhiB3hoFPaMidT0bjJS90Tx
	 SnyzgCXQxNEHQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d890
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=mCKABES6tY-doaLBvqoA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 10/13] builtin/gc.c: correct RAM calculation when using sysinfo
Date: Sun,  6 Apr 2025 20:38:36 +0100
Message-ID: <a2eb9ab117c9a7ea8723c166739b30243388ea77.1743859985.git.ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com> <cover.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJu0g9RgNJBxGFBYM7eykHCQM3T+qrWMMoqwI+f8ZqHvU6fu1YntMPxF3ax8ejDQTuhIC5u/Wz/gMWT2cspVtJ/QbULFScavOWegXCQ5oe5XLRUaKRBa
 SR+SCkRPnyVxqtFDRvffhMQX8eszv1qz82jIfFLkn1i7pMFWXVLGGClBeUCwrsj9AoKGs0V+VJoxcf67DtHSWJ5ttY3GAjAy5jc=

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

