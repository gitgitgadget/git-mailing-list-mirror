Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251471420DD
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214687; cv=none; b=SI/cC11eX+vi7/UX8/6BG8bb3lYo4hGZyTBtIWYXSFKqrFZ8I9/wvEHJSG6Suoi6WpmkzKKoL6hnlSQyb1ORt13q9albUERhPUJFlYkf7Fn1DLiMdRMPQkww9SFqRvTLMSVXeepwdsdL9EuVJlz+gxSLudj05Nj4MeVcbXYZeDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214687; c=relaxed/simple;
	bh=a6iNkZcrpnIei7os34GZglKI1jg+ODJTNBp6r/Ko2X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoAa9WC7XqrSqKDCIMFIn56Nr4+dr63nyR+MRDHTVmhFsbHbE212EV83YqcfK0jjleH6+sbj/lZHCcZZ1x5RbCmtfoK5+j/u2CsuXO2rO3X/z4y6u95VNo0GxZBGM90SANPxlv2VczNXvnFUbcC1gChIcXGAVvqP0FjGGH1jE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15419 invoked by uid 109); 24 Sep 2024 21:51:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:51:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18498 invoked by uid 111); 24 Sep 2024 21:51:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:51:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:51:24 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 04/28] connect: clear child process before freeing in
 diagnostic mode
Message-ID: <20240924215124.GD1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

The git_connect() function has a special CONNECT_DIAG_URL mode, where we
stop short of actually connecting to the other side and just print some
parsing details. For URLs that require a child process (like ssh), we
free() the child_process struct but forget to clear it, leaking the
strings we stuffed into its "env" list.

This leak is triggered many times in t5500, which uses "fetch-pack
--diag-url", but we're not yet ready to mark it as leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/connect.c b/connect.c
index 6829ab3974..58f53d8dcb 100644
--- a/connect.c
+++ b/connect.c
@@ -1485,6 +1485,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 				free(hostandport);
 				free(path);
+				child_process_clear(conn);
 				free(conn);
 				strbuf_release(&cmd);
 				return NULL;
-- 
2.46.2.1011.gf1f9323e02

