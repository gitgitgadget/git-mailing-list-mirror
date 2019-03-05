Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2956420248
	for <e@80x24.org>; Tue,  5 Mar 2019 04:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfCEErm (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:47:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:38842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726522AbfCEErl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:47:41 -0500
Received: (qmail 796 invoked by uid 109); 5 Mar 2019 04:47:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:47:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28704 invoked by uid 111); 5 Mar 2019 04:47:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:47:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:47:39 -0500
Date:   Mon, 4 Mar 2019 23:47:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 2/2] fsck: always compute USED flags for unreachable
 objects
Message-ID: <20190305044739.GB32325@sigill.intra.peff.net>
References: <20190305044530.GG19800@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190305044530.GG19800@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --connectivity-only option avoids opening every object, and instead
just marks reachable objects with a flag and compares this to the set
of all objects. This strategy is discussed in more detail in 3e3f8bd608
(fsck: prepare dummy objects for --connectivity-check, 2017-01-17).

This means that we report _every_ unreachable object as dangling.
Whereas in a full fsck, we'd have actually opened and parsed each of
those unreachable objects, marking their child objects with the USED
flag, to mean "this was mentioned by another object". And thus we can
report only the tip of an unreachable segment of the object graph as
dangling.

You can see this difference with a trivial example:

  tree=$(git hash-object -t tree -w /dev/null)
  one=$(echo one | git commit-tree $tree)
  two=$(echo two | git commit-tree -p $one $tree)

Running `git fsck` will report only $two as dangling, but with
--connectivity-only, both commits (and the tree) are reported. Likewise,
using --lost-found would write all three objects.

We can make --connectivity-only work like the normal case by taking a
separate pass over the unreachable objects, parsing them and marking
objects they refer to as USED. That still avoids parsing any blobs,
though we do pay the cost to access any unreachable commits and trees
(which may or may not be noticeable, depending on how many you have).

If neither --dangling nor --lost-found is in effect, then we can skip
this step entirely, just like we do now. That makes "--connectivity-only
--no-dangling" just as fast as the current "--connectivity-only". I.e.,
we do the correct thing always, but you can still tweak the options to
make it faster if you don't care about dangling objects.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-fsck.txt |  4 +++
 builtin/fsck.c             | 62 ++++++++++++++++++++++++++++++++++++++
 t/t1450-fsck.sh            | 19 ++++++++++--
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index b7c7ac0866..e0eae642c1 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -69,6 +69,10 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	exist). This will detect corruption in commits and trees, but
 	not do any semantic checks (e.g., for format errors). Corruption
 	in blob objects will not be detected at all.
++
+Unreachable tags, commits, and trees will also be accessed to find the
+tips of dangling segments of history. Use `--no-dangling` if you don't
+care about this output and want to speed it up further.
 
 --strict::
 	Enable more strict checking, namely to catch a file mode
diff --git a/builtin/fsck.c b/builtin/fsck.c
index bb4227bebc..d26fb0a044 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -235,6 +235,48 @@ static int mark_used(struct object *obj, int type, void *data, struct fsck_optio
 	return 0;
 }
 
+static void mark_unreachable_referents(const struct object_id *oid)
+{
+	struct fsck_options options = FSCK_OPTIONS_DEFAULT;
+	struct object *obj = lookup_object(the_repository, oid->hash);
+
+	if (!obj || !(obj->flags & HAS_OBJ))
+		return; /* not part of our original set */
+	if (obj->flags & REACHABLE)
+		return; /* reachable objects already traversed */
+
+	/*
+	 * Avoid passing OBJ_NONE to fsck_walk, which will parse the object
+	 * (and we want to avoid parsing blobs).
+	 */
+	if (obj->type == OBJ_NONE) {
+		enum object_type type = oid_object_info(the_repository,
+							&obj->oid, NULL);
+		if (type > 0)
+			object_as_type(the_repository, obj, type, 0);
+	}
+
+	options.walk = mark_used;
+	fsck_walk(obj, NULL, &options);
+}
+
+static int mark_loose_unreachable_referents(const struct object_id *oid,
+					    const char *path,
+					    void *data)
+{
+	mark_unreachable_referents(oid);
+	return 0;
+}
+
+static int mark_packed_unreachable_referents(const struct object_id *oid,
+					     struct packed_git *pack,
+					     uint32_t pos,
+					     void *data)
+{
+	mark_unreachable_referents(oid);
+	return 0;
+}
+
 /*
  * Check a single reachable object
  */
@@ -347,6 +389,26 @@ static void check_connectivity(void)
 	/* Traverse the pending reachable objects */
 	traverse_reachable();
 
+	/*
+	 * With --connectivity-only, we won't have actually opened and marked
+	 * unreachable objects with USED. Do that now to make --dangling, etc
+	 * accurate.
+	 */
+	if (connectivity_only && (show_dangling || write_lost_and_found)) {
+		/*
+		 * Even though we already have a "struct object" for each of
+		 * these in memory, we must not iterate over the internal
+		 * object hash as we do below. Our loop would potentially
+		 * resize the hash, making our iteration invalid.
+		 *
+		 * Instead, we'll just go back to the source list of objects,
+		 * and ignore any that weren't present in our earlier
+		 * traversal.
+		 */
+		for_each_loose_object(mark_loose_unreachable_referents, NULL, 0);
+		for_each_packed_object(mark_packed_unreachable_referents, NULL, 0);
+	}
+
 	/* Look up all the requirements, warn about missing objects.. */
 	max = get_max_object_index();
 	if (verbose)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index c61f972141..49f08d5b9c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -740,7 +740,7 @@ test_expect_success 'fsck detects truncated loose object' '
 # for each of type, we have one version which is referenced by another object
 # (and so while unreachable, not dangling), and another variant which really is
 # dangling.
-test_expect_success 'fsck notices dangling objects' '
+test_expect_success 'create dangling-object repository' '
 	git init dangling &&
 	(
 		cd dangling &&
@@ -751,19 +751,34 @@ test_expect_success 'fsck notices dangling objects' '
 		commit=$(git commit-tree $tree) &&
 		dcommit=$(git commit-tree -p $commit $tree) &&
 
-		cat >expect <<-EOF &&
+		cat >expect <<-EOF
 		dangling blob $dblob
 		dangling commit $dcommit
 		dangling tree $dtree
 		EOF
+	)
+'
 
+test_expect_success 'fsck notices dangling objects' '
+	(
+		cd dangling &&
 		git fsck >actual &&
 		# the output order is non-deterministic, as it comes from a hash
 		sort <actual >actual.sorted &&
 		test_i18ncmp expect actual.sorted
 	)
 '
 
+test_expect_success 'fsck --connectivity-only notices dangling objects' '
+	(
+		cd dangling &&
+		git fsck --connectivity-only >actual &&
+		# the output order is non-deterministic, as it comes from a hash
+		sort <actual >actual.sorted &&
+		test_i18ncmp expect actual.sorted
+	)
+'
+
 test_expect_success 'fsck $name notices bogus $name' '
 	test_must_fail git fsck bogus &&
 	test_must_fail git fsck $ZERO_OID
-- 
2.21.0.684.gc9dc8b89c9
