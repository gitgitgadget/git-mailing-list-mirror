Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BB7C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 04:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81B5611CC
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 04:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhFMEok (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 00:44:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:53638 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhFMEoe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 00:44:34 -0400
Received: (qmail 26895 invoked by uid 109); 13 Jun 2021 04:42:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 13 Jun 2021 04:42:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23124 invoked by uid 111); 13 Jun 2021 04:42:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Jun 2021 00:42:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Jun 2021 00:42:32 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Message-ID: <YMWMuDbctae7tF6J@coredump.intra.peff.net>
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210609170520.67014-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 09, 2021 at 12:05:20PM -0500, Felipe Contreras wrote:

> The test_atexit unit test relies on the specific location of the
> generated files.
> 
> When TEST_OUTPUT_DIRECTORY is unset, _run_sub_test_lib_test_common sets
> it to pwd, which is two levels under the pwd of the parent unit test,
> and the parent can find the generated files just fine.
> 
> But when TEST_OUTPUT_DIRECTORY is set, it's stored in GIT-BUILD-OPTIONS,
> and even though _run_sub_test_lib_test_common correctly overrides it,
> when the child script is run, it sources GIT-BUILD-OPTIONS, and
> TEST_OUTPUT_DIRECTORY is overridden.
> 
> Effectively both the parent and child scripts output to the same
> directory.
> 
>   make TEST_OUTPUT_DIRECTORY=/tmp/foobar GIT-BUILD-OPTIONS &&
>   make -C t t0000-basic.sh

I agree things are broken when TEST_OUTPUT_DIRECTORY is set. We pollute
/tmp/foobar in that case with trash directories, as well as its
test-results/ directory with subtest results (mostly "counts" files).

> On the other hand we could follow the alternate path suggested in
> 6883047071 (t0000: set TEST_OUTPUT_DIRECTORY for sub-tests, 2013-12-28):
> pass the --root parameter to the child scripts.
> 
> The alternate solution works, so let's do that instead.

Unfortunately, this isn't a complete solution. Using --root fixes the
trash directories, but we still pollute test-results. No tests in t0000
rely on that, but it's still the wrong thing to be doing.

That's true before your patch, as well, though it does make things
slightly worse when TEST_OUTPUT_DIRECTORY isn't set (before in that case
everything worked perfectly, and now it pollutes test-results/, too).

I think solving the whole issue would require a mechanism for passing
TEST_OUTPUT_DIRECTORY in a way that can't be overridden (whether in an
environment variable or the command-line).

Alternatively, it would be nice if GIT-BUILD-OPTIONS didn't override the
environment. That would fix this problem, prevent similar ones in the
future, and I think would do the right thing if a caller decided to do
something like:

  PERL_PATH=/some/other/perl ./t1234-foo.sh

We might be able to write GIT-BUILD-OPTIONS to use ${foo:=}
default-value expansion, but I'm not sure if there are any non-shell
readers of the file (I don't see any, but I feel like we've run afoul of
this before). Something like this might work:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index adaf03543e..731dd41d9c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -54,7 +54,10 @@ then
 	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
 	exit 1
 fi
+# let our env take precedence over build options
+current_env=$(set)
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+eval "$current_env"
 export PERL_PATH SHELL_PATH
 
 # Disallow the use of abbreviated options in the test suite by default

but I think more fixes are required for $TEST_OUTPUT_DIRECTORY, since we
set it so early in the script (before we read GIT-BUILD-OPTIONS, so at
that point we have no idea if it came from the environment or our
default settings).

-Peff
