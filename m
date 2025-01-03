Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6751C5F24
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735937200; cv=none; b=F9+TaEV2gbHvhNn2o3fsdwaD1EqkugFzeq06VwDxYdw05m5rDAnQpiIcDav8ORvHGMJ+GotxT1gsuuG7smaay3r1y0CCrjTv9kxC8d5J9ANPW57WaGETrDcD1QZpespHhUvZg1njn2NGjDkXyklp1RafHb5JqAbmpjObitmsWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735937200; c=relaxed/simple;
	bh=SNqFONrkTbuPxewdfsVKjG2TUmsGAFGumbMAPDTcLkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT12XVfrx1TT4EdGprLu10YO7e7pUKX+4jcIbAvWDQpm35vYsC6E8Y+0mquVqOrDNrnRQ/Z+67R20WXkorZ6wfby+zD1ORcvltmN3JGg50st3jnUVtZdHWuX8ri7Qukh7yUwAXxJswD+r2jKwNZBzRvJPkF9DKLO8hoBQez/rMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UwTLeuAs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UwTLeuAs"
Received: (qmail 19376 invoked by uid 109); 3 Jan 2025 20:46:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SNqFONrkTbuPxewdfsVKjG2TUmsGAFGumbMAPDTcLkU=; b=UwTLeuAsiHZ5Tmc93Xu7q+USQOBhLZ5B0ik1wX9KM/YEfzTD91oKGFax2ahFwlENBaTzQWH3P3CN0Cm9GVusffk3dOQiqFwg1/ZvMy7huNAVZFPMPomoZJkOC3CmYX/Fan2g/JfNHV4lYDzXh7h9sAUEjDCWKdFuu4PCfSDUUG1c4+Thvnyojgbx0KFAVAP5B0xhb8lI3KQeY3uJqINg65O4m7Y/X7xCkUYBlVxnvkmpd1ni4lhF91xJkWfMG9LzN1+6857ZwGno9TmmHIPa/eaOjlAGdk7Esui77EXB9/mXTWKeZD1VTxxuTXAys/p0TKugwyuEqbBNE69AfV8zdQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 20:46:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5084 invoked by uid 111); 3 Jan 2025 20:46:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 15:46:25 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 15:46:24 -0500
From: Jeff King <peff@peff.net>
To: Wink Saville <wink@saville.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [BUGREPORT] git diff-tree --cc SEGFAUTs
Message-ID: <20250103204624.GE3212696@coredump.intra.peff.net>
References: <CAKk8isqpAXLoiXxOP3uAc00M+OM0FaU3Uhnt5R1FnFMD=xGARg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKk8isqpAXLoiXxOP3uAc00M+OM0FaU3Uhnt5R1FnFMD=xGARg@mail.gmail.com>

On Fri, Jan 03, 2025 at 11:28:47AM -0800, Wink Saville wrote:

> `git diff-tree --cc` SEGFAUTs after adding trace_printf to diff_tree_combined.

Hmm, is it really a bug in Git if you had to add new code which contains
the bug? :)

> @@ -1595,8 +1597,16 @@ void diff_tree_combined(const struct object_id *oid,
>  	}
>  
>  	/* find out number of surviving paths */
> -	for (num_paths = 0, p = paths; p; p = p->next)
> +	trace_printf("Wink diff_tree_combined: find number of surviving paths num_parent=%d\n", num_parent);
> +	for (num_paths = 0, p = paths; p; p = p->next) {
> +		trace_printf("Wink diff_tree_combined: num_paths=%d &p=%p mode=%0x, oid=%s path=%s\n", num_paths, p, p->mode, oid_to_hex(&p->oid), p->path);
> +		for (i = 0; i < num_parent; i++) {
> +			trace_printf("Wink diff_tree_combined:  &p->parent[%d]=%p status=%c mode=%x oid=%s path.buf=%p contents path.buf=%s\n",
> +				 i, &p->parent[i], p->parent[i].status, p->parent[i].mode, oid_to_hex(&p->parent[i].oid), p->parent[i].path.buf, p->parent[i].path.buf);
> +		}

The parent "path" strbufs are only initialized in intersect_paths() if
combined_all_paths is set, and if there was an actual path change (a
copy or rename).

So you'd probably need something like this:

diff --git a/combine-diff.c b/combine-diff.c
index 455bc19087..1e58809c4e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1601,8 +1601,11 @@ void diff_tree_combined(const struct object_id *oid,
 	for (num_paths = 0, p = paths; p; p = p->next) {
 		trace_printf("Wink diff_tree_combined: num_paths=%d &p=%p mode=%0x, oid=%s path=%s\n", num_paths, p, p->mode, oid_to_hex(&p->oid), p->path);
 		for (i = 0; i < num_parent; i++) {
+			const char *path = rev->combine_all_paths &&
+					   filename_changed(p->parent[i].status) ?
+					   p->parent[i].path.buf : NULL;
 			trace_printf("Wink diff_tree_combined:  &p->parent[%d]=%p status=%c mode=%x oid=%s path.buf=%p contents path.buf=%s\n",
-				 i, &p->parent[i], p->parent[i].status, p->parent[i].mode, oid_to_hex(&p->parent[i].oid), p->parent[i].path.buf, p->parent[i].path.buf);
+				     i, &p->parent[i], p->parent[i].status, p->parent[i].mode, oid_to_hex(&p->parent[i].oid), path, path);
 		}
 		num_paths++;
 	}

-Peff
