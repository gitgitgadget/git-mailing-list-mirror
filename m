Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53A82488
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214642; cv=none; b=Ee/6wapXl+yU1LLzsxl0R+pnc/lToENfTvSqNhcD3Hxwgzj6vkMlNiCCVEj7v5rJj2IjDM+VW9KATRiAoyP/oH45usjMFwVcp88VHIKjhrmjfSAnTbIK6Hgmfqe2ghLfX38KgA5ccMIHSvDBwjXoooEP0JSoO3I+BKZvUyiNvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214642; c=relaxed/simple;
	bh=jDMMe2wBFJr3UMEyfu1nC3a6lBycStQKPsGNU5qEclk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZLjJtT0qyuUhvAPfX7xE++iQhgb42URzMn+SF0WkQ3Zae8ITV6tcLx5Idwp8VSk8z3pKSnyd0C72X3LU7a+QcO/LkQ3jUdijAh5pXmxhSRdfmpIz/p966qaRBfetQPZA+xu1ZDCaSSEsLDNj0jq2yhoXN7d26gLzb7NA4Z1KZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15405 invoked by uid 109); 24 Sep 2024 21:50:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:50:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18361 invoked by uid 111); 24 Sep 2024 21:50:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:50:39 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:50:39 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 02/28] shallow: fix leak when unregistering last shallow root
Message-ID: <20240924215039.GB1143820@coredump.intra.peff.net>
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

From: Patrick Steinhardt <ps@pks.im>

When unregistering a shallow root we shrink the array of grafts by one
and move remaining grafts one to the left. This can of course only
happen when there are any grafts left, because otherwise there is
nothing to move. As such, this code is guarded by a condition that only
performs the move in case there are grafts after the position of the
graft to be unregistered.

By mistake we also put the call to free the unregistered graft into that
condition. But that doesn't make any sense, as we want to always free
the graft when it exists. Fix the resulting memory leak by doing so.

This leak is exposed by t5500, but plugging it does not make the whole
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jeff King <peff@peff.net>
---
 shallow.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/shallow.c b/shallow.c
index dcebc263d7..4bb1518dbc 100644
--- a/shallow.c
+++ b/shallow.c
@@ -51,12 +51,11 @@ int unregister_shallow(const struct object_id *oid)
 	int pos = commit_graft_pos(the_repository, oid);
 	if (pos < 0)
 		return -1;
-	if (pos + 1 < the_repository->parsed_objects->grafts_nr) {
-		free(the_repository->parsed_objects->grafts[pos]);
+	free(the_repository->parsed_objects->grafts[pos]);
+	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
 		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
 			   the_repository->parsed_objects->grafts + pos + 1,
 			   the_repository->parsed_objects->grafts_nr - pos - 1);
-	}
 	the_repository->parsed_objects->grafts_nr--;
 	return 0;
 }
-- 
2.46.2.1011.gf1f9323e02

