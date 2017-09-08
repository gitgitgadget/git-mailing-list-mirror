Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62333208E3
	for <e@80x24.org>; Fri,  8 Sep 2017 05:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbdIHFKS (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 01:10:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:60454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750829AbdIHFKR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 01:10:17 -0400
Received: (qmail 14385 invoked by uid 109); 8 Sep 2017 05:10:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 05:10:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5821 invoked by uid 111); 8 Sep 2017 05:10:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 01:10:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 01:10:15 -0400
Date:   Fri, 8 Sep 2017 01:10:15 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?0JLQsNC70LXQvdGC0LjQvQ==?= <valiko.ua@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git shortlog -sn --follow -- <path>" counts all commits to
 entire repo
Message-ID: <20170908051015.ybq4egdrddecl4se@sigill.intra.peff.net>
References: <CAJrPYn8_n1JD3hL1LSAVz2Khs=dZRVaZ-gpru5AV+ottv5WfAw@mail.gmail.com>
 <CAGZ79kZAeCERKn6he2LzAj97BXEJ5U+Fy4sorAPNmW_XaCS9Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZAeCERKn6he2LzAj97BXEJ5U+Fy4sorAPNmW_XaCS9Vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2017 at 12:30:01PM -0700, Stefan Beller wrote:

> > "--follow" switch is not listed on
> > https://git-scm.com/docs/git-shortlog so maybe it's not supported. In
> > this case I would expect error message.
> >
> > Tried the following versions:
> > "git version 2.14.1.windows.1" on Windows 7
> > "git version 2.7.4" on Ubuntu 16.04
> 
> The shortlog takes most (all?) options that git-log
> does, e.g. in git.git:

That's definitely the intent, but I think --follow is just buggy here.
We don't seem to trigger a diff, which is where "git log" does the
follow check (because of the way it's bolted onto the diff, and not the
actual pathspec-pruning mechanism).

Something like the patch below seems to work, but there are a lot of
open questions. And it would probably want to do something to prevent
nonsense like "shortlog -p" from showing actual diffs.

I suspect a better solution might involve actually building on
log-tree.c to do the traversal (since this internal traversal is
supposed to be equivalent to "git log | git shortlog").

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 43c4799ea9..31274a92f5 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -175,8 +175,31 @@ static void get_from_rev(struct rev_info *rev, struct shortlog *log)
 
 	if (prepare_revision_walk(rev))
 		die(_("revision walk setup failed"));
-	while ((commit = get_revision(rev)) != NULL)
-		shortlog_add_commit(log, commit);
+	while ((commit = get_revision(rev)) != NULL) {
+		int show_commit;
+
+		/* trigger a diff to give --follow a chance to kick in */
+		if (!commit->parents) {
+			/* should diff against empty tree or respect --root? */
+			show_commit = 1;
+		} else if (commit->parents->next) {
+			/* how to handle merge commits? */
+			show_commit = 1;
+		} else {
+			struct commit *parent = commit->parents->item;
+
+			parse_commit_or_die(parent);
+			parse_commit_or_die(commit);
+			diff_tree_oid(&parent->tree->object.oid,
+				      &commit->tree->object.oid,
+				      "", &rev->diffopt);
+			show_commit = !diff_queue_is_empty();
+			diff_flush(&rev->diffopt);
+		}
+
+		if (show_commit)
+			shortlog_add_commit(log, commit);
+	}
 }
 
 static int parse_uint(char const **arg, int comma, int defval)
