Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53661B0F03
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839491; cv=none; b=n8UiQ5MJLlTBJ5SvwR9qHVHRkEyCjqJJYNp+ejoT1jtxJHpVA9em2U83OKssEYXSxd0EPvsYOmElVVH7tcvSYNF6Q+F6Ql/GfDzF8hXUBwnY01uJ5d8PjijTdAzFxLG2dIhjWoNrw3kPfCs08HBb+2VOg+s1vK8T1PZcO6bG22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839491; c=relaxed/simple;
	bh=O7r3qvrXpR3keAF3q9i5XGknj11Jas45RtWCVeZdwtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU+gml4ZK+CIJSrbr5MY3ovGIhE9tAK40AIcdghF4szxdjipIzWQKX5KBZri7B6dsXcS6haqTudIIJG1Im9LE1dR7PPf8lxWadwzLM8gvK9tkeQCxk6s41KRM9FrBhV3Xx4fzqdC/rfZSramLyc4jpPVEzzpDXaSpZbFQRb3NGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NDBnP53L; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NDBnP53L"
Received: (qmail 484 invoked by uid 109); 25 Oct 2024 06:58:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=O7r3qvrXpR3keAF3q9i5XGknj11Jas45RtWCVeZdwtA=; b=NDBnP53LrZEcfJrdF/iTl1RxYpXuXufQhqelOHtB9mnV3Af+yzaSjqCnN0ASMyTTTZBnnjDWVNpu5F1erZCdYZ0A9Qh/MVXLuiYjmuekPcrlX2fqEv0VGkSVNfzDjbpFJ+y1MI4jgzcKmHFx7EPcC2Fyq6a3eUrsfWAaeF7LssdoxUN7fVrLLwNIeO7DaVmG/9BSdKR352oAqjLXPDD5q5p8AKARwhQ9r9OHcCtHy0JY1+hmGz8ln6wSUGDkFPs7MDkTaclpKasew1B/oL5Mgt0lMZgU5/tSTZdxpuZ9kQVl+pCW2VbbJALbqjWvBP8EY9oIfSWuoKvYSlyVMa1vzQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 06:58:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12790 invoked by uid 111); 25 Oct 2024 06:58:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 02:58:06 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 02:58:06 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: [PATCH 03/11] dumb-http: store downloaded pack idx as tempfile
Message-ID: <20241025065806.GC2110355@coredump.intra.peff.net>
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

This patch fixes a regression in b1b8dfde69 (finalize_object_file():
implement collision check, 2024-09-26) where fetching a v1 pack idx file
over the dumb-http protocol would cause the fetch to fail.

The core of the issue is that dumb-http stores the idx we fetch from the
remote at the same path that will eventually hold the idx we generate
from "index-pack --stdin". The sequence is something like this:

  0. We realize we need some object X, which we don't have locally, and
     nor does the other side have it as a loose object.

  1. We download the list of remote packs from objects/info/packs.

  2. For each entry in that file, we download each pack index and store
     it locally in .git/objects/pack/pack-$hash.idx (the $hash is not
     something we can verify yet and is given to us by the remote).

  3. We check each pack index we got to see if it has object X. When we
     find a match, we download the matching .pack file from the remote
     to a tempfile. We feed that to "index-pack --stdin", which
     reindexes the pack, rather than trusting that it has what the other
     side claims it does. In most cases, this will end up generating the
     exact same (byte-for-byte) pack index which we'll store at the same
     pack-$hash.idx path, because the index generation and $hash id are
     computed based on what's in the packfile. But:

       a. The other side might have used other options to generate the
          index. For instance we use index v2 by default, but long ago
          it was v1 (and you can still ask for v1 explicitly).

       b. The other side might even use a different mechanism to
          determine $hash. E.g., long ago it was based on the sorted
          list of objects in the packfile, but we switched to using the
          pack checksum in 1190a1acf8 (pack-objects: name pack files
          after trailer hash, 2013-12-05).

The regression we saw in the real world was (3a). A recent client
fetching from a server with a v1 index downloaded that index, then
complained about trying to overwrite it with its own v2 index. This
collision is otherwise harmless; we know we want to replace the remote
version with our local one, but the collision check doesn't realize
that.

There are a few options to fix it:

  - we could teach index-pack a command-line option to ignore only pack
    idx collisions, and use it when the dumb-http code invokes
    index-pack. This would be an awkward thing to expose users to and
    would involve a lot of boilerplate to get the option down to the
    collision code.

  - we could delete the remote .idx file right before running
    index-pack. It should be redundant at that point (since we've just
    downloaded the matching pack). But it feels risky to delete
    something from our own .git/objects based on what the other side has
    said. I'm not entirely positive that a malicious server couldn't lie
    about which pack-$hash.idx it has and get us to delete something
    precious.

  - we can stop co-mingling the downloaded idx files in our local
    objects directory. This is a slightly bigger change but I think
    fixes the root of the problem more directly.

