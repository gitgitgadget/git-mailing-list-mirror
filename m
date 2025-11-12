Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F62DC34B
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935058; cv=none; b=r/sdkcL0Ug+k503BNFc3UFXMl8oJL34FL0nlj/UjqUO3P6aRJwWPfyBLcwmo7bUlO1vNahOGe2IzsrAOVjQhSlzHA+jAffwc/kghrdUD2/0fGu5P7GKR6kRmXx8HghOOSAlOULHAB/UQLIo+lHnFfWsW+QgjnDhXha+MM8kWT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935058; c=relaxed/simple;
	bh=TrWMwBkG6Jx1X+sqKtzjeX0l4qSmuJUZCx8JOcq744k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8B2Ukk5XaQdmdH5aeRtIo+2mahlqA2fjaBf5v28IDaoVo5XSISqqQnS+zxv1elCk/N1o+3D2sBgjXPehGnW//bELMJQlnGg2bdPqSJRo7YfTQgdy+mL8sOz2vhgEGNZR0ESGNmWBvUCwjE+TwHDWjIdu/hI2qQjCYPFcKrp7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZhzMVy3A; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZhzMVy3A"
Received: (qmail 495507 invoked by uid 109); 12 Nov 2025 08:10:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TrWMwBkG6Jx1X+sqKtzjeX0l4qSmuJUZCx8JOcq744k=; b=ZhzMVy3A8xtM/BVjGBe+p1avvwoM1Zu3KV1Naneimlcg0R3ULk9qmOd1XRA2dCFq+J3GKGvBCRf+y29OmVZodOfjwmGUmRbt3+BAcuOhCnq7SW/KsMQ/biBjcpYF7aM8kqWfSRFu3LlM5Ncy89cNT0CHH0pTTRo7zUQGV3tf1Z5Lb3lPeMGDTgQXOoipdIogD2vtvExQ13fqj7y/sk5b6zvgrNBCYHsgvJDuuyGBpLHFVeqjKqF3mIUfHKAufI7aeuhMPbRwEz+/PCJ1NZkA7aHtl6MtDlbSPPnTUB9ZVnmE/vvLyOFySVZeJ/fXKhbnCTjf+xuY/AJZ2tTfVVzqrg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 08:10:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 786496 invoked by uid 111); 12 Nov 2025 08:10:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 03:10:56 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 03:10:55 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 9/9] t: enable ASan's strict_string_checks option
Message-ID: <20251112081055.GI979063@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112075522.GA978866@coredump.intra.peff.net>

ASan has an option to enable strict string checking, where any pointer
passed to a function that expects a NUL-terminated string will be
checked for that NUL termination. This can sometimes produce false
positives. E.g., it is not wrong to pass a buffer with { '1', '2', '\n' }
into strtoul(). Even though it is not NUL-terminated, it will stop at
the newline.

But in trying it out, it identified two problematic spots in our test
suite (which have now been adjusted):

  1. The strtol() parsing in cache-tree.c was a real potential problem,
     which would have been very hard to find otherwise (since it
     required constructing a very specific broken index file).

  2. The use of string functions in fsck_ident() were false positives,
     because we knew that there was always a trailing newline which
     would stop the functions from reading off the end of the buffer.
     But the reasoning behind that is somewhat fragile, and silencing
     those complaints made the code easier to reason about.

So even though this did not find any earth-shattering bugs, and even had
a few false positives, I'm sufficiently convinced that its complaints
are more helpful than hurtful. Let's turn it on by default (since the
test suite now runs cleanly with it) and see if it ever turns up any
other instances.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ef0ab7ec2d..0fb76f7d11 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -77,6 +77,7 @@ prepend_var GIT_SAN_OPTIONS : strip_path_prefix="$GIT_BUILD_DIR/"
 # want that one to complain to stderr).
 prepend_var ASAN_OPTIONS : $GIT_SAN_OPTIONS
 prepend_var ASAN_OPTIONS : detect_leaks=0
+prepend_var ASAN_OPTIONS : strict_string_checks=1
 export ASAN_OPTIONS
 
 prepend_var LSAN_OPTIONS : $GIT_SAN_OPTIONS
-- 
2.52.0.rc1.260.g3e4993586f
