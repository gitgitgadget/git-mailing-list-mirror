Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456DB138E
	for <git@vger.kernel.org>; Sat, 25 May 2024 04:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716612399; cv=none; b=VvWKRWCzBRjHZTlTbGj0NE6dEgGoVccBFetLxu6pQy5r7blKFNQdB54d3dhC7esPWn6Q7WMGkjO47KS9sUGpURkcCa8vEtgK0QzeZGp5unQGLbobMqWW05FwlkuMGHhte5Zi44OaXUf8YqoaEOKecs+N3aWMbZoymDhfGfUnfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716612399; c=relaxed/simple;
	bh=/dVKCTf73KZRyE4F7cRzaIqflzBGsVtvMS82ujonF0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkVCH34ck0OGvjf0ye/gJkrp0/3W37BD58rkb8X6HPRcjkk8uQMuF/ZSo3KkC7WaM8nNUGxp/wp+cOBXJEuSGNbRlC7WWX5AGVmK/3+DAra/IT8INxf2sifcol1b8X0w79Md4riNIxDpiQ4g1gH0xrWuCEiJ1Y8Y60hB/TiD98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4014 invoked by uid 109); 25 May 2024 04:46:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 May 2024 04:46:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15952 invoked by uid 111); 25 May 2024 04:46:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 May 2024 00:46:39 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 May 2024 00:46:35 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/21] strbuf: fix leak when `appendwholeline()` fails
 with EOF
Message-ID: <20240525044635.GB1895047@coredump.intra.peff.net>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <9dd8709d1b3b350008218133986befdb2ae74bae.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9dd8709d1b3b350008218133986befdb2ae74bae.1716541556.git.ps@pks.im>

On Fri, May 24, 2024 at 12:03:29PM +0200, Patrick Steinhardt wrote:

> In `strbuf_appendwholeline()` we call `strbuf_getwholeline()` with a
> temporary buffer. In case the call returns an error we indicate this by
> returning EOF, but never release the temporary buffer. This can lead to
> a memory leak when the line has been partially filled. Fix this.

Hmm, doesn't this indicate a bug in getwholeline()? Most strbuf
functions on error try to leave the allocation as-is.

At the end of the getdelim() version (which is probably what you're
running), when we see an error we do:

        if (!sb->buf)
                strbuf_init(sb, 0);
        else
                strbuf_reset(sb);
        return EOF;

So if getdelim() returned error and left us with a buffer (but still
returned -1 for error!), I think this code is assuming that the buffer
it left us with was the same one that existed beforehand.

But your commit message implies that it might allocate, hit an error,
and then return that error along with an allocated buffer? Looks like
that matches the getdelim() manpage, which says:

  If *lineptr was set to NULL before the call, then the buffer should be
  freed by the user program even on failure.

So should we do something like:

diff --git a/strbuf.c b/strbuf.c
index e1076c9891..e37165812b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -659,7 +659,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	if (!sb->buf)
 		strbuf_init(sb, 0);
 	else
-		strbuf_reset(sb);
+		strbuf_release(sb);
 	return EOF;
 }
 #else

That assumes sb->alloc is valid after a failed call, since
strbuf_release() checks it. But that seems reasonable. If not, we'd need
to free() and re-initialize it ourselves, and the code is more like:

diff --git a/strbuf.c b/strbuf.c
index e1076c9891..aed699c6bf 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -656,10 +656,8 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	 * we can just re-init, but otherwise we should make sure that our
 	 * length is empty, and that the result is NUL-terminated.
 	 */
-	if (!sb->buf)
-		strbuf_init(sb, 0);
-	else
-		strbuf_reset(sb);
+	FREE_AND_NULL(sb->buf);
+	strbuf_init(sb, 0);
 	return EOF;
 }
 #else

But I think either of those would solve your leak, _and_ would help with
similar leaks of strbuf_getwholeline() and friends.

-Peff
