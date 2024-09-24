Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F806E614
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215601; cv=none; b=hKHebCCvAo6SihyKVa8xostpLUEC1q/oj7H7u621tp4rKjkMs0CVfEt16JcRIV3FJIy2qh71GOevCLqaR1WMVfVLXjhCKSv84NfXOcNeFxIGUDWSLAIDiOwroBt4M//09ThdMKK3U+qOaosP1LQIofwLY65/M44EEFO00WgFt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215601; c=relaxed/simple;
	bh=yBY+5pmQZU24WMj+cv0WL0yzePbHRc2BXA9rC6nGHWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERCFm5pvJAbPUGwgi9SFhnrKEvA0nMCCyL7YIt54UiQ+OPphkSjNmHqlb8JuuL8D8G6K3mbyh6KcP9/g7d5KH3DHR+fKgXoUnuvd/QRVTjtW0s9lEonskua7gDSZ5ihqFqB/mX/Xez76UVoU1SSeBzJdRXVNdGPoWgZJ0CHyS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15588 invoked by uid 109); 24 Sep 2024 22:06:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:06:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18818 invoked by uid 111); 24 Sep 2024 22:06:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:06:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:06:38 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 22/28] http-push: free transfer_request dest field
Message-ID: <20240924220638.GV1143820@coredump.intra.peff.net>
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

When we issue a PUT request, we store the destination in the "dest"
field by detaching from a strbuf. But we never free the result, causing
a leak.

We can address this in the release_request() function. But note that we
also need to initialize it to NULL, as most other request types do not
set it at all.

Curiously there are _two_ functions to initialize a transfer_request
struct. Adding the initialization only to add_fetch_request() seems to
be enough for t5540, but I won't pretend to understand why. Rather than
just adding "request->dest = NULL" in both spots, let's zero the whole
struct. That addresses this problem, as well as any future ones (and it
can't possibly hurt, as by definition we'd be hitting uninitialized
memory previously).

This fixes several leaks noticed by t5540.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/http-push.c b/http-push.c
index 451f7d14bb..9aa4d11ccd 100644
--- a/http-push.c
+++ b/http-push.c
@@ -514,6 +514,7 @@ static void release_request(struct transfer_request *request)
 	}
 
 	free(request->url);
+	free(request->dest);
 	free(request);
 }
 
@@ -651,11 +652,8 @@ static void add_fetch_request(struct object *obj)
 		return;
 
 	obj->flags |= FETCHING;
-	request = xmalloc(sizeof(*request));
+	CALLOC_ARRAY(request, 1);
 	request->obj = obj;
-	request->url = NULL;
-	request->lock = NULL;
-	request->headers = NULL;
 	request->state = NEED_FETCH;
 	request->next = request_queue_head;
 	request_queue_head = request;
@@ -687,11 +685,9 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	}
 
 	obj->flags |= PUSHING;
-	request = xmalloc(sizeof(*request));
+	CALLOC_ARRAY(request, 1);
 	request->obj = obj;
-	request->url = NULL;
 	request->lock = lock;
-	request->headers = NULL;
 	request->state = NEED_PUSH;
 	request->next = request_queue_head;
 	request_queue_head = request;
-- 
2.46.2.1011.gf1f9323e02

