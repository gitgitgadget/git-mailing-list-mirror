Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07A18D647
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839659; cv=none; b=QaDkMGLf/WqOby/Nlomov/7fUWhLNZyBkJSuzVJ/7I6s096/nojOU7iA4k+TnSOZXHiaMGYhdekJtMJYOdgOvQlrxozH0F2iDFWlY/HcgUrPFmvXh/cdke1DYN1Xwj9EwC9dkrgO5OQ6BBeGsKAQbMmS6xLJ98/hbM4FmPyukNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839659; c=relaxed/simple;
	bh=xQ7NKb3oJjUwBu6QKUbTJlAdSzABMkVijmtYX8CqTBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4tFcA2TUs9rH+hM/PqRvB4KawMYluytL4HUNG/HUjOVlyOkq7Ye7Xtdv9tlfR4ElZkfZpceUHiPdLcMOvOFQLxiHiWni9xmOnS4EuQsEvQBHpTsP7Lxhl572rdoZsUkK0jGbnTr7rZyKYvJcY/etP8FPYxj1az8/IlzEaEwTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FITC21nJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FITC21nJ"
Received: (qmail 513 invoked by uid 109); 25 Oct 2024 07:00:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xQ7NKb3oJjUwBu6QKUbTJlAdSzABMkVijmtYX8CqTBQ=; b=FITC21nJtVLzSLUr2VvlUi3mEICnRubq05ENVVehhUHDjWehdCo0aFwwBFt4vbICC7g9NZf+U9PdWzZ/6Htt/CJjJ8a1tISsSJDx5KR4LLalmIWJL+yspHnYmV91o9uJEiprbipb53fo72pjoDexKq2XDMWJkm5hvqnaJnFNPDwNY1QWUn9LzoFCx0TzBkl0+ZZS+Qr+Bbxwck4M8psOkLDSuxAOzZjiXC+dk12jbXuAyMfv7HVXSgdP+c4rRSiHQXNpsOQZwQ1VjLvvrRaGz11ycTG9ZwN/E2kkm2GYbcwguMlMq7XmzC26lpYyd/ngVhmY75kNDaiQ2iIzdxdAXg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 07:00:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12841 invoked by uid 111); 25 Oct 2024 07:00:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 03:00:56 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 03:00:55 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: [PATCH 05/11] packfile: drop sha1_pack_name()
Message-ID: <20241025070055.GE2110355@coredump.intra.peff.net>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025064148.GA2110169@coredump.intra.peff.net>

The sha1_pack_name() function has a few ugly bits:

  - it writes into a static strbuf (and not even a ring buffer of them),
    which can lead to subtle invalidation problems

  - it uses the term "sha1", but it's really using the_hash_algo, which
    could be sha256

There's only one caller of it left. And in fact that caller is better
off using the underlying odb_pack_name() function itself, since it's
just copying the result into its own strbuf anyway.

Converting that caller lets us get rid of this now-obselete function.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c     | 3 ++-
 packfile.c | 6 ------
 packfile.h | 7 -------
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/http.c b/http.c
index 03802b9049..510332ab04 100644
--- a/http.c
+++ b/http.c
@@ -2579,7 +2579,8 @@ struct http_pack_request *new_direct_http_pack_request(
 
 	preq->url = url;
 
-	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(packed_git_hash));
+	odb_pack_name(&preq->tmpfile, packed_git_hash, "pack");
+	strbuf_addstr(&preq->tmpfile, ".temp");
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
 		error("Unable to open local file %s for pack",
diff --git a/packfile.c b/packfile.c
index 0ead2290d4..48d650161f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -35,12 +35,6 @@ char *odb_pack_name(struct strbuf *buf,
 	return buf->buf;
 }
 
-char *sha1_pack_name(const unsigned char *sha1)
-{
-	static struct strbuf buf = STRBUF_INIT;
-	return odb_pack_name(&buf, sha1, "pack");
-}
-
 char *sha1_pack_index_name(const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
diff --git a/packfile.h b/packfile.h
index b4df3546a3..2bbcc58571 100644
--- a/packfile.h
+++ b/packfile.h
@@ -31,13 +31,6 @@ struct pack_entry {
  */
 char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
 
-/*
- * Return the name of the (local) packfile with the specified sha1 in
- * its name.  The return value is a pointer to memory that is
- * overwritten each time this function is called.
- */
-char *sha1_pack_name(const unsigned char *sha1);
-
 /*
  * Return the name of the (local) pack index file with the specified
  * sha1 in its name.  The return value is a pointer to memory that is
-- 
2.47.0.363.g6e72b256be

