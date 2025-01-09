Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654D2F2D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412623; cv=none; b=Js9igntLF/z29fNQr/Z14m5jbdDHU9dRnxUrdouJVFTB9NbuoX4zpqQPRLaI1uKwObq8XdHd7gGPV9NKzmuAXvoauAEzwHC3Z6I1RA6AaHtGwHJAfdqOvh7JMLJ+zaDMT4aH0KCRoplvJ8R1PRm6nNXoeatIXwCZZ6QPsmG+3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412623; c=relaxed/simple;
	bh=UYx9WFpy77/QfdVavBk8WVQVhPaUpYvTZ4CAF4kFMW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP/PPqAkBfkM41YXB0Jt0zDyK+J8zG15tEXHDD3piDNBMNX5S3R/eWUeNTHRPDFnUuHw7oBBtTXPyZFsKBEmhSdKbFuAZbMwuiGfycT1uknHA0EvCfJm2DSGsLMn7PmlAF8+lzSk30JL23dR2RsPqt1Y6kc9CRaeIoH7Z4QzA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dbum2aeA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dbum2aeA"
Received: (qmail 25735 invoked by uid 109); 9 Jan 2025 08:50:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UYx9WFpy77/QfdVavBk8WVQVhPaUpYvTZ4CAF4kFMW0=; b=Dbum2aeApcWfVSq+nYFROBW0FRQ1zIQJ0lJk/RhWT7vAncwS8C9pUDgSH8Gq4txLuIrokwV6wLbyjm1bdt69+a3f3EM9MyTkfMU9+p2vFDfTa1YmjC4NwCNr5uip0nHm1uYSJ8kDNENiQQgjD66lPvQTKCw42tT1A5uMWX5dTFrOrDLWTV3NEQcLA5j+tCxIYrVLmtyB4fHvoGLtpqNiODfueMXsK2kVLxOPlg8KKs6YM4S7MvF7S8EzqqQjLz7gLCQPAk1/SvbjmQn+xLLC8Sg/NDWqPMb3Gl8s/e1vmMmDyKaTNUJz4yTXc0VDcIO5fMb7D6tsSjGsiG+/L7J9hg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:50:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20398 invoked by uid 111); 9 Jan 2025 08:50:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:50:20 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:50:19 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 10/14] combine-diff: drop public declaration of
 combine_diff_path_size()
Message-ID: <20250109085019.GJ2748836@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109082723.GA2748497@coredump.intra.peff.net>

We want callers to use combine_diff_path_new() to allocate structs,
rather than using combine_diff_path_size() and xmalloc(). That gives us
more consistency over the initialization of the fields.

Now that the final external user of combine_diff_path_size() is gone, we
can stop declaring it publicly. And since our constructor is the only
caller, we can just inline it there.

Breaking the size computation into two parts also lets us reuse the
intermediate multiplication result of the parent length, since we need
to know it to perform our memset(). The result is a little easier to
read.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c | 5 +++--
 diff.h         | 3 ---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index ae3cbfc699..f21e1f58ba 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1658,16 +1658,17 @@ struct combine_diff_path *combine_diff_path_new(const char *path,
 						size_t num_parents)
 {
 	struct combine_diff_path *p;
+	size_t parent_len = st_mult(sizeof(p->parent[0]), num_parents);
 
-	p = xmalloc(combine_diff_path_size(num_parents, path_len));
+	p = xmalloc(st_add4(sizeof(*p), path_len, 1, parent_len));
 	p->path = (char *)&(p->parent[num_parents]);
 	memcpy(p->path, path, path_len);
 	p->path[path_len] = 0;
 	p->next = NULL;
 	p->mode = mode;
 	oidcpy(&p->oid, oid);
 
-	memset(p->parent, 0, sizeof(p->parent[0]) * num_parents);
+	memset(p->parent, 0, parent_len);
 
 	return p;
 }
diff --git a/diff.h b/diff.h
index 60e7db4ad6..32ad17fd38 100644
--- a/diff.h
+++ b/diff.h
@@ -489,9 +489,6 @@ struct combine_diff_path {
 		char *path;
 	} parent[FLEX_ARRAY];
 };
-#define combine_diff_path_size(n, l) \
-	st_add4(sizeof(struct combine_diff_path), (l), 1, \
-		st_mult(sizeof(struct combine_diff_parent), (n)))
 struct combine_diff_path *combine_diff_path_new(const char *path,
 						size_t path_len,
 						unsigned int mode,
-- 
2.48.0.rc2.413.gc1c80375a3

