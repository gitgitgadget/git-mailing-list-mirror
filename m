Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B11713CFA5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215962; cv=none; b=BGHgrHO1VMe6tT3ACjgSr4R2abvx9A+HVH+MbsfYnvnRW6qf5XOmggBB6Sr7ulmuMo3inbRWsR54rP25suSN2pirKPIytu1gHzXvZzS8lplOBSKJ7eQsd5KWB3MKfaPIisyjYKbMuXW9BLjEBfkWEQORXhPZCqj2l3ZNa3Ixxkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215962; c=relaxed/simple;
	bh=BJ2VvkRTSWAULhWXOP2d/ZtEQ/tzI8NtRvnRHG537F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk+HgeRj+oZuwz28bGa5cyCVOuNoa+jaibtX0NdL0/HrtgU0Z6/S5oyg6tbRf6IALeIefyXqqAq0ztuxly9nV8Esex36h4tgRO0HbQp7ZNVOvvvo63/AW7b2KwDtw2q2fekzz6YJIr9tB36KEJSBvfDFT9/4l0hbHBOthkGXlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15637 invoked by uid 109); 24 Sep 2024 22:12:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:12:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18919 invoked by uid 111); 24 Sep 2024 22:12:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:12:40 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:12:39 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 28/28] http-push: clean up local_refs at exit
Message-ID: <20240924221239.GB1143820@coredump.intra.peff.net>
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

We allocate a list of ref structs from get_local_heads() but never clean
it up. We should do so before exiting to avoid complaints from the
leak-checker. Note that we have to initialize it to NULL, because
there's one code path that can jump to the cleanup label before we
assign to it.

Fixing this lets us mark t5540 as leak-free.

Curiously building with SANITIZE=leak and gcc does not seem to find this
problem, but switching to clang does. It seems like a fairly obvious
leak, though.

I was curious that the matching remote_refs did not have the same leak.
But that is because we store the list in a global variable, so it's
still reachable after we exit. Arguably we could treat it the same as
future-proofing, but I didn't bother (now that the script is marked
leak-free, anybody moving it to a stack variable will notice).

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c                 | 3 ++-
 t/t5540-http-push-webdav.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index b36b1f9e35..aad89f2eab 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1719,7 +1719,7 @@ int cmd_main(int argc, const char **argv)
 	int rc = 0;
 	int i;
 	int new_refs;
-	struct ref *ref, *local_refs;
+	struct ref *ref, *local_refs = NULL;
 
 	CALLOC_ARRAY(repo, 1);
 
@@ -1997,6 +1997,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	refspec_clear(&rs);
+	free_refs(local_refs);
 
 	return rc;
 }
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 37db3dec0c..27389b0908 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -10,6 +10,7 @@ This test runs various sanity checks on http-push.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
-- 
2.46.2.1011.gf1f9323e02
