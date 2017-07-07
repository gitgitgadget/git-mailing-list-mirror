Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15699202AE
	for <e@80x24.org>; Fri,  7 Jul 2017 06:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbdGGGWP (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 02:22:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:33298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750950AbdGGGWO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 02:22:14 -0400
Received: (qmail 1768 invoked by uid 109); 7 Jul 2017 06:22:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 06:22:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20191 invoked by uid 111); 7 Jul 2017 06:22:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 02:22:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 02:22:11 -0400
Date:   Fri, 7 Jul 2017 02:22:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
Message-ID: <20170707062211.a7336zi7rn7pal3z@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
 <xmqqh8yqix7p.fsf@gitster.mtv.corp.google.com>
 <20170705212757.3ygxiasbi2e7v27p@sigill.intra.peff.net>
 <xmqqa84ih5ao.fsf@gitster.mtv.corp.google.com>
 <20170706071606.doxirwm6cqx3duzg@sigill.intra.peff.net>
 <xmqq1spth8qy.fsf@gitster.mtv.corp.google.com>
 <20170707051954.rpej3taew6onv3oo@sigill.intra.peff.net>
 <xmqq37a8eqhe.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37a8eqhe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 06, 2017 at 11:00:13PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I suspect that "--since 3.days" is still quite buggy (even with a single
> > reflog) because it checks commit timestamps and stops traversing when we
> > go too bar back. But in a reflog, the commits may be totally out of
> > order. I'm not sure what it should do. Either:
> >
> >   1. During a reflog walk, --since and --until should respect reflog
> >      timestamps instead of commit timestamps. You can already do
> >      "--until" there by simply starting the traversal later, but there's
> >      no way to cut it off with --since.
> >
> >   2. Limit commits shown by --since/--until as usual, but skip the "stop
> >      traversing" optimization when we see too many "old" commits. I.e.,
> >      omit a 4.days.ago commit, but keep walking to find other recent
> >      commits.
> 
> I think 1. is more logical, and I was imagining that it should be
> doable, now we are not constrained by (ab)using the commit_list with
> the fake-parent thing, but are pulling the entries directly from the
> reflog iterator and the timestamp would be already available to the
> iterator.
> 
> But I recall that the max_age and min_age cutoff is done long after
> a commit is pulled out of the "iterator mechanism" (be it the
> commit_list or your direct reflog iterator) by comparing
> commit->date with the cut-off, so it may be a bit more involved to
> arrange than I imagined X-<.  Hmph...

It's probably not too bad.

We do some of the limiting in limit_list(), which tries to mark commits
as UNINTERESTING. But I think in general that limit_list is incompatible
with reflog traversals (though I wouldn't be surprised if we fail to
flag all the options that set revs->limited as incompatible).

We handle max_age in get_revision_1() itself, which should be pretty
straightforward. For min_age, we do it in get_commit_action(), which
would need access to the reflog timestamp. But we do have the rev_info
there.

So something like the patch below would work, I think.

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
index 5fc01f2d26..c248a16974 100644
--- a/revision.c
+++ b/revision.c
@@ -2973,8 +2973,13 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 		return commit_show;
 	if (commit->object.flags & UNINTERESTING)
 		return commit_ignore;
-	if (revs->min_age != -1 && (commit->date > revs->min_age))
-		return commit_ignore;
+	if (revs->min_age != -1) {
+		timestamp_t date = revs->reflog_info ?
+				   get_reflog_timestamp(revs->reflog_info) :
+				   commit->date;
+		if (date > revs->min_age)
+			return commit_ignore;
+	}
 	if (revs->min_parents || (revs->max_parents >= 0)) {
 		int n = commit_list_count(commit->parents);
 		if ((n < revs->min_parents) ||
@@ -3127,9 +3132,13 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		 * that we'd otherwise have done in limit_list().
 		 */
 		if (!revs->limited) {
-			if (revs->max_age != -1 &&
-			    (commit->date < revs->max_age))
-				continue;
+			if (revs->max_age != -1) {
+				timestamp_t date = revs->reflog_info ?
+						   get_reflog_timestamp(revs->reflog_info) :
+						   commit->date;
+				if (date < revs->max_age)
+					continue;
+			}
 			if (!revs->reflog_info &&
 			    add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
 				if (!revs->ignore_missing_links)
