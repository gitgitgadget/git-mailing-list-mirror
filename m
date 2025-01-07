Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B410185E7F
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736234313; cv=none; b=PX0f5eOYYVVPoD0e+OVEdM6j48pljG4Guso2C2p3pK868U6Lsej14MoUPYIL0d1Ye+c1td6YXyhYvRX2z8cIR/SfbinVMirGt5W3jWtp8G4NDDcCSXXIG/i7iFKnwty+xO4vNsLEbUf5UVT3/TX4o833+6lv7z96/paHzmYgDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736234313; c=relaxed/simple;
	bh=eiRpGPRKeohcicqvqvoLTGjsU7Vhj6Ydyr8kH/FdO/c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JxWSwAfqdxLyQBGbTTXpOD+D6efgbknaSswSqG9X0/ZN7wsBMg1frlGM9K3t3VexHVa3dbei1deq3KHPvCua2xu4phF58wWWcKzVrkZtvyXHe0XBcJedtuc4rnF2FIWT8jknthGrBWSPT4Cqb2g8zhXQ5L0Wf9Gl6V5seHYnEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gHfo/kxj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gHfo/kxj"
Received: (qmail 29144 invoked by uid 109); 7 Jan 2025 07:18:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=eiRpGPRKeohcicqvqvoLTGjsU7Vhj6Ydyr8kH/FdO/c=; b=gHfo/kxjlkGXhIlhNTiuPWHjb2xEmc/niwi2M5W802/txgAYtOaYPYMcJbeSiHn27CI9vSZg9xT53eyCJzu5Ur7C5LakSQecEFSP9JKP5APRvBJBH5YrXqtO/UF5EeKEYzLXOT6gHl0fE0Pzot7FxetZKIpd+qq4qtq0pSVmRiOQVUHSP4FoxsgXH7ndQNraGICxzZdS+xBezMXTCCOG/y9eb20d+wwzApEFn/mE5jK9gTS/hJ9OzWw4lBa903uL28gs5SEXl5BCgAbzSNtGCrjtePo/cjSDI/wHkDEW98mk0O4maeysJiVeVwvBTZOG2T3BCzzGPZCbhTzrr5p8EA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 07:18:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21977 invoked by uid 111); 7 Jan 2025 07:18:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2025 02:18:24 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jan 2025 02:18:24 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] t7407: use test_grep
Message-ID: <20250107071824.GA594237@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

There are a few grep calls here that can benefit from test_grep, which
produces more user-friendly output when it fails.

One of these calls also passes "-sq", which is curious. The "-q" option
suppresses the matched output. But test output is either already
redirected to /dev/null in non-verbose mode, and in verbose mode it's
better to see the output. The "-s" option suppresses errors opening
files, but we are just grepping in the "expected" file we just
generated, so it should not be needed. Neither of these was really
hurting anything, but they are not a style we'd like to see emulated. So
get rid of them.

(It is also curious to grep in the expected file in the first place, but
that is because we are auto-generating the expectation from a Git
command. So this is double-checking it did what we wanted).

Signed-off-by: Jeff King <peff@peff.net>
---
Just something I noticed while working on an unrelated topic.

 t/t7407-submodule-foreach.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 8d7b234beb..77b6d0040e 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -426,14 +426,14 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
 		git submodule foreach "echo be --quiet" > ../expected &&
 		git submodule foreach echo be --quiet > ../actual
 	) &&
-	grep -sq -e "--quiet" expected &&
+	test_grep -e "--quiet" expected &&
 	test_cmp expected actual
 '
 
 test_expect_success 'option-like arguments passed to foreach recurse correctly' '
 	git -C clone2 submodule foreach --recursive "echo be --an-option" >expect &&
 	git -C clone2 submodule foreach --recursive echo be --an-option >actual &&
-	grep -e "--an-option" expect &&
+	test_grep -e "--an-option" expect &&
 	test_cmp expect actual
 '
 
-- 
2.48.0.rc2.377.g0507c08f68
