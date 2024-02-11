Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0315BE
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707617170; cv=none; b=eNoev50MAxxbUmBVQF6+chyWeLb2RhikVpnH4zu0QgYh0p2//09n2W3r2HVKGvkVecqAIekNwh8aFcrHWY9u2gJEDr1ieZnBjt49XsG6LDT/Ap7GiqgdzJ1d2wVbxG/kT6Fz3s3BgD0z9BKp9EvM/ayIo0unIuJjY++vOGYjMIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707617170; c=relaxed/simple;
	bh=5gUp7XB3/zgTaQvH9CGE+9PvZ2Pf3t+inPWiSQIb3EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lte0Q9CtG8PvF5UOYNKwvbA8l9BQWAxrMjBn6RBTUVxi844Z5t51iY3AE3CxDXXiYytUfd2LbDrHBOhd1tW/dET5HsIRLjYWSCe6LQQNu3E1KqGKoGscZUcABCXbNtsxqjd/fTd38139tyS0iNVSM/++NV2Rxxy5y9faJfde3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fS4AMtFZ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fS4AMtFZ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DD98E23A24;
	Sat, 10 Feb 2024 21:06:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5gUp7XB3/zgTaQvH9CGE+9PvZ2Pf3t+inPWiSQ
	Ib3EM=; b=fS4AMtFZ3zDzhHbIBZ7ydaRiQ6682AprRJoPUA7Hj0KSUCGdFemsrF
	d54r8j0XI0s0K8I4sunaqvYzRPsU5LAc+J6q+kP6KB4Lm/3D6nyKo/827nnvlFMw
	4X/xfg7rdAXiEDY/Z3BmbpNzrtTdi42ajPEQaBxjjmLvZ0H54DLBE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D651023A23;
	Sat, 10 Feb 2024 21:06:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 76B7623A21;
	Sat, 10 Feb 2024 21:05:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [BUG] git 2.44.0-rc0 t0080.1 Breaks on NonStop x86 and ia64
In-Reply-To: <000401da5c4c$fd4ad260$f7e07720$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Sat, 10 Feb 2024 13:14:24
	-0500")
References: <000401da5c4c$fd4ad260$f7e07720$@nexbridge.com>
Date: Sat, 10 Feb 2024 18:05:57 -0800
Message-ID: <xmqqbk8nbvqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 198CA5BA-C882-11EE-9779-A19503B9AAD1-77302942!pb-smtp21.pobox.com

<rsbecker@nexbridge.com> writes:

> The diff appears to have failed because of an assumption of how paths are
> resolved during compilation. The assumption is that files remain partially
> qualified, which is not the case in all C compilers. This is c99. My
> experience with gcc is that it qualifies names differently than other
> compilers.

I just found this bit of gem in t/unit-tests/test-lib.c.  I guess
Visual C falls into the same category as yours, while GCC and Clang
are from different camps?

The easiest way forward may be to build on top of it, perhaps like
so, to generalize the make_relative() to cover your case, too?

 t/unit-tests/test-lib.c | 63 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git c/t/unit-tests/test-lib.c w/t/unit-tests/test-lib.c
index 7bf9dfdb95..69dbe1bbc7 100644
--- c/t/unit-tests/test-lib.c
+++ w/t/unit-tests/test-lib.c
@@ -21,45 +21,78 @@ static struct {
 	.result = RESULT_NONE,
 };
 
-#ifndef _MSC_VER
-#define make_relative(location) location
-#else
+#include "dir.h"
 /*
  * Visual C interpolates the absolute Windows path for `__FILE__`,
  * but we want to see relative paths, as verified by t0080.
+ * There are other compilers that do the same, and are not for
+ * Windows.
  */
-#include "dir.h"
-
 static const char *make_relative(const char *location)
 {
 	static char prefix[] = __FILE__, buf[PATH_MAX], *p;
 	static size_t prefix_len;
+	static int need_bs_to_fs = -1;
 
-	if (!prefix_len) {
+	/* one-time preparation */
+	if (need_bs_to_fs < 0) {
 		size_t len = strlen(prefix);
-		const char *needle = "\\t\\unit-tests\\test-lib.c";
+		char needle[] = "t\\unit-tests\\test-lib.c";
 		size_t needle_len = strlen(needle);
 
-		if (len < needle_len || strcmp(needle, prefix + len - needle_len))
+		if (len < needle_len)
+			die("unexpected prefix '%s'", prefix);
+
+		/*
+		 * The path could be relative (t/unit-tests/test-lib.c)
+		 * or full (/home/user/git/t/unit-tests/test-lib.c).
+		 * Check the slash between "t" and "unit-tests".
+		 */
+		prefix_len = len - needle_len;
+		if (prefix[prefix_len + 1] == '/') {
+			/* Oh, we're not Windows */
+			for (size_t i = 0; i < needle_len; i++)
+				if (needle[i] == '\\')
+					needle[i] = '/';
+			need_bs_to_fs = 0;
+		} else {
+			need_bs_to_fs = 1;
+		}
+
+		/* 
+		 * prefix_len == 0 if the compiler gives paths relative
+		 * to the root of the working tree.  Otherwise, we want
+		 * to see that we did find the needle[] at a directory
+		 * boundary.
+		 */
+		if (fspathcmp(needle, prefix + prefix_len) ||
+		    (prefix_len &&
+		     prefix[prefix_len - 1] != '/' &&
+		     prefix[prefix_len - 1] != '\\'))
 			die("unexpected suffix of '%s'", prefix);
 
-		/* let it end in a directory separator */
-		prefix_len = len - needle_len + 1;
 	}
 
+	/* 
+	 * If our compiler gives relative paths and we do not need
+	 * to munge directory separator, we can return location as-is.
+	 */
+	if (!prefix_len && !need_bs_to_fs)
+		return location;
+
 	/* Does it not start with the expected prefix? */
 	if (fspathncmp(location, prefix, prefix_len))
 		return location;
 
 	strlcpy(buf, location + prefix_len, sizeof(buf));
 	/* convert backslashes to forward slashes */
-	for (p = buf; *p; p++)
-		if (*p == '\\')
-			*p = '/';
-
+	if (need_bs_to_fs) {
+		for (p = buf; *p; p++)
+			if (*p == '\\')
+				*p = '/';
+	}
 	return buf;
 }
-#endif
 
 static void msg_with_prefix(const char *prefix, const char *format, va_list ap)
 {
