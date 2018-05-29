Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE791F42D
	for <e@80x24.org>; Tue, 29 May 2018 21:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967383AbeE2VVD (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 17:21:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:55744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S967615AbeE2VUb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 17:20:31 -0400
Received: (qmail 3391 invoked by uid 109); 29 May 2018 21:20:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 May 2018 21:20:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30860 invoked by uid 111); 29 May 2018 21:20:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 May 2018 17:20:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2018 17:20:29 -0400
Date:   Tue, 29 May 2018 17:20:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
Message-ID: <20180529212029.GB7964@sigill.intra.peff.net>
References: <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net>
 <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
 <20180525024002.GA1998@sigill.intra.peff.net>
 <xmqqd0xknmf1.fsf@gitster-ct.c.googlers.com>
 <xmqq1sdzno3g.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sdzno3g.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 26, 2018 at 11:32:35AM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Yup, thanks for being extra explicit.  I do imagine there are quite
> > a few of us who would be puzzled without this update (but with the
> > previous one to unhide it from behind the pager).
> 
> With these two patches queued on top of jk/branch-l-0-deprecation,
> the follow-up patches jk/branch-l-1-removal that makes 'branch -l'
> to fail and then jk/branch-l-2-reincarnation that makes 'branch -l'
> a synonym to 'branch --list' needs rebasing.  Both are trivial and
> hopefully I did them correctly.
> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Mon, 26 Mar 2018 03:29:22 -0400
> Subject: [PATCH] branch: drop deprecated "-l" option
> 
> We marked the "-l" option as deprecated back in <insert sha1
> here>. Now that sufficient time has passed, let's follow
> through and get rid of it.

Thanks. There's one bit missing here, because it did not cause a textual
conflict during the rebase (but it's now dead code). Patch below (to be
squashed to the tip of jk/branch-l-1-removal).

We may also want to fill in <insert sha1 here>. I think it's afc968e579
(branch: deprecate "-l" option, 2018-03-26), which should be stable at
this point (it's already merged to 'next').

diff --git a/builtin/branch.c b/builtin/branch.c
index 01b35b3c3d..f7cd333587 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -34,7 +34,6 @@ static const char * const builtin_branch_usage[] = {
 	NULL
 };
 
-static int used_deprecated_reflog_option;
 static const char *head;
 static struct object_id head_oid;
 
@@ -686,17 +685,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (list)
 		setup_auto_pager("branch", 1);
 
-	if (used_deprecated_reflog_option) {
-		if (list) {
-			warning("the '-l' option is an alias for '--create-reflog' and");
-			warning("has no effect in list mode. This option will soon be");
-			warning("removed and you should omit it (or use '--list' instead).");
-		} else {
-			warning("the '-l' alias for '--create-reflog' is deprecated;");
-			warning("it will be removed in a future version of Git");
-		}
-	}
-
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
