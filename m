Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D4F1FA21
	for <e@80x24.org>; Tue, 10 Oct 2017 10:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755723AbdJJKZO (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 06:25:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:48088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755400AbdJJKZM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 06:25:12 -0400
Received: (qmail 4594 invoked by uid 109); 10 Oct 2017 10:25:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 10:25:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24975 invoked by uid 111); 10 Oct 2017 10:25:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 06:25:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2017 06:25:10 -0400
Date:   Tue, 10 Oct 2017 06:25:10 -0400
From:   Jeff King <peff@peff.net>
To:     Nazri Ramliy <ayiehere@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What happened to "git status --color=(always|auto|never)"?
Message-ID: <20171010102509.e7ucbyon6ka6722l@sigill.intra.peff.net>
References: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
 <20171010001619.GL19555@aiede.mtv.corp.google.com>
 <CAEY4ZpPj3=+gL_wBW548qzAuS=aC=qswuPx-4H9DS=X10iJWVw@mail.gmail.com>
 <20171010005942.GO19555@aiede.mtv.corp.google.com>
 <CAEY4ZpMKE6yf2baaJt+x6c_esorFnyWvLZ=_KS1iRs6XbL42hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEY4ZpMKE6yf2baaJt+x6c_esorFnyWvLZ=_KS1iRs6XbL42hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 12:42:43PM +0800, Nazri Ramliy wrote:

> >         commit 6be4595edb8e5b616c6e8b9fbc78b0f831fa2a87
> >         Author: Jeff King <peff@peff.net>
> >         Date:   Tue Oct 3 09:46:06 2017 -0400
> >
> >             color: make "always" the same as "auto" in config
> >
> > Would you like to take a stab at adding it?  builtin/commit.c and
> > Documentation/git-{commit,status}.txt would be my best guesses at
> > where to start.
> 
> Perhaps, seeing that that commit intentionally "broke" the color
> output of my tool[1], because it parses the output of `git -c
> color.status=always status`, which now no longer work the way it used
> to. I know, I know... shame on me for parsing the output of a
> porcelain command :)
> 
> But this also means that I will have to modify [1] to cope with this,
> given that it may be used with an older version of git (parse
> git-version and shell out to different git command - either `git -c
> color.ui=always status`, or the not-yet-exist `git status
> --color=always`), or make it use the plumbing output of `git status`,
> but that would just add additional work that  I really don't look
> forward to doing at this moment.

:( I was worried that this might hit some third-party scripts.

One workaround you can do that should work with any version of Git is:

  GIT_PAGER_IN_USE=1 git status | your-parser

That tells Git that even though stdout isn't a tty, you're expecting to
present the data to the user and it should be colored appropriately. It
has the additional upside that it doesn't override the user's color
config.

It does have the potential downside that other non-color changes could
kick in (e.g., somebody recently proposed that auto-columns kick in with
GIT_PAGER_IN_USE).

All that said, should we revisit the decision from 6be4595edb? The two
code changes we could make are:

  1. Adding a "--color" option to "git status". Commit 0c88bf5050
     (provide --color option for all ref-filter users, 2017-10-03) from
     that same series shows some prior art.

     This is a clean solution, but it does mean that scripts have to
     adapt (and would potentially need to care about which Git version
     they're relying on).

  2. Re-allow "color.always" config from the command-line. It's actually
     on-disk config that we want to downgrade, but I wanted to avoid
     making complicated rules about how the config would behave in
     different scopes. The patch for this would look something like the
     one below.

  3. Revert the original series, and revisit the original "respect
     color.ui via porcelain" commit which broke add--interactive in
     v2.14.2 (136c8c8b8fa).

I dunno. I think for your use case, PAGER_IN_USE may actually be the
"right" solution, because it most closely expresses what you're doing.
We probably ought to have (1) as a general rule for commands which
handle color.

But (2) and (3) are the only ones that will work seamlessly with
existing scripts. I'm not excited about either of them, though.

-Peff

diff --git a/color.c b/color.c
index 9c0dc82370..3870d3e395 100644
--- a/color.c
+++ b/color.c
@@ -307,8 +307,21 @@ int git_config_colorbool(const char *var, const char *value)
 	if (value) {
 		if (!strcasecmp(value, "never"))
 			return 0;
-		if (!strcasecmp(value, "always"))
-			return var ? GIT_COLOR_AUTO : 1;
+		if (!strcasecmp(value, "always")) {
+			/*
+			 * Command-line options always respect "always".
+			 * Likewise for "-c" config on the command-line.
+			 */
+			if (!var ||
+			    current_config_scope() == CONFIG_SCOPE_CMDLINE)
+				return 1;
+
+			/*
+			 * Otherwise, we're looking at on-disk config;
+			 * downgrade to auto.
+			 */
+			return GIT_COLOR_AUTO;
+		}
 		if (!strcasecmp(value, "auto"))
 			return GIT_COLOR_AUTO;
 	}
