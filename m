Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CA13211C
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574046; cv=none; b=BdFOWPvNqN0M3rhGBwN40VzpSDI/O44tf1yIs9Yn6zHxahtJm6SXttIRUUCn6qiu2UfiG5O1LvZlDIWP91rX5ZAbpxluRdA278NizVQvX3Yt9Vh4r+T278v7eEsoznDkSQ07WpV5aUZ2F1Ww2tev/oM6sDlrX+gaYUx38fIGb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574046; c=relaxed/simple;
	bh=92TrvRS8X4BacB5Iz2Nl/66rZ/+X+/dWMfEr+ANo9dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjxdhgeQb/muguPtMgAznbv9ddZE+DT3VleCVKx9HhuXrndEr+yNclhX54P3gyBRJelErSBD0e0bJ2mU0u43xsn0UZbD3SKmA6J7zrC7YaeIefErCCgU92M3tlQYqf1iW/6jYJ0d6XV8HpdGa7PngcHK/DNSlnUto3BxTzI7de4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NjmsdQ1j; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NjmsdQ1j"
Received: (qmail 27642 invoked by uid 109); 22 Oct 2024 05:14:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=92TrvRS8X4BacB5Iz2Nl/66rZ/+X+/dWMfEr+ANo9dQ=; b=NjmsdQ1jfODr4K0+8+535JfRpb+BjAs/+dG36nClL9MKv7Qys1PzE9Onzvu3witb5GUYiLin+5YFB0WBEDYsXSjDJJor/alQtkb2uYDUXnM7MkBFpwTleylDbUnLU/F7ik5QnvOgKVOxKU7SOARIUQFqbmJrQzlMIxeTgEQBuNmwnQtVyvfNk5V7LXDqCb/FYUNq4/bQfgItNSCe21ixKk3YTtwmq2qAFGa0N9VvTfC7/1R/53m1CZY/0vWxHf+waiVbCK4ptAyxIWPK+Sctk4VnsF9DCE+Cg+uIRYZapslH15vhjJW3wVCAkxfkNKXluacAd9JrrawSO/tBPOIFRQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Oct 2024 05:14:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5333 invoked by uid 111); 22 Oct 2024 05:14:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Oct 2024 01:14:02 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Oct 2024 01:14:02 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: Bug report: v2.47.0 cannot fetch version 1 pack indexes
Message-ID: <20241022051402.GB1247135@coredump.intra.peff.net>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
 <20241020012455.GA599236@coredump.intra.peff.net>
 <20241020024022.GA615104@coredump.intra.peff.net>
 <Zxa6ixwP2aOJdfmL@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zxa6ixwP2aOJdfmL@nand.local>

On Mon, Oct 21, 2024 at 04:33:15PM -0400, Taylor Blau wrote:

> > @@ -2388,8 +2389,24 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
> >  	strbuf_addf(&buf, "objects/pack/pack-%s.idx", hash_to_hex(hash));
> >  	url = strbuf_detach(&buf, NULL);
> >
> > -	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(hash));
> > -	tmp = strbuf_detach(&buf, NULL);
> > +	/*
> > +	 * Don't put this into packs/, since it's just temporary and we don't
> > +	 * want to confuse it with our local .idx files.  We'll generate our
> > +	 * own index if we choose to download the matching packfile.
> > +	 *
> > +	 * It's tempting to use xmks_tempfile() here, but it's important that
> > +	 * the file not exist, otherwise http_get_file() complains. So we
> > +	 * create a filename that should be unique, and then just register it
> > +	 * as a tempfile so that it will get cleaned up on exit.
> > +	 *
> > +	 * Arguably it would be better to hold on to the tempfile handle so
> > +	 * that we can remove it as soon as we download the pack and generate
> > +	 * the real index, but that might need more surgery.
> > +	 */
> > +	tmp = xstrfmt("%s/tmp_pack_%s.idx",
> > +		      repo_get_object_directory(the_repository),
> > +		      hash_to_hex(hash));
> > +	register_tempfile(tmp);
> 
> Makes perfect sense, and the comment above here is much appreciated.
> 
> I thought about trying to use some intermediate state of the strbuf here
> to avoid an extra xstrfmt() call, but couldn't come up with anything I
> didn't think was awkward.

I don't think there's any useful intermediate state. The earlier %s is
the base url, but here it's our local directory.

We could continue to re-use the scratch strbuf as the existing code did
(and which xstrfmt() is doing under the hood). It wasn't really
intentional for me to change that, but I went through a lot of attempts
to get here (using mks_tempfile(), and so on).

> > +static char *pack_path_from_idx(const char *idx_path)
> > +{
> > +	size_t len;
> > +	if (!strip_suffix(idx_path, ".idx", &len))
> > +		BUG("idx path does not end in .idx: %s", idx_path);
> > +	return xstrfmt("%.*s.pack", (int)len, idx_path);
> > +}
> > +
> >  struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
> >  {
> > -	const char *path = sha1_pack_name(sha1);
> > +	char *path = pack_path_from_idx(idx_path);
> 
> Huh. I would have thought we have such a helper function already. I
> guess we probably do, but that it's also defined statically because it's
> so easy to write.

I thought so, too, but couldn't find one. We have pack_bitmap_filename()
(and so on for .rev and .midx files) that goes from .pack to those
extensions. But here we want to go from .idx to .pack. I think most
stuff goes from ".pack" because that's what we store in the packed_git
struct.

There's also sha1_pack_index_name(), but that goes from a csum-file hash
to a filename.

I grepped around and strip_suffix() seems to be par for the course in
similar situations within pack/repack code, so I think it's OK here.

> In any case, this looks like the right thing to do here. It would be
> nice to have a corresponding test here, since unlike the other
> finalize_object_file() changes, this one can be provoked
> deterministically.
> 
> Would you mind submitting this as a bona-fide patch, which I can then
> pick up and start merging down?

Yeah, the test is easy:

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 58189c9f7d..50a7b98813 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -507,4 +507,14 @@ test_expect_success 'fetching via http alternates works' '
 	git -c http.followredirects=true clone "$HTTPD_URL/dumb/alt-child.git"
 '
 
+test_expect_success 'dumb http can fetch index v1' '
+	server=$HTTPD_DOCUMENT_ROOT_PATH/idx-v1.git &&
+	git init --bare "$server" &&
+	git -C "$server" --work-tree=. commit --allow-empty -m foo &&
+	git -C "$server" -c pack.indexVersion=1 gc &&
+
+	git clone "$HTTPD_URL/dumb/idx-v1.git" &&
+	git -C idx-v1 fsck
+'
+
 test_done

I raised some other more philosophical issues in the other part of the
thread, but assuming the answer is "no, let's do the simplest thing",
then I think this approach is OK.

I'd also like to see if I can clean things up around parse_pack_index(),
whose semantics I'm changing here (and which violates all manner of
assumptions that we usually have about packed_git structs). It's used
only by the dumb-http code, and I think we want to refactor it a bit so
that nobody else is tempted to use it.

I'll try to send something out tonight or tomorrow.

-Peff
