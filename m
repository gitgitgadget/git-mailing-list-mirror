Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347EB1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 08:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfADI0B (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 03:26:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:54456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726382AbfADI0B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 03:26:01 -0500
Received: (qmail 27298 invoked by uid 109); 4 Jan 2019 08:26:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Jan 2019 08:26:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16096 invoked by uid 111); 4 Jan 2019 08:25:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 04 Jan 2019 03:25:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2019 03:25:58 -0500
Date:   Fri, 4 Jan 2019 03:25:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erin Dahlgren <eedahlgren@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] Simplify handling of setup_git_directory_gently()
 failure cases.
Message-ID: <20190104082558.GB26014@sigill.intra.peff.net>
References: <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
 <1545953789-15040-1-git-send-email-eedahlgren@gmail.com>
 <20190103051432.GE20047@sigill.intra.peff.net>
 <xmqqy381haup.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy381haup.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 03, 2019 at 10:09:18AM -0800, Junio C Hamano wrote:

> >> @@ -1132,7 +1142,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >>  	 * the user has set GIT_DIR.  It may be beneficial to disallow bogus
> >>  	 * GIT_DIR values at some point in the future.
> >>  	 */
> >> -	if (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)) {
> >> +	if (// GIT_DIR_EXPLICIT, GIT_DIR_DISCOVERED, GIT_DIR_BARE
> >> +	    startup_info->have_repository ||
> >> +	    // GIT_DIR_EXPLICIT
> >> +	    getenv(GIT_DIR_ENVIRONMENT)) {
> >
> > Same "//" style issue as above. I'm not sure how much value there is in
> > repeating the GIT_DIR_* cases here, as they're likely to grow out of
> > sync with the switch() statement above.
> 
> It is unclear to me if the original code is doing the right thing
> under one condition, and this patch does not seem to change the
> behaviour.
>
> What happens if GIT_DIR environment is set to an invalid path and
> nongit_ok is non-NULL?  setup_explicit_git_dir() would have assigned
> 1 to *nongit_ok, so have_repository is false at this point.
> 
> We enter the if() statement in such a case, and end up calling
> setup_git_env(gitdir) using the bogus path that is not pointing at a
> repository.  We leave have_repository to be false but the paths
> recorded in the_repository by setup_git_env() would all point at
> bogus places.

Yeah, that matches my analysis of what the code is doing.

Looks like this code (and comment) come from 73f192c991 (setup: don't
perform lazy initialization of repository state, 2017-06-20). I'm
guessing this was mostly a hack to quiet some test that complained about
the other changes in that commit. And indeed, dropping the getenv() half
of the conditional and running the tests in 73f192c991 gets me a failure
in t1050, which does:

  GIT_DIR=non-existent git index-pack --strict --verify foo/.git/objects/pack/*.pack

But that's a bug in index-pack, which should be able to verify a pack
outside of a repository. And I think (according to bisection) we fixed
that in 14a9bd2898 (prepare_commit_graft: treat non-repository as a
noop, 2018-05-31), and the tests currently pass even with this patch
applied:

diff --git a/setup.c b/setup.c
index 1be5037f12..e2c03e9bbc 100644
--- a/setup.c
+++ b/setup.c
@@ -1132,7 +1132,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * the user has set GIT_DIR.  It may be beneficial to disallow bogus
 	 * GIT_DIR values at some point in the future.
 	 */
-	if (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)) {
+	if (startup_info->have_repository) {
 		if (!the_repository->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)

> > At first I thought this could all be folded into the "else" clause of
> > the conditional above (which would make the logic much easier to
> > follow), but that wouldn't cover the case of GIT_DIR=/bogus, which is
> > what that getenv() is trying to handle here.
> 
> Yes, but should GIT_DIR=/bogus even be touching the_repository?  

Probably not. And from my poking around above, I think we're probably
safe to remove this hackery now.

> It is a separate clean-up and does not affect the validity of this
> simplification patchd, so I agreee with ...
> 
> > So I think this is the best we can do for now.

Yep, it's definitely orthogonal. But if we do this cleanup as part of
it, we should be able to simplify further on top of Erin's patch, like
this:

diff --git a/setup.c b/setup.c
index eb8332bc02..edf65c44bf 100644
--- a/setup.c
+++ b/setup.c
@@ -1125,35 +1125,26 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		// !nongit_ok || !*nongit_ok
 		startup_info->have_repository = 1;
 		startup_info->prefix = prefix;
+
 		if (prefix)
 			setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
 		else
 			setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
-	}
 
-	/*
-	 * Not all paths through the setup code will call 'set_git_dir()' (which
-	 * directly sets up the environment) so in order to guarantee that the
-	 * environment is in a consistent state after setup, explicitly setup
-	 * the environment if we have a repository.
-	 *
-	 * NEEDSWORK: currently we allow bogus GIT_DIR values to be set in some
-	 * code paths so we also need to explicitly setup the environment if
-	 * the user has set GIT_DIR.  It may be beneficial to disallow bogus
-	 * GIT_DIR values at some point in the future.
-	 */
-	if (// GIT_DIR_EXPLICIT, GIT_DIR_DISCOVERED, GIT_DIR_BARE
-	    startup_info->have_repository ||
-	    // GIT_DIR_EXPLICIT
-	    getenv(GIT_DIR_ENVIRONMENT)) {
+		/*
+		 * Not all paths through the setup code will call 'set_git_dir()' (which
+		 * directly sets up the environment) so in order to guarantee that the
+		 * environment is in a consistent state after setup, explicitly setup
+		 * the environment if we have a repository.
+		 */
 		if (!the_repository->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env(gitdir);
 		}
-		if (startup_info->have_repository)
-			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+
+		repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	}
 
 	strbuf_release(&dir);

I actually wonder if the "not all paths..." bit is even still true these
days (and if it is, I think we should consider fixing those code paths).
Certainly that setup_git_env() needed to trigger for the GIT_DIR=bogus,
but with that gone, any $GIT_DIR should have triggered GIT_DIR_EXPLICIT,
and any "default to .git" should be handled as part of discovery, I'd
think.

So what next? Erin, are you interested in using the details of this
conversation to take the cleanups a bit further? If not, then I can try
to prepare a few patches on top of yours.

-Peff
