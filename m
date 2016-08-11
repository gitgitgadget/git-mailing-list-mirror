Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5FAF2018E
	for <e@80x24.org>; Thu, 11 Aug 2016 05:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbcHKFPT (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 01:15:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:53396 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751502AbcHKFPR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 01:15:17 -0400
Received: (qmail 18901 invoked by uid 109); 11 Aug 2016 05:15:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 05:15:17 +0000
Received: (qmail 6832 invoked by uid 111); 11 Aug 2016 05:15:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 01:15:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 01:15:14 -0400
Date:	Thu, 11 Aug 2016 01:15:14 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 1/2] pack-objects: break delta cycles before delta-search
 phase
Message-ID: <20160811051514.7f2llllaw7lmnsy2@sigill.intra.peff.net>
References: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
 <20160810120248.i2hvm2q6ag3rvsk4@sigill.intra.peff.net>
 <xmqqr39w4bvx.fsf@gitster.mtv.corp.google.com>
 <20160811050252.g3iusy7bp3j6tzte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160811050252.g3iusy7bp3j6tzte@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 01:02:52AM -0400, Jeff King wrote:

> Yeah, I think we would be better to just switch to printf if we want to
> be careful.
> 
> I'll follow-up with a patch.

Here it is. It switches out the echos for printfs (which, ironically,
_do_ complain about the "-" argument if you do so naively, but of course
the right way is "printf '%s\n' -whatever").

It also sets the dfs_state flag to DONE after breaking a delta, as
discussed.

Patch 2/2 on top does not need any adjustment, so I won't bother sending
it.

-- >8 --
Subject: [PATCH] pack-objects: break delta cycles before delta-search phase

We do not allow cycles in the delta graph of a pack (i.e., A
is a delta of B which is a delta of A) for the obvious
reason that you cannot actually access any of the objects in
such a case.

There's a last-ditch attempt to notice cycles during the
write phase, during which we issue a warning to the user and
write one of the objects out in full. However, this is
"last-ditch" for two reasons:

  1. By this time, it's too late to find another delta for
     the object, so the resulting pack is larger than it
     otherwise could be.

  2. The warning is there because this is something that
     _shouldn't_ ever happen. If it does, then either:

       a. a pack we are reusing deltas from had its own
          cycle

       b. we are reusing deltas from multiple packs, and
          we found a cycle among them (i.e., A is a delta of
          B in one pack, but B is a delta of A in another,
          and we choose to use both deltas).

       c. there is a bug in the delta-search code

     So this code serves as a final check that none of these
     things has happened, warns the user, and prevents us
     from writing a bogus pack.

Right now, (2b) should never happen because of the static
ordering of packs in want_object_in_pack(). If two objects
have a delta relationship, then they must be in the same
pack, and therefore we will find them from that same pack.

However, a future patch would like to change that static
ordering, which will make (2b) a common occurrence. In
preparation, we should be able to handle those kinds of
cycles better. This patch does by introducing a
cycle-breaking step during the get_object_details() phase,
when we are deciding which deltas can be reused. That gives
us the chance to feed the objects into the delta search as
if the cycle did not exist.

We'll leave the detection and warning in the write_object()
phase in place, as it still serves as a check for case (2c).

This does mean we will stop warning for (2a). That case is
caused by bogus input packs, and we ideally would warn the
user about it.  However, since those cycles show up after
picking reusable deltas, they look the same as (2b) to us;
our new code will break the cycles early and the last-ditch
check will never see them.

We could do analysis on any cycles that we find to
distinguish the two cases (i.e., it is a bogus pack if and
only if every delta in the cycle is in the same pack), but
we don't need to. If there is a cycle inside a pack, we'll
run into problems not only reusing the delta, but accessing
the object data at all. So when we try to dig up the actual
size of the object, we'll hit that same cycle and kick in
our usual complain-and-try-another-source code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c          |  84 +++++++++++++++++++++++++++++
 pack-objects.h                  |   9 ++++
 t/t5314-pack-cycle-detection.sh | 113 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100755 t/t5314-pack-cycle-detection.sh

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4a63398..b8e4e41 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1495,6 +1495,83 @@ static int pack_offset_sort(const void *_a, const void *_b)
 			(a->in_pack_offset > b->in_pack_offset);
 }
 
