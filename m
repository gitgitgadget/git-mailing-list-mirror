Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900CB18CBF0
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923689; cv=none; b=XGh6tey/4m1J0g6WUhwRyDj9tXyUJtp8NHmqv6vu90fhS3t0Aov4sGOwSX1aPHTViNbcntUKF7dsjCXWmMwtGkxXrAtttTbIQBNRdXAP+gHvNyG2yb3/TzEJQWFU8jKgguhXmO7P5zNtq3k4UkCJosKdr3rOBU7F4v2J2bOmQyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923689; c=relaxed/simple;
	bh=fXq9ROFAKuwTyESt0cQQyMmxnApP1zdpirZTc6rANLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N18BzrNuvRZe1B51UZA+seDUMll7jMsG8ln1PyhJ8Lx2FYlEO1N2OqphWgDY1DH51VLUGth8uarK16BkT7KyT0QlRLj4hsygXbaTiQbHHvGzq3fkt9SKPoLqBgXMv6gjOKZixBaDccdw910FJTqzc1t3pvIPdRXVZ+c3qte6TgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32209 invoked by uid 109); 9 Sep 2024 23:14:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:14:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24913 invoked by uid 111); 9 Sep 2024 23:14:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:14:46 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:14:45 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 3/9] ref-filter: strip signature when parsing tag trailers
Message-ID: <20240909231445.GC921834@coredump.intra.peff.net>
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

To expand the "%(trailers)" placeholder, we have to feed the commit or
tag body to the trailer API. But that API doesn't know anything about
signatures, and will be confused by a signed tag like this:

  the subject

  the body

  Some-trailer: foo
  -----BEGIN PGP SIGNATURE-----
  ...etc...

because it will start looking for trailers after the signature, and get
stopped walking backwards by the very non-trailer signature lines. So it
thinks there are no trailers.

This problem has existed since %(trailers) was added to the ref-filter
code, but back then trailers on tags weren't something we really
considered (commits don't have the same problem because their signatures
are embedded in the header). But since 066cef7707 (builtin/tag: add
--trailer option, 2024-05-05), we'd generate an object like the above
for "git tag -s --trailer 'Some-trailer: foo' my-tag".

The implementation here is pretty simple: we just make a NUL-terminated
copy of the non-signature part of the tag (which we've already parsed)
and pass it to the trailer API. There are some alternatives I rejected,
at least for now:

  - the trailer code already understands skipping past some cruft at the
    end of a commit, such as patch dividers. see find_end_of_log_message().
    We could teach it to do the same for signatures. But since this is
    the only context where we'd want that feature, and since we've already
    parsed the object into subject/body/signature here, it seemed easier
    to just pass in the truncated message.

  - it would be nice if we could just pass in a pointer/len pair to the
    trailer API (rather than a NUL-terminated string) to avoid the extra
    copy. I think this is possible, since as noted above, the trailer
    code already has to deal with ignoring some cruft at the end of the
    input. But after an initial attempt at this, it got pretty messy, as
    we have to touch a lot of intermediate functions that are also
    called in other contexts.

    So I went for the simple and stupid thing, at least for now. I don't
    think the extra copy overhead will be all that bad. The previous
    patch noted that an extra copy seemed to cause about 1-2% slowdown
    for something simple like "%(subject)". But here we are only
    triggering it for "%(trailers)" (and only when there is a
    signature), and the trailer code is a bit allocation-heavy already.
    I couldn't measure any difference formatting "%(trailers)" on
    linux.git before and after (even though there are not even any
    trailers to find).

Reported-by: Brooke Kuhlmann <brooke@alchemists.io>
Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c            | 10 +++++++++-
 t/t6300-for-each-ref.sh | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 0f5513ba7e..e39f505a81 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2008,9 +2008,17 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_TRAILERS) {
 			struct strbuf s = STRBUF_INIT;
+			const char *msg;
+			char *to_free = NULL;
+
+			if (siglen)
+				msg = to_free = xmemdupz(subpos, sigpos - subpos);
+			else
+				msg = subpos;
 
 			/* Format the trailer info according to the trailer_opts given */
-			format_trailers_from_commit(&atom->u.contents.trailer_opts, subpos, &s);
+			format_trailers_from_commit(&atom->u.contents.trailer_opts, msg, &s);
+			free(to_free);
 
 			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_BARE)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7c208e20a6..b830b542c4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1835,6 +1835,24 @@ sig_crlf="$(printf "%s" "$sig" | append_cr; echo dummy)"
 sig_crlf=${sig_crlf%dummy}
 test_atom refs/tags/fake-sig-crlf contents:signature "$sig_crlf"
 
+test_expect_success 'set up tag with signature and trailers' '
+	git tag -F - fake-sig-trailer <<-\EOF
+	this is the subject
+
+	this is the body
+
+	My-Trailer: foo
+	-----BEGIN PGP SIGNATURE-----
+
+	not a real signature, but we just care about the
+	subject/body/trailer parsing.
+	-----END PGP SIGNATURE-----
+	EOF
+'
+
+# use "separator=" here to suppress the terminating newline
+test_atom refs/tags/fake-sig-trailer trailers:separator= 'My-Trailer: foo'
+
 test_expect_success 'git for-each-ref --stdin: empty' '
 	>in &&
 	git for-each-ref --format="%(refname)" --stdin <in >actual &&
-- 
2.46.0.867.gf99b2b8e0f

