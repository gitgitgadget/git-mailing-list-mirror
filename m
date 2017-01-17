Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6376220756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbdAQVd6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:33:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:40525 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbdAQVdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:33:46 -0500
Received: (qmail 28158 invoked by uid 109); 17 Jan 2017 21:33:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 21:33:00 +0000
Received: (qmail 22082 invoked by uid 111); 17 Jan 2017 21:33:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 16:33:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 16:32:57 -0500
Date:   Tue, 17 Jan 2017 16:32:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/6] fsck: prepare dummy objects for --connectivity-check
Message-ID: <20170117213257.hfqpkic4olav22z5@sigill.intra.peff.net>
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
 <20170116213204.e7ykwowqzafkexqd@sigill.intra.peff.net>
 <xmqqa8ape6b6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8ape6b6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 01:15:57PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +static void mark_object_for_connectivity(const unsigned char *sha1)
> > +{
> > +	struct object *obj = lookup_object(sha1);
> > +
> > +	/*
> > +	 * Setting the object type here isn't strictly necessary here for a
> > +	 * connectivity check.
> 
> Drop one of these "here"s?

Yeah.

> > The cmd_fsck() part of the diff is pretty nasty without
> > "-b".
> 
> True.  I also wonder if swapping the if/else arms make the end
> result and the patch easier to read. i.e.
> 
> +	if (connectivity_only) {
> +		mark loose for connectivity;
> +		mark packed for connectivity;
> +	} else {
> 		... existing code comes here reindented ...
> 	}                
> 
> But the patch makes sense.

Yeah. It doesn't help the diff, but the end result is more readable. And
the conditional lacks a negation, which is nice. Will change.

> > +test_expect_success 'fsck --connectivity-only with explicit head' '
> > +	(
> > +		cd connectivity-only &&
> > +		test_must_fail git fsck --connectivity-only $tree
> > +	)
> > +'
> 
> Most of the earlier "tree=..." assignments are done in subshells,
> and it is not clear which tree this refers to.  Is this the one that
> was written in 'rev-list --verify-objects with bad sha1' that has
> been removed in its when-finished handler?

Doh. It was meant to be the one from the earlier --connectivity-only
check. But that is doubly silly, even, because the tree variable in that
case is holding the filename, not the sha1. The right thing is to call
rev-parse again, but of course that doesn't work because the repo has
been corrupted. :-/

Here's a re-roll with the two changes above (and the notice thing you
mentioned elsewhere), plus a test that actually checks the right thing
(fails before this commit and passes after).

If everything else looks good, you can queue it along with the rest.
Otherwise if I need a re-roll, it will be in the next version.

-- >8 --
Subject: fsck: prepare dummy objects for --connectivity-check

Normally fsck makes a pass over all objects to check their
integrity, and then follows up with a reachability check to
make sure we have all of the referenced objects (and to know
which ones are dangling). The latter checks for the HAS_OBJ
flag in obj->flags to see if we found the object in the
first pass.

Commit 02976bf85 (fsck: introduce `git fsck --connectivity-only`,
2015-06-22) taught fsck to skip the initial pass, and to
fallback to has_sha1_file() instead of the HAS_OBJ check.

However, it converted only one HAS_OBJ check to use
has_sha1_file(). But there are many other places in
builtin/fsck.c that assume that the flag is set (or that
lookup_object() will return an object at all). This leads to
several bugs with --connectivity-only:

  1. mark_object() will not queue objects for examination,
     so recursively following links from commits to trees,
     etc, did nothing. I.e., we were checking the
     reachability of hardly anything at all.

  2. When a set of heads is given on the command-line, we
     use lookup_object() to see if they exist. But without
     the initial pass, we assume nothing exists.

  3. When loading reflog entries, we do a similar
     lookup_object() check, and complain that the reflog is
     broken if the object doesn't exist in our hash.

So in short, --connectivity-only is broken pretty badly, and
will claim that your repository is fine when it's not.
Presumably nobody noticed for a few reasons.

One is that the embedded test does not actually test the
recursive nature of the reachability check. All of the
missing objects are still in the index, and we directly
check items from the index. This patch modifies the test to
delete the index, which shows off breakage (1).

Another is that --connectivity-only just skips the initial
pass for loose objects. So on a real repository, the packed
objects were still checked correctly. But on the flipside,
it means that "git fsck --connectivity-only" still checks
the sha1 of all of the packed objects, nullifying its
original purpose of being a faster git-fsck.

And of course the final problem is that the bug only shows
up when there _is_ corruption, which is rare. So anybody
running "git fsck --connectivity-only" proactively would
assume it was being thorough, when it was not.

One possibility for fixing this is to find all of the spots
that rely on HAS_OBJ and tweak them for the connectivity-only
case. But besides the risk that we might miss a spot (and I
found three already, corresponding to the three bugs above),
there are other parts of fsck that _can't_ work without a
full list of objects. E.g., the list of dangling objects.

Instead, let's make the connectivity-only case look more
like the normal case. Rather than skip the initial pass
completely, we'll do an abbreviated one that sets up the
HAS_OBJ flag for each object, without actually loading the
object data.

That's simple and fast, and we don't have to care about the
connectivity_only flag in the rest of the code at all.
While we're at it, let's make sure we treat loose and packed
objects the same (i.e., setting up dummy objects for both
and skipping the actual sha1 check). That makes the
connectivity-only check actually fast on a real repo (40
seconds versus 180 seconds on my copy of linux.git).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c  | 120 +++++++++++++++++++++++++++++++++++++++++++++-----------
 t/t1450-fsck.sh |  29 +++++++++++++-
 2 files changed, 124 insertions(+), 25 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3e67203f9..75e836e2f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -205,8 +205,6 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(obj->oid.hash))
 			return; /* it is in pack - forget about it */
-		if (connectivity_only && has_object_file(&obj->oid))
-			return;
 		printf("missing %s %s\n", typename(obj->type),
 			describe_object(obj));
 		errors_found |= ERROR_REACHABLE;
@@ -584,6 +582,79 @@ static int fsck_cache_tree(struct cache_tree *it)
 	return err;
 }
 
