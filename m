Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838E61362
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315391; cv=none; b=vFBqQwC0n17PZjuMZF1qPsRhiNoVC+OV07gRrY4vBPxUMkw0S4zXtcVS6uBWwjKzsJ4IJrjsO4MtZQR9LgpBPW85GEyELjyacY0en2WojAgquWlVJGH8gZFRp60PrDiZMONVMV3t2AU6jmBFtVAOJHUHUAKtGY2nQzSAyumIQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315391; c=relaxed/simple;
	bh=BwaV311oWMHaiseQS0uxOaWSCWD8fw2ubqFbOmNbQUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0773GpfwY1fmDaLyXQi33jCLnj78WJWMAmZv+PIOgacK+4U52uuRKhgWxdG+b46x72X1N72yc4Wh53LVAlAbZG/DTyut3zff4yu1nIKg0DALs89Bua/cqgm1LefIuVOwiviI4V2Aq9/ROF877AWOTVG0DJ+QbYMLZ4M5kCRUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EvhacJpb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EvhacJpb"
Received: (qmail 11988 invoked by uid 109); 24 Jul 2025 00:03:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BwaV311oWMHaiseQS0uxOaWSCWD8fw2ubqFbOmNbQUk=; b=EvhacJpb4u1VqXe67r0yGiYDhOz+zHu+G+ziTThWrsHcOjlgRFQUAGw33vpaOtcEo2Ev1u6lKrMMuTIThs8qZ51Ob5OsnaleMj2qpOeNMIONdhUBEeGBqxVFsgghKLIhTdvKlsGrrLRWXIKNGuqHJrpB36IkKLN+zt40fKLVJBzB1G+TvAPZzvEeIeeBs1mm6TSkt68pmjYY6U+RxCcvRaV7sPMkN0QjngXg7XrewXKVT501K2IulF/wfkqGpvcI2HyFxBYUbBfVwXkJTTWiTiOwCS0QPOQ77CMU01UXlNQq0HUh5lmMui0DaE8wgH9PAhNCkwpq/nzbQp6YEiIjug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jul 2025 00:03:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25862 invoked by uid 111); 24 Jul 2025 00:03:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jul 2025 20:03:11 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Jul 2025 20:03:08 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Subject: [PATCH 3/3] test-delta: close output descriptor after use
Message-ID: <20250724000308.GC597294@coredump.intra.peff.net>
References: <20250723235929.GB592873@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723235929.GB592873@coredump.intra.peff.net>

After we write to the output file, the program exits. This naturally
closes the descriptor. But we should do an explicit close for two
reasons:

  1. It's possible to hit an error on close(), which we should detect
     and report via our exit code.

  2. Leaking descriptors is a bad practice in general. Even if it isn't
     meaningful here, it sets a bad example.

It is tempting to write:

  if (write_in_full(fd, ...) < 0 || close(fd) < 0)
        die_errno(...);

But that pattern contains a subtle problem that has resulted in
descriptor leaks before. If write_in_full() fails, we'll short-circuit
and never call close(), leaking the descriptor.

That's not a problem here, since our error path dies instead of
returning up the stack. But since we're trying to set a good example,
let's write it out as two separate conditions. As a bonus, that lets us
produce a slightly more specific error message.

Signed-off-by: Jeff King <peff@peff.net>
---
Another option is that the program should just write to stdout, then we
do not have to open or close it at all. ;)

 t/helper/test-delta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 7945793078..52ea00c937 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -45,6 +45,8 @@ int cmd__delta(int argc, const char **argv)
 	fd = xopen(argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
 	if (write_in_full(fd, out_buf, out_size) < 0)
 		die_errno("write(%s)", argv[4]);
+	if (close(fd) < 0)
+		die_errno("close(%s)", argv[4]);
 
 	strbuf_release(&from);
 	strbuf_release(&data);
-- 
2.50.1.666.gdb1e186d6a
