Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E265227
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729392026; cv=none; b=k4sD5ABM8mbga5m16ckDLn1rpS6Vl159CJSvg/tEtWg4av3yhsFAhLO1x7pzEIZmfl/hqzw+k9ZC2asckH2bpclSkWVR3AfpYpsDNvWDyOs1HIujYZcCKq/EjtNudxf8g0+iEmIFIdlGhGoGl5p5C3WfYaUs9bbuu+r18T8uU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729392026; c=relaxed/simple;
	bh=LTUV0gSFCdyOLxacYH4Cg804k7PMnBTGzHiXcb3BDcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2bvkiCzgNpNqo7IfRhQ1+0j2Vay3+0/wkEOnp/TR3WOqlFkD6hdi6EN6Em8VUNgJy8diWMDYKJ4V+UblPkHIOaHE4UorFFNNaLFQJ3z/Efat6NxUbaq8UHZfmF16LShaAqwbKmxFcpuAbzbdSYbg1gR0XLDQ9YcxzKljoDqm10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iFfDeasJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iFfDeasJ"
Received: (qmail 16993 invoked by uid 109); 20 Oct 2024 02:40:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LTUV0gSFCdyOLxacYH4Cg804k7PMnBTGzHiXcb3BDcI=; b=iFfDeasJiroX/bqFnJiHP+SgqMdjALw915oNYxZJUyWbe7AHzVTVDLXoIF1jqUR3PgcFa1j1IRztjpbPxiVSWJfHlCFgfdS0cs2wn7WKwgXvH9u17tiL0ZhU+Up7U3p5hjOYZOB1qwQ7ihs3AtVDoksVzKz9rk4QhZMsqAq0PrmRZUhhA9t/CiHCfJd8qH8rMh0PT9pF/nkSqEX4TuBdq1fJ6jZB3pdOkBRQr0LR+Wrak8eIA3dmJlFQBqy04QRKrka7ca0ZTpBBGM3n2eIcap3hd+xx9i92hy8Uk06QAySvbP2XCmlH98n4yu7lK75ywTSbmzu7p/90ZS0cHEVXiQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 20 Oct 2024 02:40:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8185 invoked by uid 111); 20 Oct 2024 02:40:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Oct 2024 22:40:22 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Oct 2024 22:40:22 -0400
From: Jeff King <peff@peff.net>
To: fox <fox.gbr@townlong-yak.com>
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: Bug report: v2.47.0 cannot fetch version 1 pack indexes
Message-ID: <20241020024022.GA615104@coredump.intra.peff.net>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
 <20241020012455.GA599236@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020012455.GA599236@coredump.intra.peff.net>

On Sat, Oct 19, 2024 at 09:24:55PM -0400, Jeff King wrote:

> So I feel like the root of the problem is that we moved the other side's
> "pack-1234abcd.idx" into place at all! We do not plan to use it, but
> only need to access it via our custom packed_git structs to see whether
> we want to download the matching pack. And in fact I'd suspect there are
> other possible bugs/trickery lurking, if the other side gives us a
> broken .idx that does not match its pack (our odb would now have the
> broken file with no matching pack).
> 
> So IMHO a cleaner fix is that we should keep the stuff we download from
> the remote marked as temporary files, and then throw them away when we
> complete the fetch (rather than just expecting index-pack to overwrite
> them).

And here's what that might look like. It stores the temporary index
outside of the pack/ directory, and then we don't "finalize" it into
place. We have to teach parse_pack to retain the original name, but
that's OK. It's used only by the http walker anyway.

diff --git a/http.c b/http.c
index d59e59f66b..6df032e40f 100644
--- a/http.c
+++ b/http.c
@@ -19,6 +19,7 @@
 #include "string-list.h"
 #include "object-file.h"
 #include "object-store-ll.h"
+#include "tempfile.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
@@ -2388,8 +2389,24 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
 	strbuf_addf(&buf, "objects/pack/pack-%s.idx", hash_to_hex(hash));
 	url = strbuf_detach(&buf, NULL);
 
-	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(hash));
-	tmp = strbuf_detach(&buf, NULL);
+	/*
+	 * Don't put this into packs/, since it's just temporary and we don't
+	 * want to confuse it with our local .idx files.  We'll generate our
+	 * own index if we choose to download the matching packfile.
+	 *
+	 * It's tempting to use xmks_tempfile() here, but it's important that
+	 * the file not exist, otherwise http_get_file() complains. So we
+	 * create a filename that should be unique, and then just register it
+	 * as a tempfile so that it will get cleaned up on exit.
+	 *
+	 * Arguably it would be better to hold on to the tempfile handle so
+	 * that we can remove it as soon as we download the pack and generate
+	 * the real index, but that might need more surgery.
+	 */
+	tmp = xstrfmt("%s/tmp_pack_%s.idx",
+		      repo_get_object_directory(the_repository),
+		      hash_to_hex(hash));
+	register_tempfile(tmp);
 
 	if (http_get_file(url, tmp, NULL) != HTTP_OK) {
 		error("Unable to get pack index %s", url);
@@ -2427,10 +2444,8 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	}
 
 	ret = verify_pack_index(new_pack);
-	if (!ret) {
+	if (!ret)
 		close_pack_index(new_pack);
-		ret = finalize_object_file(tmp_idx, sha1_pack_index_name(sha1));
-	}
 	free(tmp_idx);
 	if (ret)
 		return -1;
diff --git a/packfile.c b/packfile.c
index df4ba67719..16d3bcf7f7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -237,13 +237,22 @@ static struct packed_git *alloc_packed_git(int extra)
 	return p;
 }
 
+static char *pack_path_from_idx(const char *idx_path)
+{
+	size_t len;
+	if (!strip_suffix(idx_path, ".idx", &len))
+		BUG("idx path does not end in .idx: %s", idx_path);
+	return xstrfmt("%.*s.pack", (int)len, idx_path);
+}
+
 struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 {
-	const char *path = sha1_pack_name(sha1);
+	char *path = pack_path_from_idx(idx_path);
 	size_t alloc = st_add(strlen(path), 1);
 	struct packed_git *p = alloc_packed_git(alloc);
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
+	free(path);
 	hashcpy(p->hash, sha1, the_repository->hash_algo);
 	if (check_packed_git_idx(idx_path, p)) {
 		free(p);
