Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDC42A8F
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215553; cv=none; b=Ez1KfKVtNooVNUWpZbUsmIDtPSB9SQEyInsnR2gtiDjPzVoGlZ8njHUYP5knEi8fSdgo2NCo+mpOH0kHcTrbpGs8ZZQ9BItU1rJ5vrA2C41Dmh+iGzcZfBE7aS1cQyLWUkAtANegTd6Qdsi5sxTywdg0nc//SJ6ZaH/tFmEUFVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215553; c=relaxed/simple;
	bh=cgH51hyTMfwnu+WQCELbiEGAPdeLpUjQwuBIh3K0IRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEyhkKLV0g3g/7fY5ETMffVMjjyBY3hNupEV+ERdkgv0HA2Qhfu2w7+mXRRjR1mVdci11gzNnb4WhFM3rxNWEG7S3n7vP1c2XEUTg5iyeD3P/f4yRtByHyptE9w6m6sQamH1dOrgxhJeiMJfqMzkg2LqQ/A8I4r/l3Eo8k7s9ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15582 invoked by uid 109); 24 Sep 2024 22:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:05:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18814 invoked by uid 111); 24 Sep 2024 22:05:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:05:50 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:05:50 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 21/28] http-push: free curl header lists
Message-ID: <20240924220550.GU1143820@coredump.intra.peff.net>
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

To pass headers to curl, we have to allocate a curl_slist linked list
and then feed it to curl_easy_setopt(). But the header list is not
copied by curl, and must remain valid until we are finished with the
request.

A few spots in http-push get this right, freeing the list after
finishing the request, but many do not. In most cases the fix is simple:
we set up the curl slot, start it, and then use run_active_slot() to
take it to completion. After that, we don't need the headers anymore and
can call curl_slist_free_all().

But one case is trickier: when we do a MOVE request, we start the
request but don't immediately finish it. It's possible we could change
this to be more like the other requests, but I didn't want to get into
risky refactoring of this code. So we need to stick the header list into
the request struct and remember to free it later.

Curiously, the struct already has a headers field for this purpose! It
goes all the way back to 58e60dd203 (Add support for pushing to a remote
repository using HTTP/DAV, 2005-11-02), but it doesn't look like it was
ever used. We can make use of it just by assigning our headers to it,
and there is already code in finish_request() to clean it up.

This fixes several leaks triggered by t5540.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/http-push.c b/http-push.c
index 52c53928a9..451f7d14bb 100644
--- a/http-push.c
+++ b/http-push.c
@@ -437,9 +437,11 @@ static void start_move(struct transfer_request *request)
 	if (start_active_slot(slot)) {
 		request->slot = slot;
 		request->state = RUN_MOVE;
+		request->headers = dav_headers;
 	} else {
 		request->state = ABORTED;
 		FREE_AND_NULL(request->url);
+		curl_slist_free_all(dav_headers);
 	}
 }
 
@@ -1398,6 +1400,7 @@ static int update_remote(const struct object_id *oid, struct remote_lock *lock)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		strbuf_release(&out_buffer.buf);
+		curl_slist_free_all(dav_headers);
 		if (results.curl_result != CURLE_OK) {
 			fprintf(stderr,
 				"PUT error: curl result=%d, HTTP code=%ld\n",
@@ -1407,6 +1410,7 @@ static int update_remote(const struct object_id *oid, struct remote_lock *lock)
 		}
 	} else {
 		strbuf_release(&out_buffer.buf);
+		curl_slist_free_all(dav_headers);
 		fprintf(stderr, "Unable to start PUT request\n");
 		return 0;
 	}
@@ -1516,6 +1520,7 @@ static void update_remote_info_refs(struct remote_lock *lock)
 					results.curl_result, results.http_code);
 			}
 		}
+		curl_slist_free_all(dav_headers);
 	}
 	strbuf_release(&buffer.buf);
 }
-- 
2.46.2.1011.gf1f9323e02

