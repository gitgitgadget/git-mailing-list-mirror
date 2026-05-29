Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933783A257A
	for <git@vger.kernel.org>; Fri, 29 May 2026 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033228; cv=none; b=mp4YFg4qi7cl/qY/Gjc+u5nBb2OV9Rg8ugUvbOgzameK+od/fcAvL1BjFSeyMb3i0vBj0RtG4ChRVOQ52sRLkkgXOjMRCR+F+MBv50abhtgpEBWF1a+eLXyXN0QKkQJF7KkMtE/qgFrqQnbdqlItTreWKKYGuf8h+OL+JrCdQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033228; c=relaxed/simple;
	bh=pj7EBG8Losr25dvBQpDhw+jCRa3pnIM7Pw2pFwgfjbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar2dSoBlEKnQmTxcP36gkk9rP1C6GuGOJqx/4/kI/ShPPDa/Dt8VJBDbMZVWstdEZydZE7c+FAZ1krvX0k6JuapBaGqM8phpA4vtiwDGwFssOIDASw4lMfG1srq8Ga1CQV0RvyvF2LRIxnZUMrNMvgv7/OP9TzvtZbVHrob9/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gN7OpeTk; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gN7OpeTk"
Received: (qmail 3901 invoked by uid 106); 29 May 2026 05:40:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pj7EBG8Losr25dvBQpDhw+jCRa3pnIM7Pw2pFwgfjbQ=; b=gN7OpeTkTkVK+wd55Yn7neXfnfknmKToS1g4knCwV3mtz4kzmG6KPHSO+bQeddO+pVQ+8TsSuX/GpFEd0jmCpi5UNVUHRM8Cu/QU0fRP4oxjUZ251linlx3W+WXHuVB3QEU9y7NFmdpZKd3AJB8jrpf8DkRRmTwXObEfCwjjI9vVtvtsw2Z9WNGltw+PZ7TKQQt4OXFDvnqY9dO4I7DVWo6ElABqrtc0PLTpdi67nEPC7RyL0iZm08Q5UDhwNnMBHKrA2pVYklTi8Dm6kCYIE/AwPqYk6T5MomiCyuMf8E9D3sY7OgEnBzfhQI8w/3ZNspLjP2jhv9wYS07tYp7nmQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 05:40:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7286 invoked by uid 111); 29 May 2026 05:40:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 01:40:28 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 01:40:24 -0400
From: Jeff King <peff@peff.net>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	fox <fox.gbr@townlong-yak.com>
Subject: Re: [PATCH v2] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <20260529054024.GA1104383@coredump.intra.peff.net>
References: <agx5tblaCZNsYEBq@lorenzo-VM>
 <ahjUmMCKxREamQE-@lorenzo-VM>
 <20260529053659.GC1099450@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529053659.GC1099450@coredump.intra.peff.net>

On Fri, May 29, 2026 at 01:36:59AM -0400, Jeff King wrote:

> But it _could_ be done as a preparatory patch. And the rationale for
> doing that on its own I think is roughly:
> 
>   1. It is mostly doing nothing, because 63aca3f7f1 registered it as a
>      tempfile, so it will be cleaned up at process end anyway (whether
>      we succeed in fetching it or not).
> 
>   2. It is maybe a little harmful, because we are going to unlink() it
>      now, and then later the tempfile code will try to unlink() it again
>      (so a simultaneous fetch could have created the same file).

BTW, for (2) I wondered about going in the opposite direction. If we
actually passed the tempfile back up, like in the patch below, then we
could use delete_tempfile() to do the unlink (and remove it from the
tempfile list).

And then your patch would want to similarly delete_tempfile() in its
error path.

But I don't think it really buys us much. _If_ we were going to keep
passing the tempfile struct up the call stack on success, then we could
store it and call delete_tempfile() as soon as we had ran index-pack on
it. But that's even more surgery, for again little gain (we delete our
tempfiles a little earlier, rather than at process end).

So I'm inclined to go in the direction that shortens the code. ;)

-Peff

---
diff --git a/http.c b/http.c
index ea9b16861b..e83a3857b3 100644
--- a/http.c
+++ b/http.c
@@ -2546,9 +2546,10 @@ int http_fetch_ref(const char *base, struct ref *ref)
 }
 
 /* Helpers for fetching packs */
-static char *fetch_pack_index(unsigned char *hash, const char *base_url)
+static struct tempfile *fetch_pack_index(unsigned char *hash, const char *base_url)
 {
 	char *url, *tmp;
+	struct tempfile *ret;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (http_is_verbose)
@@ -2575,23 +2576,24 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
 	tmp = xstrfmt("%s/tmp_pack_%s.idx",
 		      repo_get_object_directory(the_repository),
 		      hash_to_hex(hash));
-	register_tempfile(tmp);
+	ret = register_tempfile(tmp);
+	free(tmp);
 
-	if (http_get_file(url, tmp, NULL) != HTTP_OK) {
+	if (http_get_file(url, ret->filename.buf, NULL) != HTTP_OK) {
 		error("Unable to get pack index %s", url);
-		FREE_AND_NULL(tmp);
+		delete_tempfile(&ret);
 	}
 
 	free(url);
-	return tmp;
+	return ret;
 }
 
 static int fetch_and_setup_pack_index(struct packfile_list *packs,
 				      unsigned char *sha1,
 				      const char *base_url)
 {
 	struct packed_git *new_pack, *p;
-	char *tmp_idx = NULL;
+	struct tempfile *tmp_idx;
 	int ret;
 
 	/*
@@ -2607,11 +2609,9 @@ static int fetch_and_setup_pack_index(struct packfile_list *packs,
 	if (!tmp_idx)
 		return -1;
 
-	new_pack = parse_pack_index(the_repository, sha1, tmp_idx);
+	new_pack = parse_pack_index(the_repository, sha1, tmp_idx->filename.buf);
 	if (!new_pack) {
-		unlink(tmp_idx);
-		free(tmp_idx);
-
+		delete_tempfile(&tmp_idx);
 		return -1; /* parse_pack_index() already issued error message */
 	}
 
