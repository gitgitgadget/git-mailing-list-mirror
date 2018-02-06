Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643AB1F576
	for <e@80x24.org>; Tue,  6 Feb 2018 08:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeBFIo7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 03:44:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:41906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751835AbeBFIo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 03:44:58 -0500
Received: (qmail 23679 invoked by uid 109); 6 Feb 2018 08:44:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Feb 2018 08:44:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16171 invoked by uid 111); 6 Feb 2018 08:45:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Feb 2018 03:45:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2018 03:44:56 -0500
Date:   Tue, 6 Feb 2018 03:44:56 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 2/2] git-sh-i18n: check GETTEXT_POISON before
 USE_GETTEXT_SCHEME
Message-ID: <20180206084456.GB26329@sigill.intra.peff.net>
References: <20180206084226.GA26237@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180206084226.GA26237@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running "make NO_GETTEXT=1 GETTEXT_POISON=1" currently fails
t0205.

While it might seem nonsensical at first glance to both
poison and disable gettext, it's useful to be able to do a
poison test-run on a system that doesn't have gettext at
all. And it works fine for C programs; the problem is only
with the shell code.

The issue is that we check the baked-in USE_GETTEXT_SCHEME
value before GETTEXT_POISON. And when NO_GETTEXT is set, the
Makefile sets USE_GETTEXT_SCHEME to "fallthrough".

So one fix would be to have the Makefile just set
USE_GETTEXT_SCHEME to "poison" if GETTEXT_POISON is set.
But there are two problems with that:

  1. USE_GETTEXT_SCHEME is actually a user-facing knob, so
     conceivably somebody could override it with:

       make USE_GETTEXT_SCHEME=gnu GETTEXT_POISON=1

     which would do the wrong thing (though that's much less
     likely than them having the variable set in their
     config.mak and just overriding GETTEXT_POISON on the
     command-line for a one-off test).

  2. We don't actually bake GETTEXT_POISON in to the shell
     library like we do for the C code. It checks
     $GIT_GETTEXT_POISON at runtime, which is set up by the
     test suite. So it makes sense to put the fix in the
     runtime code, too, which would cover something like:

       GIT_GETTEXT_POISON=foo git foo

     It's not likely that people use the poison code outside
     of running the test suite, but it's easy enough to make
     this case work.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-sh-i18n.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 1ef1889dbd..9d065fb4bf 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -17,15 +17,15 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "@@USE_GETTEXT_SCHEME@@"
+if test -n "$GIT_GETTEXT_POISON"
+then
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
+elif test -n "@@USE_GETTEXT_SCHEME@@"
 then
 	GIT_INTERNAL_GETTEXT_SH_SCHEME="@@USE_GETTEXT_SCHEME@@"
 elif test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
 then
 	: no probing necessary
-elif test -n "$GIT_GETTEXT_POISON"
-then
-	GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
 elif type gettext.sh >/dev/null 2>&1
 then
 	# GNU libintl's gettext.sh
-- 
2.16.1.273.gc07cfcd8c9
