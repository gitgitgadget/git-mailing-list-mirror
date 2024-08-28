Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA0A3C488
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817596; cv=none; b=VEpbT+HJtasrBszlc7fYy/8a1uic6H1XFI+4oWBDkceiEYhnLqMVt5k+dYFT2udRMAct5lEBLeS1zYPn4DKUS4LEr8ib4TsLWhqumivar4CBTijQjWd+7WGTRlzX73hgW5/Dq+B6j2B3aGM21qSN69XzhG+9QskWCEqJsSLow8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817596; c=relaxed/simple;
	bh=TGr57wTHpXxmh7EptCgYgoky7a7QcpHAnO48gco+duw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvAuYkJCdlP925G4T8gE4tbcOyebQqBJpn/Wa5FP57HRrFMzytM00qpQt05z8EQXF/Hu3bEqtVxbwPdUQlI4BxdTh/xrcPYOzQmxH8mtUX1uAWjB/EbB/EmUG5aSNWwIHhWtaE0RgIlvRVHPswRHHL7aja/idr38vMqUrBi4TZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20544 invoked by uid 109); 28 Aug 2024 03:59:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 03:59:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23060 invoked by uid 111); 28 Aug 2024 03:59:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Aug 2024 23:59:56 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Aug 2024 23:59:52 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 4/6] compat: disable -Wunused-parameter in win32/headless.c
Message-ID: <20240828035952.GD3999193@coredump.intra.peff.net>
References: <20240828035722.GA3998881@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828035722.GA3998881@coredump.intra.peff.net>

As with the files touched in the previous commit, win32/headless.c does
not include git-compat-util.h, so it doesn't have our UNUSED macro.
Unlike those ones, this is not third-party code, so it would not be a
big deal to modify it.

However, I'm not sure if including git-compat-util.h would create other
headaches (and I don't even have a machine to test this on; I'm relying
on Windows CI to compile it at all). Given how trivial the file is, and
that the unused parameters are not interesting (they are just
boilerplate for the wWinMain() function), we can just use the same trick
as the previous commit and disable the warnings via pragma.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/win32/headless.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/win32/headless.c b/compat/win32/headless.c
index 8b00dfe3bd..11392a0b9a 100644
--- a/compat/win32/headless.c
+++ b/compat/win32/headless.c
@@ -11,6 +11,8 @@
 #include <stdlib.h>
 #include <wchar.h>
 
+#pragma GCC diagnostic ignored "-Wunused-parameter"
+
 /*
  * If `dir` contains the path to a Git exec directory, extend `PATH` to
  * include the corresponding `bin/` directory (which is where all those
-- 
2.46.0.754.g24c813f009