This patch implements the third option. The big design questions are:
where do we store the downloaded files, and how do we manage their
lifetimes?

There are some additional quirks to the dumb-http system we should
consider. Remember that in step 2 we downloaded every pack index, but in
step 3 we may only download some of the matching packs. What happens to
those other idx files now? They sit in the .git/objects/pack directory,
possibly waiting to be used at a later date. That may save bandwidth for
a subsequent fetch, but it also creates a lot of weird corner cases:

  - our local object directory now has semi-untrusted .idx files sitting
    around, without their matching .pack

  - in case 3b, we noted that we might not generate the same hash as the
    other side. In that case even if we download the matching pack,
    our index-pack invocation will store it in a different
    pack-$hash.idx file. And the unmatched .idx will sit there forever.

  - if the server repacks, it may delete the old packs. Now we have
    these orphaned .idx files sitting around locally that will never be
    used (nor deleted).

  - if we repack locally we may delete our local version of the server's
    pack index and not realize we have it. So we'll download it again,
    even though we have all of the objects it mentions.

I think the right solution here is probably some more complex cache
management system: download the remote .idx files to their own storage
directory, mark them as "seen" when we get their matching pack (to avoid
re-downloading even if we repack), and then delete them when the
server's objects/info/refs no longer mentions them.

But since the dumb http protocol is so ancient and so inferior to the
smart http protocol, I don't think it's worth spending a lot of time
creating such a system. For this patch I'm just downloading the idx
files to .git/objects/tmp_pack_*, and marking them as tempfiles to be
deleted when we exit (and due to the name, any we miss due to a crash,
etc, should eventually be removed by "git gc" runs based on timestamps).

That is slightly worse for one case: if we download an idx but not the
matching pack, we won't retain that idx for subsequent runs. But the
flip side is that we're making other cases better (we never hold on to
useless idx files forever). I suspect that worse case does not even come
up often, since it implies that the packs are generated to match
distinct parts of history (i.e., in practice even in a repo with many
packs you're going to end up grabbing all of those packs to do a clone).
If somebody really cares about that, I think the right path forward is a
managed cache directory as above, and this patch is providing the first
step in that direction anyway (by moving things out of the objects/pack/
directory).

There are two test changes. One demonstrates the broken v1 index case
(it double-checks the resulting clone with fsck to be careful, but prior
to this patch it actually fails at the clone step). The other tweaks the
expectation for a test that covers the "slightly worse" case to
accommodate the extra index download.

The code changes are fairly simple. We stop using finalize_object_file()
to copy the remote's index file into place, and leave it as a tempfile.
We give the tempfile a real ".idx" name, since the packfile code expects
that, and thus we make sure it is out of the usual packs/ directory (so
we'd never mistake it for a real local .idx).

We also have to change parse_pack_index(), which creates a temporary
packed_git to access our index (we need this because all of the pack idx
code assumes we have that struct). It reads the index data from the
tempfile, but prior to this patch would speculatively write the
finalized name into the packed_git struct using the pack-$hash we expect
to use.

I was mildly surprised that this worked at all, since we call
verify_pack_index() on the packed_git which mentions the final name
before moving the file into place! But it works because
parse_pack_index() leaves the mmap-ed data in the struct, so the
lazy-open in verify_pack_index() never triggers, and we read from the
tempfile, ignoring the filename in the struct completely. Hacky, but it
works.

After this patch, parse_pack_index() now uses the index filename we pass
in to derive a matching .pack name. This is OK to change because there
are only two callers, both in the dumb http code (and the other passes
in an existing pack-$hash.idx name, so the derived name is going to be
pack-$hash.pack, which is what we were using anyway).

I'll follow up with some more cleanups in that area, but this patch is
sufficient to fix the regression.

Reported-by: fox <fox.gbr@townlong-yak.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 http.c                     | 25 ++++++++++++++++++++-----
 packfile.c                 | 11 ++++++++++-
 t/t5550-http-fetch-dumb.sh | 12 +++++++++++-
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index d59e59f66b..9642cad2e3 100644
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
+	 * In theory we could hold on to the tempfile and delete these as soon
+	 * as we download the matching pack, but it would take a bit of
+	 * refactoring. Leaving them until the process ends is probably OK.
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
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 3968b82260..706540ab74 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -335,7 +335,7 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
 	count_fetches 1 pack one.trace &&
 	GIT_TRACE_CURL=$PWD/two.trace git --git-dir=clone_packed_branches.git \
 		fetch "$HTTPD_URL"/dumb/repo_packed_branches.git branch2:branch2 &&
-	count_fetches 0 idx two.trace &&
+	count_fetches 1 idx two.trace &&
 	count_fetches 1 pack two.trace
 '
 
@@ -521,4 +521,14 @@ test_expect_success 'fetching via http alternates works' '
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
-- 
2.47.0.363.g6e72b256be

