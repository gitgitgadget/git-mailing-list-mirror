Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19228373
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276485; cv=none; b=kWiIOrUjR287Jc3A2dvkYsUcjQ/7KKuTjEuwtSqtXAVj7GcXMJUdJjvsJYOo7CvOFHbRiyEtWbLgbhO6jDtHUA+2xgYkZZCPZR3AIUCHgR4lRr3FEvJPpJiRqXd2p/2u8ImUGzx9gwbSILYOdWiReLkNFUjiqxRxMaOuF+Q0/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276485; c=relaxed/simple;
	bh=uz8TmVVtw9e0oYwUumdUKYNsiGnn3OFYBHHRuPJFc1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MH9uUQgZvhMcWV3HRWP6EwSHoPgxb4DHhhJjbER2PQz8n0zzPSFl/ytKNsWe1GYDn/RoJcLcvutBekKsaKxzGnKEycPnMrYUDEf/WYy7c63YclVF87mOsLJhuvenatJ+CPzG5g243wEfvN1+fQJ3f45VsPtRlc53xOFXqcrDSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GMQqBxgQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GMQqBxgQ"
Received: (qmail 28346 invoked by uid 109); 18 Mar 2025 05:41:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uz8TmVVtw9e0oYwUumdUKYNsiGnn3OFYBHHRuPJFc1M=; b=GMQqBxgQYig68UnnZJ7jVbNlvsF44a2Lo/oC2/cASExE59mC95ts8EhALpLVSoqbQrYAbvHp3vE6pmnGCY6xn40RFbzPsPFWDg6W0AEexwAR9M6vxaikCYz63P0Z+KcsOWpLwkwWOpgWZ7ad1+aF86rT/XNBdEgriGyuVo1ScCSLhgss0brVmI4skJk7yOeq1Slb7MinomvBawgB4u0NhHjExu8ifkGTPF1AINU2hGvL9tkT1KX2Wr/pCkQqJOWXxKdyGvf1dAiwhsBCB+Pn357Ef2Oi3/Nn63aqchXT+aKuSMqNUCI0Fkrd3QozcM66jFmun+vUDHgGMbV/8vj97w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 05:41:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6228 invoked by uid 111); 18 Mar 2025 05:41:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Mar 2025 01:41:22 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Mar 2025 01:41:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 2/2] fetch: don't ask for remote HEAD if followRemoteHEAD is
 "never"
Message-ID: <20250318054122.GB2051617@coredump.intra.peff.net>
References: <20250318053905.GA2051217@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318053905.GA2051217@coredump.intra.peff.net>

When we are going to consider updating the refs/remotes/*/HEAD symref,
we have to ask the remote side where its HEAD points. But if we know
that the feature is disabled by config, we don't need to bother!

This saves a little bit of work and network communication for the
server. And even a little bit of effort on the client, as our local
set_head() function did a bit of work matching the remote HEAD before
realizing that we're not going to do anything with it.

Signed-off-by: Jeff King <peff@peff.net>
---
I guess we could leave the check inside set_head() in case somebody else
ever called it without checking the value of follow_remote_head. But
it's a static function that is called once, so I'd rather not keep the
dead code around.

 builtin/fetch.c  | 6 ++----
 t/t5510-fetch.sh | 5 ++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 66f5ae31b6..3658509740 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1643,9 +1643,6 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 		string_list_append(&heads, strip_refshead(ref->name));
 	}
 
-	if (follow_remote_head == FOLLOW_REMOTE_NEVER)
-		goto cleanup;
-
 	if (!heads.nr)
 		result = 1;
 	else if (heads.nr > 1)
@@ -1729,7 +1726,8 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			do_set_head = 1;
+			if (transport->remote->follow_remote_head != FOLLOW_REMOTE_NEVER)
+				do_set_head = 1;
 		}
 		if (branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ad23dd11ef..5f0eb5684e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -119,7 +119,10 @@ test_expect_success "fetch test followRemoteHEAD never" '
 		cd two &&
 		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
 		git config set remote.origin.followRemoteHEAD "never" &&
-		git fetch &&
+		GIT_TRACE_PACKET=$PWD/trace.out git fetch &&
+		# Confirm that we do not even ask for HEAD when we are
+		# not going to act on it.
+		test_grep ! "ref-prefix HEAD" trace.out &&
 		test_must_fail git rev-parse --verify refs/remotes/origin/HEAD
 	)
 '
-- 
2.49.0.390.gc9996a6a6c
