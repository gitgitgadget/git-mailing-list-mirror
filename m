Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75C720989
	for <e@80x24.org>; Thu, 13 Oct 2016 16:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933497AbcJMQxs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 12:53:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:57047 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933345AbcJMQxr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 12:53:47 -0400
Received: (qmail 28531 invoked by uid 109); 13 Oct 2016 16:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 16:53:46 +0000
Received: (qmail 30957 invoked by uid 111); 13 Oct 2016 16:54:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 12:54:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2016 12:53:44 -0400
Date:   Thu, 13 Oct 2016 12:53:44 -0400
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fetch: use "quick" has_sha1_file for tag following
Message-ID: <20161013165344.jv7hyj74q33yb4ip@sigill.intra.peff.net>
References: <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
 <af801f22-0e24-525d-a862-f2114941719a@oracle.com>
 <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2016 at 11:26:32AM -0400, Jeff King wrote:

> On Thu, Oct 13, 2016 at 09:20:07AM +0200, Vegard Nossum wrote:
> 
> > > Does the patch below help?
> > 
> > Yes, ~2m10s -> ~1m25s when I test a git fetch this morning (the other
> > variation in time may be due to different CPU usage by other programs,
> > but I ran with/without the patch multiple times and the difference is
> > consistent).
> > [...]
> > There are some 20k refs on the remote, closer to 25k locally.
> 
> OK, that makes some sense. For whatever reason, your remote has a bunch
> of tags that point to objects you do not already have. That could
> happen, I think, if the remote added a lot of tags since you cloned
> (because clone will grab all of the tags), but those tags do not point
> to history that you are otherwise fetching (since fetch by default will
> "auto-follow" such tags).

Armed with this information, I was able to reproduce the issue locally.
However, once my patch is applied, it's now quite fast. So I still don't
know where your other 1m25s is going.

So here's that same patch wrapped up with a commit message. Note that I
converted one more call site to the "quick" form; it would trigger when
the candidate tags are real tag objects, not just pointers to commits.
That might improve your runtime more, depending on what is actually in
your repository.

-- >8 --
Subject: [PATCH] fetch: use "quick" has_sha1_file for tag following

When we auto-follow tags in a fetch, we look at all of the
tags advertised by the remote and fetch ones where we don't
already have the tag, but we do have the object it peels to.
This involves a lot of calls to has_sha1_file(), some of
which we can reasonably expect to fail. Since 45e8a74
(has_sha1_file: re-check pack directory before giving up,
2013-08-30), this may cause many calls to
reprepare_packed_git(), which is potentially expensive.

