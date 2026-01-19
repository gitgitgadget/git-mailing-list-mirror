Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24C2836E
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800203; cv=none; b=giouoEnQf2MjbGSv5HgtlXxL5hJEbNQx6bIsPVhEiwiKFpXUwO8d8FkxDpe5KCaw8OGJ2A19bixpNHziSOojWFgbuSG0VdpcDpr1ruqXUzYbwoPyEtmxULxQ4yETZNZiYHAminRYr+mt4ZkhXXZ/FL3+YAsJXzwRJyIidOFg4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800203; c=relaxed/simple;
	bh=hVxeB+iRPlczCSpCLUSSpUNx4MQGKQ3TbfqtT0OJc+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0z0orlKoxYP3u2hiBo3CXo2nlhoDFWCjCp6DlU1XjAz59PNrgLBCuD4k9gy2z/RzViWvCjh+qPMpk+t/6Nq8o3aFG/7h1rXad+4slVEZNXbELFAQ6yxOAYJJNvWuSdus0u+kX/S0BZc+uDPE6kDgnQc6G3ojXhU+MQwsNMKeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bd2ObaNT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bd2ObaNT"
Received: (qmail 94452 invoked by uid 109); 19 Jan 2026 05:23:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hVxeB+iRPlczCSpCLUSSpUNx4MQGKQ3TbfqtT0OJc+U=; b=bd2ObaNTvsOACd2AEDOlvxB4at6rA38uEcYovcizxBpKTeBDcSc7EnzsFBlZ2gENZBJJHXkBJr57hy0rZIIhI4Vys7TpWynb+Ov1RX78E6bVAzHYtiT7IaRGQ1+4CBoVbQL2snlFyw3L3zN4vNCK31LM/opJme0CVGeebqy/rtRmIKoxE/71qUUEggrQNhILVAE7qRd3UV7Y5aA8K0a1lzWZxOfnZC1cmtx7yYgMJ/qL8hsPV8Rzxq+DTr7DbmaQ5ZXQ6MS442dQmZ52Aa/U1IlwebkxNZ2UTgJpQEoB9KHzNPHwFEhTQDksjjHeo0LjL9/6yp5xHkpS0mtg4WJb/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jan 2026 05:23:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 153883 invoked by uid 111); 19 Jan 2026 05:23:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jan 2026 00:23:24 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Jan 2026 00:23:20 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH 4/4] remote: always allocate branch.push_tracking_ref
Message-ID: <20260119052320.GD1991523@coredump.intra.peff.net>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119051858.GA1991308@coredump.intra.peff.net>

In branch_get_push(), we usually allocate a new string for the @{push}
ref, but will not do so in push.default=upstream mode, where we just
pass back the result of branch_get_upstream() directly.

This led to a hacky memory management scheme in e291c75a95 (remote.c:
add branch_get_push, 2015-05-21): we store the result in the
push_tracking_ref field of a "struct branch", under the assumption that
the branch struct will last until the end of the program. So even though
the struct doesn't know if it has an allocated string or not, it doesn't
matter because we hold on to it either way.

But that assumption was violated by f5ccb535cc (remote: fix leaking
config strings, 2024-08-22), which added a function to free branch
structs. Any struct which is fed to branch_release() is at risk of
leaking its push_tracking_ref member.

I don't think this can actually be triggered in practice. We rarely
actually free the branch structs, and we only fill in the
push_tracking_ref string lazily when it is needed. So triggering the
leak would require a code path that does both, and I couldn't find one.

Still, this is an ugly trap that may eventually spring on us. Since
there is only one code path in branch_get_push() that doesn't allocate,
let's just have it copy the string. And then we know that
push_tracking_ref is always allocated, and we can free it in
branch_release().

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 7 ++++---
 remote.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index e191b0ff6e..3e9d9b3e1f 100644
--- a/remote.c
+++ b/remote.c
@@ -272,6 +272,7 @@ static void branch_release(struct branch *branch)
 	free((char *)branch->refname);
 	free(branch->remote_name);
 	free(branch->pushremote_name);
+	free(branch->push_tracking_ref);
 	merge_clear(branch);
 }
 
@@ -1883,8 +1884,8 @@ static char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
-static const char *branch_get_push_1(struct repository *repo,
-				     struct branch *branch, struct strbuf *err)
+static char *branch_get_push_1(struct repository *repo,
+			       struct branch *branch, struct strbuf *err)
 {
 	struct remote_state *remote_state = repo->remote_state;
 	struct remote *remote;
@@ -1924,7 +1925,7 @@ static const char *branch_get_push_1(struct repository *repo,
 		return tracking_for_push_dest(remote, branch->refname, err);
 
 	case PUSH_DEFAULT_UPSTREAM:
-		return branch_get_upstream(branch, err);
+		return xstrdup_or_null(branch_get_upstream(branch, err));
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
diff --git a/remote.h b/remote.h
index 0ca399e183..fc052945ee 100644
--- a/remote.h
+++ b/remote.h
@@ -331,7 +331,7 @@ struct branch {
 
 	int merge_alloc;
 
-	const char *push_tracking_ref;
+	char *push_tracking_ref;
 };
 
 struct branch *branch_get(const char *name);
-- 
2.53.0.rc0.338.g08aa8a9473
