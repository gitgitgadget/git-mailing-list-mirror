Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9B7ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 23:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIFXFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 19:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIFXFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 19:05:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A134320F40
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 16:05:43 -0700 (PDT)
Received: (qmail 19896 invoked by uid 109); 6 Sep 2022 23:05:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Sep 2022 23:05:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6693 invoked by uid 111); 6 Sep 2022 23:05:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Sep 2022 19:05:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Sep 2022 19:05:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: [PATCH 2/3] upload-pack: skip parse-object re-hashing of "want"
 objects
Message-ID: <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Imagine we have a history with commit C pointing to a large blob B.
If a client asks us for C, we can generally serve both objects to them
without accessing the uncompressed contents of B. In upload-pack, we
figure out which commits we have and what the client has, and feed those
tips to pack-objects. In pack-objects, we traverse the commits and trees
(or use bitmaps!) to find the set of objects needed, but we never open
up B. When we serve it to the client, we can often pass the compressed
bytes directly from the on-disk packfile over the wire.

But if a client asks us directly for B, perhaps because they are doing
an on-demand fetch to fill in the missing blob of a partial clone, we
end up much slower. Upload-pack calls parse_object() on the oid we
receive, which opens up the object and re-checks its hash (even though
if it were a commit, we might skip this parse entirely in favor of the
commit graph!). And then we feed the oid directly to pack-objects, which
again calls parse_object() and opens the object. And then finally, when
we write out the result, we may send bytes straight from disk, but only
after having unnecessarily uncompressed and computed the sha1 of the
object twice!

This patch teaches both code paths to use the new SKIP_HASH_CHECK flag
for parse_object(). You can see the speed-up in p5600, which does a
blob:none clone followed by a checkout. The savings for git.git are
modest:

  Test                          HEAD^             HEAD
  ----------------------------------------------------------------------
  5600.3: checkout of result    2.23(4.19+0.24)   1.72(3.79+0.18) -22.9%

But the savings scale with the number of bytes. So on a repository like
linux.git with more files, we see more improvement (in both absolute and
relative numbers):

  Test                          HEAD^                HEAD
  ----------------------------------------------------------------------------
  5600.3: checkout of result    51.62(77.26+2.76)    34.86(61.41+2.63) -32.5%

And here's an even more extreme case. This is the android gradle-plugin
repository, whose tip checkout has ~3.7GB of files:

  Test                          HEAD^               HEAD
  --------------------------------------------------------------------------
  5600.3: checkout of result    79.51(90.84+5.55)   40.28(51.88+5.67) -49.3%

Keep in mind that these timings are of the whole checkout operation. So
they count the client indexing the pack and actually writing out the
files. If we want to see just the server's view, we can hack up the
GIT_TRACE_PACKET output from those operations and replay it via
upload-pack. For the gradle example, that gives me:

  Benchmark 1: GIT_PROTOCOL=version=2 git.old upload-pack ../gradle-plugin <input
    Time (mean ± σ):     50.884 s ±  0.239 s    [User: 51.450 s, System: 1.726 s]
    Range (min … max):   50.608 s … 51.025 s    3 runs

  Benchmark 2: GIT_PROTOCOL=version=2 git.new upload-pack ../gradle-plugin <input
    Time (mean ± σ):      9.728 s ±  0.112 s    [User: 10.466 s, System: 1.535 s]
    Range (min … max):    9.618 s …  9.842 s    3 runs

  Summary
    'GIT_PROTOCOL=version=2 git.new upload-pack ../gradle-plugin <input' ran
      5.23 ± 0.07 times faster than 'GIT_PROTOCOL=version=2 git.old upload-pack ../gradle-plugin <input'

So a server would see an 80% reduction in CPU serving the initial
checkout of a partial clone for this repository. Or possibly even more
depending on the packing; most of the time spent in the faster one were
objects we had to open during the write phase.

In both cases skipping the extra hashing on the server should be pretty
safe. The client doesn't trust the server anyway, so it will re-hash all
of the objects via index-pack. There is one thing to note, though: the
change in get_reference() affects not just pack-objects, but rev-list,
git-log, etc. We could use a flag to limit to index-pack here, but we
may already skip hash checks in this instance. For commits, we'd skip
anything we load via the commit-graph. And while before this commit we
would check a blob fed directly to rev-list on the command-line, we'd
skip checking that same blob if we found it by traversing a tree.

The exception for both is if --verify-objects is used. In that case,
we'll skip this optimization, and the new test makes sure we do this
correctly.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c      |  4 +++-
 t/t1450-fsck.sh | 20 ++++++++++++++++++++
 upload-pack.c   |  3 ++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index ee702e498a..786e090785 100644
--- a/revision.c
+++ b/revision.c
@@ -384,7 +384,9 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 	if (commit)
 		object = &commit->object;
 	else
-		object = parse_object(revs->repo, oid);
+		object = parse_object_with_flags(revs->repo, oid,
+						 revs->verify_objects ? 0 :
+						 PARSE_OBJECT_SKIP_HASH_CHECK);
 
 	if (!object) {
 		if (revs->ignore_missing)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 53c2aa10b7..6410eff4e0 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -507,6 +507,26 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 	test_i18ngrep -q "error: hash mismatch $(dirname $new)$(test_oid ff_2)" out
 '
 
+# An actual bit corruption is more likely than swapped commits, but
+# this provides an easy way to have commits which don't match their purported
+# hashes, but which aren't so broken we can't read them at all.
+test_expect_success 'rev-list --verify-objects notices swapped commits' '
+	git init swapped-commits &&
+	(
+		cd swapped-commits &&
+		test_commit one &&
+		test_commit two &&
+		one_oid=$(git rev-parse HEAD) &&
+		two_oid=$(git rev-parse HEAD^) &&
+		one=.git/objects/$(test_oid_to_path $one_oid) &&
+		two=.git/objects/$(test_oid_to_path $two_oid) &&
+		mv $one tmp &&
+		mv $two $one &&
+		mv tmp $two &&
+		test_must_fail git rev-list --verify-objects HEAD
+	)
+'
+
 test_expect_success 'force fsck to ignore double author' '
 	git cat-file commit HEAD >basis &&
 	sed "s/^author .*/&,&/" <basis | tr , \\n >multiple-authors &&
diff --git a/upload-pack.c b/upload-pack.c
index b217a1f469..4bacdf087c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1420,7 +1420,8 @@ static int parse_want(struct packet_writer *writer, const char *line,
 		if (commit)
 			o = &commit->object;
 		else
-			o = parse_object(the_repository, &oid);
+			o = parse_object_with_flags(the_repository, &oid,
+						    PARSE_OBJECT_SKIP_HASH_CHECK);
 
 		if (!o) {
 			packet_writer_error(writer,
-- 
2.37.3.1134.gfd534b3986

