Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2218C03C
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839746; cv=none; b=srnOzORgBw3FtK7B3cv9invRaJfLzlZQgXmTyESluD4/bmbnjgH1QmHZBDHEimyomIq2EykSR3sh4sfXYC7uQ3oktvxFa+51IDS5Ap7YgnG773Q63JC5OgLAufkvj/xULP4sMb4iN8Gz61Rw/gf7xMu3X0/uaV7tUXnydMonONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839746; c=relaxed/simple;
	bh=YzYWuNJQY5StW769ixlHdyPJS5IJh1tdJeehnmrGeq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaPb0k7BGCcIUJ5+BIohBww+OENN1nRe47v0CK/T1NoTCz+J3f6yq1iTFQoUdvuHSx6Rfm9JavDCmnib9s3X+nXU/vlHsxvxcZYFeLfbq5Y4CvpXEteCWvQGvZ+j/dy+HxoRZouP+qVfIsAzeOGMCw7RNl4oKZijMSsBlIqA+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WrZWt/Y9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WrZWt/Y9"
Received: (qmail 541 invoked by uid 109); 25 Oct 2024 07:02:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YzYWuNJQY5StW769ixlHdyPJS5IJh1tdJeehnmrGeq8=; b=WrZWt/Y961v+i775p/a8qI6IpmgcH/jfBYJVQpTE8adiGGsEzDc3mcyHVF1ckbrMFJY/+mekBBwTKSk226q1Q32fE6JFb6hjWWIoUfDc0kdwFT7coWQo0C9GMTVC7S/gju4dFbV5lTnPdtxRZAkb6ufUoIa8hZam58WrflQWezKUWkzL7Gd4+0ZPb3pf/nx0Mr+r82uMZ9m/xnfk4ifpxbfPzbQ7ulCqyp3OZaIt03Hk2cZGVF97VuqzKKD2XVZVgbhEvHLgdJtLrfU7o8GipOwekpM/2iy9ejsQfbGF/YGVcNH5wenua0W82e82xaAYdIRJ/yxB0trgsPYuNiCW1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 07:02:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12855 invoked by uid 111); 25 Oct 2024 07:02:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 03:02:23 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 03:02:22 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: [PATCH 07/11] packfile: warn people away from parse_packed_git()
Message-ID: <20241025070222.GG2110355@coredump.intra.peff.net>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025064148.GA2110169@coredump.intra.peff.net>

With a name like parse_packed_git(), you might think it's the right way
to access a local pack index and its associated objects. But not so!
It's a one-off used by the dumb-http code to access pack idx files we've
downloaded from the remote, but whose packs we might not have.

There's only one caller left for this function, and ideally we'd drop it
completely and just inline it there. But that would require exposing
other internals from packfile.[ch], like alloc_packed_git() and
check_packed_git_idx().

So let's leave it be for now, and just warn people that it's probably
not what they're looking for. Perhaps in the long run if we eventually
drop dumb-http support, we can remove the function entirely then.

Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/packfile.h b/packfile.h
index 6812abaae0..ad393be9f1 100644
--- a/packfile.h
+++ b/packfile.h
@@ -37,6 +37,15 @@ char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *e
  */
 const char *pack_basename(struct packed_git *p);
 
+/*
+ * Parse the pack idx file found at idx_path and create a packed_git struct
+ * which can be used with find_pack_entry_one().
+ *
+ * You probably don't want to use this function! It skips most of the normal
+ * sanity checks (including whether we even have the matching .pack file),
+ * and does not add the resulting packed_git struct to the internal list of
+ * packs. You probably want add_packed_git() instead.
+ */
 struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
@@ -193,7 +202,7 @@ int is_promisor_object(const struct object_id *oid);
  *
  * This function should not be used directly. It is exposed here only so that we
  * have a convenient entry-point for fuzz testing. For real uses, you should
- * probably use open_pack_index() or parse_pack_index() instead.
+ * probably use open_pack_index() instead.
  */
 int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	     size_t idx_size, struct packed_git *p);
-- 
2.47.0.363.g6e72b256be

