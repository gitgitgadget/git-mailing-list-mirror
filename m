Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16898ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 21:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIFVEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIFVEj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 17:04:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1012DC
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 14:04:36 -0700 (PDT)
Received: (qmail 19338 invoked by uid 109); 6 Sep 2022 21:04:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Sep 2022 21:04:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5774 invoked by uid 111); 6 Sep 2022 21:04:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Sep 2022 17:04:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Sep 2022 17:04:35 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] rev-list: disable commit graph with --verify-objects
Message-ID: <Yxe1422xPYoMNlkG@coredump.intra.peff.net>
References: <Yxe0k++LA/UfFLF/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxe0k++LA/UfFLF/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the point of --verify-objects is to actually load and checksum the
bytes of each object, optimizing out reads using the commit graph runs
contrary to our goal.

The most targeted way to implement this would be for the revision
traversal code to check revs->verify_objects and avoid using the commit
graph. But it's difficult to be sure we've hit all of the correct spots.
For instance, I started this patch by writing the first of the included
test cases, where the corrupted commit is directly on rev-list's command
line. And that is easy to fix by teaching get_reference() to check
revs->verify_objects before calling lookup_commit_in_graph().

But that doesn't cover the second test case: when we traverse to a
corrupted commit, we'd parse the parent in process_parents(). So we'd
need to check there, too. And it keeps going. In handle_commit() we
sometimes parses commits, too, though I couldn't figure out a way to
trigger it that did not already parse via get_reference() or tag
peeling. And try_to_simplify_commit() has its own parse call, and so on.

So it seems like the safest thing is to just disable the commit graph
for the whole process when we see the --verify-objects option. We can do
that either in builtin/rev-list.c, where we use the option, or in
revision.c, where we parse it. There are some subtleties:

  - putting it in rev-list.c is less surprising in some ways, because
    there we know we are just doing a single traversal. In a command
    which does multiple traversals in a single process, it's rather
    unexpected to globally disable the commit graph.

  - putting it in revision.c is less surprising in some ways, because
    the caller does not have to remember to disable the graph
    themselves. But this is already tricky! The verify_objects flag in
    rev_info doesn't do anything by itself. The caller has to provide an
    object callback which does the right thing.

  - for that reason, in practice nobody but rev-list uses this option in
    the first place. So the distinction is probably not important either
    way. Arguably it should just be an option of rev-list, and not the
    general revision machinery; right now you can run "git log
    --verify-objects", but it does not actually do anything useful.

  - checking for a parsed revs.verify_objects flag in rev-list.c is too
    late. By that time we've already passed the arguments to
    setup_revisions(), which will have parsed the commits using the
    graph.

So this commit disables the graph as soon as we see the option in
revision.c. That's a pretty broad hammer, but it does what we want, and
in practice nobody but rev-list is using this flag anyway.

The tests cover both the "tip" and "parent" cases. Obviously our hammer
hits them both in this case, but it's good to check both in case
somebody later tries the more focused approach.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c      |  1 +
 t/t1450-fsck.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/revision.c b/revision.c
index ee702e498a..00f9c7943b 100644
--- a/revision.c
+++ b/revision.c
@@ -2426,6 +2426,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->tree_objects = 1;
 		revs->blob_objects = 1;
 		revs->verify_objects = 1;
+		disable_commit_graph(revs->repo);
 	} else if (!strcmp(arg, "--unpacked")) {
 		revs->unpacked = 1;
 	} else if (starts_with(arg, "--unpacked=")) {
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 53c2aa10b7..f9a1bc5de7 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -507,6 +507,34 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 	test_i18ngrep -q "error: hash mismatch $(dirname $new)$(test_oid ff_2)" out
 '
 
+test_expect_success 'set up repository with commit-graph' '
+	git init corrupt-graph &&
+	(
+		cd corrupt-graph &&
+		test_commit one &&
+		test_commit two &&
+		git commit-graph write --reachable
+	)
+'
+
+corrupt_graph_obj () {
+	oid=$(git -C corrupt-graph rev-parse "$1") &&
+	obj=corrupt-graph/.git/objects/$(test_oid_to_path $oid) &&
+	test_when_finished 'mv backup $obj' &&
+	mv $obj backup &&
+	echo garbage >$obj
+}
+
+test_expect_success 'rev-list --verify-objects with commit graph (tip)' '
+	corrupt_graph_obj HEAD &&
+	test_must_fail git -C corrupt-graph rev-list --verify-objects HEAD
+'
+
+test_expect_success 'rev-list --verify-objects with commit graph (parent)' '
+	corrupt_graph_obj HEAD^ &&
+	test_must_fail git -C corrupt-graph rev-list --verify-objects HEAD
+'
+
 test_expect_success 'force fsck to ignore double author' '
 	git cat-file commit HEAD >basis &&
 	sed "s/^author .*/&,&/" <basis | tr , \\n >multiple-authors &&
-- 
2.37.3.1134.gfd534b3986
