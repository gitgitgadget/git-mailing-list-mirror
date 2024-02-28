Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F61361C0
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159950; cv=none; b=hf5aJpPPbbWkl2zgcWtIm2yEw5XDKz4r3q6RtlBiav9GUmx7kumLxWHyA9CFbbMc99GS+USx1scsK5AkDeV5+Ji2b0TmKsfMMUY5vf9SUYs0VfKyFUGjK6ZcCLCKyVlDWWHBlKDgM11ZDHAKMXC/5uCzoITxOo6u6XdmKxKpymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159950; c=relaxed/simple;
	bh=y8Mg0SOh8gXbtzmQ4zGRKaha4hpjP+WfRC0Pt7DLW88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOwBAeU2rtLLgg9ARtPUhj0MW0WL8IfAU32pLriTLzPkdsumLoQE9JfLuOqV4CpIUx5V35HSaKy3BH8AhPumtDyhi4lZpZiSPyoreAeLJS4e0/4YQXL8QvkqPfp9IrbOErdkZ2PZug1AzvKpAEIV/CwstU6qBDdM0aBRusEnAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23704 invoked by uid 109); 28 Feb 2024 22:39:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:39:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26780 invoked by uid 111); 28 Feb 2024 22:39:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:39:10 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:39:07 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benjamin Flesch <benjaminflesch@icloud.com>
Subject: [PATCH 9/9] upload-pack: free tree buffers after parsing
Message-ID: <20240228223907.GI1158131@coredump.intra.peff.net>
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

When a client sends us a "want" or "have" line, we call parse_object()
to get an object struct. If the object is a tree, then the parsed state
means that tree->buffer points to the uncompressed contents of the tree.
But we don't really care about it. We only really need to parse commits
and tags; for trees and blobs, the important output is just a "struct
object" with the correct type.

But much worse, we do not ever free that tree buffer. It's not leaked in
the traditional sense, in that we still have a pointer to it from the
global object hash. But if the client requests many trees, we'll hold
all of their contents in memory at the same time.

Nobody really noticed because it's rare for clients to directly request
a tree. It might happen for a lightweight tag pointing straight at a
tree, or it might happen for a "tree:depth" partial clone filling in
missing trees.

