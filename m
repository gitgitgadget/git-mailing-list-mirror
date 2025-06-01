Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CA149C4A
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748766258; cv=none; b=clpoRU1nA8oXOGHaWaXV+H/cGRdneej4DTEFG6YjVmg20KKQCWkYhztLS/+TUK/axqFGJ+/1pXDCZ20DVKaIkUmkFPN6OhVhZeEJBOQyTBid/tp258kNrU/fzN4ILF0DPpuvUHRnETk72jisRUVTkjYsGisJcR/aztnOh0ql2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748766258; c=relaxed/simple;
	bh=b70b2Yxho5O6x6CRygKBZcxD3uL9JZLsFf2YkgixJ4c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pQw/z1X7owyZVJOL4fqPx8lJkK9TVsqMiHDc9uvHjHTEYlKrBwH7fpeKwwbIUAzGpe2PqtR+SIsIVUFxyRQAkaJ6XGWK/HIzmdcUArf7ChtnXwM8TWKrkK+ji81KkRoseYLYsKqgC2YxP9hYhVfympivRhhqIKlvOuWvBSZS4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=QYukPhAE; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="QYukPhAE"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4b994G02Scz8PbP
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 04:24:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
	:from:to:subject:message-id:mime-version:content-type; s=
	default; bh=b70b2Yxho5O6x6CRygKBZcxD3uL9JZLsFf2YkgixJ4c=; b=QYuk
	PhAEvnoUqPuFuoFyTQ4fsVncmLV40+rh3n+eBAi8uhEevZyoAOntWs+XOcWXWpMf
	S6H6hlVYWKco9DRtWQReEL5dbXBFKZya6nW6IvARpcgQ8FZbOefYkqi3PqEIvD0O
	2Z/0pgcDZHGAhc5bZCr6CmnczhL55jpx1Q9TqYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=default; b=
	ljTuOvLy55pMcK28erK9Nrx5Rt/gAezWg2zu3EQq9g9dhCzFYq4kN2C10HbxIsIx
	uSOA6Ppaenzyo+Ipaw6Hy7Qu0ft0aKb7dkih1xEnrGvKUNoqWm4D53FNyYYQCXpH
	92Gsu8icak5yCQIz+7R4q0XVr8QBnC15FZZaKiQCU2w=
Received: from humpty.home.comstyle.com (unknown [IPv6:2001:470:b050:3:fee6:fc3a:d232:9c1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4b994F59qcz8PbN
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 04:24:13 -0400 (EDT)
Date: Sun, 1 Jun 2025 04:24:12 -0400
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
Subject: [PATCH] builtin/gc: correct physical memory detection for OpenBSD /
 NetBSD
Message-ID: <aDwOLPOa8JOgFJZg@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

OpenBSD / NetBSD use HW_PHYSMEM64 to detect the amount of physical
memory in a system. HW_PHYSMEM will not provide the correct amount
on a system with >=4GB of memory.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 builtin/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e690453d4f..eacb445085 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -431,7 +431,7 @@ static uint64_t total_ram(void)
 			total *= (uint64_t)si.mem_unit;
 		return total;
 	}
-#elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM))
+#elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM) || defined(HW_PHYSMEM64))
 	int64_t physical_memory;
 	int mib[2];
 	size_t length;
@@ -439,6 +439,8 @@ static uint64_t total_ram(void)
 	mib[0] = CTL_HW;
 # if defined(HW_MEMSIZE)
 	mib[1] = HW_MEMSIZE;
+# elif defined(HW_PHYSMEM64)
+	mib[1] = HW_PHYSMEM64;
 # else
 	mib[1] = HW_PHYSMEM;
 # endif
-- 
2.49.0

