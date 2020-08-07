Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2989FC433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8722177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgHGVdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:33:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:52332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGVdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:33:50 -0400
Received: (qmail 2758 invoked by uid 109); 7 Aug 2020 21:33:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 21:33:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18672 invoked by uid 111); 7 Aug 2020 21:33:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 17:33:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 17:33:49 -0400
From:   Jeff King <peff@peff.net>
To:     Nuthan Munaiah <nm6061@rit.edu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: `git blame` Line Number Off-by-one
Message-ID: <20200807213349.GB1871940@coredump.intra.peff.net>
References: <emc6590292-832a-4a35-8815-d5707731d605@sanctum>
 <20200807212159.GA1871940@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807212159.GA1871940@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 07, 2020 at 05:21:59PM -0400, Jeff King wrote:

> So we have two one-line entries at lines 21 and 23 ("lno"; note that
> internally we zero-index the lines), and we know that the second one is
> actually from 22 ("s_lno").
> 
> But then after blame_coalesce() returns, we have only one entry with
> both lines:
> 
>   (gdb) n
>   1148		if (!(output_option & (OUTPUT_COLOR_LINE | OUTPUT_SHOW_AGE_WITH_COLOR)))
>   (gdb) print *sb->ent
>   $46 = {next = 0x0, lno = 20, num_lines = 2, suspect = 0x555555999a30, s_lno = 20, score = 0, ignored = 0, 
>     unblamable = 0}
> 
> Presumably it saw the adjacent lines in the _source_ file and coalesced
> them, but that's not the right thing to do. They're distinct hunks in
> the output we're going to show, so they have to remain such.

I took a look at blame_coalesce(), wondering if there might be a bug in
it (e.g., using source lines instead of result lines). But it seems to
be intentionally joining lines based on the original source count. And
thinking on it, we wouldn't need to join groups based no result lines,
since those start as groups in the first place.

So I'm having trouble seeing how this coalescing could ever be helpful.
It dates back to the original cee7f245dc (git-pickaxe: blame rewritten.,
2006-10-19). Is it possible that this is just an ill-conceived idea that
nobody ever noticed before (because most of the time it simply does
nothing)?

Dropping it entirely, as below, doesn't break any tests. Junio, do you
know of a case this is meant to improve?

-Peff

diff --git a/blame.c b/blame.c
index 82fa16d658..e4fd9a80ef 100644
--- a/blame.c
+++ b/blame.c
@@ -1172,33 +1172,6 @@ static void sanity_check_refcnt(struct blame_scoreboard *sb)
 		sb->on_sanity_fail(sb, baa);
 }
 
-/*
- * If two blame entries that are next to each other came from
- * contiguous lines in the same origin (i.e. <commit, path> pair),
- * merge them together.
- */
-void blame_coalesce(struct blame_scoreboard *sb)
-{
-	struct blame_entry *ent, *next;
-
-	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
-		if (ent->suspect == next->suspect &&
-		    ent->s_lno + ent->num_lines == next->s_lno &&
-		    ent->ignored == next->ignored &&
-		    ent->unblamable == next->unblamable) {
-			ent->num_lines += next->num_lines;
-			ent->next = next->next;
-			blame_origin_decref(next->suspect);
-			free(next);
-			ent->score = 0;
-			next = ent; /* again */
-		}
-	}
-
-	if (sb->debug) /* sanity */
-		sanity_check_refcnt(sb);
-}
-
 /*
  * Merge the given sorted list of blames into a preexisting origin.
  * If there were no previous blames to that commit, it is entered into
diff --git a/blame.h b/blame.h
index b6bbee4147..1807253ef8 100644
--- a/blame.h
+++ b/blame.h
@@ -173,7 +173,6 @@ static inline struct blame_origin *blame_origin_incref(struct blame_origin *o)
 }
 void blame_origin_decref(struct blame_origin *o);
 
-void blame_coalesce(struct blame_scoreboard *sb);
 void blame_sort_final(struct blame_scoreboard *sb);
 unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entry *e);
 void assign_blame(struct blame_scoreboard *sb, int opt);
diff --git a/builtin/blame.c b/builtin/blame.c
index 94ef57c1cc..ce564a5916 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1143,8 +1143,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	blame_sort_final(&sb);
 
-	blame_coalesce(&sb);
-
 	if (!(output_option & (OUTPUT_COLOR_LINE | OUTPUT_SHOW_AGE_WITH_COLOR)))
 		output_option |= coloring_mode;
 
