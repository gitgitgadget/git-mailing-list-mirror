Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16C12DDA1
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550995; cv=none; b=RAla0UichUppOElbnBPYSQ7XYFE4Om1cs3beBfsAXwPsFPfwirnIbeAQzknDJO921VloS4LQS/rSihnSqyjISAUST+MV8cXr6egFIh3tFAvEPYiy4sp/npaOUdSGQUi1cV7Ld/TtwoYFHRaAbdTZNYcuvltv9YtMSEOlJ0oYbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550995; c=relaxed/simple;
	bh=GT1K5dkmbosWDlhpPFNIUXDfw7Z6BWK3J4kEYTC53bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrWRXPYoDDMNf9Wn2sge1OOS/lUozdJo/hRuCfHNM7KqQtuAyqmxLHE+wpconNr2qhe6qJ3N96dVCW4maCi2HwYabo/fX/DB/M/ohD/2NqW0BpRnszaIV+AtQhwBtM1S9hHGV943Bbj5nomQY+X7ipXDT07jNpJZ4TTIL/mfDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BMdrP32z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BMdrP32z"
Received: (qmail 23311 invoked by uid 109); 18 Aug 2025 21:03:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GT1K5dkmbosWDlhpPFNIUXDfw7Z6BWK3J4kEYTC53bM=; b=BMdrP32zht3E5fe6VYz0AtWhQXUU9wXr0puI6eocpi7OC1/kk6mjn+V7l46wl0QCYpC8aLr5SPanpO8r2Z6pw+uD4nhuAMCUULXHVzNjXvu/Ub4HHa0472iGwqSjhWMiGeWzikLmYXxsyercl4hg5jbK9MvAM09aD3D86BYkDd6LH9kwKim55eClUTYLi2+QlJ6bMwKdRYpjE5u87g6/nhYkosslstc4CA/86kT2wUHsMl8KNKGvcKRg5yykPBQTAvmlvKcYs/XIMzjDb8TcBvCRxAZxh+wN2Hke4WTFgjqP//MLBsrsDVokgcXoUfw6cX5Ehkc+z7EqhsnNorIASA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 21:03:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30328 invoked by uid 111); 18 Aug 2025 21:03:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 17:03:12 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 17:03:12 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: [PATCH 4/5] describe: handle blob traversal with no commits
Message-ID: <20250818210312.GD1024556@coredump.intra.peff.net>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818205812.GA1018043@coredump.intra.peff.net>

When describing a blob, we traverse from HEAD, remembering each commit
we saw, and then checking each blob to report the containing commit.
But if we haven't seen any commits at all, we'll segfault (we store the
"current" commit as an oid initialized to the null oid, causing
lookup_commit_reference() to return NULL).

This shouldn't be able to happen normally. We always start our traversal
at HEAD, which must be a commit (a property which is enforced by the
refs code). But you can trigger the segfault like this:

  blob=$(echo foo | git hash-object -w --stdin)
  echo $blob >.git/HEAD
  git describe $blob

We can instead catch this case and return an empty result, which hits
the usual "we didn't find $blob while traversing HEAD" error.

This is a minor lie in that we did "find" the blob. And this even hints
at a bigger problem in this code: what if the traversal pointed to the
blob as _not_ part of a commit at all, but we had previously filled in
the recorded "current commit"? One could imagine this happening due to a
tag pointing directly to the blob in question.

But that can't happen, because we only traverse from HEAD, never from
any other refs. And the intent of the blob-describing code is to find
blobs within commits.

So I think this matches the original intent as closely as we can (and
again, this segfault cannot be triggered without corrupting your
repository!).

I didn't include a test here because it requires corrupting the
repository in a way that is only easy to do using the files ref backend.
It doesn't seem worth carrying a REFFILES test just for this oddity.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index f7bea3c8c5..72b2e1162c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -507,8 +507,10 @@ static void process_object(struct object *obj, const char *path, void *data)
 
 	if (oideq(pcd->looking_for, &obj->oid) && !pcd->dst->len) {
 		reset_revision_walk();
-		describe_commit(&pcd->current_commit, pcd->dst);
-		strbuf_addf(pcd->dst, ":%s", path);
+		if (!is_null_oid(&pcd->current_commit)) {
+			describe_commit(&pcd->current_commit, pcd->dst);
+			strbuf_addf(pcd->dst, ":%s", path);
+		}
 		free_commit_list(pcd->revs->commits);
 		pcd->revs->commits = NULL;
 	}
-- 
2.51.0.326.gecbb38d78e

