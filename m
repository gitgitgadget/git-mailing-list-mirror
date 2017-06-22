Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AE320802
	for <e@80x24.org>; Thu, 22 Jun 2017 22:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbdFVWZs (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 18:25:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:49532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752429AbdFVWZs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 18:25:48 -0400
Received: (qmail 27908 invoked by uid 109); 22 Jun 2017 22:25:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 22:25:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6662 invoked by uid 111); 22 Jun 2017 22:25:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 18:25:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 18:25:46 -0400
Date:   Thu, 22 Jun 2017 18:25:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
Message-ID: <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
 <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
 <87efud7xjd.fsf@kyleam.com>
 <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
 <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
 <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
 <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
 <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
 <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
 <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 05:52:35PM -0400, Jeff King wrote:

> Which really makes me feel like this patch is going in the right
> direction, as it makes all of this behave conceptually like:
> 
>   while read old new etc ...
>   do
>     git show $new
>   done <.git/logs/$ref
> 
> which is simple to explain and is what I'd expect (and is certainly the
> direction we went with the "diff uses real parents" commit).
> 
> We just need to hit the simplify_commit() code path here.

So here's a patch on top of what I posted before that pushes the reflog
check into the loop (it just decides whether to pull from the reflogs or
from the commit queue at the top of the loop).

I was surprised to find, though, that simplify_commit() does not
actually do the pathspec limiting! It's done by
try_to_simplify_commit(), which is part of add_parents_to_list(). I
hacked around it in the later part of the loop by calling
try_to_simplify myself and checking the TREESAME flag. But I have a
feeling I'm missing something about how the traversal is supposed to
work.

This does behave sensibly with "--no-merges" and "--merges", as well as
pathspec limiting.

diff --git a/revision.c b/revision.c
index 675247cd9..203468ddf 100644
--- a/revision.c
+++ b/revision.c
@@ -3112,19 +3112,19 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
 
 static struct commit *get_revision_1(struct rev_info *revs)
 {
-	if (revs->reflog_info) {
-		struct commit *commit = next_reflog_entry(revs->reflog_info);
-		if (commit) {
-			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
-			return commit;
-		}
-	}
+	while (1) {
+		struct commit *commit;
 
-	if (!revs->commits)
-		return NULL;
+		if (revs->reflog_info)
+			commit = next_reflog_entry(revs->reflog_info);
+		else
+			commit = pop_commit(&revs->commits);
 
-	do {
-		struct commit *commit = pop_commit(&revs->commits);
+		if (!commit)
+			return NULL;
+
+		if (revs->reflog_info)
+			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 
 		/*
 		 * If we haven't done the list limiting, we need to look at
@@ -3135,7 +3135,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			if (revs->max_age != -1 &&
 			    (commit->date < revs->max_age))
 				continue;
-			if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
+			if (!revs->reflog_info &&
+			    add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
 						oid_to_hex(&commit->object.oid));
@@ -3151,10 +3152,14 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		default:
 			if (revs->track_linear)
 				track_linear(revs, commit);
+			if (revs->reflog_info) {
+				try_to_simplify_commit(revs, commit);
+				if (commit->object.flags & TREESAME)
+					continue;
+			}
 			return commit;
 		}
-	} while (revs->commits);
-	return NULL;
+	}
 }
 
 /*
