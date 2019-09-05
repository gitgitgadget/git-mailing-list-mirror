Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1621F461
	for <e@80x24.org>; Thu,  5 Sep 2019 06:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfIEGrZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 02:47:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:40090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730778AbfIEGrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 02:47:25 -0400
Received: (qmail 25283 invoked by uid 109); 5 Sep 2019 06:47:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 06:47:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24319 invoked by uid 111); 5 Sep 2019 06:49:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 02:49:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 02:47:24 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, stolee@gmail.com,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
Message-ID: <20190905064723.GC21450@sigill.intra.peff.net>
References: <cover.1567563244.git.me@ttaylorr.com>
 <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
 <20190904030456.GA28836@sigill.intra.peff.net>
 <20190904211847.GA20904@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904211847.GA20904@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 04, 2019 at 05:18:47PM -0400, Taylor Blau wrote:

> All of this makes sense to me, so I'm wondering what part(s) of this you
> feel are worth addressing in this first patch series. Presumably, there
> is a longer series that we _could_ write which would introduce a new
> 'corrupt' field and then check for it here.
> 
> But, I'm hesitant to write those patches, since I only have this one
> call-site in mind. If we introduce 'corrupt', I feel it would be best to
> use it uniformly, instead of only checking it here, and relying on other
> bespoke mechanisms to detect corruption elsewhere.
> 
> So, I'm content to write the pseudo-code you provided above (which is to
> say, call and check both 'parse_commit_no_graph', _and_
> 'get_commit_tree_oid'), because I think that it's expedient, and fix the
> issue which I'm pointing out here.

I'd actually be willing to just take the patch you have here, and
consider the "parsed but we saw an error" thing as an oddity of the
object code.  IOW, we shouldn't _have_ to be double-checking here.
Looking for an error return from parse_commit() should really be all a
caller needs to do. Once that's fixed, then your code would just be
doing the right thing.

That said, there's another unhandled case, I think: lookup_tree() might
return NULL (if somebody previously saw that oid as a non-tree), and
parse_commit() wouldn't even notice and return an error!

IMHO that's also something that parse_commit() should be returning an
error for. And it's probably a lot easier to trigger versus the "parsed
earlier but corrupted" thing.

So it might be worth doing the NULL tree check here in the meantime. I
dunno.

Below is a sketch of what I'm thinking parse_commit() should do:

  - remember when an earlier parse returned an error, so we can repeat
    that error (this requires some unfortunate bit-field adjusting)

  - notice a lookup_tree failure

  - likewise, notice a lookup_parent failure

---
diff --git a/commit.c b/commit.c
index a98de16e3d..7e415932b7 100644
--- a/commit.c
+++ b/commit.c
@@ -391,7 +391,9 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph)
+static int parse_commit_buffer_1(struct repository *r, struct commit *item,
+				 const void *buffer, unsigned long size,
+				 int check_graph)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -401,9 +403,6 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	const int tree_entry_len = the_hash_algo->hexsz + 5;
 	const int parent_entry_len = the_hash_algo->hexsz + 7;
 
-	if (item->object.parsed)
-		return 0;
-	item->object.parsed = 1;
 	tail += size;
 	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
 			bufptr[tree_entry_len] != '\n')
@@ -412,6 +411,10 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
 	set_commit_tree(item, lookup_tree(r, &parent));
+	if (!item->maybe_tree)
+		return error("bad tree pointer %s in commit %s",
+			     oid_to_hex(&parent),
+			     oid_to_hex(&item->object.oid));
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
@@ -431,15 +434,19 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
 		new_parent = lookup_commit(r, &parent);
-		if (new_parent)
-			pptr = &commit_list_insert(new_parent, pptr)->next;
+		if (!new_parent)
+			return error("bad parent %s in commit %s",
+				     oid_to_hex(&parent),
+				     oid_to_hex(&item->object.oid));
+		pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
 	if (graft) {
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
 			new_parent = lookup_commit(r,
 						   &graft->parent[i]);
+			/* Here we ignore bogus grafts. Also should be an error? */
 			if (!new_parent)
 				continue;
 			pptr = &commit_list_insert(new_parent, pptr)->next;
@@ -453,6 +460,23 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	return 0;
 }
 
+int parse_commit_buffer(struct repository *r, struct commit *item,
+			const void *buffer, unsigned long size,
+			int check_graph)
+{
+	int ret;
+
+	if (item->object.parsed)
+		return item->object.corrupt ? -1 : 0;
+	item->object.parsed = 1;
+
+	ret = parse_commit_buffer_1(r, item, buffer, size, check_graph);
+	if (ret < 0)
+		item->object.corrupt = 1;
+
+	return ret;
+}
+
 int repo_parse_commit_internal(struct repository *r,
 			       struct commit *item,
 			       int quiet_on_missing,
diff --git a/object.h b/object.h
index 0120892bbd..b83d3964ad 100644
--- a/object.h
+++ b/object.h
@@ -59,7 +59,7 @@ struct object_array {
 
 /*
  * object flag allocation:
- * revision.h:               0---------10                              25----28
+ * revision.h:               0---------10                              24----27
  * fetch-pack.c:             01
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
@@ -78,13 +78,14 @@ struct object_array {
  * builtin/show-branch.c:    0-------------------------------------------26
  * builtin/unpack-objects.c:                                 2021
  */
-#define FLAG_BITS  29
+#define FLAG_BITS  28
 
 /*
  * The object type is stored in 3 bits.
  */
 struct object {
 	unsigned parsed : 1;
+	unsigned corrupt : 1;
 	unsigned type : TYPE_BITS;
 	unsigned flags : FLAG_BITS;
 	struct object_id oid;
diff --git a/revision.h b/revision.h
index 4134dc6029..5c0b831b37 100644
--- a/revision.h
+++ b/revision.h
@@ -33,7 +33,7 @@
 #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)
 
 #define TOPO_WALK_EXPLORED	(1u<<27)
-#define TOPO_WALK_INDEGREE	(1u<<28)
+#define TOPO_WALK_INDEGREE	(1u<<24)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
