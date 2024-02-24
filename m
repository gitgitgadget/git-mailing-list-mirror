Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D5211C
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708806775; cv=none; b=rvuHV0crt+peMCreii6xpMVyjxJMqabI6rKFnF3SgRRczW2vQ/3s8iAgiIR/lXr5bBryT9D0k+3wu8FER6L9BFgBGKH+/GoMavPno93TBXL5HNrmKs89SRSNEbXGYPMfDuOloLMHmXNdOBhf0WQoG+kH/A4G5p+Rx5xqobHn7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708806775; c=relaxed/simple;
	bh=ehqD9icL+GdNTEuA9WLSg8PvwNA99F1MTBhwDQXezIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bViTaIItt+lrLAN2qEfYol1cfc5EIxvrL5kIgS9ZAW1GqjIZB/VjYOE0mwQMDbghn5d6dRB9Mf8bCNldELpbJq57gQapFQ+xEfisAK+38ygN2wf64E+fucJWYp3u3uzBCUPom/TEhX8Zd8sCKKVErmaCGvEupKjzvuk+2L06Oag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LDYLTjyv; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LDYLTjyv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EC841E9189;
	Sat, 24 Feb 2024 15:32:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=e
	hqD9icL+GdNTEuA9WLSg8PvwNA99F1MTBhwDQXezIk=; b=LDYLTjyvvDadr1ZDz
	yyw+WSJX8Nw2swCWI7CN3VweCpwmLdIdZNQ6FhKPTP6Gb2sIATPRT2hZT4VMMx0M
	sbAWy6+h+ZyIhu2izZstxfSOraLv9tyOxzBBurCgbIykHwTA/jKM24BUcGVA7Lkj
	VC8ZJf9372F0JOd6/euMkBzHm8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 36AA31E9188;
	Sat, 24 Feb 2024 15:32:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F07A1E9187;
	Sat, 24 Feb 2024 15:32:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] compat: drop inclusion of <git-compat-util.h>
Date: Sat, 24 Feb 2024 12:32:51 -0800
Message-ID: <xmqqwmqtli18.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E2402FDC-D353-11EE-8E1E-25B3960A682E-77302942!pb-smtp2.pobox.com

These two header files are included from ordinary source files that
already include <git-compat-util.h> as the first header file as they
should.  There is no need to include the compat-util in these
headers.

"make hdr-check" is not affected, as it is designed to assume that
what <git-compat-util.h> offers is available to everybody without
being included.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * There is an obvious alternative that goes in the complete
   opposite direction possible, to update "make hdr-check" to ensure
   that things that are depended upon in each header file
   (e.g. pager.h refers to uintmax_t) are brought in by the header
   file to include the compat-util in it, i.e.

	diff --git c/Makefile w/Makefile
	index 78e874099d..d7b360f15e 100644
	--- c/Makefile
	+++ w/Makefile
	@@ -3259,7 +3259,7 @@ HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
	 HCC = $(HCO:hco=hcc)
	 
	 %.hcc: %.h
	-	@echo '#include "git-compat-util.h"' >$@
	+	@echo '/* #include "git-compat-util.h" */' >$@
	 	@echo '#include "$<"' >>$@
	 
	 $(HCO): %.hco: %.hcc FORCE

   which would require in a noisy diff to add inclusion of
   git-compat-util.h to many header files.  For purposes of folks
   who may want to carve out only pieces of our source tree, such an
   approach might work better, but for that to happen and yield any
   useful result, I suspect that compat-util header needs to be
   split into "compatibility essentials" and other "it is convenient
   if these are available everywhere, even though they do not have
   much to do with hiding system dependencies from the sources"
   parts first.

 compat/compiler.h | 1 -
 compat/disk.h     | 1 -
 2 files changed, 2 deletions(-)

diff --git c/compat/compiler.h w/compat/compiler.h
index 10dbb65937..e9ad9db84f 100644
--- c/compat/compiler.h
+++ w/compat/compiler.h
@@ -1,7 +1,6 @@
 #ifndef COMPILER_H
 #define COMPILER_H
 
-#include "git-compat-util.h"
 #include "strbuf.h"
 
 #ifdef __GLIBC__
diff --git c/compat/disk.h w/compat/disk.h
index 6c979c27d8..23bc1bef86 100644
--- c/compat/disk.h
+++ w/compat/disk.h
@@ -1,7 +1,6 @@
 #ifndef COMPAT_DISK_H
 #define COMPAT_DISK_H
 
-#include "git-compat-util.h"
 #include "abspath.h"
 #include "gettext.h"
 
