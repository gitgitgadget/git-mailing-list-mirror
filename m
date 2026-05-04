Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402B38B152
	for <git@vger.kernel.org>; Mon,  4 May 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888675; cv=none; b=b6YURN8xFCGfDhoYA3ctjT4BymNW6SCXuY8wtGke9adp2MiALE/A0/rGrZRNcAtbQnNHYn59hlR0qj+mvtnOyjaut5vLiK875ROpXDrUH/P5y6FxpRVrr2NkCfcx6wm2HzxruC4jOpcoB10dF0qBiHwnuAXDXbG3Ap3JfCWtX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888675; c=relaxed/simple;
	bh=gxSVrdRA7AJcg5IL3EiS1UDVj1Hu6Shhx8/51goG8TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4YGFi57h+QX9E29uJG0imhxDR5f/i+yK3kvG1d4S+ytgYRKm//FfXiEQafv5RDbT+r5/hDUAyCoHR4xVcGhBjHX7lErwB0rYSx6SOY5QKtMA8qjeM+Bj45hLEoIIAEZE2oKy4a6eEhH8hPGhMzXj4yl6VTbzfW41CH2R88V1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E+21nLaK; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E+21nLaK"
Received: (qmail 28052 invoked by uid 106); 4 May 2026 09:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gxSVrdRA7AJcg5IL3EiS1UDVj1Hu6Shhx8/51goG8TQ=; b=E+21nLaKUsJ6CMPM8Rx9wjfhZlNiCx8Q1jqJ8Ko/Y0Ao/pkXAQwr4aPXo+RLeHu0rkM6O8j+xsJDo9SzkHF2+KiQCqBIzVcHiXnZnWAixecupURbr2o+Id+26cP7U4G6Yvms6qDdJ2qRSnvEA0Ry1XkcsFNUTukzEM6RjCRUDeNJA6N7Ts8lO8rOanoIJpvgicEty0GNgWfsWRwqF2nQYQGn046nicnob5gKTDCmvP7oo0260MBEefQiAfYzTHIktmOX6wxCRdivPj4yh2ALIp1ljNenudQ30kmjRcGG5MVt2V83mAEOB5kzZeUNhydXwJESadyeHn7NMmSzM0zWpA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 May 2026 09:51:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 54925 invoked by uid 111); 4 May 2026 09:51:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2026 05:51:10 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 May 2026 05:51:10 -0400
From: Jeff King <peff@peff.net>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: git@vger.kernel.org, emkan@prevas.dk
Subject: Re: git clone with --dissociate sometimes fails to check out target
 commit
Message-ID: <20260504095110.GA599780@coredump.intra.peff.net>
References: <87h5onsi0f.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h5onsi0f.fsf@prevas.dk>

On Mon, May 04, 2026 at 10:20:32AM +0200, Rasmus Villemoes wrote:

> Are we using --dissociate wrongly, or are we perhaps not maintaining
> those local mirror repos properly? They are essentially just created
> with 'git clone --mirror', with 'git remote update' run periodically.
> 
> Naively, I'd expect the effects of --dissociate to only happen after
> everything else the clone command does has been done, but it seems that
> the ties to the reference repo are cut too soon.

No, you're using it correctly. The dissociate step should copy all of
the shared objects into the new repo, so it shouldn't matter whether we
do it before or after checkout. The objects are there either way.

But there's an interesting bug here with commit graphs. What happens is
this:

  1. During the initial part of the clone, we may load a commit object
     using the commit-graph file from the --reference repo. The commit
     struct is left with a blank "maybe_tree" field, because we know we
     can load it from the commit graph later (and don't want to spend
     the effort to make a "struct tree" unless somebody asks for it).

  2. During the dissociate step, we call odb_close(), since we're
     throwing away the link to the reference repo, and we don't want to
     use our in-process structs that point to it. That step also throws
     away our open reference to the commit-graph file, and the
     in-process slab that holds the graph positions we've loaded.

  3. The checkout process needs the tree, so it calls
     repo_get_commit_tree(). That sees that maybe_commit is NULL, so we
     check whether it might be loaded from the graph file. But when we
     ask about the graph position, we don't have one! It was in the slab
     we threw away. So we return NULL, and the caller thinks the commit
     is corrupt.

This is a bug that we theorized existed in a thread a while ago:

  https://lore.kernel.org/git/20240110113914.GE16674@coredump.intra.peff.net/

but we didn't have a way to trigger it. Now we do. Hooray, I guess? ;)

The fallback load suggested in that message fixes it (modulo the fact
that it forgot to return commit->maybe_tree at the end of the function).
Below is a slightly safer version of the same concept that likewise
fixes the problem.

It's kind of ugly, but I think may be the least-bad solution. See that
earlier thread for more discussion of alternatives.

In the meantime, doing your dissociate clone with:

  git -c core.commitGraph=false clone ...

should work around the problem.

---
diff --git a/commit.c b/commit.c
index 80d8d07875..50d736b339 100644
--- a/commit.c
+++ b/commit.c
@@ -434,16 +434,46 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
+static void load_tree_from_commit_contents(struct repository *r, struct commit *commit)
+{
+	enum object_type type;
+	unsigned long size;
+	char *buf;
+	const char *p;
+	struct object_id tree_oid;
+
+	buf = odb_read_object(r->objects, &commit->object.oid, &type, &size);
+	if (!buf)
+		return;
+
+	if (type == OBJ_COMMIT &&
+	    skip_prefix(buf, "tree ", &p) &&
+	    !parse_oid_hex(p, &tree_oid, &p) &&
+	    *p == '\n')
+		commit->maybe_tree = lookup_tree(r, &tree_oid);
+
+	free(buf);
+}
+
 struct tree *repo_get_commit_tree(struct repository *r,
-				  const struct commit *commit)
+				  struct commit *commit)
 {
 	if (commit->maybe_tree || !commit->object.parsed)
 		return commit->maybe_tree;
 
 	if (commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
 		return get_commit_tree_in_graph(r, commit);
 
-	return NULL;
+	/*
+	 * This is either a corrupt commit, or one which we partially loaded
+	 * from a graph file but then subsequently threw away the graph data.
+	 *
+	 * Optimistically assume it's the latter and try to reload from
+	 * scratch. This gives a performance penalty if it really is a corrupt
+	 * commit, but presumably that happens rarely.
+	 */
+	load_tree_from_commit_contents(r, commit);
+	return commit->maybe_tree;
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
diff --git a/commit.h b/commit.h
index 58150045af..5eb1264077 100644
--- a/commit.h
+++ b/commit.h
@@ -163,7 +163,7 @@ void repo_unuse_commit_buffer(struct repository *r,
  */
 void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
 
-struct tree *repo_get_commit_tree(struct repository *, const struct commit *);
+struct tree *repo_get_commit_tree(struct repository *, struct commit *);
 struct object_id *get_commit_tree_oid(const struct commit *);
 
 /*
