Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF57B1F42D
	for <e@80x24.org>; Fri, 25 May 2018 02:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965233AbeEYCkL (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 22:40:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:52262 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965237AbeEYCkF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 22:40:05 -0400
Received: (qmail 25933 invoked by uid 109); 25 May 2018 02:40:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 May 2018 02:40:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31523 invoked by uid 111); 25 May 2018 02:40:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 May 2018 22:40:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2018 22:40:03 -0400
Date:   Thu, 24 May 2018 22:40:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
Message-ID: <20180525024002.GA1998@sigill.intra.peff.net>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net>
 <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 10:55:45AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm, actually, I suppose the true value of the warning is to help people
> > doing "git branch -l foo", and it would still work there. The "more
> > extreme" from your suggested patch would only affect "branch -l".
> 
> > Still, I think I prefer the gentler version that we get by keeping it as
> > a warning even in the latter case.
> 
> "git branch -l newbranch [forkpoint]" that warns "We won't be doing
> reflog creation with -l" is good, but "git branch -l" that warns "We
> won't be doing reflog creation with -l" sounds like a pure noise, as
> the user would say "Irrelevant, I am not doing that anyway--I am
> listing".
> 
> The warning to prepare users for the next step jk/branch-l-1-removal
> should say "we won't be accepting '-l' as a silent and unadvertised
> synonym soon. Spell it as --list" when "git branch -l" is given, I
> would think.

I hoped that reminding them that "-l is a synonym for --create-reflog"
would serve as a gentle reminder that they're Doing It Wrong. I guess we
could be more explicit, though.

It is not "we won't be accepting -l as a synonym" though. It was never a
synonym, it's just that it didn't happen to do anything in list mode.

> > @@ -700,6 +700,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
> >  	if (list)
> >  		setup_auto_pager("branch", 1);
> >  
> > +	if (used_deprecated_reflog_option) {
> > +		warning("the '-l' alias for '--create-reflog' is deprecated;");
> > +		warning("it will be removed in a future version of Git");
> > +	}
> 
> So from that point of view, we may need a separate message to warn
> users who _do_ want listing with '-l' before jk/branch-l-1-removal
> removes it?  
> 
> The jk/branch-l-2-resurrection topic later repurposes '-l' for
> '--list' but until that happens 'git branch -l' will error not, no?

Yes, after step 1 it will error out. Again, I hoped the existing message
would prepare people. But maybe we should do this on top of what I
posted earlier?

-- >8 --
Subject: [PATCH] branch: customize "-l" warning in list mode

People mistakenly use "git branch -l", thinking that it
triggers list mode. It doesn't, but the lack of non-option
arguments in that command does (and the "-l" becomes a
silent noop).

Since afc968e579 (branch: deprecate "-l" option, 2018-03-26)
we've warned that "-l" is going away. But the warning text
is primarily aimed at people who _meant_ to use "-l", as in
"git branch -l foo". People who mistakenly said "git branch
-l" may be left puzzled.

Let's make it clear that:

  1. No, "-l" didn't do what they thought here.

  2. It's going away, and what they should do instead.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55bfacd843..b0b33dab94 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -701,8 +701,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		setup_auto_pager("branch", 1);
 
 	if (used_deprecated_reflog_option) {
-		warning("the '-l' alias for '--create-reflog' is deprecated;");
-		warning("it will be removed in a future version of Git");
+		if (list) {
+			warning("the '-l' option is an alias for '--create-reflog' and");
+			warning("has no effect in list mode. This option will soon be");
+			warning("removed and you should omit it (or use '--list' instead).");
+		} else {
+			warning("the '-l' alias for '--create-reflog' is deprecated;");
+			warning("it will be removed in a future version of Git");
+		}
 	}
 
 	if (delete) {
-- 
2.17.0.1391.g6fdbf40724

