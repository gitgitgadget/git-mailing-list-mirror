Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B0533DB
	for <git@vger.kernel.org>; Thu, 22 May 2025 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952127; cv=none; b=RtOyJFxGguvlvx33sE5OzvVyBIcgvxNcXVEqXjIAcElQaE88rnK7HpXvexQdEc1xxob9Yoseq3v1JeVUPr2T6vRptlrsLsy1PCoAjIHAE4HXcGeuTxo/a2WkjB/7t6DBIaMwldnIJJtrIpOIxwYCcLRwCGe4/17uLub4oKkpeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952127; c=relaxed/simple;
	bh=yq2VMQ3oNyI6RUATrOMX2ZXrHcLUtC+MrwUhhsElpn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJGCIGlXQsiSga8inBx+ac1cz7jvyNlc5mMwBum4AGtaijzUk/MfVX7UKJEHEQMJbVFRLraoC4ACZopVFj3K/3Lak4+O1/9bwAIOiYN2UgV/RcmZ0nV4xk+UIiizCfbpjinQv7Smks/mJS5kfQerGoA9E7xWvEeIoDf1YujGSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H23NatoU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H23NatoU"
Received: (qmail 1644 invoked by uid 109); 22 May 2025 22:15:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yq2VMQ3oNyI6RUATrOMX2ZXrHcLUtC+MrwUhhsElpn0=; b=H23NatoUTxd6LEpm7DtfXBmU7pj2yV9f33BB8ZDU7aVBfazJGHcB2laXwFvR9G0ooSVmAYSScOYzW9G+pCaDjzwiuQgjoMncLPdr6lyGL4iOej64gIPuNfoSZNI7Z3jkVSQ0wUyuWP6BaU8saMRm1AI8Bub4oyKkLBokKW8v3EKdgsiS9xXhXm/u7tDgRfKbElGPJ5uc6BvPgi938CYK+OG+vfdqOmJU1BhKrrplycoRY7795RQZtXM2Na6LbZo0qVEjEzppxmv+XY3q7LSVQd94qJuXERQJITQ6NrlhPtiqI0DSpqqWTepi04lmGROFgXucem3BBGtvJizwSSVKcg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 22:15:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24846 invoked by uid 111); 22 May 2025 22:15:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 18:15:26 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 18:15:23 -0400
From: Jeff King <peff@peff.net>
To: Joey Hess <id@joeyh.name>
Cc: git@vger.kernel.org
Subject: Re: buggy smudge/clean of empty files
Message-ID: <20250522221523.GA21347@coredump.intra.peff.net>
References: <aC90kn2mE93DCJEH@kitenet.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aC90kn2mE93DCJEH@kitenet.net>

On Thu, May 22, 2025 at 03:01:38PM -0400, Joey Hess wrote:

> git seems to be buggy in its handling of empty files when smudge/clean filters
> are used.
> 
> I've attached a script setup_smudge_clean.sh, which configures a git
> repository to use a very simple smudge and clean filter pair for all
> files. The clean filter prepends a line "hi" to the file content, and the
> smudge filter removes the line. There is nothing very special about this
> smudge/clean, it's just a simple one for the sake of an example.
> 
> Here's the bug:

Thanks for a reproducible example. Running it through the debugger, I'd
guess the problem is in ce_match_stat_basic(), specifically this bit:

          /* Racily smudged entry? */
          if (!ce->ce_stat_data.sd_size) {
                  if (!is_empty_blob_oid(&ce->oid, the_repository->hash_algo))
                          changed |= DATA_CHANGED;
          }

That comes from f49c2c22fe (racy-git: an empty blob has a fixed object
name, 2008-06-10), which says:

      We use size=0 as the magic token to say the entry is known to be racily
      clean, but a sequence that does:
  
       - update the path with a non-empty blob and write the index;
       - update an unrelated path and write the index -- this smudges
         the above entry;
       - truncate the path to size zero.
  
      would make both the size field for the path in the index and the size on
      the filesystem zero.  We should not mistake it as a clean index entry.

but I suspect the is_empty_blob_oid() check is out of date for a world
with clean/smudge filters. The blob content inside the repository is
going to be "hi\n" in this case, so we will mark it as DATA_CHANGED. But
what we really want to know is: when smudged for the worktree, is the
content expected to be empty?

Something like the patch below, but it feels very dirty.

I wondered if we might be able to just catch these cases later in
diffcore (like we do for other stat-unmatch cases), but I do think this
conditional has false positives and false negatives. Your case is
confusing an empty file in the worktree which fails to match its smudged
content. But the opposite one is where the file should have content in
the worktree (due to smudging), but is cleaned to empty inside the
repository.

So I dunno. I'm hoping somebody more familiar with the index and/or
clean/smudge conversions can show a better way.

-Peff

diff --git a/read-cache.c b/read-cache.c
index 73f83a7e7a..0f19440514 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -48,6 +48,7 @@
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
+#include "convert.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -342,8 +343,37 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 
 	/* Racily smudged entry? */
 	if (!ce->ce_stat_data.sd_size) {
-		if (!is_empty_blob_oid(&ce->oid, the_repository->hash_algo))
+		/*
+		 * Yuck, we'd really like to be able to ask if there is any
+		 * conversion configured so we can just check the oid in
+		 * the common non-smudge case. But there is no worktree
+		 * equivalent to would_convert_to_git().
+		 *
+		 * It would not be correct to check is_empty_blob_oid() first
+		 * here (and skip the more expensive check). I think that would
+		 * be wrong for cases where the clean in-repo blob is empty,
+		 * but the smudged version has data.
+		 */
+		char *data;
+		unsigned long len;
+		enum object_type type;
+		struct strbuf expected_wt = STRBUF_INIT;
+
+		/*
+		 * skip error handling for this example. What would we do? Set
+		 * DATA_CHANGED pessimistically?
+		 */
+		data = repo_read_object_file(the_repository,
+					     &ce->oid,
+					     &type, &len);
+		convert_to_working_tree(the_repository->index,
+					ce->name, data, len,
+					&expected_wt, NULL);
+
+		if (expected_wt.len)
 			changed |= DATA_CHANGED;
+		strbuf_release(&expected_wt);
+		free(data);
 	}
 
 	return changed;
