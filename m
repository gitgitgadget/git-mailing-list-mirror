Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C9C1F406
	for <e@80x24.org>; Thu, 17 May 2018 13:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEQNgG (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 09:36:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:44512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751642AbeEQNgF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 09:36:05 -0400
Received: (qmail 16912 invoked by uid 109); 17 May 2018 13:36:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 May 2018 13:36:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1881 invoked by uid 111); 17 May 2018 13:36:12 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 17 May 2018 09:36:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 May 2018 06:36:02 -0700
Date:   Thu, 17 May 2018 06:36:02 -0700
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: jk/branch-l-0-deprecation (was Re: What's cooking in git.git
 (May 2018, #02; Thu, 17))
Message-ID: <20180517133601.GC17548@sigill.intra.peff.net>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fu2qbojy.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 17, 2018 at 11:48:33AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > 	    If there are ample branches, the warning message might be
> > 	    hidden out of screen but we shouldn't rely on that, I
> > 	    suppose.
> 
> Also if we have lots of branches, depending on your pager settings you
> won't see this at all, I have:

We redirect stderr to the pager, as well, exactly to catch this sort of
case. But because git-branch does not kick in the pager until later
(because it only wants to do it for list-mode), that happens _after_
we've emitted the message.

So one fix would be to teach deprecated_reflog_option_cb() to just set a
flag rather than printing the warning, and then issue the warning.
Something like this:

diff --git a/builtin/branch.c b/builtin/branch.c
index 452742fecf..f51b89e962 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -34,6 +34,7 @@ static const char * const builtin_branch_usage[] = {
 	NULL
 };
 
+static int used_deprecated_reflog_option;
 static const char *head;
 static struct object_id head_oid;
 
@@ -576,8 +577,7 @@ static int edit_branch_description(const char *branch_name)
 static int deprecated_reflog_option_cb(const struct option *opt,
 				       const char *arg, int unset)
 {
-	warning("the '-l' alias for '--create-reflog' is deprecated;");
-	warning("it will be removed in a future version of Git");
+	used_deprecated_reflog_option = 1;
 	*(int *)opt->value = !unset;
 	return 0;
 }
@@ -703,6 +703,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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

On the other hand, I'm not sure this is that big a deal. The point of
the deprecation warning is to catch people who are actually trying to
use "-l" as "--create-reflog", and that case does not page. The people
doing "git branch -l" are actually getting what they want eventually,
which is to turn it into "--list". In the interim step where it becomes
an unknown option, they'll get a hard error.

-Peff
