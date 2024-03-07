Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047082D93
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801796; cv=none; b=O2uVxBqVAnZkKhaCBhuju+YNq1PG+PrEieY3FvjGs7FIzwONzqbihx9mF2f9YHA0B4DMq+GbXAC0SayalF1KNdwseZYSO716ABnLz+PbjvcG/GsuQBVZdLRctVq6QVfXzRQgL1Z2D/e9ym9WExIOF5pcDN7XB25xmD6OvvLQtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801796; c=relaxed/simple;
	bh=dAmaBrYbB2Z96FEEvWOkzSAeSY4NgtTmkSuhwIq5pPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daTjsADhdK7cgF/E8MejOe+rCYC/uno822La1PRi+wlep8Xpfli+CRd/re/KN/siTRvSUgWNRMZ1qrvTNpHQJnB10sOC+uqTbbpJ6TH1vfVwZ88Hk3aSsgWqHYAGRlplf98BiWdQN+xwkUK+EOztfedscsAzLtzxZoF54kmhNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6717 invoked by uid 109); 7 Mar 2024 08:56:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 08:56:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12396 invoked by uid 111); 7 Mar 2024 08:56:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 03:56:38 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 03:56:32 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] doc/gitremote-helpers: match object-format option docs
 to code
Message-ID: <20240307085632.GB2072294@coredump.intra.peff.net>
References: <20240307084735.GA2072130@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307084735.GA2072130@coredump.intra.peff.net>

Git's transport-helper code has always sent "option object-format\n",
and never provided the "true" or "algorithm" arguments. While the
"algorithm" request is something we might need or want to eventually
support, it probably makes sense for now to document the actual
behavior, especially as it has been in place for several years, since
8b85ee4f47 (transport-helper: implement object-format extensions,
2020-05-25).

Signed-off-by: Jeff King <peff@peff.net>
---
As I discussed in patch 1, remote-curl does handle the "true" thing
correctly. And that's really the helper that matters in practice (it's
possible some third party helper is looking for the explicit "true", but
presumably they'd have reported their confusion to the list). So we
could probably just start tacking on the "true" in transport-helper.c
and leave that part of the documentation untouched.

I'm less sure of the specific-algorithm thing, just because it seems
like remote-curl would never make use of it anyway (preferring instead
to match whatever algorithm is used by the http remote). But maybe there
are pending interoperability plans that depend on this?

I guess it would not hurt to leave it in place even if transport-helper
never produces it. On the other hand, any helper which advertises the
"object-format" capability is supposed to support it, and without the
transport-helper side being implemented, I don't know how any helper
program can claim that.

 Documentation/gitremote-helpers.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 07c8439a6f..12dffbf383 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -542,13 +542,10 @@ set by Git if the remote helper has the 'option' capability.
 	transaction.  If successful, all refs will be updated, or none will.  If the
 	remote side does not support this capability, the push will fail.
 
-'option object-format' {'true'|algorithm}::
-	If 'true', indicate that the caller wants hash algorithm information
+'option object-format'::
+	Indicate that the caller wants hash algorithm information
 	to be passed back from the remote.  This mode is used when fetching
 	refs.
-+
-If set to an algorithm, indicate that the caller wants to interact with
-the remote side using that algorithm.
 
 SEE ALSO
 --------
-- 
2.44.0.463.g71abcb3a9f
