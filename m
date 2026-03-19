Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6728CF77
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963350; cv=none; b=DfOskAZzNqViu1kLYwez6vO361bYlkxgF+vs9wEiaMjksNI3N51QVHuvbJ9w+FzmxuxBjjtRvl6BsnzAH7XsVqZUuLIRccmTq2Yqea7NM40tE7nibGE0jYuz2oPOf6IhQEPcJqD7ZS2xE3Ur4G51rngGw/VHKcbPE7LYtAXUSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963350; c=relaxed/simple;
	bh=a2ciue+OHQ1VMEw/Yi9iG6C20/NyHEb3/U15oHydsGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUSzGmg2/DRuIuePfR1yEtC93q0ypMVUWjzZVghLGm6orDVUyaLGTSpgjInwTv+zOkBQJw/re3FlLeYvWDplsY7+2RTuK0KpQ4pCjMSu5x0Kc8UemsO87Esdso6E8Z16wEbQ4oL6O6G3BbsCv+G6WFl41+GulomykQuIFmeBXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PO4kerm3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PO4kerm3"
Received: (qmail 61646 invoked by uid 106); 19 Mar 2026 23:35:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=a2ciue+OHQ1VMEw/Yi9iG6C20/NyHEb3/U15oHydsGo=; b=PO4kerm30SlkMf7k6zR7nyMMBpJZ5WyxIl5tp0hob2dH0HEAf+XUmflIhAWrycUne2ph8g8QAOtdAMb+Z/Iqjaq2yhRpn/DpZAopFZM5xn0Fh7hcFqx/CQ1syH1SOnLdKuDTAvE1rGFPosV0ZTnlE5QfkvVl0/Jqi7qL4wdGUpwsuKHb8H8P6malX1j2Zw+WGlrxTCaiyx9aUO4rKLyr3ozVQw5bwEWraMf5dZOsmOwjrvRXshmklRs8SXio6AFbuM8euP2uHzJhWQWkqf74J1dvrgR/l6q0RO26EKV3LtYENKE835h31FlisP2HihynHfqBl4BacqGRMcMAIbRKjA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Mar 2026 23:35:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 90773 invoked by uid 111); 19 Mar 2026 23:35:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 19:35:46 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 19:35:46 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
Message-ID: <20260319233546.GA3632561@coredump.intra.peff.net>
References: <xmqq341wnvbk.fsf@gitster.g>
 <xmqqcy0zii0s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcy0zii0s.fsf@gitster.g>

On Thu, Mar 19, 2026 at 03:14:27PM -0700, Junio C Hamano wrote:

> One is in list-objects-filter-options.c::parse_list_objects_filter()
> 
>         void parse_list_objects_filter(
>                 struct list_objects_filter_options *filter_options,
>                 const char *arg)
>         {
>                 struct strbuf errbuf = STRBUF_INIT;
> 
>                 if (!filter_options->filter_spec.buf)
>                         BUG("filter_options not properly initialized");
> 
> The filter_options variable points at a list_objects_filter_options
> structure, which has an embedded "struct strbuf".  This BUG() is
> unnecessary if the structure is properly initialized, either by the
> LIST_OBJECTS_FILTER_INIT macro or a list_objects_filter_init() call.
> But it is easy to memset(&lofo, 0, sizeof(lofo)) or zero initialize
> with "= {0}", so I think it is OK to special case and allow for
> checking the possibility that .buf might be NULL.

Yeah, this is about catching _other_ code which accidentally violates
the invariant. I don't think there is any choice between special-casing
it or just removing the BUG() check. It is probably OK to do the latter
at this point. As part of the transition to LIST_OBJECTS_FILTER_INIT it
was a bigger risk, but that is less likely now. So I am OK either way.

> Because strbuf_getwholeline() discards what is originally in sb and
> replaces it with what getdelim() returns, I have a suspicion that
> working with bare char * and size_t to interact with getdelim() and
> then using strbuf_attach() on the success case would be simpler to
> read and maintain.  Once such a rewrite of this function is done
> (#leftoverbits), the special case we see in the Coccinelle rule can
> be lifted.

Hmm. I think that is something like this:

diff --git a/strbuf.c b/strbuf.c
index 3939863cf3..0333aea261 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -631,6 +631,8 @@ int strbuf_getcwd(struct strbuf *sb)
 #ifdef HAVE_GETDELIM
 int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
+	char *buf;
+	size_t alloc;
 	ssize_t r;
 
 	if (feof(fp))
@@ -639,12 +641,14 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	strbuf_reset(sb);
 
 	/* Translate slopbuf to NULL, as we cannot call realloc on it */
-	if (!sb->alloc)
-		sb->buf = NULL;
+	alloc = sb->alloc;
+	buf = alloc ? sb->buf : NULL;
 	errno = 0;
-	r = getdelim(&sb->buf, &sb->alloc, term, fp);
+	r = getdelim(&buf, &alloc, term, fp);
 
 	if (r > 0) {
+		sb->buf = buf;
+		sb->alloc = alloc;
 		sb->len = r;
 		return 0;
 	}
@@ -669,10 +673,13 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	 * we can just re-init, but otherwise we should make sure that our
 	 * length is empty, and that the result is NUL-terminated.
 	 */
-	if (!sb->buf)
+	if (!buf)
 		strbuf_init(sb, 0);
-	else
-		strbuf_reset(sb);
+	else {
+		sb->buf = buf;
+		sb->alloc = alloc;
+		strbuf_reset(&sb);
+	}
 	return EOF;
 }
 #else

So I don't know that it makes anything simpler. We have to copy the
values back into the strbuf either way, and we still have to handle
restoring the strbuf invariants. Even the strbuf_init() case is still
needed, because we don't know whether getdelim() just didn't allocate
(in which case we could leave the strbuf alone) or if it actually ate
the allocation we passed in (which was just a copy of sb->buf).

-Peff
