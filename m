Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F588F5A
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923551; cv=none; b=Wce//og1d0l4MZ1x0e5qc/JIHRIBuFuvoQ1/MmxfmseonfbR9Qz/whmG/kG6Vqnh8dDH2eVZBbgRKEvYNmxq9KgNDQTmyW9a5YKcG2B7GQOS6IJHmACYOmDsyusPqTJOyhMIQ0IB1d89QM7EeqHzfYmYQewW5mMJVoujWXHGkzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923551; c=relaxed/simple;
	bh=6MAOrnPxgiYCabUVPkogXuNIk3fdOZxc+cCvMD2n1lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVxsmzFQfxiUwF4kWNogNVRduFJ0GDLLeWtsqcGxdcpG0F4TTk4FmwB2B374QsWf46eEMNdprZPpk0B+vXjNo2g31NkRL+K0nG8O/THzKErJfWYDqsGizGlbk+2Zm4jcYDqG0IkQtYZpEPqhBSTLTHJp6M9/TpHcN9uSZkKS6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32201 invoked by uid 109); 9 Sep 2024 23:12:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:12:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24904 invoked by uid 111); 9 Sep 2024 23:12:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:12:28 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:12:28 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 2/9] ref-filter: avoid extra copies of payload/signature
Message-ID: <20240909231228.GB921834@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909230758.GA921697@coredump.intra.peff.net>

When we know we're going to show the subject or body of a tag or commit,
we call find_subpos(), which returns pointers and lengths for the three
parts: subject, body, signature.

Oddly, the function finds the signature twice: once by calling
parse_signature() at the start, which copies the signature into a
separate strbuf, and then again by calling parse_signed_buffer() after
we've parsed past the subject.

This is due to 482c119186 (gpg-interface: improve interface for parsing
tags, 2021-02-11) and 88bce0e24c (ref-filter: hoist signature parsing,
2021-02-11). The idea is that in a multi-hash world, tag signatures may
appear in the header, rather than at the end of the body, in which case
we need to extract them into a separate buffer.

But parse_signature() would never find such a buffer! It only looks for
signature lines (like "-----BEGIN PGP") at the start of each line,
without any header keyword. So this code will never find anything except
the usual in-body signature.

And the extra code has two downsides:

  1. We spend time copying the payload and signature into strbufs. That
     might even be useful if we ended up with a NUL-terminated copy of
     the payload data, but we throw it away immediately. And the
     signature, since it comes at the end of the message, is already its
     own NUL-terminated buffer.

     The overhead isn't huge, but I measured a pretty consistent 1-2%
     speedup running "git for-each-ref --format='%(subject)'" with this
     patch on a clone of linux.git.

  2. The output of find_subpos() is a set of three ptr/len combinations,
     but only two of them point into the original buffer. This makes the
     interface confusing: you can't do pointer comparisons between them,
     and you have to remember to free the signature buffer. Since
     there's only one caller, it's not too bad in practice, but it did
     bite me while working on the next patch (and simplifying it will
     pave the way for that).

In the long run we might have to go back to something like this
approach, if we do have multi-hash header signatures. But I would argue
that the extra buffer should kick in only for a header signature, and be
passed out of find_subpos() separately.

Signed-off-by: Jeff King <peff@peff.net>
---
This should produce no behavior change.

It does seem funny to me that we do this signature parsing for commits
as well as tags, even through the former would have an in-header
signature. So arguably we are wrongly cutting in-body signatures from
commits, and not showing their signatures with %(contents:signature).
(But note that %(signature) is its own thing and does handle commits
correctly).

So I don't know if we'd want to fix that or not, but I left it as-is in
this series. And as I said above, if we did want to go that way, I think
we'd still want to build it on top of this, so that find_subpos()
returns the in-header and in-body signatures separately.

 ref-filter.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index b6c6c10127..0f5513ba7e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1833,16 +1833,10 @@ static void find_subpos(const char *buf,
 			size_t *nonsiglen,
 			const char **sig, size_t *siglen)
 {
-	struct strbuf payload = STRBUF_INIT;
-	struct strbuf signature = STRBUF_INIT;
 	const char *eol;
 	const char *end = buf + strlen(buf);
 	const char *sigstart;
 
-	/* parse signature first; we might not even have a subject line */
-	parse_signature(buf, end - buf, &payload, &signature);
-	strbuf_release(&payload);
-
 	/* skip past header until we hit empty line */
 	while (*buf && *buf != '\n') {
 		eol = strchrnul(buf, '\n');
@@ -1853,8 +1847,10 @@ static void find_subpos(const char *buf,
 	/* skip any empty lines */
 	while (*buf == '\n')
 		buf++;
-	*sig = strbuf_detach(&signature, siglen);
+	/* parse signature first; we might not even have a subject line */
 	sigstart = buf + parse_signed_buffer(buf, strlen(buf));
+	*sig = sigstart;
+	*siglen = end - *sig;
 
 	/* subject is first non-empty line */
 	*sub = buf;
@@ -2021,7 +2017,6 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 			v->s = xstrdup(subpos);
 
 	}
-	free((void *)sigpos);
 }
 
 /*
-- 
2.46.0.867.gf99b2b8e0f

