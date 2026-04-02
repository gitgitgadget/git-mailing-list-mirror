Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F83603F6
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103309; cv=none; b=t9GWo2dZ/IIHZwgW1qiOA6rG0Owg4fHFnNlbOdVpbCMsyrr4EHCe9+zBd9h+EpAqo19UR0rDFEyUcF1/go+N8SySj8oijgA7SudMMPr57up8tFGYbsqgu2uimp6S4p6EAXnuyZbc/OMEbem/5yjRdHTHJqvKXNASNSWydg01wl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103309; c=relaxed/simple;
	bh=eaCvr5AtihQxrpuAhNC1ap2stVln7TI1Zkg5aMZtjN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTczAlYcqjTS3RU94Kxvrx7VVHP1r7VzA80fKXaOaDqBMCagI0nJcOcfONPvZmTAFVG14k47tEZvH/P4cPXBIAMHcOs8341GF2wJmipNbTbaghHOFjvdH0sxe/imVQxv9SDHPUgMTsP1FL9hzc01FzHLhFcV24zSIWCTPboovAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YHBD5wPQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YHBD5wPQ"
Received: (qmail 218871 invoked by uid 106); 2 Apr 2026 04:15:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eaCvr5AtihQxrpuAhNC1ap2stVln7TI1Zkg5aMZtjN8=; b=YHBD5wPQtEbRu35Y1MB6o0RQkapJglPnrsn5aqpK0tcxW45HVjU4ptn405DkeWFFb6RGcDqvnH2foLXWDNy8iXoHN9OVCx2vF2Zc5YhDfsyETZ01ddbXQ1LaTDS69ykFi90ZuIFDRiZ2LmqsMrXqhiGz9vXyZV51beRLJ8dnLAqHG3Y8z4+b5HpsZhj+kwzLvFUMtS3GcpTI77M2583qx23jpjERNo/8GAU/+reQ6vqZKq3GznicrFbnDrl+iRgTnnaVvNy4TBd9+Uy/foqzv+GQD/8Wr0NttYftENh3cffU+y9CeIDnFjWwLJud0XqLDGvF48YrVijyOQ4KfvKjrA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:15:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349760 invoked by uid 111); 2 Apr 2026 04:15:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:15:06 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:15:05 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 07/12] pseudo-merge: fix disk reads from
 find_pseudo_merge()
Message-ID: <20260402041505.GG3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>

The goal of this commit was to fix a const warning when compiling
with new versions of glibc, but ended up untangling a much deeper
problem.

The find_pseudo_merge() function does a bsearch() on the "commits"
pointer of a pseudo_merge_map. This pointer ultimately comes from memory
mapped from the on-disk bitmap file, and is thus not writable.

The "commits" array is correctly marked const, but the result from
bsearch() is returned directly as a non-const pseudo_merge_commit
struct. Since new versions of glibc annotate bsearch() in a way that
detects the implicit loss of const, the compiler now warns.

My first instinct was that we should be returning a const struct. That
requires apply_pseudo_merges_for_commit() to mark its local pointer as
const. But that doesn't work! If the offset field has the high-bit set,
we look it up in the extended table via nth_pseudo_merge_ext(). And that
function then feeds our const struct to read_pseudo_merge_commit_at(),
which writes into it by byte-swapping from the on-disk mmap.

But I think this points to a larger problem with find_pseudo_merge(). It
is not just that the return value is missing const, but it is missing
that byte-swapping! And we know that byte-swapping is needed here,
because the comparator we use for bsearch() also calls our
read_pseudo_merge_commit_at() helper.

So I think the interface is all wrong here. We should not be returning a
pointer to a struct which was cast from on-disk data. We should be
filling in a caller-provided struct using the bytes we found,
byte-swapping the values.

That of course raises the dual question: how did this ever work, and
does it work now? The answer to the first part is: this code does not
seem to be triggered in the test suite at all. If we insert a BUG("foo")
call into apply_pseudo_merges_for_commit(), it never triggers.

So I think there is something wrong or missing from the test setup, and
this bears further investigation. Sadly the answer to the second part
("does it work now") is still "no idea". I _think_ this takes us in a
positive direction, but my goal here is mainly to quiet the compiler
warning. Further bug-hunting on this experimental feature can be done
separately.

Signed-off-by: Jeff King <peff@peff.net>
---
 pseudo-merge.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index a2d5bd85f9..ff18b6c364 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -638,31 +638,37 @@ static int pseudo_merge_commit_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-static struct pseudo_merge_commit *find_pseudo_merge(const struct pseudo_merge_map *pm,
-						     uint32_t pos)
+static int find_pseudo_merge(const struct pseudo_merge_map *pm, uint32_t pos,
+			     struct pseudo_merge_commit *out)
 {
+	const unsigned char *at;
+
 	if (!pm->commits_nr)
-		return NULL;
+		return 0;
 
-	return bsearch(&pos, pm->commits, pm->commits_nr,
-		       PSEUDO_MERGE_COMMIT_RAWSZ, pseudo_merge_commit_cmp);
+	at = bsearch(&pos, pm->commits, pm->commits_nr,
+		     PSEUDO_MERGE_COMMIT_RAWSZ, pseudo_merge_commit_cmp);
+	if (!at)
+		return 0;
+
+	read_pseudo_merge_commit_at(out, at);
+	return 1;
 }
 
 int apply_pseudo_merges_for_commit(const struct pseudo_merge_map *pm,
 				   struct bitmap *result,
 				   struct commit *commit, uint32_t commit_pos)
 {
 	struct pseudo_merge *merge;
-	struct pseudo_merge_commit *merge_commit;
+	struct pseudo_merge_commit merge_commit;
 	int ret = 0;
 
-	merge_commit = find_pseudo_merge(pm, commit_pos);
-	if (!merge_commit)
+	if (!find_pseudo_merge(pm, commit_pos, &merge_commit))
 		return 0;
 
-	if (merge_commit->pseudo_merge_ofs & ((uint64_t)1<<63)) {
+	if (merge_commit.pseudo_merge_ofs & ((uint64_t)1<<63)) {
 		struct pseudo_merge_commit_ext ext = { 0 };
-		off_t ofs = merge_commit->pseudo_merge_ofs & ~((uint64_t)1<<63);
+		off_t ofs = merge_commit.pseudo_merge_ofs & ~((uint64_t)1<<63);
 		uint32_t i;
 
 		if (pseudo_merge_ext_at(pm, &ext, ofs) < -1) {
@@ -673,11 +679,11 @@ int apply_pseudo_merges_for_commit(const struct pseudo_merge_map *pm,
 		}
 
 		for (i = 0; i < ext.nr; i++) {
-			if (nth_pseudo_merge_ext(pm, &ext, merge_commit, i) < 0)
+			if (nth_pseudo_merge_ext(pm, &ext, &merge_commit, i) < 0)
 				return ret;
 
 			merge = pseudo_merge_at(pm, &commit->object.oid,
-						merge_commit->pseudo_merge_ofs);
+						merge_commit.pseudo_merge_ofs);
 
 			if (!merge)
 				return ret;
@@ -687,7 +693,7 @@ int apply_pseudo_merges_for_commit(const struct pseudo_merge_map *pm,
 		}
 	} else {
 		merge = pseudo_merge_at(pm, &commit->object.oid,
-					merge_commit->pseudo_merge_ofs);
+					merge_commit.pseudo_merge_ofs);
 
 		if (!merge)
 			return ret;
-- 
2.53.0.1172.ge9e20b5838

