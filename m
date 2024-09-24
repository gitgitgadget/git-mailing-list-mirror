Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2483CD5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214730; cv=none; b=B0oXCELaB8x9kCL7pKXv5Ayf8ksKPsQaG3TcQGaxJ2ZnvzxlaTDz0jSYeLzEVWRs60XdEiuCsBeGOp0zib4j/XY+mg5QHaWHeMG4Tg7DPU3lbwpJhkAycJ2E5Zp7Dud5mfXsbcEQDj3NvkL77WJjgbhoRKCtx/wq9a2cvSmVORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214730; c=relaxed/simple;
	bh=5xwbp1WLpvje9S2WhnjjI1fOx3Ec6oQCcXsMDT5UQCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBDyfzuVMovZhHJai0xPS1WJHdRKR/n59053bFExGPIG2ImPeEDyuREcfL02W9FKA0B05SX8TpRTiPh19OMZyJxL9N7Wc/DZnI3uWDIkUNJD1bCVTIO+0mgc8rICNs+B1IMs+7D802GfmrAjNSSUvuh6zGDHHzoU0nm2CH/NREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15425 invoked by uid 109); 24 Sep 2024 21:52:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:52:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18507 invoked by uid 111); 24 Sep 2024 21:52:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:52:07 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:52:07 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 05/28] fetch-pack: free object filter before exiting
Message-ID: <20240924215207.GE1143820@coredump.intra.peff.net>
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

Our fetch_pack_args holds a filter_options struct that may be populated
with allocated strings by the by the "--filter" command-line option. We
must free it before exiting to avoid a leak when the program exits.

The usual fetch code paths that use transport.c don't have the same
leak, because we do the cleanup in disconnect_git().

Fixing this leak lets us mark t5500 as leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c  | 1 +
 t/t5500-fetch-pack.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c5319232a5..cfc6951d23 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -293,5 +293,6 @@ int cmd_fetch_pack(int argc,
 	free(sought);
 	free_refs(fetched_refs);
 	free_refs(remote_refs);
+	list_objects_filter_release(&args.filter_options);
 	return ret;
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 585ea0ee16..605f17240c 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -8,6 +8,7 @@ test_description='Testing multi_ack pack fetching'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test fetch-pack/upload-pack pair.
-- 
2.46.2.1011.gf1f9323e02

