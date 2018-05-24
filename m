Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012141F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030334AbeEXTbI (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:31:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:51798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S967642AbeEXTbH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:31:07 -0400
Received: (qmail 10866 invoked by uid 109); 24 May 2018 19:31:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 May 2018 19:31:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28541 invoked by uid 111); 24 May 2018 19:31:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 May 2018 15:31:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2018 15:31:05 -0400
Date:   Thu, 24 May 2018 15:31:05 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] branch: issue "-l" deprecation warning after pager starts
Message-ID: <20180524193105.GB21535@sigill.intra.peff.net>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524192214.GA21535@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 03:22:14PM -0400, Jeff King wrote:

> On Thu, May 24, 2018 at 08:40:18PM +0530, Kaartic Sivaraam wrote:
> 
> > > On the other hand, I'm not sure this is that big a deal. The point of
> > > the deprecation warning is to catch people who are actually trying to
> > > use "-l" as "--create-reflog", and that case does not page. The people
> > > doing "git branch -l" are actually getting what they want eventually,
> > > which is to turn it into "--list". In the interim step where it becomes
> > > an unknown option, they'll get a hard error. 
> > 
> > I just thought we wouldn't want to surprise/confuse users who try to
> > use "git branch -l" with the warning message about "create reflog"
> > along-side the list of branches. That would just add to the confusion.
> > So, I thought we should error out when users do "git branch -l"
> > instead. Something like the following should help us prevent "git
> > branch -l" from listing branch names and might also prevent the
> > confusion.
> 
> Yeah, I think that's just a more extreme version of the current plan (it
> turns it immediately into a hard error instead of warning for a while).
> If we just make the warning easier to see in the paged case, I think
> that makes the current plan fine.
> 
> I'll wrap up the patch I sent earlier.

Hmm, actually, I suppose the true value of the warning is to help people
doing "git branch -l foo", and it would still work there. The "more
extreme" from your suggested patch would only affect "branch -l".

Still, I think I prefer the gentler version that we get by keeping it as
a warning even in the latter case.

Here's the patch. It goes on top of jk/branch-l-0-deprecation (and will
naturally conflict with the removal branch, but the resolution should be
obvious).

-- >8 --
Subject: [PATCH] branch: issue "-l" deprecation warning after pager starts

If you run "git branch -l", we issue a deprecation warning
that "-l" is probably not doing what you expect. But we do
so while parsing the options, which is _before_ we start the
pager. Depending on your pager settings, this means that the
warning may get totally overwritten by the pager.

Instead, let's delay the message until after we would have
started the pager. If we do page, then it will end up inside
the pager (since we redirect stderr). And if not (including
the case when you really did mean for "-l" to work as
"--create-reflog"), then it will still get shown on stderr.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e50a5a1680..55bfacd843 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -34,6 +34,7 @@ static const char * const builtin_branch_usage[] = {
 	NULL
 };
 
+static int used_deprecated_reflog_option;
 static const char *head;
 static struct object_id head_oid;
 
@@ -573,8 +574,7 @@ static int edit_branch_description(const char *branch_name)
 static int deprecated_reflog_option_cb(const struct option *opt,
 				       const char *arg, int unset)
 {
-	warning("the '-l' alias for '--create-reflog' is deprecated;");
-	warning("it will be removed in a future version of Git");
+	used_deprecated_reflog_option = 1;
 	*(int *)opt->value = !unset;
 	return 0;
 }
@@ -700,6 +700,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (list)
 		setup_auto_pager("branch", 1);
 
+	if (used_deprecated_reflog_option) {
+		warning("the '-l' alias for '--create-reflog' is deprecated;");
+		warning("it will be removed in a future version of Git");
+	}
+
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-- 
2.17.0.1391.g6fdbf40724

