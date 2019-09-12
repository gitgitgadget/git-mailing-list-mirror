Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532381F463
	for <e@80x24.org>; Thu, 12 Sep 2019 14:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbfILOoq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 10:44:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:47956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732592AbfILOoq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 10:44:46 -0400
Received: (qmail 13985 invoked by uid 109); 12 Sep 2019 14:44:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Sep 2019 14:44:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8342 invoked by uid 111); 12 Sep 2019 14:46:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2019 10:46:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Sep 2019 10:44:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH v2 2/2] upload-pack: disable commit graph more gently for
 shallow traversal
Message-ID: <20190912144444.GB25101@sigill.intra.peff.net>
References: <20190912144122.GA27815@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912144122.GA27815@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the client has asked for certain shallow options like
"deepen-since", we do a custom rev-list walk that pretends to be
shallow. Before doing so, we have to disable the commit-graph, since it
is not compatible with the shallow view of the repository. That's
handled by 829a321569 (commit-graph: close_commit_graph before shallow
walk, 2018-08-20). That commit literally closes and frees our
repo->objects->commit_graph struct.

That creates an interesting problem for commits that have _already_ been
parsed using the commit graph. Their commit->object.parsed flag is set,
their commit->graph_pos is set, but their commit->maybe_tree may still
be NULL. When somebody later calls repo_get_commit_tree(), we see that
we haven't loaded the tree oid yet and try to get it from the commit
graph. But since it has been freed, we segfault!

So the root of the issue is a data dependency between the commit's
lazy-load of the tree oid and the fact that the commit graph can go
away mid-process. How can we resolve it?

There are a couple of general approaches:

  1. The obvious answer is to avoid loading the tree from the graph when
     we see that it's NULL. But then what do we return for the tree oid?
     If we return NULL, our caller in do_traverse() will rightly
     complain that we have no tree. We'd have to fallback to loading the
     actual commit object and re-parsing it. That requires teaching
     parse_commit_buffer() to understand re-parsing (i.e., not starting
     from a clean slate and not leaking any allocated bits like parent
     list pointers).

  2. When we close the commit graph, walk through the set of in-memory
     objects and clear any graph_pos pointers. But this means we also
     have to "unparse" any such commits so that we know they still need
     to open the commit object to fill in their trees. So it's no less
     complicated than (1), and is more expensive (since we clear objects
     we might not later need).

  3. Stop freeing the commit-graph struct. Continue to let it be used
     for lazy-loads of tree oids, but let upload-pack specify that it
     shouldn't be used for further commit parsing.

  4. Push the whole shallow rev-list out to its own sub-process, with
     the commit-graph disabled from the start, giving it a clean memory
     space to work from.

I've chosen (3) here. Options (1) and (2) would work, but are
non-trivial to implement. Option (4) is more expensive, and I'm not sure
how complicated it is (shelling out for the actual rev-list part is
easy, but we do then parse the resulting commits internally, and I'm not
clear which parts need to be handling shallow-ness).

The new test in t5500 triggers this segfault, but see the comments there
for how horribly intimate it has to be with how both upload-pack and
commit graphs work.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c        | 12 ++++++++++++
 commit-graph.h        |  6 ++++++
 repository.h          |  3 +++
 t/t5500-fetch-pack.sh | 38 ++++++++++++++++++++++++++++++++++++++
 upload-pack.c         |  2 +-
 5 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index baeaf0d1bf..bbde647f8b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -468,6 +468,13 @@ static int prepare_commit_graph(struct repository *r)
 {
 	struct object_directory *odb;
 
+	/*
+	 * This must come before the "already attempted?" check below, because
+	 * we want to disable even an already-loaded graph file.
+	 */
+	if (r->commit_graph_disabled)
+		return 0;
+
 	if (r->objects->commit_graph_attempted)
 		return !!r->objects->commit_graph;
 	r->objects->commit_graph_attempted = 1;
@@ -2101,3 +2108,8 @@ void free_commit_graph(struct commit_graph *g)
 	free(g->filename);
 	free(g);
 }
+
+void disable_commit_graph(struct repository *r)
+{
+	r->commit_graph_disabled = 1;
+}
diff --git a/commit-graph.h b/commit-graph.h
index 486e64e591..7f5c933fa2 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -107,4 +107,10 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 void close_commit_graph(struct raw_object_store *);
 void free_commit_graph(struct commit_graph *);
 
+/*
+ * Disable further use of the commit graph in this process when parsing a
+ * "struct commit".
+ */
+void disable_commit_graph(struct repository *r);
+
 #endif
diff --git a/repository.h b/repository.h
index 4da275e73f..84335292cd 100644
--- a/repository.h
+++ b/repository.h
@@ -124,6 +124,9 @@ struct repository {
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
 
+	/* True if commit-graph has been disabled within this process. */
+	int commit_graph_disabled;
+
 	/* Configurations */
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8210f63d41..244c3e7062 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -783,6 +783,44 @@ test_expect_success 'clone shallow since selects no commits' '
 	)
 '
 
+# A few subtle things about the request in this test:
+#
+#  - the server must have commit-graphs present and enabled
+#
+#  - the history is such that our want/have share a common ancestor ("base"
+#    here)
+#
+#  - we send only a single have, which is fewer than a normal client would
+#    send. This ensures that we don't parse "base" up front with
+#    parse_object(), but rather traverse to it as a parent while deciding if we
+#    can stop the "have" negotiation, and call parse_commit(). The former
+#    sees the actual object data and so always loads the three oid, whereas the
+#    latter will try to load it lazily.
+#
+#  - we must use protocol v2, because it handles the "have" negotiation before
+#    processing the shallow directives
+#
+test_expect_success 'shallow since with commit graph and already-seen commit' '
+	test_create_repo shallow-since-graph &&
+	(
+	cd shallow-since-graph &&
+	test_commit base &&
+	test_commit master &&
+	git checkout -b other HEAD^ &&
+	test_commit other &&
+	git commit-graph write --reachable &&
+	git config core.commitGraph true &&
+
+	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
+	0012command=fetch
+	00010013deepen-since 1
+	0032want $(git rev-parse other)
+	0032have $(git rev-parse master)
+	0000
+	EOF
+	)
+'
+
 test_expect_success 'shallow clone exclude tag two' '
 	test_create_repo shallow-exclude &&
 	(
diff --git a/upload-pack.c b/upload-pack.c
index 222cd3ad89..135bb3f6cc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -722,7 +722,7 @@ static void deepen_by_rev_list(struct packet_writer *writer, int ac,
 {
 	struct commit_list *result;
 
-	close_commit_graph(the_repository->objects);
+	disable_commit_graph(the_repository);
 	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
 	send_shallow(writer, result);
 	free_commit_list(result);
-- 
2.23.0.667.gcccf1fbb03
