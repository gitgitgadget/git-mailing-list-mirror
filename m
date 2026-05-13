Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F13A783D
	for <git@vger.kernel.org>; Wed, 13 May 2026 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698457; cv=none; b=N3TkQAgFLDo42D3aCaX6qwoakzl5Gnsk/FD279tt0+tEJ12CZtW6Ng79Thj918w6tViNKEET3pjD36BCnd4mBLkfOkvEaSZ2p+idCAgQ1biqbBDn4lXoFLc0yjGjxKq45Ht1azLa8jjeEpmrA3Ukg9F9NIN7RAPa+nVd3Oie/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698457; c=relaxed/simple;
	bh=Zl2j62kC95JS14OSuhRQC65DgAbJwUrYwuQV6J1vLtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8P/wYtwHXuhc62LXRI/hwv+m41UWfWvFsAqitgJOIJD2rfOAiCTcnQxIUVSi3ycsMte0vqKbmiv+Bq3RJQ61C7oQoL3duJbaIOH0Zdn6C56AofCjUZ91bw/lK+Oq/Pw0ZjM9nLHUvNUlqNzzbcm7cVRp0lVXX1yi5GKf+X6bsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=igr6KaDB; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="igr6KaDB"
Received: (qmail 40145 invoked by uid 106); 13 May 2026 18:54:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Zl2j62kC95JS14OSuhRQC65DgAbJwUrYwuQV6J1vLtA=; b=igr6KaDBGN3JfUrBLa3e4+3OI2ZmrDjI/+/1HJmxyTPuW824eU/sJG0kzTItlkuES5JqFKiob1Y4RUHp+Cvul9RQZunxeeR7G2Jl1i4qMFokmJguv03nhrfZdDqJ9znX91Ec9285pWkGZjrC90zz7fP4+6gTyiabiWnMfB7HUNLG/Pk1OKIWgieMQZsdjGcQrvVAllQWteSSw4Duk8eC0f0bLnBIXM5ftivGpXe/6DidKN4inJA5jHTxytS/iIiSdcok0hsakbEfoUM27lv+pHbDEs0nHuVLjKzWYi1j44EuAJ1Bx0k25jdodlCELnVdE4PxIL9SfNaP4zddjBGExw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 May 2026 18:54:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 68671 invoked by uid 111); 13 May 2026 18:54:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2026 14:54:09 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 May 2026 14:54:08 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Luke Martin <lmartin@paramenoeng.com>
Subject: Re: [PATCH] pretty: drop strbuf pre-sizing from add_rfc2047()
Message-ID: <20260513185408.GA147423@coredump.intra.peff.net>
References: <20260512162022.GA69669@coredump.intra.peff.net>
 <xmqqtsscjf30.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtsscjf30.fsf@gitster.g>

On Wed, May 13, 2026 at 10:03:31AM +0900, Junio C Hamano wrote:

> Someday we may want to go through the output from
> 
>     $ git grep -e 'strbuf_grow(' \*.c
> 
> and remove this ineffective presizing.  I think any call to
> strbuf_grow() that is immediately followed by a call to
> strbuf_addX() is suspect, like in the following illustration (there
> are others in these files).

Yup. I think this could be #leftoverbits material, but anybody who wants
to pick this up should be careful to read through the whole function and
make sure there's no subtle dependency on the grown buffer.

Skimming through, it looks like most are just leftovers from when old
code was converted to strbuf, and the pre-growth was kept mostly out of
conservatism.

Some of them are truly ugly to look at, like:

  http-backend.c: strbuf_grow(&buf, cnt * 53 + 2);

and I think in some cases we can even drop some surrounding code, like:

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 070a5af3e4..aa32ebc8ab 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1337,21 +1337,14 @@ static int tecmp1 (const void *_a, const void *_b)
 
 static void mktree(struct tree_content *t, int v, struct strbuf *b)
 {
-	size_t maxlen = 0;
 	unsigned int i;
 
 	if (!v)
 		QSORT(t->entries, t->entry_count, tecmp0);
 	else
 		QSORT(t->entries, t->entry_count, tecmp1);
 
-	for (i = 0; i < t->entry_count; i++) {
-		if (t->entries[i]->versions[v].mode)
-			maxlen += t->entries[i]->name->str_len + 34;
-	}
-
 	strbuf_reset(b);
-	strbuf_grow(b, maxlen);
 	for (i = 0; i < t->entry_count; i++) {
 		struct tree_entry *e = t->entries[i];
 		if (!e->versions[v].mode)

So probably some satisfying cleanup opportunities available for somebody
who wants to spend a little time with it. ;)

-Peff
