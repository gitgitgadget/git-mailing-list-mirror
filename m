Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB73202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 08:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdGEIAj (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 04:00:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:59770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750867AbdGEIAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 04:00:39 -0400
Received: (qmail 21530 invoked by uid 109); 5 Jul 2017 08:00:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 08:00:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5695 invoked by uid 111); 5 Jul 2017 08:00:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 04:00:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 04:00:36 -0400
Date:   Wed, 5 Jul 2017 04:00:36 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: [PATCH 2/6] t1414: document some reflog-walk oddities
Message-ID: <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since its inception, the general strategy of the reflog-walk
code has been to start with the tip commit for the ref, and
as we traverse replace each commit's parent pointers with
fake parents pointing to the previous reflog entry.

This lets us traverse the reflog as if it were a real
history, but it has some user-visible oddities. Namely:

  1. The fake parents are used for commit selection and
     display. So for example, "--merges" or "--no-merges"
     are useful, because the history appears as a linear
     string. Likewise, pathspec limiting is based on the
     diff between adjacent entries, not the changes actually
     introduced by a commit.

     These are often the same (e.g., because the entry was
     just running "git commit" and the adjacent entry _is_
     the true parent), but it may not be in several common
     cases. For instance, using "git reset" to jump around
     history, or "git checkout" to move HEAD.

  2. We reverse-map each commit back to its reflog. So when
     it comes time to show commit X, we say "a-ha, we added
     X because it was at the tip of the 'foo' reflog, so
     let's show the foo reflog". But this leads to nonsense
     results when you ask to traverse multiple reflogs: if
     two reflogs have the same tip commit, we only map back
     to one of them.

     Instead, we should show each reflog individually, in
     the order the user gave us on the command line.

  2. If the tip of the reflog and the ref tip disagree on
     the current value, we show the ref tip but give no
     indication of the value in the reflog.  This situation
     isn't supposed to happen (since any ref update should
     touch the reflog). But if it does, given that the
     requested operation is to show the reflog, it makes
     sense to prefer that.

This commit adds several expect_failure tests, to show how
the tool ought to behave.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1414-reflog-walk.sh | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100755 t/t1414-reflog-walk.sh

diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
new file mode 100755
index 0000000000..bb847f797d
--- /dev/null
+++ b/t/t1414-reflog-walk.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='various tests of reflog walk (log -g) behavior'
+. ./test-lib.sh
+
+test_expect_success 'set up some reflog entries' '
+	test_commit one &&
+	test_commit two &&
+	git checkout -b side HEAD^ &&
+	test_commit three &&
+	git merge --no-commit master &&
+	echo evil-merge-content >>one.t &&
+	test_tick &&
+	git commit --no-edit -a
+'
+
+do_walk () {
+	git log -g --format="%gd %gs" "$@"
+}
+
+sq="'"
+test_expect_success 'set up expected reflog' '
+	cat >expect.all <<-EOF
+	HEAD@{0} commit (merge): Merge branch ${sq}master${sq} into side
+	HEAD@{1} commit: three
+	HEAD@{2} checkout: moving from master to side
+	HEAD@{3} commit: two
+	HEAD@{4} commit (initial): one
+	EOF
+'
+
+test_expect_success 'reflog walk shows expected logs' '
+	do_walk >actual &&
+	test_cmp expect.all actual
+'
+
+test_expect_failure 'reflog can limit with --no-merges' '
+	grep -v merge expect.all >expect &&
+	do_walk --no-merges >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'reflog can limit with pathspecs' '
+	grep two expect.all >expect &&
+	do_walk -- two.t >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'pathspec limiting handles merges' '
+	sed -n "1p;3p;5p" expect.all >expect &&
+	do_walk -- one.t >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure '--parents shows true parents' '
+	# convert newlines to spaces
+	echo $(git rev-parse HEAD HEAD^1 HEAD^2) >expect &&
+	git rev-list -g --parents -1 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'walking multiple reflogs shows both' '
+	{
+		do_walk HEAD &&
+		do_walk side
+	} >expect &&
+	do_walk HEAD side >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'walk prefers reflog to ref tip' '
+	head=$(git rev-parse HEAD) &&
+	one=$(git rev-parse one) &&
+	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
+	echo "$head $one $ident	broken reflog entry" >>.git/logs/HEAD &&
+
+	echo $one >expect &&
+	git log -g --format=%H -1 >actual &&
+	test_cmp expect actual
+'
+
+
+test_done
-- 
2.13.2.892.g25f9b59978

