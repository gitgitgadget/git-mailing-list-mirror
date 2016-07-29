Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5FA1F858
	for <e@80x24.org>; Fri, 29 Jul 2016 04:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbcG2EGO (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 00:06:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:50792 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750729AbcG2EGM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 00:06:12 -0400
Received: (qmail 23995 invoked by uid 102); 29 Jul 2016 04:06:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:06:14 -0400
Received: (qmail 31305 invoked by uid 107); 29 Jul 2016 04:06:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:06:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 00:06:09 -0400
Date:	Fri, 29 Jul 2016 00:06:09 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] t/perf: add tests for many-pack scenarios
Message-ID: <20160729040609.GA22408@sigill.intra.peff.net>
References: <20160729040422.GA19678@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729040422.GA19678@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Git's pack storage does efficient (log n) lookups in a
single packfile's index, but if we have multiple packfiles,
we have to linearly search each for a given object.  This
patch introduces some timing tests for cases where we have a
large number of packs, so that we can measure any
improvements we make in the following patches.

The main thing we want to time is object lookup. To do this,
we measure "git rev-list --objects --all", which does a
fairly large number of object lookups (essentially one per
object in the repository).

However, we also measure the time to do a full repack, which
is interesting for two reasons. One is that in addition to
the usual pack lookup, it has its own linear iteration over
the list of packs. And two is that because it it is the tool
one uses to go from an inefficient many-pack situation back
to a single pack, we care about its performance not only at
marginal numbers of packs, but at the extreme cases (e.g.,
if you somehow end up with 5,000 packs, it is the only way
to get back to 1 pack, so we need to make sure it performs
well).

We measure the performance of each command in three
scenarios: 1 pack, 50 packs, and 1,000 packs.

The 1-pack case is a baseline; any optimizations we do to
handle multiple packs cannot possibly perform better than
this.

The 50-pack case is as far as Git should generally allow
your repository to go, if you have auto-gc enabled with the
default settings. So this represents the maximum performance
improvement we would expect under normal circumstances.

The 1,000-pack case is hopefully rare, though I have seen it
in the wild where automatic maintenance was broken for some
time (and the repository continued to receive pushes). This
represents cases where we care less about general
performance, but want to make sure that a full repack
command does not take excessively long.

Signed-off-by: Jeff King <peff@peff.net>
---
By the way, a caution before you run this. It takes one the order of an
hour to run on linux.git. So if you're comparing a few builds, be
patient. :)

 t/perf/p5303-many-packs.sh | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100755 t/perf/p5303-many-packs.sh

diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
new file mode 100755
index 0000000..3779851
--- /dev/null
+++ b/t/perf/p5303-many-packs.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description='performance with large numbers of packs'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+# A real many-pack situation would probably come from having a lot of pushes
+# over time. We don't know how big each push would be, but we can fake it by
+# just walking the first-parent chain and having every 5 commits be their own
+# "push". This isn't _entirely_ accurate, as real pushes would have some
+# duplicate objects due to thin-pack fixing, but it's a reasonable
+# approximation.
+#
+# And then all of the rest of the objects can go in a single packfile that
+# represents the state before any of those pushes (actually, we'll generate
+# that first because in such a setup it would be the oldest pack, and we sort
+# the packs by reverse mtime inside git).
+repack_into_n () {
+	rm -rf staging &&
+	mkdir staging &&
+
+	git rev-list --first-parent HEAD |
+	sed -n '1~5p' |
+	head -n "$1" |
+	perl -e 'print reverse <>' \
+	>pushes
+
+	# create base packfile
+	head -n 1 pushes |
+	git pack-objects --delta-base-offset --revs staging/pack
+
+	# and then incrementals between each pair of commits
+	last= &&
+	while read rev
+	do
+		if test -n "$last"; then
+			{
+				echo "$rev" &&
+				echo "^$last"
+			} |
+			git pack-objects --delta-base-offset --revs \
+				staging/pack || return 1
+		fi
+		last=$rev
+	done <pushes &&
+
+	# and install the whole thing
+	rm -f .git/objects/pack/* &&
+	mv staging/* .git/objects/pack/
+}
+
+# Pretend we just have a single branch and no reflogs, and that everything is
+# in objects/pack; that makes our fake pack-building via repack_into_n()
+# much simpler.
+test_expect_success 'simplify reachability' '
+	tip=$(git rev-parse --verify HEAD) &&
+	git for-each-ref --format="option no-deref%0adelete %(refname)" |
+	git update-ref --stdin &&
+	rm -rf .git/logs &&
+	git update-ref refs/heads/master $tip &&
+	git symbolic-ref HEAD refs/heads/master &&
+	git repack -ad
+'
+
+for nr_packs in 1 50 1000
+do
+	test_expect_success "create $nr_packs-pack scenario" '
+		repack_into_n $nr_packs
+	'
+
+	test_perf "rev-list ($nr_packs)" '
+		git rev-list --objects --all >/dev/null
+	'
+
+	# This simulates the interesting part of the repack, which is the
+	# actual pack generation, without smudging the on-disk setup
+	# between trials.
+	test_perf "repack ($nr_packs)" '
+		git pack-objects --keep-true-parents \
+		  --honor-pack-keep --non-empty --all \
+		  --reflog --indexed-objects --delta-base-offset \
+		  --stdout </dev/null >/dev/null
+	'
+done
+
+test_done
-- 
2.9.2.607.g98dce7b

