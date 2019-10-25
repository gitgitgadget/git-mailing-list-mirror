Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83F91F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 21:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfJYVUW (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 17:20:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:58704 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725783AbfJYVUW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 17:20:22 -0400
Received: (qmail 20127 invoked by uid 109); 25 Oct 2019 21:20:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Oct 2019 21:20:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14237 invoked by uid 111); 25 Oct 2019 21:23:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2019 17:23:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Oct 2019 17:20:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/23] fsck: unify object-name code
Message-ID: <20191025212020.GA25625@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
 <20191018045613.GI17879@sigill.intra.peff.net>
 <xmqq8spafzjt.fsf@gitster-ct.c.googlers.com>
 <20191024180710.GC12892@sigill.intra.peff.net>
 <xmqqa79pecec.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa79pecec.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 25, 2019 at 12:23:39PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Heh. I originally wrote just "put" and "get" for brevity, but then
> > worried that wasn't clear enough. Let's just use the full names. We can
> > afford the extra few bytes, and it makes it easier if we later need to
> > grep for them or whatever. Here's a replacement patch (I won't send the
> > whole series just yet, as it seems it hasn't gotten a whole lot of
> > review so far).
> 
> It seems that you sent the original instead X-<.
> 
> I'll just replace the original 09/23 with the following squashed in
> for now.

Doh. Perhaps you have a brown paper bag I could borrow, as well. :)

What you showed matches what I meant to send. If I can trouble you once
more on this series, can you swap out the subject for patch 4 ("remember
commit/tag parse failures", as suggested by Jonathan Tan? Here's a
replacement patch (really this time!), but the subject is the only
different thing:

-- >8 --
Subject: [PATCH] commit, tag: don't set parsed bit for parse failures

If we can't parse a commit, then parse_commit() will return an error
code. But it _also_ sets the "parsed" flag, which tells us not to bother
trying to re-parse the object. That means that subsequent parses have no
idea that the information in the struct may be bogus.  I.e., doing this:

  parse_commit(commit);
  ...
  if (parse_commit(commit) < 0)
          die("commit is broken");

will never trigger the die(). The second parse_commit() will see the
"parsed" flag and quietly return success.

There are two obvious ways to fix this:

  1. Stop setting "parsed" until we've successfully parsed.

  2. Keep a second "corrupt" flag to indicate that we saw an error (and
     when the parsed flag is set, return 0/-1 depending on the corrupt
     flag).

This patch does option 1. The obvious downside versus option 2 is that
we might continually re-parse a broken object. But in practice,
corruption like this is rare, and we typically die() or return an error
in the caller. So it's OK not to worry about optimizing for corruption.
And it's much simpler: we don't need to use an extra bit in the object
struct, and callers which check the "parsed" flag don't need to learn
about the corrupt bit, too.

There's no new test here, because this case is already covered in t5318.
Note that we do need to update the expected message there, because we
now detect the problem in the return from "parse_commit()", and not with
a separate check for a NULL tree. In fact, we can now ditch that
explicit tree check entirely, as we're covered robustly by this change
(and the previous recent change to treat a NULL tree as a parse error).

We'll also give tags the same treatment. I don't know offhand of any
cases where the problem can be triggered (it implies somebody ignoring a
parse error earlier in the process), but consistently returning an error
should cause the least surprise.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-graph.c          |  3 ---
 commit.c                | 14 +++++++++++++-
 t/t5318-commit-graph.sh |  2 +-
 tag.c                   | 12 +++++++++++-
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index fc4a43b8d6..852b9c39e6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -855,9 +855,6 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 			die(_("unable to parse commit %s"),
 				oid_to_hex(&(*list)->object.oid));
 		tree = get_commit_tree_oid(*list);
-		if (!tree)
-			die(_("unable to get tree for %s"),
-				oid_to_hex(&(*list)->object.oid));
 		hashwrite(f, tree->hash, hash_len);
 
 		parent = (*list)->parents;
diff --git a/commit.c b/commit.c
index 810419a168..e12e7998ad 100644
--- a/commit.c
+++ b/commit.c
@@ -405,7 +405,18 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 
 	if (item->object.parsed)
 		return 0;
-	item->object.parsed = 1;
+
+	if (item->parents) {
+		/*
+		 * Presumably this is leftover from an earlier failed parse;
+		 * clear it out in preparation for us re-parsing (we'll hit the
+		 * same error, but that's good, since it lets our caller know
+		 * the result cannot be trusted.
+		 */
+		free_commit_list(item->parents);
+		item->parents = NULL;
+	}
+
 	tail += size;
 	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
 			bufptr[tree_entry_len] != '\n')
@@ -462,6 +473,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	if (check_graph)
 		load_commit_graph_info(r, item);
 
+	item->object.parsed = 1;
 	return 0;
 }
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d42b3efe39..127b404856 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -660,7 +660,7 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 		git commit-tree -p "$broken" -m "good" "$tree" >good &&
 		test_must_fail git commit-graph write --stdin-commits \
 			<good 2>test_err &&
-		test_i18ngrep "unable to get tree for" test_err
+		test_i18ngrep "unable to parse commit" test_err
 	)
 '
 
diff --git a/tag.c b/tag.c
index 6a51efda8d..71b544467e 100644
--- a/tag.c
+++ b/tag.c
@@ -141,7 +141,16 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 
 	if (item->object.parsed)
 		return 0;
-	item->object.parsed = 1;
+
+	if (item->tag) {
+		/*
+		 * Presumably left over from a previous failed parse;
+		 * clear it out in preparation for re-parsing (we'll probably
+		 * hit the same error, which lets us tell our current caller
+		 * about the problem).
+		 */
+		FREE_AND_NULL(item->tag);
+	}
 
 	if (size < the_hash_algo->hexsz + 24)
 		return -1;
@@ -192,6 +201,7 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 	else
 		item->date = 0;
 
+	item->object.parsed = 1;
 	return 0;
 }
 
-- 
2.24.0.rc1.670.g28e7e9fef7