+/*
+ * Drop an on-disk delta we were planning to reuse. Naively, this would
+ * just involve blanking out the "delta" field, but we have to deal
+ * with two extra pieces of book-keeping:
+ *
+ *   1. Removing ourselves from the delta_sibling linked list.
+ *
+ *   2. Updating our size; check_object() will have filled in the size of our
+ *      delta, but a non-delta object needs it true size.
+ */
+static void drop_reused_delta(struct object_entry *entry)
+{
+	struct object_entry **p = &entry->delta->delta_child;
+	struct pack_window *w_curs = NULL;
+
+	while (*p) {
+		if (*p == entry)
+			*p = (*p)->delta_sibling;
+		else
+			p = &(*p)->delta_sibling;
+	}
+	entry->delta = NULL;
+
+	entry->size = get_size_from_delta(entry->in_pack, &w_curs,
+			  entry->in_pack_offset + entry->in_pack_header_size);
+	unuse_pack(&w_curs);
+
+	/*
+	 * If we failed to get the size from this pack for whatever reason,
+	 * fall back to sha1_object_info, which may find another copy. And if
+	 * that fails, the error will be recorded in entry->type and dealt
+	 * with in prepare_pack().
+	 */
+	if (entry->size == 0)
+		entry->type = sha1_object_info(entry->idx.sha1, &entry->size);
+}
+
+/*
+ * Follow the chain of deltas from this entry onward, throwing away any links
+ * that cause us to hit a cycle (as determined by the DFS state flags in
+ * the entries).
+ */
+static void break_delta_cycles(struct object_entry *entry)
+{
+	/* If it's not a delta, it can't be part of a cycle. */
+	if (!entry->delta) {
+		entry->dfs_state = DFS_DONE;
+		return;
+	}
+
+	switch (entry->dfs_state) {
+	case DFS_NONE:
+		/*
+		 * This is the first time we've seen the object. We mark it as
+		 * part of the active potential cycle and recurse.
+		 */
+		entry->dfs_state = DFS_ACTIVE;
+		break_delta_cycles(entry->delta);
+		entry->dfs_state = DFS_DONE;
+		break;
+
+	case DFS_DONE:
+		/* object already examined, and not part of a cycle */
+		break;
+
+	case DFS_ACTIVE:
+		/*
+		 * We found a cycle that needs broken. It would be correct to
+		 * break any link in the chain, but it's convenient to
+		 * break this one.
+		 */
+		drop_reused_delta(entry);
+		entry->dfs_state = DFS_DONE;
+		break;
+	}
+}
+
 static void get_object_details(void)
 {
 	uint32_t i;
@@ -1512,6 +1589,13 @@ static void get_object_details(void)
 			entry->no_try_delta = 1;
 	}
 
+	/*
+	 * This must happen in a second pass, since we rely on the delta
+	 * information for the whole list being completed.
+	 */
+	for (i = 0; i < to_pack.nr_objects; i++)
+		break_delta_cycles(&to_pack.objects[i]);
+
 	free(sorted_by_offset);
 }
 
