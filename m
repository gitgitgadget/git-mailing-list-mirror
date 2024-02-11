Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D12B8466
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707641879; cv=none; b=CvUAXcxvrK7NOBOSRKwpneDrG/kXK6DBveU8CgrTh9Ytk38H15qAX6HPG6NknGTYV5h4j6z0eUF/BSFjq8HCm6Bw0fsGfSfswVP5krAcxfgss0HdHEijAqMdQvQj1BImDp/ba3KXZ7fW8J1XvBe2SppxvBjg7BIGF7rtQUkpqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707641879; c=relaxed/simple;
	bh=RBUgEY8D5yBWYrWw1yV/DInOjJltKtN8tmdqMJuy3D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hAE4Rp4GqsXRqTzF8aGH91DPtJD5Bwkch6YVZ7ATx/mcv3U0M/TgRwSxRxN3rdMKdGfAHOIpbZu6aIRTo8XFTEt6wvOfCsQTNay9SzsingnhgdtDdxlUebhdVMNaHGBmi+dZIyVZ/5SzyxolxiYwBkLPR0pU4AisUdGiiwsLryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uzTknggF; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uzTknggF"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BFAA27885;
	Sun, 11 Feb 2024 03:57:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	BUgEY8D5yBWYrWw1yV/DInOjJltKtN8tmdqMJuy3D4=; b=uzTknggFNEJuoMAhx
	ez6OGcpXRRcHdw4a/zFIwMfjbTIBbbSapyEDET8UvSDjHmm3IXS19At2SpxhRz1Z
	abzkKALrTk7DxkQwxw0g4NlzbTaTcX560vRHK1dxrh6Fw4mhCKPdTpIl/eKibRKk
	DiwCg/YN1JK3eCjotatMruiRpQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 66E4627884;
	Sun, 11 Feb 2024 03:57:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 91ADE27883;
	Sun, 11 Feb 2024 03:57:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Johannes Schindelin
  <johannes.schindelin@gmx.de>, "Randall S. Becker"
 <rsbecker@nexbridge.com>
Subject: [PATCH] unit-tests: do show relative file paths on non-Windows, too
Date: Sun, 11 Feb 2024 00:57:45 -0800
Message-ID: <xmqqttmf9y46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A0BB25C8-C8BB-11EE-9B1A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

There are compilers other than Visual C that want to show absolute
paths.  Generalize the helper introduced by a2c5e294 (unit-tests: do
show relative file paths, 2023-09-25) so that it can also work with
a path that uses slash as the directory separator, and becomes
almost no-op once one-time preparation finds out that we are using a
compiler that already gives relative paths.  Incidentally, this also
should do the right thing on Windows with a compiler that shows
relative paths but with backslash as the directory separator (if
such a thing exists and is used to build git).

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Another change I made, which is not described in the proposed
   commit log message, is that we now use fspathcmp() instead of
   strcmp() to precompute the prefix length using a known needle[]
   string, to be consistent with the runtime check done for each and
   every path.

   This is a belated follow-up on <f0b804129e8a21449cbb6f346473d3570182ddfa.1695640837.git.gitgitgadget@gmail.com>

 t/unit-tests/test-lib.c | 60 ++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 7bf9dfdb95..83c9eb8c59 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -21,12 +21,11 @@ static struct {
 	.result = RESULT_NONE,
 };
 
-#ifndef _MSC_VER
-#define make_relative(location) location
-#else
 /*
  * Visual C interpolates the absolute Windows path for `__FILE__`,
  * but we want to see relative paths, as verified by t0080.
+ * There are other compilers that do the same, and are not for
+ * Windows.
  */
 #include "dir.h"
 
@@ -34,32 +33,67 @@ static const char *make_relative(const char *location)
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
-- 
2.44.0-rc0

