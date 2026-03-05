Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C374C92
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752352; cv=none; b=P6EPMarrqa9Cww290eUZb9qSXoUhf6JFiwXi0av5Mw9LQS7EtTG1a/lUdI93leu59Jx8gh7mpZQHap9rbkb6v/0NApJcwVtSKEacvLSR9jHRqvhMKOGyjcvcgurXxDb/jGdVwfaNuPPoTs52lr6dRys1c2op8TXzhrFUFEpapzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752352; c=relaxed/simple;
	bh=jjRxHzLKiyMUK5227QsE9vku2XVc48JnY6lGLdEX0eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXwNw3zOpcaA/aVp3I3SFa85MyxbyPgR8iKyRW8asUq2/5DGf8gQqbvs201/p2si2EMr9uCkK6rrP9dGf30gCjLs8ow5FGWS+fFCwFM4VMkH6inNjQruONOXg7GOhpLL2swgiL3w8Q2Tr66sPz5dk0tok0KdjJD9LTux4ePpznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dIr4ptEy; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dIr4ptEy"
Received: (qmail 2696 invoked by uid 106); 5 Mar 2026 23:12:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jjRxHzLKiyMUK5227QsE9vku2XVc48JnY6lGLdEX0eE=; b=dIr4ptEy9UtyV6FVvpwuNnwRDBljbjzhTtdoWOzN3CSw8Hn7dusn/fqhdvL6ZrxX+jm8bHhS3grjjcVtpcEJvnANZFVRlfRO+epAnknEUHKiEWxOCFIORe7ymSpYMQQnd4Szjh5qnhH/CQ5arznmhlH2GvbK8acFN+pUFZ9Z5wjNhkSLlFc7sGoZMZCK5j0j05SFI9pE5n6FL2qh6fQ4djf84fb4Hepxpf5ciXb4r6AkB8yFNHL6aDoum+yP5nKHLTPDhTKEKXE2M9htqybwEGSUHhVqnJ1qpjxRuQlg8t35r/E1n72FL1Bec0B08pmdU//ETaSaXAFughuqOzNa3A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Mar 2026 23:12:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 393538 invoked by uid 111); 5 Mar 2026 23:12:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Mar 2026 18:12:32 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Mar 2026 18:12:29 -0500
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org
Subject: [PATCH 3/4] pack-revindex: avoid double-loading .rev files
Message-ID: <20260305231229.GC2901305@coredump.intra.peff.net>
References: <20260305230315.GA2354983@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305230315.GA2354983@coredump.intra.peff.net>

The usual entry point for loading the pack revindex is the
load_pack_revindex() function. It returns immediately if the packed_git
has a non-NULL revindex or revindex data field (representing an
in-memory or mmap'd .rev file, respectively), since the data is already
loaded.

But in 5a6072f631 (fsck: validate .rev file header, 2023-04-17) the fsck
code path switched to calling load_pack_revindex_from_disk() directly,
since it wants to check the on-disk data (if there is any). But that
function does _not_ check to see if the data has already been loaded; it
just maps the file, overwriting the revindex_map pointer (and pointing
revindex_data inside that map). And in that case we've leaked the mmap()
pointed to by revindex_map (if it was non-NULL).

This usually doesn't happen, since fsck wouldn't need to load the
revindex for any reason before we get to these checks. But there are
some cases where it does. For example, is_promisor_object() runs
odb_for_each_object() with the PACK_ORDER flag, which uses the revindex.

This happens a few times in our test suite, but SANITIZE=leak doesn't
detect it because we are leaking an mmap(), not a heap-allocated buffer
from malloc(). However, if you build with NO_MMAP, then our compat mmap
will read into a heap buffer instead, and LSan will complain. This
causes failures in t5601, t0410, t5702, and t5616.

We can fix it by checking for existing revindex_data when loading from
disk. This is redundant when we're called from load_pack_revindex(), but
it's a cheap check. The alternative is to teach check_pack_rev_indexes()
in fsck to skip the load, but that seems messier; it doesn't otherwise
know about internals like revindex_map and revindex_data.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-revindex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index 56cd803a67..1fe0afe899 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -277,6 +277,10 @@ int load_pack_revindex_from_disk(struct packed_git *p)
 {
 	char *revindex_name;
 	int ret;
+
+	if (p->revindex_data)
+		return 0;
+
 	if (open_pack_index(p))
 		return -1;
 
-- 
2.53.0.786.g466665faa3

