Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6951F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 13:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbeGKNi1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 09:38:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:55160 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732469AbeGKNi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 09:38:26 -0400
Received: (qmail 8320 invoked by uid 109); 11 Jul 2018 13:34:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 13:34:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7055 invoked by uid 111); 11 Jul 2018 13:34:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 09:34:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 09:34:02 -0400
Date:   Wed, 11 Jul 2018 09:34:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: Segfault on "git pull" on "bad object HEAD"
Message-ID: <20180711133402.GD23835@sigill.intra.peff.net>
References: <87k1q2c9zq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1q2c9zq.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 01:00:57PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This segfaults, but should print an error instead, have a repo with a
> corrupt HEAD:
> 
>     (
>         rm -rf /tmp/git &&
>         git clone --single-branch --branch todo git@github.com:git/git.git /tmp/git &&
>         echo 1111111111111111111111111111111111111111 >/tmp/git/.git/refs/heads/todo &&
>         git -C /tmp/git pull
>     )

It took me a minute to reproduce this. It needs "pull --rebase" if you
don't have that setup in your config.

> The immediate reason is that in run_diff_index() we have this:
> 
> 	ent = revs->pending.objects;
> 
> And that in this case that's NULL:
> 
>     (gdb) bt
>     #0  0x000055555565993f in run_diff_index (revs=0x7fffffffcb90, cached=1) at diff-lib.c:524
>     #1  0x00005555557633da in has_uncommitted_changes (ignore_submodules=1) at wt-status.c:2345

These two are the interesting functions. has_uncommitted_changes() calls
add_head_to_pending(). So it could realize then that there is no valid
HEAD to compare against.

But as you note, it's run_diff_index() that blindly dereferences
revs->pending.objects without seeing if it's non-empty. Normally
setup_revisions() would barf on a bad object, but the manual
add_head_to_pending() quietly returns (as it must for some cases, like
unborn branches).

So I feel like the right answer here is probably this:

diff --git a/wt-status.c b/wt-status.c
index d1c05145a4..5fcaa3d0f8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2340,7 +2340,16 @@ int has_uncommitted_changes(int ignore_submodules)
 	if (ignore_submodules)
 		rev_info.diffopt.flags.ignore_submodules = 1;
 	rev_info.diffopt.flags.quick = 1;
+
 	add_head_to_pending(&rev_info);
+	if (!rev_info.pending.nr) {
+		/*
+		 * We have no head (or it's corrupt), but the index is not
+		 * unborn; declare it as uncommitted changes.
+		 */
+		return 1;
+	}
+
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_index(&rev_info, 1);
 	return diff_result_code(&rev_info.diffopt, result);

That does quietly paper over the corruption, but it does the
conservative thing, and a follow-up "git status" would yield "bad
object: HEAD".

I do worry that other callers of run_diff_index() might have similar
problems, though. Grepping around, the other callers seem to fall into
one of three categories:

 - they resolve the object themselves and put it in the pending list
   (and often fallback to the empty tree, which is more or less what the
   patch above is doing)

 - they resolve the object themselves and avoid calling run_diff_index()
   if it's not valid

 - they use setup_revisions(), which will barf on the broken object

So I think this may be sufficient. We probably should also add an
assertion to run_diff_index(), since that's better than segfaulting.

-Peff
