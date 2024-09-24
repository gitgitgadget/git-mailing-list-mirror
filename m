Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79036E614
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215841; cv=none; b=hCVxE19JwmtiDiZLiMAw4ZUijO6i0BqgrHUkpDGsB1AWTR4O7cDHg5PXCVB86O3G8TNN+ne8uWCeqengbpm9uFh210a3pRJkTsqqQPAI9BI+566p5fAyEDYkjpC6biAS4E7RUuoQ97j7GRyOqx9G1ofnahLl2jSeKQ3epldGWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215841; c=relaxed/simple;
	bh=8ceUppMXa8nKrfI5M0LOZQmzMmDDkMVhyV+Y65MmwB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkGX6LFxEohH5uOe7pxezw8ibPV1AVtm+TZKZeB6Z1De4jRANT9qpIZgqmieikiJD9E8m1n8kxwkvnGyeQ+t6X7J+PsSM6E0tKmgSGyjE0Ygt4322wq1gJdb5gccIddeyHRMHtqEmXyLj+7atoFBP69Gn55CnrNqEl4rGajyIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15621 invoked by uid 109); 24 Sep 2024 22:10:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:10:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18909 invoked by uid 111); 24 Sep 2024 22:10:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:10:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:10:38 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 26/28] http-push: clean up objects list
Message-ID: <20240924221038.GZ1143820@coredump.intra.peff.net>
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

In http-push's get_delta(), we generate a list of pending objects by
recursively processing trees and blobs, adding them to a linked list.
And then we iterate over the list, adding a new request for each
element.

But since we iterate using the list head pointer, at the end it is NULL
and all of the actual list structs have been leaked.

We can fix this either by using a separate iterator and then calling
object_list_free(), or by just freeing as we go. I picked the latter,
just because it means we continue to shrink the list as we go, though
I'm not sure it matters in practice (we call add_send_request() in the
loop, but I don't think it ever looks at the global objects list
itself).

This fixes several leaks noticed in t5540.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 1146d7c6fe..1cddd2fb37 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1374,9 +1374,13 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 	}
 
 	while (objects) {
+		struct object_list *next = objects->next;
+
 		if (!(objects->item->flags & UNINTERESTING))
 			count += add_send_request(objects->item, lock);
-		objects = objects->next;
+
+		free(objects);
+		objects = next;
 	}
 
 	return count;
-- 
2.46.2.1011.gf1f9323e02

