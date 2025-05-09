Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9B26A0A7
	for <git@vger.kernel.org>; Fri,  9 May 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771200; cv=none; b=mjE6tNXevd3/RsIoU4M6qKtY+ydcS8omdf6lno19gzm3larj6SUqr0LVUvefSMKj2HPGZWlgqkfiGiV7XAnURHKtV35q4qwrAkR8Dcr5IMQ0GbNwYoCQSa6YWRxyftWo37radDZyCeJ6UqnhJ72xKZzXMrvAdMo8KqpqFpr5FjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771200; c=relaxed/simple;
	bh=wtiW2I8KNJdtXaj2JqPwG3wdO3ls1qHXUIOZy3SGgng=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i47pbeYn0+B/Ujvi64IrqGyilNA6JEpnmq/C1UkhHJUFDWGl1geWFK2ki771MGqUSu6NLpo5D6FioztQUP3IOWuzfJ57vzX1VAGNfRi1cqiyDr3Wnbuh7XBtEQLI7FdAFImRj59i9QDSCRCmtn+fItnBWa0nSuoTDX9X/49LBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=T2OAwq6G; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="T2OAwq6G"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4ZtzFl1hV6z8PbP
	for <git@vger.kernel.org>; Fri,  9 May 2025 02:13:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
	:from:to:subject:message-id:mime-version:content-type; s=
	default; bh=wtiW2I8KNJdtXaj2JqPwG3wdO3ls1qHXUIOZy3SGgng=; b=T2OA
	wq6G9kwcwK+EFpIiHo9tH73GPG6hYUe/Gh69lN6c+CCNFY37S79z4/HFH+2nqnW9
	Ow7IzAyCKkJQo2AVgrhnLbHpG8MzXJBQoLD7/ZAIS1rIpoP9HCLoeVrs6K0qR8u5
	HHX8QlnmJ4kvdiUcXhz93amWyuNyCKXv3E7LAMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=default; b=
	Z1yyfBOE7n8jV/Hv2uhNQWNwIOkXl+1x5eDyAjAho3L/gSlniuVmjkmbie/x1Trw
	Uiw/JnROclaODKryzLD1jVFd72y2Ch7esRlUhhu0AgplrZ+Qv6IdKLp1WcHNEu4B
	taRzOVNTqzw1uJ9zTPaoGiQIbdjnSaNWqyT8TTAGP6k=
Received: from humpty.home.comstyle.com (unknown [IPv6:2001:470:b050:3:e451:c279:b9cc:6dc1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4ZtzFk6nPcz8PbN
	for <git@vger.kernel.org>; Fri,  9 May 2025 02:13:14 -0400 (EDT)
Date: Fri, 9 May 2025 02:13:13 -0400
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
Subject: [PATCH] thread-utils.c: detect online CPU count on OpenBSD / NetBSD
Message-ID: <aB2c-W0V83aVDpZr@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

OpenBSD / NetBSD use HW_NCPUONLINE to detect the online CPU
count. OpenBSD ships with SMT disabled on X86 systems so
HW_NCPU would provide double the number of CPUs as opposed
to the proper online count.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 thread-utils.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/thread-utils.c b/thread-utils.c
index 1f89ffab4c..374890e6b0 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -46,11 +46,11 @@ int online_cpus(void)
 	mib[0] = CTL_HW;
 #  ifdef HW_AVAILCPU
 	mib[1] = HW_AVAILCPU;
-	len = sizeof(cpucount);
-	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))
-		return cpucount;
-#  endif /* HW_AVAILCPU */
+#  elif defined(HW_NCPUONLINE)
+	mib[1] = HW_NCPUONLINE;
+#  else
 	mib[1] = HW_NCPU;
+#  endif /* HW_AVAILCPU */
 	len = sizeof(cpucount);
 	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))
 		return cpucount;
-- 
2.49.0