This has gone unnoticed for several years because it
requires a fairly unique setup to matter:

  1. You need to have a lot of packs on the client side to
     make reprepare_packed_git() expensive (the most
     expensive part is finding duplicates in an unsorted
     list, which is currently quadratic).

  2. You need a large number of tag refs on the server side
     that are candidates for auto-following (i.e., that the
     client doesn't have). Each one triggers a re-read of
     the pack directory.

  3. Under normal circumstances, the client would
     auto-follow those tags and after one large fetch, (2)
     would no longer be true. But if those tags point to
     history which is disconnected from what the client
     otherwise fetches, then it will never auto-follow, and
     those candidates will impact it on every fetch.

So when all three are true, each fetch pays an extra
O(nr_tags * nr_packs^2) cost, mostly in string comparisons
on the pack names. This was exacerbated by 47bf4b0
(prepare_packed_git_one: refactor duplicate-pack check,
2014-06-30) which uses a slightly more expensive string
check, under the assumption that the duplicate check doesn't
happen very often (and it shouldn't; the real problem here
is how often we are calling reprepare_packed_git()).

This patch teaches fetch to use HAS_SHA1_QUICK to sacrifice
accuracy for speed, in cases where we might be racy with a
simultaneous repack. This is similar to the fix in 0eeb077
(index-pack: avoid excessive re-reading of pack directory,
2015-06-09). As with that case, it's OK for has_sha1_file()
occasionally say "no I don't have it" when we do, because
the worst case is not a corruption, but simply that we may
fail to auto-follow a tag that points to it.

Here are results from the included perf script, which sets
up a situation similar to the one described above:

Test            HEAD^               HEAD
----------------------------------------------------------
5550.4: fetch   11.21(10.42+0.78)   0.08(0.04+0.02) -99.3%

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c            | 11 ++++--
 cache.h                    |  1 +
 sha1_file.c                |  5 +++
 t/perf/p5550-fetch-tags.sh | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 4 deletions(-)
 create mode 100755 t/perf/p5550-fetch-tags.sh

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d5329f9..74c0546 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -241,9 +241,10 @@ static void find_non_local_tags(struct transport *transport,
 		 * as one to ignore by setting util to NULL.
 		 */
 		if (ends_with(ref->name, "^{}")) {
-			if (item && !has_object_file(&ref->old_oid) &&
+			if (item &&
+			    !has_object_file_with_flags(&ref->old_oid, HAS_SHA1_QUICK) &&
 			    !will_fetch(head, ref->old_oid.hash) &&
-			    !has_sha1_file(item->util) &&
+			    !has_sha1_file_with_flags(item->util, HAS_SHA1_QUICK) &&
 			    !will_fetch(head, item->util))
 				item->util = NULL;
 			item = NULL;
@@ -256,7 +257,8 @@ static void find_non_local_tags(struct transport *transport,
 		 * to check if it is a lightweight tag that we want to
 		 * fetch.
 		 */
-		if (item && !has_sha1_file(item->util) &&
+		if (item &&
+		    !has_sha1_file_with_flags(item->util, HAS_SHA1_QUICK) &&
 		    !will_fetch(head, item->util))
 			item->util = NULL;
 
@@ -276,7 +278,8 @@ static void find_non_local_tags(struct transport *transport,
 	 * We may have a final lightweight tag that needs to be
 	 * checked to see if it needs fetching.
 	 */
-	if (item && !has_sha1_file(item->util) &&
+	if (item &&
+	    !has_sha1_file_with_flags(item->util, HAS_SHA1_QUICK) &&
 	    !will_fetch(head, item->util))
 		item->util = NULL;
 
diff --git a/cache.h b/cache.h
index 2cfb1ca..ec791a6 100644
--- a/cache.h
+++ b/cache.h
@@ -1154,6 +1154,7 @@ static inline int has_sha1_file(const unsigned char *sha1)
 
 /* Same as the above, except for struct object_id. */
 extern int has_object_file(const struct object_id *oid);
+extern int has_object_file_with_flags(const struct object_id *oid, int flags);
 
 /*
  * Return true iff an alternate object database has a loose object
diff --git a/sha1_file.c b/sha1_file.c
index 309e87d..c652cb6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3309,6 +3309,11 @@ int has_object_file(const struct object_id *oid)
 	return has_sha1_file(oid->hash);
 }
 
+int has_object_file_with_flags(const struct object_id *oid, int flags)
+{
+	return has_sha1_file_with_flags(oid->hash, flags);
+}
+
 static void check_tree(const void *buf, size_t size)
 {
 	struct tree_desc desc;
diff --git a/t/perf/p5550-fetch-tags.sh b/t/perf/p5550-fetch-tags.sh
new file mode 100755
index 0000000..a5dc39f
--- /dev/null
+++ b/t/perf/p5550-fetch-tags.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+
+test_description='performance of tag-following with many tags
+
+This tests a fairly pathological case, so rather than rely on a real-world
+case, we will construct our own repository. The situation is roughly as
+follows.
+
+The parent repository has a large number of tags which are disconnected from
+the rest of history. That makes them candidates for tag-following, but we never
+actually grab them (and thus they will impact each subsequent fetch).
+
+The child repository is a clone of parent, without the tags, and is at least
+one commit behind the parent (meaning that we will fetch one object and then
+examine the tags to see if they need followed). Furthermore, it has a large
+number of packs.
+
+The exact values of "large" here are somewhat arbitrary; I picked values that
+start to show a noticeable performance problem on my machine, but without
+taking too long to set up and run the tests.
+'
+. ./perf-lib.sh
+
+# make a long nonsense history on branch $1, consisting of $2 commits, each
+# with a unique file pointing to the blob at $2.
+create_history () {
+	perl -le '
+		my ($branch, $n, $blob) = @ARGV;
+		for (1..$n) {
+			print "commit refs/heads/$branch";
+			print "committer nobody <nobody@example.com> now";
+			print "data 4";
+			print "foo";
+			print "M 100644 $blob $_";
+		}
+	' "$@" |
+	git fast-import --date-format=now
+}
+
+# make a series of tags, one per commit in the revision range given by $@
+create_tags () {
+	git rev-list "$@" |
+	perl -lne 'print "create refs/tags/$. $_"' |
+	git update-ref --stdin
+}
+
+# create $1 nonsense packs, each with a single blob
+create_packs () {
+	perl -le '
+		my ($n) = @ARGV;
+		for (1..$n) {
+			print "blob";
+			print "data <<EOF";
+			print "$_";
+			print "EOF";
+		}
+	' "$@" |
+	git fast-import &&
+
+	git cat-file --batch-all-objects --batch-check='%(objectname)' |
+	while read sha1
+	do
+		echo $sha1 | git pack-objects .git/objects/pack/pack
+	done
+}
+
+test_expect_success 'create parent and child' '
+	git init parent &&
+	git -C parent commit --allow-empty -m base &&
+	git clone parent child &&
+	git -C parent commit --allow-empty -m trigger-fetch
+'
+
+test_expect_success 'populate parent tags' '
+	(
+		cd parent &&
+		blob=$(echo content | git hash-object -w --stdin) &&
+		create_history cruft 3000 $blob &&
+		create_tags cruft &&
+		git branch -D cruft
+	)
+'
+
+test_expect_success 'create child packs' '
+	(
+		cd child &&
+		git config gc.auto 0 &&
+		git config gc.autopacklimit 0 &&
+		create_packs 500
+	)
+'
+
+test_perf 'fetch' '
+	# make sure there is something to fetch on each iteration
+	git -C child update-ref -d refs/remotes/origin/master &&
+	git -C child fetch
+'
+
+test_done
-- 
2.10.1.589.gca16299

