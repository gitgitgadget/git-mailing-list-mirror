Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570A02023D
	for <e@80x24.org>; Fri,  3 Mar 2017 09:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbdCCJRc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 04:17:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:37816 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbdCCJR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 04:17:29 -0500
Received: (qmail 14066 invoked by uid 109); 3 Mar 2017 07:36:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 07:36:35 +0000
Received: (qmail 25500 invoked by uid 111); 3 Mar 2017 07:36:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 02:36:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 02:36:33 -0500
Date:   Fri, 3 Mar 2017 02:36:33 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH] t/perf: add fallback for pre-bin-wrappers versions of git
Message-ID: <20170303073633.maoaovchkz32h467@sigill.intra.peff.net>
References: <20170228221236.selqkf5wme3fvued@sigill.intra.peff.net>
 <20170302195041.1699-1-jonathantanmy@google.com>
 <20170303064512.khs2seru5onl54mh@sigill.intra.peff.net>
 <20170303071403.2k3vbcdstllq2j3y@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170303071403.2k3vbcdstllq2j3y@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 02:14:03AM -0500, Jeff King wrote:

> With this patch I was able to run p0001 against v1.7.0. I don't think we
> can go further back than that because the perf library depends on the
> presence of bin-wrappers. That's probably enough. Unlike the t/interop
> library I proposed recently it's not that interesting to go really far
> back in time (and I did hack around the bin-wrappers thing in t/interop;
> you really can test against v1.0.0 there).

This is easy to fix (see below). I doubt anybody cares, but it's
probably worth fixing just because the failure mode (quietly running
whatever git is in your PATH) is so confusing. It would also be an
improvement to just detect the situation and die(), but this is
literally not any more effort.

-- >8 --
Subject: [PATCH] t/perf: add fallback for pre-bin-wrappers versions of git

It's tempting to say:

  ./run v1.0.0 HEAD

to see how we've sped up Git over the years. Unfortunately,
this doesn't quite work because versions of Git prior to
v1.7.0 lack bin-wrappers, so our "run" script doesn't
correctly put them in the PATH.

Worse, it means we silently find whatever other "git" is in
the PATH, and produce test results that have no bearing on
what we asked for.

Let's fallback to the main git directory when bin-wrappers
isn't present. Many modern perf scripts won't run with such
an antique version of Git, of course, but at least those
failures are detected and reported (and you're free to write
a limited perf script that works across many versions).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/run | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index e8adedadf..c788d713a 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -63,6 +63,9 @@ run_dirs_helper () {
 		unset GIT_TEST_INSTALLED
 	else
 		GIT_TEST_INSTALLED="$mydir/bin-wrappers"
+		# Older versions of git lacked bin-wrappers; fallback to the
+		# files in the root.
+		test -d "$GIT_TEST_INSTALLED" || GIT_TEST_INSTALLED=$mydir
 		export GIT_TEST_INSTALLED
 	fi
 	run_one_dir "$@"
-- 
2.12.0.385.gdf4947bc7

