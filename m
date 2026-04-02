Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E93603D2
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103294; cv=none; b=uo9BsCbBFDZW+9yooDYvv5bwkf6X86pIYwrKmSuh8CAaYngCpF+7lWEaVRVAqsNDoCntOh6Iun3vH7rC8U7HSauNpWUkE5R+J3SjYeakoc/kjotweCCH/EfO6cOmM+/0obQ5d8fM9jURH0beuV4Vsvy/yF1JcjGQU4VIHQ0sFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103294; c=relaxed/simple;
	bh=HryuW4OXBLaHU8NtH58EUjF/BGeuZDvKTsf3LUVPolI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNkEjN5YKo1IuBsbu3/a9926Jtyhk/vk4+/ZEdeg95bG3h4ki5J7XQWKzBDbbhoeobpNjGy2EbdCJBHpg9xWWUGpRmVY5/mDl6dXxTJLCg6BZDTrI8I/Vhl9c8JGhf2RV2HMfoKSdRmuUeZT26eJL6RqawuDjObHvRhBe0sENUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XP+Ircup; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XP+Ircup"
Received: (qmail 218791 invoked by uid 106); 2 Apr 2026 04:14:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HryuW4OXBLaHU8NtH58EUjF/BGeuZDvKTsf3LUVPolI=; b=XP+IrcuppMt5LGb1Jngvitpv7FGyD4IiF1CGdKfEhGu2+GELIT/4DKVT4+2PK0Mx3QGHj78UyTtUfLcmwB9O4J3QQwmJGWjldc/nSuCD8qgFrFD7rbzvpgYtM+mZKk5sttNdHGv+gBcbS3TyZcT2m2NlgKnj8iJb5efKr5KoqvulonPJ6mrPxnvfgNhrAnQeDigtLWaH7Byyfueu5Vn2ycGoZLTaTbsd9iJ4cl3XSu/ZDmlvXpUGHACWo5kuabSTROUBPHpnVtwaWr8RYDTV0x9jFmb8rUodOwz7TZHuZz96Y0fVvfwFwq7rVokiJqn88BD7cZQ5sLOe3VZYzV/XSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:14:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349707 invoked by uid 111); 2 Apr 2026 04:14:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:14:52 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:14:51 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 02/12] http: add const to fix strchr() warnings
Message-ID: <20260402041451.GB3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>

The "path" field of a "struct repo" (a custom http-push struct, not to
be confused with "struct repository) is a pointer into a const argv
string, and is never written to.

The compiler does not traditionally complain about assigning from a
const pointer because it happens via strchr(). But with some C23 libc
versions (notably recent glibc), it has started to do so. Let's mark the
field as const to silence the warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 9ae6062198..96df6344ee 100644
--- a/http-push.c
+++ b/http-push.c
@@ -99,7 +99,7 @@ static struct object_list *objects;
 
 struct repo {
 	char *url;
-	char *path;
+	const char *path;
 	int path_len;
 	int has_info_refs;
 	int can_update_info_refs;
-- 
2.53.0.1172.ge9e20b5838

