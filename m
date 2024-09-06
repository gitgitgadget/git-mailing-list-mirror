Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB42481B3
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594431; cv=none; b=alHVJ0O+/CyPO6HjX3b4VbAZfAGlq1nppU4Lh+avheIqarDX08YaZG9meZXwt/2VZ77FGqTQoIFRkhVR4Z8Ga6/oxFmRIoDl0VXgEHIcfUxJE9FcKmqXQNOb2GubgIPF7w1LNfRYhkqOfIDve6aj7NTHujGdNCuCMT8XP6w3+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594431; c=relaxed/simple;
	bh=dXgTjx6BRsudF3UMopMsOq6BVN3zcVzzTdyAdmq7nrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq51eWkSdBJH8nIsz8XhvpT6Cv6T6/7ZKcbgfZe+p12QCVDqKCaFJXQfUCiwAWgyTGmxz7Nnt5SXN5Ks+fzTGJjduphD2rK6uwouYed6nJ6jgyJ9EbAR3z3E4LQ+09uScFBdJiPy4OP2ot6fAfk1F+vAxd1sT7gJRzBjE+R/9PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15217 invoked by uid 109); 6 Sep 2024 03:47:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Sep 2024 03:47:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16346 invoked by uid 111); 6 Sep 2024 03:47:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 23:47:08 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 23:47:08 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] sparse-checkout: consolidate cleanup when writing
 patterns
Message-ID: <20240906034708.GA4168362@coredump.intra.peff.net>
References: <20240906034557.GA3693911@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906034557.GA3693911@coredump.intra.peff.net>

In write_patterns_and_update(), we always need to free the pattern list
before exiting the function.  Rather than handling it manually when we
return early, we can jump to an "out" label where cleanup happens. This
let us drop one line, but also establishes a pattern we can use for
other cleanup.

Signed-off-by: Jeff King <peff@peff.net>
---
This would also be helpful in the long run if all of the other die()
calls ended up as error returns, but I guess this is in builtin/, so it
may not be that likely a candidate for libification anyway.

 builtin/sparse-checkout.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 2604ab04df..dfefe609a1 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -343,9 +343,8 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	result = update_working_directory(pl);
 	if (result) {
 		rollback_lock_file(&lk);
-		clear_pattern_list(pl);
 		update_working_directory(NULL);
-		return result;
+		goto out;
 	}
 
 	fp = xfdopen(fd, "w");
@@ -358,9 +357,9 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	fflush(fp);
 	commit_lock_file(&lk);
 
+out:
 	clear_pattern_list(pl);
-
-	return 0;
+	return result;
 }
 
 enum sparse_checkout_mode {
-- 
2.46.0.802.g13da1a47c4

