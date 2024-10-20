Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA55184
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729387499; cv=none; b=X0kQCmfX6piVtELq6PIL+hkddYK2RCD9oXE+FpB6dVfMelvlmVQy9ouc8lxWcJejd3m4Aq0rArdnPXR/r66Vp2QbcvA2EWiaSSTdDU1Ek6G3F8THg7PikXQhM+IukRI8vi2ytk5Kn7zlpymYzdfYUSSH4D4BBFmt4XA/aJfU2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729387499; c=relaxed/simple;
	bh=5bDTxwwQ2iKbdc61XlhWUGyjTC0JgCEe8GizOPEQxgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZxxqs4o/mNnNxIr6PATKNZh4EgVI5gqXefppMipQWQZ7e8ze4BkJZi8CNNU55EQgC0QKGg8Hue3t0XW+SNn4Gv9lh2eywuAjhQqeLwkX0QoqvKvWxsSSx7iDyA2BjJQ80g+gyMwg+9nnEwzn8ghPOGuiMqKB0hIarGLjxgYPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=R7u/j02z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="R7u/j02z"
Received: (qmail 16908 invoked by uid 109); 20 Oct 2024 01:24:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5bDTxwwQ2iKbdc61XlhWUGyjTC0JgCEe8GizOPEQxgc=; b=R7u/j02zQDHHa9+/fPQRS8C/aH20395leuutGUeg7hgIirpp73weDvRlDTJSL7wopR8ypPT3D/PO9QgGQCS9muRd+kVTawJ9/9zgnO1GHAyteesBMa1OhWa9/wlgZPK8pFNhwRYkUK+dywnfOkW6+KDGbZugrVxRUgfsNNNTi4tfy70oTBtKpHDo7LJ4/UXMI2Ede2nwPEn4PxfTOcuGqelYdhwuWL6EjNt3YV4HuJ6kcxs76on9L0fIzALW5Ce6VLHv8c3h219HMnTq9pffLkZtiFSQhTHKKBYm/Irrplx2usiRI2iI273Sgrl75GYYTcYQHYP/GEWc+jXpBkA3/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 20 Oct 2024 01:24:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7487 invoked by uid 111); 20 Oct 2024 01:24:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Oct 2024 21:24:55 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Oct 2024 21:24:55 -0400
From: Jeff King <peff@peff.net>
To: fox <fox.gbr@townlong-yak.com>
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: Bug report: v2.47.0 cannot fetch version 1 pack indexes
Message-ID: <20241020012455.GA599236@coredump.intra.peff.net>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>

On Sun, Oct 20, 2024 at 01:22:34AM +0200, fox wrote:

> Running git-bisect identifies b1b8dfde6929ec9463eca0a858c4adb9786d7c93
> as the first bad commit, suggesting that the .idx file downloaded from
> the remote is now expected to be byte-for-byte identical with a
> locally-generated version; due to format differences, they are not.
> 
> The remote idx is in the original (version 1) format, and git
> verify-pack seems satisfied with it.  Did v2.47.0 intend to block
> fetching such indices?

Interesting case. No, we did not intend to block fetching those indices.

We knew there was a potential problem with dumb http here, but the idea
was that if we had a local file "foo.idx" (or "foo.pack"), that we'd
never try to download the other side in the first place, preferring
ours.

And AFAICT that does hold. But here we have the opposite problem! We
download the pack idx from the remote first, so that we know what it
claims to have (which tells us whether we want to grab the matching
pack). And then we grab the matching pack, but instead of using the .idx
we downloaded, we index it again ourselves.

Which is probably a good idea to make sure that we prefer our
locally-checked copy versus what the other side has. But obviously there
is no guarantee that we'll come up with the same bytes as the other side
if there are version or configuration differences.

One option is to just discard the remote version before re-indexing,
like this:

diff --git a/http.c b/http.c
index d59e59f66b..6879d7ba1b 100644
--- a/http.c
+++ b/http.c
@@ -2500,6 +2500,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	struct child_process ip = CHILD_PROCESS_INIT;
 	int tmpfile_fd;
 	int ret = 0;
+	size_t len;
 
 	fclose(preq->packfile);
 	preq->packfile = NULL;
@@ -2517,6 +2518,18 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	else
 		ip.no_stdout = 1;
 
+	/*
+	 * We're about to reindex the packfile, so throw away the .idx
+	 * we downloaded from the remote in order to prefer ours.
+	 */
+	if (strip_suffix(preq->tmpfile.buf, ".pack.temp", &len)) {
+		struct strbuf idx = STRBUF_INIT;
+		strbuf_add(&idx, preq->tmpfile.buf, len);
+		strbuf_addstr(&idx, ".idx");
+		unlink(idx.buf);
+		strbuf_release(&idx);
+	}
+
 	if (run_command(&ip)) {
 		ret = -1;
 		goto cleanup;


There are a few things I don't like there, though:

  - obviously reversing the tempfile name back to the idx is hacky. We
    could probably store the original idx that led us to this pack and
    use that.

  - I don't _think_ there is any case where that .idx file is precious.
    We wouldn't be indexing the .pack file if we didn't just download
    it, and we wouldn't have downloaded it if we already had a
    .idx/.pack pair. OTOH the name we got from the other side isn't
    necessarily the same one we'll use locally; we're feeding the pack
    via "index-pack --stdin", so it will do its own hash to come up with
    the name. The other side could have used a different scheme, or even
    be trying to intentionally trick us.

So I feel like the root of the problem is that we moved the other side's
"pack-1234abcd.idx" into place at all! We do not plan to use it, but
only need to access it via our custom packed_git structs to see whether
we want to download the matching pack. And in fact I'd suspect there are
other possible bugs/trickery lurking, if the other side gives us a
broken .idx that does not match its pack (our odb would now have the
broken file with no matching pack).

So IMHO a cleaner fix is that we should keep the stuff we download from
the remote marked as temporary files, and then throw them away when we
complete the fetch (rather than just expecting index-pack to overwrite
them).

-Peff
