Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF36202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbdGGJQY (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:16:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:33548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750883AbdGGJQX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:16:23 -0400
Received: (qmail 8819 invoked by uid 109); 7 Jul 2017 09:16:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 09:16:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20845 invoked by uid 111); 7 Jul 2017 09:16:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:16:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 05:16:21 -0400
Date:   Fri, 7 Jul 2017 05:16:21 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 7/7] reflog-walk: apply --since/--until to reflog dates
Message-ID: <20170707091620.5jljk42pppgeqork@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing a reflog walk, we use the commit's date to
do any date limiting. In earlier versions of Git, this could
lead to nonsense results, since a skipped commit would
truncate the traversal. So a sequence like:

  git commit ...
  git checkout week-old-branch
  git checkout -
  git log -g --since=1.day.ago

would stop at the week-old-branch, even though the "git
commit" entry further back is still interesting.

As of the prior commit, which uses a parent-less traversal
of the reflog, you get the whole reflog minus any commits
whose dates do not match the specified options. This is
arguably useful, as you could scan the reflogs for commits
that originated in a certain range.

But more likely a user doing a reflog walk wants to limit
based on the reflog entries themselves. You can simulate
--until with:

  git log -g @{1.day.ago}

but there's no way to ask Git to traverse only back to a
certain date. E.g.:

  # show me reflog entries from the past day
  git log -g --since=1.day.ago

This patch teaches the revision machinery to prefer the
reflog entry dates to the commit dates when doing a reflog
walk. Technically this is a change in behavior that affects
plumbing, but the previous behavior was so buggy that it's
unlikely anyone was relying on it.

Signed-off-by: Jeff King <peff@peff.net>
---
 reflog-walk.c          | 12 ++++++++++++
 reflog-walk.h          |  1 +
 revision.c             | 19 ++++++++++++++++---
 t/t1414-reflog-walk.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index fbee9e0126..74ebe5148f 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -264,6 +264,18 @@ const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
 	return info->email;
 }
 
+timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info)
+{
+	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
+	struct reflog_info *info;
+
+	if (!commit_reflog)
+		return 0;
+
+	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
+	return info->timestamp;
+}
+
 void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 			 const struct date_mode *dmode, int force_date)
 {
diff --git a/reflog-walk.h b/reflog-walk.h
index 373388cd14..7553c448fe 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -13,6 +13,7 @@ extern void show_reflog_message(struct reflog_walk_info *info, int,
 extern void get_reflog_message(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info);
 extern const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
+extern timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info);
 extern void get_reflog_selector(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info,
 		const struct date_mode *dmode, int force_date,
diff --git a/revision.c b/revision.c
index 587199739a..41b4375c3c 100644
--- a/revision.c
+++ b/revision.c
@@ -2965,6 +2965,18 @@ static inline int want_ancestry(const struct rev_info *revs)
 	return (revs->rewrite_parents || revs->children.name);
 }
 
+/*
+ * Return a timestamp to be used for --since/--until comparisons for this
+ * commit, based on the revision options.
+ */
+static timestamp_t comparison_date(const struct rev_info *revs,
+				   struct commit *commit)
+{
+	return revs->reflog_info ?
+		get_reflog_timestamp(revs->reflog_info) :
+		commit->date;
+}
+
 enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit)
 {
 	if (commit->object.flags & SHOWN)
@@ -2975,8 +2987,9 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 		return commit_show;
 	if (commit->object.flags & UNINTERESTING)
 		return commit_ignore;
-	if (revs->min_age != -1 && (commit->date > revs->min_age))
-		return commit_ignore;
+	if (revs->min_age != -1 &&
+	    comparison_date(revs, commit) > revs->min_age)
+			return commit_ignore;
 	if (revs->min_parents || (revs->max_parents >= 0)) {
 		int n = commit_list_count(commit->parents);
 		if ((n < revs->min_parents) ||
@@ -3130,7 +3143,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		 */
 		if (!revs->limited) {
 			if (revs->max_age != -1 &&
-			    (commit->date < revs->max_age))
+			    comparison_date(revs, commit) < revs->max_age)
 				continue;
 
 			if (revs->reflog_info)
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index c4c53bd209..360754959e 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -91,6 +91,32 @@ test_expect_success 'date-limiting does not interfere with other logs' '
 	test_cmp expect.all actual
 '
 
+test_expect_success 'min/max age uses entry date to limit' '
+	# Flip between commits one and two so each ref update actually
+	# does something (and does not get optimized out). We know
+	# that the timestamps of those commits will be before our "min".
+
+	git update-ref -m before refs/heads/minmax one &&
+
+	test_tick &&
+	min=$test_tick &&
+	git update-ref -m min refs/heads/minmax two &&
+
+	test_tick &&
+	max=$test_tick &&
+	git update-ref -m max refs/heads/minmax one &&
+
+	test_tick &&
+	git update-ref -m after refs/heads/minmax two &&
+
+	cat >expect <<-\EOF &&
+	max
+	min
+	EOF
+	git log -g --since=$min --until=$max --format=%gs minmax >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'walk prefers reflog to ref tip' '
 	head=$(git rev-parse HEAD) &&
 	one=$(git rev-parse one) &&
-- 
2.13.2.1000.g8590c1af5d
