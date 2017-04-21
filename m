Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE4A207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 19:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425663AbdDUTwh (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 15:52:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:37920 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425602AbdDUTwg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 15:52:36 -0400
Received: (qmail 7859 invoked by uid 109); 21 Apr 2017 17:05:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 17:05:53 +0000
Received: (qmail 17656 invoked by uid 111); 21 Apr 2017 17:06:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 13:06:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 13:05:51 -0400
Date:   Fri, 21 Apr 2017 13:05:51 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
Message-ID: <20170421170551.jsj47btuyfwvmc62@sigill.intra.peff.net>
References: <20170420205214.GB4989@hank>
 <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <20170420212436.GC4989@hank>
 <CAP8UFD2f9g__ykCjReSoaAUvFTPmgRDbsWFQMRrFoFw8haV0uA@mail.gmail.com>
 <CAP8UFD36dcm9EfvtWqqEON1Muyyd7_j3uRtr6C2bLzXZN5n1MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD36dcm9EfvtWqqEON1Muyyd7_j3uRtr6C2bLzXZN5n1MQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 05:23:51PM +0200, Christian Couder wrote:

> > I just tried on "pu" and only the first test
> > (t7009-filter-branch-null-sha1.sh) fails there.
> 
> I bisected this test's failure (when using
> GIT_TEST_SPLIT_INDEX=YesPlease) to e6a1dd77e1 (read-cache: regenerate
> shared index if necessary, 2017-02-27).
> 
> The failing test is the following:
> 
> test_expect_success 'filter commands are still checked' '
>         test_must_fail git filter-branch \
>                 --force --prune-empty \
>                 --index-filter "git rm --cached --ignore-unmatch three.t"
> '
> 
> And if I add the following at the beginning of the test:
> 
>         git config splitIndex.maxPercentChange 100 &&
> 
> the test then passes.
> 
> So It looks like in split index mode the test doesn't expect the
> shared index to be regenerated.
> Maybe Peff, as he is the author of this test, or Duy have an idea about this?

Right. The test has a broken tree with a null sha1, and filter-branch
will do:

  GIT_ALLOW_NULL_SHA1=1 git read-tree $broken

to allow it to enter the index. We expect that further commands that
write out the index will not allow it (so you can run commands that
remove the broken entry, but not ones that leave it).

So without split index, this command:

  git rm --cached three.t

will fail. But in split-index mode, the broken entry is in another
index, and is left untouched. I'm not sure there's a way to reconcile
the split-index behavior with what the test is expecting; it's
inherently optimizing out the thing that the test wants to check.

Probably we should catch the broken index entry when we write out the
tree, too. We usually do catch missing objects, but this one is a
gitlink, so it's OK for it to be missing. I think we should catch the
null sha1 specifically, though, as that was the intent of the commit
that added t7009.

So the patch below _almost_ works. It fixes the failing test. But note
the new test I added, with a noop index-filter. That checks that we
don't retain the cache-tree extension from the bogus tree when reading.
But for some reason it fails on split-index mode. Does cache-tree stuff
somehow work differently there?

diff --git a/cache-tree.c b/cache-tree.c
index 345ea3596..34baa6d85 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -354,7 +354,9 @@ static int update_one(struct cache_tree *it,
 			entlen = pathlen - baselen;
 			i++;
 		}
-		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
+
+		if (is_null_sha1(sha1) ||
+		    (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
diff --git a/read-cache.c b/read-cache.c
index b3d0f3c30..15a4779f2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2197,6 +2197,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	int drop_cache_tree = 0;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2247,6 +2248,8 @@ static int do_write_index(struct index_state *istate, int newfd,
 				warning(msg, ce->name);
 			else
 				return error(msg, ce->name);
+
+			drop_cache_tree = 1;
 		}
 		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
 			return -1;
@@ -2265,7 +2268,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && istate->cache_tree) {
+	if (!strip_extensions && !drop_cache_tree && istate->cache_tree) {
 		struct strbuf sb = STRBUF_INIT;
 
 		cache_tree_write(&sb, istate->cache_tree);
diff --git a/t/t7009-filter-branch-null-sha1.sh b/t/t7009-filter-branch-null-sha1.sh
index c27f90f28..a8d9ec498 100755
--- a/t/t7009-filter-branch-null-sha1.sh
+++ b/t/t7009-filter-branch-null-sha1.sh
@@ -31,6 +31,12 @@ test_expect_success 'setup: bring HEAD and index in sync' '
 	git commit -a -m "back to normal"
 '
 
+test_expect_success 'noop filter-branch complains' '
+	test_must_fail git filter-branch \
+		--force --prune-empty \
+		--index-filter "true"
+'
+
 test_expect_success 'filter commands are still checked' '
 	test_must_fail git filter-branch \
 		--force --prune-empty \
