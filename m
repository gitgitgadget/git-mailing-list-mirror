Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E975CE7AFE
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 04:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjI1EiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 00:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1EiK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 00:38:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D032F12A
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 21:38:08 -0700 (PDT)
Received: (qmail 3669 invoked by uid 109); 28 Sep 2023 04:38:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Sep 2023 04:38:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9647 invoked by uid 111); 28 Sep 2023 04:38:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Sep 2023 00:38:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Sep 2023 00:38:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 1/6] commit-graph: factor out chain opening function
Message-ID: <20230928043807.GA58367@coredump.intra.peff.net>
References: <20230928043746.GB57926@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928043746.GB57926@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The load_commit_graph_chain() function opens the chain file and all of
the slices of graph that it points to. If there is no chain file (which
is a totally normal condition), we return NULL. But if we run into
errors with the chain file or loading the actual graph data, we also
return NULL, and the caller cannot tell the difference.

The caller can check for ENOENT for the unremarkable "no such file"
case. But I'm hesitant to assume that the rest of the function would
never accidentally set errno to ENOENT itself, since it is opening the
slice files (and that would mean the caller fails to notice a real
error).

So let's break this into two functions: one to open the file, and one to
actually load it. This matches the interface we provide for the
non-chain graph file, which will also come in handy in a moment when we
fix some bugs in the "git commit-graph verify" code.

Some notes:

  - I've kept the "1 is good, 0 is bad" return convention (and the weird
    "fd" out-parameter) used by the matching open_commit_graph()
    function and other parts of the commit-graph code. This is unlike
    most of the rest of Git (which would just return the fd, with -1 for
    error), but it makes sense to stay consistent with the adjacent bits
    of the API here.

  - The existing chain loading function will quietly return if the file
    is too small to hold a single entry. I've retained that behavior
    (and explicitly set ENOENT in the opener function) for now, under
    the notion that it's probably valid (though I'd imagine unusual) to
    have an empty chain file.

There are two small behavior changes here, but I think both are strictly
positive:

  1. The original blindly did a stat() before checking if fopen()
     succeeded, meaning we were making a pointless extra stat call.

  2. We now use fstat() to check the file size. The previous code using
     a regular stat() on the pathname meant we could technically race
     with somebody updating the chain file, and end up with a size that
     does not match what we just opened with fopen(). I doubt anybody
     ever hit this in practice, but it may have caused an out-of-bounds
     read.

We'll retain the load_commit_graph_chain() function which does both the
open and reading steps (most existing callers do not care about seeing
errors anyway, since loading commit-graphs is optimistic).

Signed-off-by: Jeff King <peff@peff.net>
---
Same as v1.

 commit-graph.c | 58 +++++++++++++++++++++++++++++++++-----------------
 commit-graph.h |  3 +++
 2 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 5e8a3a5085..12cdd9af8e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -513,31 +513,34 @@ static int add_graph_to_chain(struct commit_graph *g,
 	return 1;
 }
 
-static struct commit_graph *load_commit_graph_chain(struct repository *r,
-						    struct object_directory *odb)
+int open_commit_graph_chain(const char *chain_file,
+			    int *fd, struct stat *st)
+{
+	*fd = git_open(chain_file);
+	if (*fd < 0)
+		return 0;
+	if (fstat(*fd, st)) {
+		close(*fd);
+		return 0;
+	}
+	if (st->st_size <= the_hash_algo->hexsz) {
+		close(*fd);
+		errno = ENOENT;
+		return 0;
+	}
+	return 1;
+}
+
+struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
+						   int fd, struct stat *st)
 {
 	struct commit_graph *graph_chain = NULL;
 	struct strbuf line = STRBUF_INIT;
-	struct stat st;
 	struct object_id *oids;
 	int i = 0, valid = 1, count;
-	char *chain_name = get_commit_graph_chain_filename(odb);
-	FILE *fp;
-	int stat_res;
+	FILE *fp = xfdopen(fd, "r");
 
-	fp = fopen(chain_name, "r");
-	stat_res = stat(chain_name, &st);
-	free(chain_name);
-
-	if (!fp)
-		return NULL;
-	if (stat_res ||
-	    st.st_size <= the_hash_algo->hexsz) {
-		fclose(fp);
-		return NULL;
-	}
-
-	count = st.st_size / (the_hash_algo->hexsz + 1);
+	count = st->st_size / (the_hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);
 
 	prepare_alt_odb(r);
@@ -585,6 +588,23 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	return graph_chain;
 }
 
+static struct commit_graph *load_commit_graph_chain(struct repository *r,
+						    struct object_directory *odb)
+{
+	char *chain_file = get_commit_graph_chain_filename(odb);
+	struct stat st;
+	int fd;
+	struct commit_graph *g = NULL;
+
+	if (open_commit_graph_chain(chain_file, &fd, &st)) {
+		/* ownership of fd is taken over by load function */
+		g = load_commit_graph_chain_fd_st(r, fd, &st);
+	}
+
+	free(chain_file);
+	return g;
+}
+
 /*
  * returns 1 if and only if all graphs in the chain have
  * corrected commit dates stored in the generation_data chunk.
diff --git a/commit-graph.h b/commit-graph.h
index 5e534f0fcc..3b662fd2b5 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -26,6 +26,7 @@ struct string_list;
 char *get_commit_graph_filename(struct object_directory *odb);
 char *get_commit_graph_chain_filename(struct object_directory *odb);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
+int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st);
 
 /*
  * Given a commit struct, try to fill the commit struct info, including:
@@ -105,6 +106,8 @@ struct commit_graph {
 struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 						 int fd, struct stat *st,
 						 struct object_directory *odb);
+struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
+						   int fd, struct stat *st);
 struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb);
 
-- 
2.42.0.773.ga6e30199be