But it's also possible for a malicious client to request a lot of trees,
causing upload-pack's memory to balloon. For example, without this
patch, requesting every tree in git.git like:

  pktline() {
    local msg="$*"
    printf "%04x%s\n" $((1+4+${#msg})) "$msg"
  }

  want_trees() {
    pktline command=fetch
    printf 0001
    git cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype)' |
      while read oid type; do
        test "$type" = "tree" || continue
        pktline want $oid
      done
      pktline done
      printf 0000
  }

  want_trees | GIT_PROTOCOL=version=2 valgrind --tool=massif ./git upload-pack . >/dev/null

shows a peak heap usage of ~3.7GB. Which is just about the sum of the
sizes of all of the uncompressed trees. For linux.git, it's closer to
17GB.

So the obvious thing to do is to call free_tree_buffer() after we
realize that we've parsed a tree. We know that upload-pack won't need it
later. But let's push the logic into parse_object_with_flags(), telling
it to discard the tree buffer immediately. There are two reasons for
this. One, all of the relevant call-sites already call the with_options
variant to pass the SKIP_HASH flag. So it actually ends up as less code
than manually free-ing in each spot. And two, it enables an extra
optimization that I'll discuss below.

I've touched all of the sites that currently use SKIP_HASH in
upload-pack. That drops the peak heap of the upload-pack invocation
above from 3.7GB to ~24MB.

I've also modified the caller in get_reference(); a partial clone
benefits from its use in pack-objects for the reasons given in
0bc2557951 (upload-pack: skip parse-object re-hashing of "want" objects,
2022-09-06), where we were measuring blob requests. But note that the
results of get_reference() are used for traversing, as well; so we
really would _eventually_ use the tree contents. That makes this at
first glance a space/time tradeoff: we won't hold all of the trees in
memory at once, but we'll have to reload them each when it comes time to
traverse.

And here's where our extra optimization comes in. If the caller is not
going to immediately look at the tree contents, and it doesn't care
about checking the hash, then parse_object() can simply skip loading the
tree entirely, just like we do for blobs! And now it's not a space/time
tradeoff in get_reference() anymore. It's just a lazy-load: we're
delaying reading the tree contents until it's time to actually traverse
them one by one.

And of course for upload-pack, this optimization means we never load the
trees at all, saving lots of CPU time. Timing the "every tree from
git.git" request above shows upload-pack dropping from 32 seconds of CPU
to 19 (the remainder is mostly due to pack-objects actually sending the
pack; timing just the upload-pack portion shows we go from 13s to
~0.28s).

These are all highly gamed numbers, of course. For real-world
partial-clone requests we're saving only a small bit of time in
practice. But it does help harden upload-pack against malicious
denial-of-service attacks.

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c      | 14 ++++++++++++++
 object.h      |  1 +
 revision.c    |  3 ++-
 upload-pack.c |  9 ++++++---
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index e6a1c4d905..f11c59ac0c 100644
--- a/object.c
+++ b/object.c
@@ -271,6 +271,7 @@ struct object *parse_object_with_flags(struct repository *r,
 				       enum parse_object_flags flags)
 {
 	int skip_hash = !!(flags & PARSE_OBJECT_SKIP_HASH_CHECK);
+	int discard_tree = !!(flags & PARSE_OBJECT_DISCARD_TREE);
 	unsigned long size;
 	enum object_type type;
 	int eaten;
@@ -298,6 +299,17 @@ struct object *parse_object_with_flags(struct repository *r,
 		return lookup_object(r, oid);
 	}
 
+	/*
+	 * If the caller does not care about the tree buffer and does not
+	 * care about checking the hash, we can simply verify that we
+	 * have the on-disk object with the correct type.
+	 */
+	if (skip_hash && discard_tree &&
+	    (!obj || obj->type == OBJ_TREE) &&
+	    oid_object_info(r, oid, NULL) == OBJ_TREE) {
+		return &lookup_tree(r, oid)->object;
+	}
+
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (!skip_hash &&
@@ -311,6 +323,8 @@ struct object *parse_object_with_flags(struct repository *r,
 					  buffer, &eaten);
 		if (!eaten)
 			free(buffer);
+		if (discard_tree && type == OBJ_TREE)
+			free_tree_buffer((struct tree *)obj);
 		return obj;
 	}
 	return NULL;
diff --git a/object.h b/object.h
index 114d45954d..c7123cade6 100644
--- a/object.h
+++ b/object.h
@@ -197,6 +197,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet);
  */
 enum parse_object_flags {
 	PARSE_OBJECT_SKIP_HASH_CHECK = 1 << 0,
+	PARSE_OBJECT_DISCARD_TREE = 1 << 1,
 };
 struct object *parse_object(struct repository *r, const struct object_id *oid);
 struct object *parse_object_with_flags(struct repository *r,
diff --git a/revision.c b/revision.c
index 2424c9bd67..b10f63a607 100644
--- a/revision.c
+++ b/revision.c
@@ -381,7 +381,8 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 
 	object = parse_object_with_flags(revs->repo, oid,
 					 revs->verify_objects ? 0 :
-					 PARSE_OBJECT_SKIP_HASH_CHECK);
+					 PARSE_OBJECT_SKIP_HASH_CHECK |
+					 PARSE_OBJECT_DISCARD_TREE);
 
 	if (!object) {
 		if (revs->ignore_missing)
diff --git a/upload-pack.c b/upload-pack.c
index b721155442..761af4a532 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -470,7 +470,8 @@ static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid
 {
 	int we_knew_they_have = 0;
 	struct object *o = parse_object_with_flags(the_repository, oid,
-						   PARSE_OBJECT_SKIP_HASH_CHECK);
+						   PARSE_OBJECT_SKIP_HASH_CHECK |
+						   PARSE_OBJECT_DISCARD_TREE);
 
 	if (!o)
 		die("oops (%s)", oid_to_hex(oid));
@@ -1150,7 +1151,8 @@ static void receive_needs(struct upload_pack_data *data,
 		}
 
 		o = parse_object_with_flags(the_repository, &oid_buf,
-					    PARSE_OBJECT_SKIP_HASH_CHECK);
+					    PARSE_OBJECT_SKIP_HASH_CHECK |
+					    PARSE_OBJECT_DISCARD_TREE);
 		if (!o) {
 			packet_writer_error(&data->writer,
 					    "upload-pack: not our ref %s",
@@ -1467,7 +1469,8 @@ static int parse_want(struct packet_writer *writer, const char *line,
 			    "expected to get oid, not '%s'", line);
 
 		o = parse_object_with_flags(the_repository, &oid,
-					    PARSE_OBJECT_SKIP_HASH_CHECK);
+					    PARSE_OBJECT_SKIP_HASH_CHECK |
+					    PARSE_OBJECT_DISCARD_TREE);
 
 		if (!o) {
 			packet_writer_error(writer,
-- 
2.44.0.rc2.424.gbdbf4d014b
