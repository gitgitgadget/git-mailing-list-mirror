Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D381A5B95
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 04:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748923978; cv=none; b=N6syqbipwYwl8a/Z81blve538IAXygcnIHAAyvYS1gOBE0hsY7i324OGoqLKk0ES8DuxXFnD86njuaa/yMyb1jbmo7+O5LLzJpgw7Ey+UQhzqhkX4IGyxazj+oxEI7FVWED/2kYZ1OGVnKeg59p12JMhibhq/KHBI9B8mIdBnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748923978; c=relaxed/simple;
	bh=VNLuSN1AMZmNXVCXsbDZJIoh8rfr6wy2s0Ajo4HDl6E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CIm47hHZeLGk7vlzX5ow60sC4InaUcLR+VgqahixTFEZUVYmsvcUXpSyi4/R2J9oEG2HQN15d4++cWeJCWo1CUy9cHeQV9/68RCkqQd8OFRGgFopq2ZN5fQ0IuP7EUTge4ovy9+qg046HMMfgleOBMUdBV+muyfRcCPAxhCwGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=MtRWGghW; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="MtRWGghW"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bBHPM29h8z8PbP
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 00:12:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
	:from:to:subject:message-id:mime-version:content-type; s=
	default; bh=VNLuSN1AMZmNXVCXsbDZJIoh8rfr6wy2s0Ajo4HDl6E=; b=MtRW
	GghW9q9IBmUa3uYc5ENWxkIQ+Quu8GV9vf5YxPMzcgwQx6j3N8/XEuqobjzHzxH4
	N3UzrF7MsqvqNcHzw1e3Ifdmnd8j/cTdYJqu77S4cnqDbQTkdysbIco6ebPfVY3e
	FdIY5CnM61XjjzHjx1mdMDUMogK6XBKESmlMVNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=default; b=
	pFxp7d3w6+/BuzGWWnqJgbU0UxOCoe1Wt39abZhEoFiunFbDPlzpGWNsD1C9pJtT
	d8NpSzf5otxll82JqdyiVmGaJmI9k+JOx1FI8zufAgpgIdU9FuJEdIFcmfJXXAYe
	5+pjOOAkzvMXuXETcbQY+jSGHAqUt93ixuQ6J2c8fv0=
Received: from humpty.home.comstyle.com (unknown [IPv6:2001:470:b050:3:3fc7:625b:78a:6fdc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bBHPL6GSbz8PbN
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 00:12:54 -0400 (EDT)
Date: Tue, 3 Jun 2025 00:12:53 -0400
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
Subject: [PATCH v2] compat: fixes for header handling with OpenBSD / NetBSD
Message-ID: <aD52RXZVAsXpimBG@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Handle OpenBSD and NetBSD as FreeBSD / DragonFly are. OpenBSD would
need _XOPEN_SOURCE to be set to 700. Its simpler to just not set
_XOPEN_SOURCE.

    CC strbuf.o
strbuf.c:645:6: warning: call to undeclared function 'getdelim'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
        r = getdelim(&sb->buf, &sb->alloc, term, fp);
            ^
1 warning generated.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 compat/posix.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/compat/posix.h b/compat/posix.h
index f4c71f9427..067a00f33b 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -60,11 +60,11 @@
 # else
 # define _XOPEN_SOURCE 500
 # endif
-#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
-      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
-      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
-      !defined(__CYGWIN__)
-#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__NetBSD__) && \
+      !defined(__OpenBSD__) && !defined(__DragonFly__) && !defined(__MirBSD__) && \
+      !defined(__USLC__) && !defined(_M_UNIX) && !defined(__sgi) && \
+      !defined(__TANDEM) && !defined(__QNX__) && !defined(__CYGWIN__)
+#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500 */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
 #define _ALL_SOURCE 1
-- 
2.49.0