+static void mark_object_for_connectivity(const unsigned char *sha1)
+{
+	struct object *obj = lookup_object(sha1);
+
+	/*
+	 * Setting the object type here isn't strictly necessary for a
+	 * connectivity check. In most cases, our walk will expect a certain
+	 * type (e.g., a tree referencing a blob) and will use lookup_blob() to
+	 * assign the type. But doing it here has two advantages:
+	 *
+	 *   1. When the fsck_walk code looks at objects that _don't_ come from
+	 *      links (e.g., the tip of a ref), it may complain about the
+	 *      "unknown object type".
+	 *
+	 *   2. This serves as a nice cross-check that the graph links are
+	 *      sane. So --connectivity-only does not check that the bits of
+	 *      blobs are not corrupted, but it _does_ check that 100644 tree
+	 *      entries point to blobs, and so forth.
+	 *
+	 * Unfortunately we can't just use parse_object() here, because the
+	 * whole point of --connectivity-only is to avoid reading the object
+	 * data more than necessary.
+	 */
+	if (!obj || obj->type == OBJ_NONE) {
+		enum object_type type = sha1_object_info(sha1, NULL);
+		switch (type) {
+		case OBJ_BAD:
+			error("%s: unable to read object type",
+			      sha1_to_hex(sha1));
+			break;
+		case OBJ_COMMIT:
+			obj = (struct object *)lookup_commit(sha1);
+			break;
+		case OBJ_TREE:
+			obj = (struct object *)lookup_tree(sha1);
+			break;
+		case OBJ_BLOB:
+			obj = (struct object *)lookup_blob(sha1);
+			break;
+		case OBJ_TAG:
+			obj = (struct object *)lookup_tag(sha1);
+			break;
+		default:
+			error("%s: unknown object type %d",
+			      sha1_to_hex(sha1), type);
+		}
+
+		if (!obj || obj->type == OBJ_NONE) {
+			errors_found |= ERROR_OBJECT;
+			return;
+		}
+	}
+
+	obj->flags |= HAS_OBJ;
+}
+
+static int mark_loose_for_connectivity(const unsigned char *sha1,
+				       const char *path,
+				       void *data)
+{
+	mark_object_for_connectivity(sha1);
+	return 0;
+}
+
+static int mark_packed_for_connectivity(const unsigned char *sha1,
+					struct packed_git *pack,
+					uint32_t pos,
+					void *data)
+{
+	mark_object_for_connectivity(sha1);
+	return 0;
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [<options>] [<object>...]"),
 	NULL
@@ -640,38 +711,41 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	git_config(fsck_config, NULL);
 
 	fsck_head_link();
-	if (!connectivity_only) {
+	if (connectivity_only) {
+		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
+		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
+	} else {
 		fsck_object_dir(get_object_directory());
 
 		prepare_alt_odb();
 		for (alt = alt_odb_list; alt; alt = alt->next)
 			fsck_object_dir(alt->path);
-	}
 
-	if (check_full) {
-		struct packed_git *p;
-		uint32_t total = 0, count = 0;
-		struct progress *progress = NULL;
+		if (check_full) {
+			struct packed_git *p;
+			uint32_t total = 0, count = 0;
+			struct progress *progress = NULL;
+
+			prepare_packed_git();
 
-		prepare_packed_git();
+			if (show_progress) {
+				for (p = packed_git; p; p = p->next) {
+					if (open_pack_index(p))
+						continue;
+					total += p->num_objects;
+				}
 
-		if (show_progress) {
+				progress = start_progress(_("Checking objects"), total);
+			}
 			for (p = packed_git; p; p = p->next) {
-				if (open_pack_index(p))
-					continue;
-				total += p->num_objects;
+				/* verify gives error messages itself */
+				if (verify_pack(p, fsck_obj_buffer,
+						progress, count))
+					errors_found |= ERROR_PACK;
+				count += p->num_objects;
 			}
-
-			progress = start_progress(_("Checking objects"), total);
-		}
-		for (p = packed_git; p; p = p->next) {
-			/* verify gives error messages itself */
-			if (verify_pack(p, fsck_obj_buffer,
-					progress, count))
-				errors_found |= ERROR_PACK;
-			count += p->num_objects;
+			stop_progress(&progress);
 		}
-		stop_progress(&progress);
 	}
 
 	heads = 0;
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index e88ec7747..4d1c3ba66 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -523,9 +523,21 @@ test_expect_success 'fsck --connectivity-only' '
 		touch empty &&
 		git add empty &&
 		test_commit empty &&
+
+		# Drop the index now; we want to be sure that we
+		# recursively notice the broken objects
+		# because they are reachable from refs, not because
+		# they are in the index.
+		rm -f .git/index &&
+
+		# corrupt the blob, but in a way that we can still identify
+		# its type. That lets us see that --connectivity-only is
+		# not actually looking at the contents, but leaves it
+		# free to examine the type if it chooses.
 		empty=.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
-		rm -f $empty &&
-		echo invalid >$empty &&
+		blob=$(echo unrelated | git hash-object -w --stdin) &&
+		mv $(sha1_file $blob) $empty &&
+
 		test_must_fail git fsck --strict &&
 		git fsck --strict --connectivity-only &&
 		tree=$(git rev-parse HEAD:) &&
@@ -537,6 +549,19 @@ test_expect_success 'fsck --connectivity-only' '
 	)
 '
 
+test_expect_success 'fsck --connectivity-only with explicit head' '
+	rm -rf connectivity-only &&
+	git init connectivity-only &&
+	(
+		cd connectivity-only &&
+		test_commit foo &&
+		rm -f .git/index &&
+		tree=$(git rev-parse HEAD^{tree}) &&
+		remove_object $(git rev-parse HEAD:foo.t) &&
+		test_must_fail git fsck --connectivity-only $tree
+	)
+'
+
 remove_loose_object () {
 	sha1="$(git rev-parse "$1")" &&
 	remainder=${sha1#??} &&
-- 
2.11.0.651.g41f4a5c4e

