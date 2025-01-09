Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E71FDA
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411593; cv=none; b=GxRc4wNknhETEfqRcTsdwQVs72jVGXNSAByCqsg8mF9AHOqf5MRKWcLcrEuzTBYMEzng+eGNWOHMLQdSfI6bgWc9E4aJzXWDSHBMTGptjbhJ1MbziP/Il7fhsEiUQVCJ8DRwXvsm1xNNIjEbNV0eRHT55/qJ52sVawgUPt0P1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411593; c=relaxed/simple;
	bh=WEpWXc50XkA14XPM7inT92wM7gnl6gKV8HwSldSzp0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mffnazTJB3q8YhLLXego1xkG85OdZ+xVkZwpILhG2zMHVcsqgJ82Php31JRV+7fq9QBRD1pGUVhtyIJPcnqYhdhsGyWC3I45jIWYcDE57Dh4t+3tcl/BrS3DldpCr/TdQGs/ofRaNf29Wyg5/jrddqEmI8YfiQp5iqRImZFvB8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gj3ZmnB6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gj3ZmnB6"
Received: (qmail 25617 invoked by uid 109); 9 Jan 2025 08:33:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WEpWXc50XkA14XPM7inT92wM7gnl6gKV8HwSldSzp0g=; b=gj3ZmnB66fGCIbcdqxS0A49x4QN1k6OIOyA9/WBZMitPeuE1e8fdpLX0k8y30328JZRPmpcN0zB+6RQXgNwDudvzUbHNjClbHnKpjBbi8LD0Ur8wDM2eIWt+hX1sda07abij0kuvwhw60IKBTfLSX6cOh/Ta8OHeMHE+1lSDcIaLRdKlK5VAdc5Q/CV3UG2NiqJpgPdB2+SKr/uV9/PtH7b3dqFbdpcbAXwq8EObRON5mdzh5vGvLvoLzPJ1En8sftrepQz1KiBXuxlhVICMCVooNcEANHGYa7YPXNhSbD0ODDsAg9BPEm/+x7X3CLUIGSFRFEBm54dIWP1mthofDQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:33:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20119 invoked by uid 111); 9 Jan 2025 08:33:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:33:10 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:33:10 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 03/14] tree-diff: clear parent array in path_appendnew()
Message-ID: <20250109083310.GC2748836@coredump.intra.peff.net>
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

All of the other functions which allocate a combine_diff_path struct
zero out the parent array, but this code path does not. There's no bug,
since our caller will fill in most of the fields. But leaving the unused
fields (like combine_diff_parent.path) uninitialized makes working with
the struct more error-prone than it needs to be.

Let's just zero the parent field to be consistent with the
combine_diff_path_new() allocator.

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index d9237ffd9b..24f7b5912c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -151,8 +151,6 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
  *	process(p);
  *	p = pprev;
  *	; don't forget to free tail->next in the end
- *
- * p->parent[] remains uninitialized.
  */
 static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	int nparent, const struct strbuf *base, const char *path, int pathlen,
@@ -187,6 +185,8 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	p->mode = mode;
 	oidcpy(&p->oid, oid ? oid : null_oid());
 
+	memset(p->parent, 0, sizeof(p->parent[0]) * nparent);
+
 	return p;
 }
 
-- 
2.48.0.rc2.413.gc1c80375a3

