Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6E13D89D
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215780; cv=none; b=UzZsmlqnTLHJMar1lenH9HtRNw/LbIrsslnSR0SdfSYQCweRWFUUC0tEg9CM7FtvEgUyabV+xvwBWP3fyArO92g7BNYLwXUxaQ6GDKH2PaxJXrRqRpFOyoYaUfn/EB07o/1EjP/TI7ambK+RMcnrI+pxfWbiRK1SEsO+37t9E5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215780; c=relaxed/simple;
	bh=miXxgs9GyeQj2Xdgiz9jr3pUjnWnqHUfHhk7VrdzLAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDxbWYrlPaET4tKAwzlaIlETtVWDhMThZnD2uCwt6IVE4oyfsizivq5+mf36PLKqRIDLJuHhpTd3a6sIlh06RYZROg2lHISunE+9DanWBSI7XVvEEELRiwzKcQb2p6HRli13wZOGCDevFyNyCUymZfeXM/PJrDPec+Va8EzuHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15605 invoked by uid 109); 24 Sep 2024 22:09:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:09:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18840 invoked by uid 111); 24 Sep 2024 22:09:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:09:37 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:09:37 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 24/28] http-push: free remote_ls_ctx.dentry_name
Message-ID: <20240924220937.GX1143820@coredump.intra.peff.net>
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

The remote_ls_ctx struct has dentry_name string, which is filled in with
a heap allocation in the handle_remote_ls_ctx() XML callback. After the
XML parse is done in remote_ls(), we should free the string to avoid a
leak.

This fixes several leaks found by running t5540.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http-push.c b/http-push.c
index 8acdb3f265..2e1c6851bb 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1183,6 +1183,7 @@ static void remote_ls(const char *path, int flags,
 	}
 
 	free(ls.path);
+	free(ls.dentry_name);
 	free(url);
 	strbuf_release(&out_buffer.buf);
 	strbuf_release(&in_buffer);
-- 
2.46.2.1011.gf1f9323e02

