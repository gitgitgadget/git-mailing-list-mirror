Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0812B1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 12:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfHFMt5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 08:49:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:35194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726036AbfHFMt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 08:49:56 -0400
Received: (qmail 16679 invoked by uid 109); 6 Aug 2019 12:49:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 12:49:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1425 invoked by uid 111); 6 Aug 2019 12:52:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 08:52:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 08:49:55 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] config: stop checking whether the_repository is NULL
Message-ID: <20190806124954.GA13649@sigill.intra.peff.net>
References: <20190806122601.GA21475@sigill.intra.peff.net>
 <20190806122758.GC13513@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806122758.GC13513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 08:27:58AM -0400, Jeff King wrote:

> diff --git a/config.c b/config.c
> index 3900e4947b..cc637363bb 100644
> --- a/config.c
> +++ b/config.c
> @@ -275,7 +275,7 @@ static int include_by_branch(const char *cond, size_t cond_len)
>  	int flags;
>  	int ret;
>  	struct strbuf pattern = STRBUF_INIT;
> -	const char *refname = !the_repository || !the_repository->gitdir ?
> +	const char *refname = !the_repository->gitdir ?
>  		NULL : resolve_ref_unsafe("HEAD", 0, NULL, &flags);

I stopped here, even though I argued earlier that this probably ought to
be have_git_dir() to match the rest of the config code. What I found
when I started poking at it is that there are a few odd cases still in
the startup code, and that IMHO the final form we want to end up with
actually matches what's written here (but I'm not quite ready to sink
the time into taking us there just yet). Read on for the gory details.

The most immediate issue I saw was that the_repository->gitdir doesn't
actually tell you whether or not we have a repository! I.e., that entry
may be non-NULL even though startup_info->have_repository is 0.

So these two tests fail:

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index d20b4d150d..7ec91c4c1c 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -348,6 +348,18 @@ test_expect_success 'conditional include, onbranch, implicit /** for /' '
 	test_cmp expect actual
 '
 
+test_expect_success 'onbranch include not fooled by fake GIT_DIR' '
+	mkdir not-a-git-dir &&
+	echo "ref: refs/heads/master" >not-a-git-dir/HEAD &&
+	git config --file=inner the.value inner &&
+	git config --file=outer the.value outer &&
+	git config --file=outer includeIf.onbranch:master.path inner &&
+	GIT_DIR=not-a-git-dir \
+		git config --file=outer --includes the.value >actual &&
+	echo outer >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'include cycles are detected' '
 	git init --bare cycle &&
 	git -C cycle config include.path cycle &&
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 3a0de0ddaa..91af2c2f89 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -99,4 +99,12 @@ test_expect_success 'onbranch config outside of git repo' '
 	nongit git help
 '
 
+test_expect_success 'early config is not fooled by bogus GIT_DIR' '
+	mkdir not-a-git-dir &&
+	git config --file=not-a-git-dir/config \
+		alias.should-not-run \
+		"!echo should-not-run" &&
+	test_must_fail env GIT_DIR="not-a-git-dir" git should-not-run
+'
+
 test_done

As you can see from that case, it's a curiosity that we still set the
internal gitdir variable from $GIT_DIR, even if we found that it's not a
valid repo.

The onbranch case is fooled by our direct check of gitdir, but likewise
have_git_dir() allows either have_repository or a non-NULL gitdir (as I
mentioned earlier, I think this is vestigial at this point).

So doing this fixes the onbranch case:

diff --git a/config.c b/config.c
index cc637363bb..134637f3ad 100644
--- a/config.c
+++ b/config.c
@@ -275,7 +275,7 @@ static int include_by_branch(const char *cond, size_t cond_len)
 	int flags;
 	int ret;
 	struct strbuf pattern = STRBUF_INIT;
-	const char *refname = !the_repository->gitdir ?
+	const char *refname = !have_git_dir() ?
 		NULL : resolve_ref_unsafe("HEAD", 0, NULL, &flags);
 	const char *shortname;
 
diff --git a/environment.c b/environment.c
index 89af47cb85..08bdf79d6b 100644
--- a/environment.c
+++ b/environment.c
@@ -203,8 +203,7 @@ int is_bare_repository(void)
 
 int have_git_dir(void)
 {
-	return startup_info->have_repository
-		|| the_repository->gitdir;
+	return startup_info->have_repository;
 }
 
 const char *get_git_dir(void)


but curiously it _doesn't_ fix the alias one, because after seeing that
we have no configured git dir, we then fall back to discover_git_dir(),
which happily reports back the same bogus $GIT_DIR.

So I think there'd be some more cleanup required there. But the general
direction is that in the near future we probably ought to be checking
startup_info->have_repository and not the_repository->gitdir.

But I think in the long-term, we probably ought to be getting rid of
startup_info->have_repository itself. It's really just hiding a subtle
dependency on whether the_repository is valid, and we're better off
actually seeing all the spots that depend on the_repository (and
eventually converting them to take a "struct repository" as
appropriate).

Where we want to end up is (I think):

  - stop setting the_repository->gitdir when we know that there's no
    repo (and possibly clear $GIT_DIR as well to avoid confusion). That
    should make it a robust way to check whether a "struct repository"
    is valid.

    This is the step I've stalled on, because I'm a bit worried that
    there's some subtle case that depends on it working this way.

  - drop startup_info->have_repository entirely. At that point it would
    be redundant with checking the_repository->gitdir.

    If you do this without the first step, t4201 will notice and fail
    (because it expects GIT_DIR=not-a-repo to notice that there is no
    repo).

  - optionally, drop have_git_dir() in favor of just checking
    the_repository->gitdir. This loses a layer of abstraction, but I
    think it makes it much more clear where we'd depending on
    the_repository.

And so in the end, the current state of include_by_branch() is what we
want, and all the other call sites should change to match it. Whether it
should be changed in the interim (until we fix the discrepancy between
gitdir/have_repository), I don't feel strongly about. There are
user-visible cases that I believe we get wrong today, but as you can see
from the tests above, they're pretty ridiculous and unlikely in
practice.

-Peff