diff --git a/pack-objects.h b/pack-objects.h
index d1b98b3..cc9b9a9 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -27,6 +27,15 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
+
+	/*
+	 * State flags for depth-first search used for analyzing delta cycles.
+	 */
+	enum {
+		DFS_NONE = 0,
+		DFS_ACTIVE,
+		DFS_DONE
+	} dfs_state;
 };
 
 struct packing_data {
diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detection.sh
new file mode 100755
index 0000000..f7dbdfb
--- /dev/null
+++ b/t/t5314-pack-cycle-detection.sh
@@ -0,0 +1,113 @@
+#!/bin/sh
+
+test_description='test handling of inter-pack delta cycles during repack
+
+The goal here is to create a situation where we have two blobs, A and B, with A
+as a delta against B in one pack, and vice versa in the other. Then if we can
+persuade a full repack to find A from one pack and B from the other, that will
+give us a cycle when we attempt to reuse those deltas.
+
+The trick is in the "persuade" step, as it depends on the internals of how
+pack-objects picks which pack to reuse the deltas from. But we can assume
+that it does so in one of two general strategies:
+
+ 1. Using a static ordering of packs. In this case, no inter-pack cycles can
+    happen. Any objects with a delta relationship must be present in the same
+    pack (i.e., no "--thin" packs on disk), so we will find all related objects
+    from that pack. So assuming there are no cycles within a single pack (and
+    we avoid generating them via pack-objects or importing them via
+    index-pack), then our result will have no cycles.
+
+    So this case should pass the tests no matter how we arrange things.
+
+ 2. Picking the next pack to examine based on locality (i.e., where we found
+    something else recently).
+
+    In this case, we want to make sure that we find the delta versions of A and
+    B and not their base versions. We can do this by putting two blobs in each
+    pack. The first is a "dummy" blob that can only be found in the pack in
+    question.  And then the second is the actual delta we want to find.
+
+    The two blobs must be present in the same tree, not present in other trees,
+    and the dummy pathname must sort before the delta path.
+
+The setup below focuses on case 2. We have two commits HEAD and HEAD^, each
+which has two files: "dummy" and "file". Then we can make two packs which
+contain:
+
+  [pack one]
+  HEAD:dummy
+  HEAD:file  (as delta against HEAD^:file)
+  HEAD^:file (as base)
+
+  [pack two]
+  HEAD^:dummy
+  HEAD^:file (as delta against HEAD:file)
+  HEAD:file  (as base)
+
+Then no matter which order we start looking at the packs in, we know that we
+will always find a delta for "file", because its lookup will always come
+immediately after the lookup for "dummy".
+'
+. ./test-lib.sh
+
+
+
+# Create a pack containing the the tree $1 and blob $1:file, with
+# the latter stored as a delta against $2:file.
+#
+# We convince pack-objects to make the delta in the direction of our choosing
+# by marking $2 as a preferred-base edge. That results in $1:file as a thin
+# delta, and index-pack completes it by adding $2:file as a base.
+#
+# Note that the two variants of "file" must be similar enough to convince git
+# to create the delta.
+make_pack () {
+	{
+		printf '%s\n' "-$(git rev-parse $2)"
+		printf '%s dummy\n' "$(git rev-parse $1:dummy)"
+		printf '%s file\n' "$(git rev-parse $1:file)"
+	} |
+	git pack-objects --stdout |
+	git index-pack --stdin --fix-thin
+}
+
+test_expect_success 'setup' '
+	test-genrandom base 4096 >base &&
+	for i in one two
+	do
+		# we want shared content here to encourage deltas...
+		cp base file &&
+		echo $i >>file &&
+
+		# ...whereas dummy should be short, because we do not want
+		# deltas that would create duplicates when we --fix-thin
+		echo $i >dummy &&
+
+		git add file dummy &&
+		test_tick &&
+		git commit -m $i ||
+		return 1
+	done &&
+
+	make_pack HEAD^ HEAD &&
+	make_pack HEAD HEAD^
+'
+
+test_expect_success 'repack' '
+	# We first want to check that we do not have any internal errors,
+	# and also that we do not hit the last-ditch cycle-breaking code
+	# in write_object(), which will issue a warning to stderr.
+	>expect &&
+	git repack -ad 2>stderr &&
+	test_cmp expect stderr &&
+
+	# And then double-check that the resulting pack is usable (i.e.,
+	# we did not fail to notice any cycles). We know we are accessing
+	# the objects via the new pack here, because "repack -d" will have
+	# removed the others.
+	git cat-file blob HEAD:file >/dev/null &&
+	git cat-file blob HEAD^:file >/dev/null
+'
+
+test_done
-- 
2.9.2.790.gaa5bc72

