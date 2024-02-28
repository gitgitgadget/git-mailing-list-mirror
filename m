Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E972901
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159946; cv=none; b=Qroho/uzy3XFE4dhzOC3DwJK7wDJGcmnS96pNNmwCaw2/X9ZPkT7cigKm88MJl8ZZXfPkACA4ZDXr9iWF0Gz/yElpZQFg78zDDkcjSJWbTnNQN9k/z2f2X2ZSJaEyHddJzgwdRdhrY33/eifN/gA1nWzIsm/JvvSBLkuWgQkxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159946; c=relaxed/simple;
	bh=dbN9V07IWnBoag/Ik/bUumQRTkZT6D9cJTlBymnP4kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmaQmIXjK1Tqm9ILA+Arrbwm7FY511T8i91L6PZpmp0FQsMFPzCeQa09m3TAQa6kvoYP/V3wSHB+W1Sv0UTFlFO62wADaXg2Z5Bwr+MXzGffqvhTFuFTJAnBIP0P2r6hQ1s0NOcve2gvfvLka7+lioQMptaltfwvhmqcBga/+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23698 invoked by uid 109); 28 Feb 2024 22:39:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:39:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26776 invoked by uid 111); 28 Feb 2024 22:39:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:39:06 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:39:03 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benjamin Flesch <benjaminflesch@icloud.com>
Subject: [PATCH 8/9] upload-pack: use PARSE_OBJECT_SKIP_HASH_CHECK in more
 places
Message-ID: <20240228223903.GH1158131@coredump.intra.peff.net>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228223700.GA1157826@coredump.intra.peff.net>

In commit 0bc2557951 (upload-pack: skip parse-object re-hashing of
"want" objects, 2022-09-06), we optimized the parse_object() calls for
v2 "want" lines from the client so that they avoided parsing blobs, and
so that they used the commit-graph rather than parsing commit objects
from scratch.

We should extend that to two other spots:

  1. We parse "have" objects in the got_oid() function. These won't
     generally be non-commits (unlike "want" lines from a partial
     clone). But we still benefit from the use of the commit-graph.

  2. For v0, the "want" lines are parsed in receive_needs(). These are
     also less likely to be non-commits because by default they have to
     be ref tips. There are config options you might set to allow
     non-tip objects, but you'd mostly do so to support partial clones,
     and clients recent enough to support partial clone will generally
     speak v2 anyway.

So I don't expect this change to improve performance much for day-to-day
operations. But both are possible denial-of-service vectors, where an
attacker can waste our time by sending over a large number of objects to
parse (of course we may waste even more time serving a pack to them, but
we try as much as possible to optimize that in pack-objects; we should
do what we can here in upload-pack, too).

With this patch, running p5600 with GIT_TEST_PROTOCOL_VERSION=0 shows
similar results to what we saw in 0bc2557951 (which ran with the v2
protocol by default). Here are the numbers for linux.git:

  Test                          HEAD^                 HEAD
  -----------------------------------------------------------------------------
  5600.3: checkout of result    50.91(87.95+2.93)     41.75(79.00+3.18) -18.0%

Or for a more extreme (and malicious) case, we can claim to "have" every
blob in git.git over the v0 protocol:

  $ {
      echo "0032want $(git rev-parse HEAD)"
      printf 0000
      git cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype)' |
      perl -alne 'print "0032have $F[0]" if $F[1] eq "blob"'
    } >input

  $ time ./git.old upload-pack . <input >/dev/null
  real	0m52.951s
  user	0m51.633s
  sys	0m1.304s

  $ time ./git.new upload-pack . <input >/dev/null
  real	0m0.261s
  user	0m0.156s
  sys	0m0.105s

(Note that these don't actually compute a pack because of the hacky
protocol usage, so those numbers are representing the raw blob-parsing
effort done by upload-pack).

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3970bb9b30..b721155442 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -469,7 +469,8 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid)
 {
 	int we_knew_they_have = 0;
-	struct object *o = parse_object(the_repository, oid);
+	struct object *o = parse_object_with_flags(the_repository, oid,
+						   PARSE_OBJECT_SKIP_HASH_CHECK);
 
 	if (!o)
 		die("oops (%s)", oid_to_hex(oid));
@@ -1148,7 +1149,8 @@ static void receive_needs(struct upload_pack_data *data,
 			free(client_sid);
 		}
 
-		o = parse_object(the_repository, &oid_buf);
+		o = parse_object_with_flags(the_repository, &oid_buf,
+					    PARSE_OBJECT_SKIP_HASH_CHECK);
 		if (!o) {
 			packet_writer_error(&data->writer,
 					    "upload-pack: not our ref %s",
-- 
2.44.0.rc2.424.gbdbf4d014b

