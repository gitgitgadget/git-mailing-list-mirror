Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A946020281
	for <e@80x24.org>; Wed,  4 Oct 2017 08:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdJDIYi (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 04:24:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:60228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751424AbdJDIYf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 04:24:35 -0400
Received: (qmail 16653 invoked by uid 109); 4 Oct 2017 08:24:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 08:24:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15928 invoked by uid 111); 4 Oct 2017 08:24:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 04:24:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 04:24:33 -0400
Date:   Wed, 4 Oct 2017 04:24:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #01; Wed, 4)
Message-ID: <20171004082433.tltvqsw3ov47f3lz@sigill.intra.peff.net>
References: <xmqqy3orbcrr.fsf@gitster.mtv.corp.google.com>
 <20171004080212.jatd4clbjlctazun@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004080212.jatd4clbjlctazun@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 04:02:12AM -0400, Jeff King wrote:

> On Wed, Oct 04, 2017 at 04:19:52PM +0900, Junio C Hamano wrote:
> 
> > * jt/partial-clone-lazy-fetch (2017-10-02) 18 commits
> [...]
> 
> The merge of this topic into jch (at 766f92478b0) causes the test suite
> to fail when compiled with ASan/UBSan. The simplest reproduction I could
> come up with is:
> 
>    $ make SANITIZE=address,undefined BLK_SHA1=1 &&
>      GIT_DIR=nope ./git shortlog </dev/null >/dev/null
>    repository.c:69:31: runtime error: index 1869098813 out of bounds for type 'git_hash_algo [1]'
> 
> Note that the series is fine by itself, it's only the merge which fails.
> Which implies to me it's some funny interaction with bc/hash-algo (which
> introduces the hash_algo concept). But I didn't dig further.
> 
> +cc brian and Jonathan.

Actually, I take it back. Bisecting between "master" and "pu" turned up
that commit (and I verified that it fails at that commit but not at its
first parent).

But if I go directly to the tip of bc/hash-algo, I can see the failure
there. And it bisects to 67a9dfcc00 (hash-algo: integrate hash algorithm
support with repo setup, 2017-08-21).

So I think it's a read of uninitialized data, and it may come and go as
various topics tickle the compiler differently. And that would make
jt/partial-clone-lazy-fetch a red herring.

This seems to make it go away (on top of 67a9dfcc00):

diff --git a/setup.c b/setup.c
index 289e24811c..310afe9736 100644
--- a/setup.c
+++ b/setup.c
@@ -1126,7 +1126,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			repo_set_gitdir(the_repository, gitdir);
 			setup_git_env();
 		}
-		repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+		/* This is only valid if we actually found a repository */
+		if (startup_info->have_repository)
+			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	}
 
 	strbuf_release(&dir);

The problem is that we may not have a real repository at all, but we
still hit this code path, which tries to setup repository properties, if
there's a $GIT_DIR set.

I actually suspect this repo_set_hash_algo() line should go into
check_repository_format_gently(), where we set other globals (and which
should eventually take a pointer to struct repository rather than
touching the_repository).

But I'm sufficiently convinced now that this is just a bug in the
RFC-marked bc/hash-algo topic, and in no danger of graduating to master
soon.

-Peff
