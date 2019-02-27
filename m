Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2453920248
	for <e@80x24.org>; Wed, 27 Feb 2019 14:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfB0O7b (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 09:59:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:59906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730756AbfB0O7a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 09:59:30 -0500
Received: (qmail 3330 invoked by uid 109); 27 Feb 2019 14:59:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Feb 2019 14:59:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6286 invoked by uid 111); 27 Feb 2019 14:59:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Feb 2019 09:59:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Feb 2019 09:59:28 -0500
Date:   Wed, 27 Feb 2019 09:59:28 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH] doc/fsck: discuss mix of --connectivity-only and
 --dangling
Message-ID: <20190227145928.GA3727@sigill.intra.peff.net>
References: <20190227145549.GA3255@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227145549.GA3255@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 09:55:49AM -0500, Jeff King wrote:

> We could make the two cases work identically by taking a separate pass
> over the unreachable objects, parsing them and marking objects they
> refer to as USED. That would still avoid parsing any blobs, but we'd pay
> the cost to access any unreachable commits and trees. Since the point of
> --connectivity-only is to quickly report whether all reachable objects
> are present, I'd argue that it's not worth slowing it down to produce
> a better-analyzed dangling list.
> 
> Instead, let's document this somewhat surprising property of
> connectivity-only. If somebody really wants to the extra analysis, we
> can add a separate option to enable it.

I'm actually a little torn on this. We could consider this a bug, and
the "option" to disable it when you want things to go fast is to say
"--no-dangling". That leaves no way to say "show me the list of
unreachable objects, but don't bother spending extra time on dangling
analysis". But I don't think I've ever really wanted that list of
unreachable objects anyway (and besides, you could do it pretty easily
with cat-file, rev-list, and comm).

So I sketched up what it might look like to just fix the bug (but kick
in only when needed), which is below.

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
