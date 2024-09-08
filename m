Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2823A1B5
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725838608; cv=none; b=PYPrLGebcjv8SUSWS2n7zVzE4/fD+PM3jRT4RSioj2BWEx70tOMPNsGabf3sGTJ9kAINRsb8PGSm8KEvSLgWpS0WpYdt5VVxQ2UL9kyVIkdN+trsFAdXxIyK1OYuKzm2VohMQmerkhHRU9lmLdFRna1yRqt5zc3m1mui15xyhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725838608; c=relaxed/simple;
	bh=WY80eP7FydcU5IG7iEhHWSkycZwn+id/ZgaJ25vbqi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rswZ+jHXZ4sShyxfdgZ1XoEWxoXHWtLN6b9lfMhLmlErUecEThcRw5x+FzsCpwHGRKb2ZmZhokpMeqHA+zcSqX+2NS1uLSLGYPDXZv0ISEzlcVWRYTfmHYbVE70sZtrK5IQzOmoOkP7wFp9flGg+nDc/B8ffZ11A6Cd71uNytS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22071 invoked by uid 109); 8 Sep 2024 23:36:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 08 Sep 2024 23:36:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14168 invoked by uid 111); 8 Sep 2024 23:36:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Sep 2024 19:36:36 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 8 Sep 2024 19:36:36 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: header signatures for hash transition?
Message-ID: <20240908233636.GA4026999@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi brian,

I'm trying to make sense of one of your commits from a few years ago.
I'm looking at ref-filter's find_subpos(), which parses a tag into
subject, body, and signature. Originally that was done by finding the
pointer location for each within the original buffer.

In 482c119186 (gpg-interface: improve interface for parsing tags,
2021-02-11), you replaced the parsing with parse_signature(), which
stuffs the payload and signature into separate strbufs. The rationale
there seems to be that in a multi-hash world, we'd store the signatures
for non-default hashes in the header, so we have to extra them from
there into a separate buffer.

So that makes sense, but...it doesn't look like parse_signature() parses
anything out of the headers. It still relies on parse_signed_buffer(),
which just loops over each line looking for get_format_by_sig(). And
that's just looking for "-----BEGIN" type messages, like we'd see in the
actual tag body.

Is this a direction that we were going to go in, but ultimately didn't?
Or is it something that just hasn't yet been fully implemented?

As an additional curiosity, this also won't find anything for signed
commits, which really are in the header. The "%(signature)" placeholder
handles this correctly, because it actually verified the signature. This
"subpos" stuff is all about "%(contents:signature)", etc, where you're
picking out the individual parts. I'm not sure if it is a bug that
"%(contents:signature)" doesn't show anything for a signed commit (it is
not part of the body contents in the same way, but AFAICT there is no
other way to format the literal signature).


The reason I stumbled upon all of this is that I need to use the subject
and buffer from find_subpos(), and the obvious way to do that is to use
"subpos" as a pointer, and "sigpos - subpos" as the length. But that
doesn't work after 482c119186, since "sigpos" is not pointing into the
same buffer anymore.

We still separately find the start of the in-body signature and return a
"size_t nonsiglen", though it's a bit awkward (it's counting from the
body start, and I am coming from the subject start, but if we assume
they're contiguous, it's just a little pointer math). So if this
approach is still useful in the long run, I can work around it. But my
initial approach (before digging in the history) was to drop the
separate buffer, something like the patch below, since it also drops
some useless extra copying of the tag contents.

And so I wanted to check with you on what the future plans are here.

-Peff

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
