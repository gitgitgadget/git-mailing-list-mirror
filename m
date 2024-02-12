Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECCB3D0A8
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753959; cv=none; b=pbEpXES9aofLGLevFgGUNmvD6sqhGS6DL+XetJrknY5E5WlkyXYFGiZRcKEGf+s7HOiBDOHMBX4TMHO2PQr8PUQTaDjLaQr+mjDje+68bl9RFmm8xmVpwQdRkyNpFrl+CVgRMtRVHfZ4upwv8eO18F4JHI58XXvCktBl1A9bCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753959; c=relaxed/simple;
	bh=941ZVpk1gTlxP6bzDItWdGcFQW3zEU49nrglMTZF0LU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bbsYdAueb4iAOpl5RsRA7lmsBlVJrWLIbBjZXeKaErm3FdFALHUSzMPVeTuSL7dWyQR0aWvAfyRV/yIULK47b/Scm4Oc3w8ixBAFjBLmfTMK9Ex0U9Coba2buP9LRetqdU8vfGKcRLR6xhfEmFB/xh6Y+uN4MpKCmDBid2s1htU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41CG5rJU3587663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 16:05:54 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <rsbecker@nexbridge.com>, "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <000401da5c4c$fd4ad260$f7e07720$@nexbridge.com> <xmqqbk8nbvqy.fsf@gitster.g> <002a01da5c94$a1bc5340$e534f9c0$@nexbridge.com>
In-Reply-To: <002a01da5c94$a1bc5340$e534f9c0$@nexbridge.com>
Subject: RE: [BUG] git 2.44.0-rc0 t0080.1 Breaks on NonStop x86 and ia64
Date: Mon, 12 Feb 2024 11:05:47 -0500
Organization: Nexbridge Inc.
Message-ID: <00fa01da5dcd$5b060150$111203f0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEKhykLt/LB5hLsEaYKWm4eL/p/IgHSi0nNAaWPrR2yisPyEA==
Content-Language: en-ca

On Saturday, February 10, 2024 9:47 PM, Junio C Hamano wrote:
>On Saturday, February 10, 2024 9:06 PM, Junio C Hamano wrote:
>><rsbecker@nexbridge.com> writes:
>>
>>> The diff appears to have failed because of an assumption of how paths
>>> are resolved during compilation. The assumption is that files remain
>>> partially qualified, which is not the case in all C compilers. This
>>> is c99. My experience with gcc is that it qualifies names differently
>>> than other compilers.
>>
>>I just found this bit of gem in t/unit-tests/test-lib.c.  I guess
>>Visual C
>falls into the
>>same category as yours, while GCC and Clang are from different camps?
>>
>>The easiest way forward may be to build on top of it, perhaps like so,
>>to
>generalize
>>the make_relative() to cover your case, too?
>>
>> t/unit-tests/test-lib.c | 63
>+++++++++++++++++++++++++++++++++++++---------
>>---
>> 1 file changed, 48 insertions(+), 15 deletions(-)
>>
>>diff --git c/t/unit-tests/test-lib.c w/t/unit-tests/test-lib.c index
>>7bf9dfdb95..69dbe1bbc7 100644
>>--- c/t/unit-tests/test-lib.c
>>+++ w/t/unit-tests/test-lib.c
>>@@ -21,45 +21,78 @@ static struct {
>> 	.result = RESULT_NONE,
>> };
>>
>>-#ifndef _MSC_VER
>>-#define make_relative(location) location -#else
>>+#include "dir.h"
>> /*
>>  * Visual C interpolates the absolute Windows path for `__FILE__`,
>>  * but we want to see relative paths, as verified by t0080.
>>+ * There are other compilers that do the same, and are not for
>>+ * Windows.
>>  */
>>-#include "dir.h"
>>-
>> static const char *make_relative(const char *location)  {
>> 	static char prefix[] = __FILE__, buf[PATH_MAX], *p;
>> 	static size_t prefix_len;
>>+	static int need_bs_to_fs = -1;
>>
>>-	if (!prefix_len) {
>>+	/* one-time preparation */
>>+	if (need_bs_to_fs < 0) {
>> 		size_t len = strlen(prefix);
>>-		const char *needle = "\\t\\unit-tests\\test-lib.c";
>>+		char needle[] = "t\\unit-tests\\test-lib.c";
>> 		size_t needle_len = strlen(needle);
>>
>>-		if (len < needle_len || strcmp(needle, prefix + len -
>needle_len))
>>+		if (len < needle_len)
>>+			die("unexpected prefix '%s'", prefix);
>>+
>>+		/*
>>+		 * The path could be relative (t/unit-tests/test-lib.c)
>>+		 * or full (/home/user/git/t/unit-tests/test-lib.c).
>>+		 * Check the slash between "t" and "unit-tests".
>>+		 */
>>+		prefix_len = len - needle_len;
>>+		if (prefix[prefix_len + 1] == '/') {
>>+			/* Oh, we're not Windows */
>>+			for (size_t i = 0; i < needle_len; i++)
>>+				if (needle[i] == '\\')
>>+					needle[i] = '/';
>>+			need_bs_to_fs = 0;
>>+		} else {
>>+			need_bs_to_fs = 1;
>>+		}
>>+
>>+		/*
>>+		 * prefix_len == 0 if the compiler gives paths relative
>>+		 * to the root of the working tree.  Otherwise, we want
>>+		 * to see that we did find the needle[] at a directory
>>+		 * boundary.
>>+		 */
>>+		if (fspathcmp(needle, prefix + prefix_len) ||
>>+		    (prefix_len &&
>>+		     prefix[prefix_len - 1] != '/' &&
>>+		     prefix[prefix_len - 1] != '\\'))
>> 			die("unexpected suffix of '%s'", prefix);
>>
>>-		/* let it end in a directory separator */
>>-		prefix_len = len - needle_len + 1;
>> 	}
>>
>>+	/*
>>+	 * If our compiler gives relative paths and we do not need
>>+	 * to munge directory separator, we can return location as-is.
>>+	 */
>>+	if (!prefix_len && !need_bs_to_fs)
>>+		return location;
>>+
>> 	/* Does it not start with the expected prefix? */
>> 	if (fspathncmp(location, prefix, prefix_len))
>> 		return location;
>>
>> 	strlcpy(buf, lnocation + prefix_len, sizeof(buf));
>> 	/* convert backslashes to forward slashes */
>>-	for (p = buf; *p; p++)
>>-		if (*p == '\\')
>>-			*p = '/';
>>-
>>+	if (need_bs_to_fs) {
>>+		for (p = buf; *p; p++)
>>+			if (*p == '\\')
>>+				*p = '/';
>>+	}
>> 	return buf;
>> }
>>-#endif
>>
>> static void msg_with_prefix(const char *prefix, const char *format,
>va_list ap)  {
>
>This looks like a good plan.

This might be trivial, but I cannot tell. The #ifndef should be changed as
follows:

diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 7bf9dfdb95..2d1f6b7648 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -21,7 +21,7 @@ static struct {
        .result = RESULT_NONE,
 };

-#ifndef _MSC_VER
+#if !defined(_MSC_VER) && !defined(__TANDEM)
 #define make_relative(location) location
 #else
 /*

However, if this goes beyond Windows and NonStop, which I suspect it does,
we could add a separate knob in config.mak.uname to pull this in. However,
this does not correct the problem. actual ends up with only:

ok 1 - passing test
ok 2 - passing test and assertion return 1

which fails the test_cmp at the end of the test.


