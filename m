Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816023CC7FA
	for <git@vger.kernel.org>; Tue, 12 May 2026 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603183; cv=none; b=ZLvNsSo9dKBlojeLe4qcafRgWdRh152yNcm9kzOVHD48kdJkDSIvC/8hKktmfniOZpgVHgi1pJAstO6333yto5RKPjqHZAQl5l8xiOgf7Iw1AS98EfN9rBhXJj/DkHDmRlXghhihfqMyI6MBJkaKHGra9F37Lzkub1kbvd70JpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603183; c=relaxed/simple;
	bh=oEtzFzxO5dQ9efMIhqHPVQ/kVEQgzsbezUmO12FMU1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A0beHDZDjylVFmut39ROZa7BHEc6x9/yqICB5r5M/l0GdNy+LGwIVWV7lHcqe3wgCWNfvMt4J/CFBp0C897xWwoyOifooKuauzY2P4cYgUJq4NQTMbZYDHJfclcFeKmYpt+X7Wg6RjjcSNaG1vA+ON8um6+g0tXyNU1pouuVLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gCjKPbEF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gCjKPbEF"
Received: (qmail 26663 invoked by uid 106); 12 May 2026 16:26:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=oEtzFzxO5dQ9efMIhqHPVQ/kVEQgzsbezUmO12FMU1o=; b=gCjKPbEFKjT0qQYrg+Ghzc7Vl105XCV82HZWK16ILeHKALBj6WGQfYYk0XeGZh+c/ZR3sGkWY2UvNEPJ+yIjuXcxgBsP1I98Oou6UooassUkvIPH8HqtCUtdEbrYGxbEa5oRdbo3uJG+4pIncI7y1fqQQDlWPz/sHaqbf29CWtlVydv9GulmV9TjjFJl64ygPWVAl3p4j8WmSZOFGmDtC5sNRZvhTkpxDykaWrUCDaNgis17Y9sLmLxpm9fIBWXixNN4Ti1jz7GFCjdCzCHYXIcLPNL+lpZN01Td1flyaJWVF0nxf4tTzQ3VYg08BOyP4PtCquLb8eA8MIRicuRtAg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 May 2026 16:26:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 50288 invoked by uid 111); 12 May 2026 16:26:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2026 12:26:19 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 May 2026 12:26:19 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: slonkazoid <slonkazoid@slonk.ing>
Subject: [PATCH] http: handle absolute-path alternates from server root
Message-ID: <20260512162619.GA69813@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When a dumb http server reports alternates with an absolute path, we try
to paste that onto the root of the URL we're trying to fetch from. So if
we go to "http://example.com/path/to/child.git" and it tells us about an
alternate at "/parent.git", we'll hit "http://example.com/parent.git".

But there's a bug in computing the base when the URL does not have any
path component at all, like "http://example.com". When looking for the
first slash after the host, strchr() returns NULL, and we compute a
nonsense value for the length of the host portion. And then when we use
that length to copy the base of the URL into a strbuf, we're likely to
fail.

The security implications are minimal here. We store the nonsense length
("serverlen") as an int, so on a 64-bit system it may effectively be
anything (it is zero minus a 64-bit heap pointer, then truncated to
32-bits and stuffed into a signed value). When we feed that length to
strbuf_add(), it is cast into a size_t and one of four things will
happen:

  1. If serverlen was negative, it will turn into a very large positive
     value and strbuf_add() will fail to allocate, ending the program.
     Ditto if serverlen was positive but just very large.

     This doesn't really get an attacker anything; the victim will just
     fail to clone their evil repo.

  2. If serverlen was small enough, we'll successfully extend the target
     strbuf, and then copy an arbitrary set of bytes from "base". And
     then one of these is true:

       a. That set of bytes is much larger than the length of the "base"
          string. This is an out-of-bounds read, but there's no
          out-of-bounds write, since the strbuf code both allocates and
          copies using the same size_t. This is likely to cause a
          segfault as we try to read unmapped pages of memory.

       b. Like (2a), but if the set of bytes is small enough we might
          not segfault. We might read random memory from the process and
          copy it into the "target" strbuf.

          What happens then? We know that "base" ends with a NUL
          terminator, which will be copied into "target" as well. So
          even though target.len might be 1000 bytes (or whatever), when
          interpreted as a NUL-terminated string, target.buf is still
          the exact same string as "base".

          And that's all we ever do with target: pass it around as a C
          string, and then eventually strbuf_detach() it to become a C
          string. So even though there was arbitrary memory copied into
          the strbuf, we never access it.

       c. The other interesting case is when serverlen is actually
          _shorter_ than the length of base. And there we truncate the
          string. Probably in a way that makes it totally invalid, but
          if you were very unlucky you could turn something like:

             http://victim.com.evil.domain:8000

          into:

            http://victim.com

	  Which looks like the start of a redirect attack, except that
	  the attacker could just have written "http://victim.com" in
	  the first place! Either way we feed it to
	  is_alternate_allowed(), which is where we check redirect and
	  protocol rules.

I think we can just treat this like a regular bug.

And it's quite a weird setup in the first place, as it implies that the
root of the web server is serving a repository (i.e., that you can get
something useful from "http://example.com/info/refs"). The bug has been
there since b3661567cf ([PATCH] Add support for alternates in HTTP,
2005-09-14) without anybody noticing.

I kind of doubt anybody really cares about making this work, but it's
easy enough to do so: the host-portion of the URL ends at either the
first slash or the end-of-string. So we can just replace strchr() with
strchrnul().

The test setup is a little gross, as we take over the httpd document
root by shoving our bare-repo components into it. But it demonstrates
the problem and shows that our solution actually allows the alternate to
function, if the server is configured to allow it.

Reported-by: slonkazoid <slonkazoid@slonk.ing>
Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c              |  2 +-
 t/t5550-http-fetch-dumb.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/http-walker.c b/http-walker.c
index 1b6d496548..f252de089f 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -268,7 +268,7 @@ static void process_alternates_response(void *callback_data)
 				 */
 				const char *colon_ss = strstr(base,"://");
 				if (colon_ss) {
-					serverlen = (strchr(colon_ss + 3, '/')
+					serverlen = (strchrnul(colon_ss + 3, '/')
 						     - base);
 					okay = 1;
 				}
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 9d0a7f5c4b..b0080bf204 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -555,4 +555,24 @@ test_expect_success 'dumb http can fetch index v1' '
 	git -C idx-v1 fsck
 '
 
+test_expect_success 'absolute-path alternate when url has no path' '
+	src=$HTTPD_DOCUMENT_ROOT_PATH/repo.git &&
+	alt=absolute-alt.git &&
+	git clone --bare --shared "$src" "$alt" &&
+
+	# Our repo has an alternate pointing to the absolute filesystem path,
+	# but that will not make any sense to an http client. So we will
+	# manually give it the equivalent path that the http server will
+	# understand.
+	echo "/dumb/repo.git/objects" >"$alt/objects/info/http-alternates" &&
+
+	# Now make our alt repository available at the root of the http
+	# server without any path (i.e., just http://localhost:1234).
+	git -C "$alt" update-server-info &&
+	mv absolute-alt.git/* "$HTTPD_DOCUMENT_ROOT_PATH" &&
+
+	git -c http.followRedirects=true clone "$HTTPD_URL" alt-clone.git 2>err &&
+	test_grep "adding alternate object store: $HTTPD_URL/dumb/repo.git" err
+'
+
 test_done
-- 
2.54.0.420.gf0bcdff42b
