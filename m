Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D50195399
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361094; cv=none; b=XI55581ODXRav2KOSemfY5/esJFJknNaPuaAYcN1ceYoL+8uIvDmKG9s1S/FRF+UcM6DuwuyNAaXoaBxjmBNq3GGTjkLvCqiKTyG4HKGONI36T1z8XMeeNUc8/ic66tI8+GmqiS6Bzgyh2u8u4bZ+E8z3MMj8nF8H40CWreEu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361094; c=relaxed/simple;
	bh=Fc46l5RtGhnOdo1bPp1UbriDiVFHQpqpMpT4I9ZJL2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMWyR69VefMLSA6WdK9JHsvjfmwwwz1F8lXORy8MumWxVCnTy1iOocvT01LQ1SZZUY6SCBtpdspIxrAfp1AMEdV41nJbgr3tBMMfA0flmrDrwbYzdnfhaX+yF/epD9Js78hMauiWUpio1RrrjX8ebg+7Hrkub4cK2Dg6lpsBu7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16585 invoked by uid 109); 14 Jun 2024 10:31:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:31:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27228 invoked by uid 111); 14 Jun 2024 10:31:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:31:29 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:31:31 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 08/11] t5801: make remote-testgit GIT_DIR setup more robust
Message-ID: <20240614103131.GH222445@coredump.intra.peff.net>
References: <20240614102439.GA222287@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614102439.GA222287@coredump.intra.peff.net>

Our tests use a fake helper that just imports from an existing Git
repository. We're fed the path to that repo on the command line, and
derive the GIT_DIR by tacking on "/.git".

This is wrong if the path is a bare repository, but that's OK since this
is just a limited test. But it's also wrong if the transport code feeds
us the actual .git directory itself (i.e., we expect "/path/to/repo" but
it gives us "/path/to/repo/.git"). None of the current tests do that,
but let's future-proof ourselves against adding a test that does.

We can instead ask "rev-parse" to set our GIT_DIR. Note that we have to
first unset other git variables from our environment. Coming into this
script, we'll have GIT_DIR set to the fetching repository, and we need
to "switch" to the remote one.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5801/git-remote-testgit | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
index c5b10f5775..f8b476499f 100755
--- a/t/t5801/git-remote-testgit
+++ b/t/t5801/git-remote-testgit
@@ -26,7 +26,8 @@ then
 	t_refspec=""
 fi
 
-GIT_DIR="$url/.git"
+unset $(git rev-parse --local-env-vars)
+GIT_DIR=$(git -C "$url" rev-parse --absolute-git-dir)
 export GIT_DIR
 
 force=
-- 
2.45.2.937.g0bcb3c087a

