Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFE791FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 14:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756040AbcLNO3u (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 09:29:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:56400 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755304AbcLNO3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 09:29:48 -0500
Received: (qmail 31362 invoked by uid 109); 14 Dec 2016 14:29:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 14:29:46 +0000
Received: (qmail 25342 invoked by uid 111); 14 Dec 2016 14:30:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 09:30:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 09:29:44 -0500
Date:   Wed, 14 Dec 2016 09:29:44 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 3/4] Makefile: match shell scripts in FIND_SOURCE_FILES
Message-ID: <20161214142944.xqwkk2zjeyqk3gfr@sigill.intra.peff.net>
References: <20161214142533.svktxk63eiwaaeor@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214142533.svktxk63eiwaaeor@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We feed FIND_SOURCE_FILES to ctags to help developers
navigate to particular functions, but we only feed C source
code. The same feature can be helpful when working with
shell scripts (especially the test suite). Modern versions
of ctags know how to parse shell scripts; we just need to
feed the filenames to it.

This patch specifically avoids including the individual test
scripts themselves. Those are unlikely to be of interest,
and there are a lot of them to process. It does pick up
test-lib.sh and test-lib-functions.sh.

Note that our negative pathspec already excludes the
individual scripts for the ls-files case, but we need to
loosen the `find` rule to match it.

Signed-off-by: Jeff King <peff@peff.net>
---
Maybe people would find this annoying. It does increase the number of
entries in the tags file. I've been running something like it for a few
months and have found it useful.

It's also possible that some people have a version of ctags or etags
that doesn't handle shell scripts. I imagine few enough people actually
run "make tags" in the first place that we can probably try it and see.

 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 001126931..ef8de4a75 100644
--- a/Makefile
+++ b/Makefile
@@ -2152,14 +2152,16 @@ po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 FIND_SOURCE_FILES = ( \
 	git ls-files \
 		'*.[hcS]' \
+		'*.sh' \
 		':!*[tp][0-9][0-9][0-9][0-9]*' \
 		2>/dev/null || \
 	$(FIND) . \
 		\( -name .git -type d -prune \) \
-		-o \( -name '[tp][0-9][0-9][0-9][0-9]' -type d -prune \) \
+		-o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
 		-o \( -name build -type d -prune \) \
 		-o \( -name 'trash*' -type d -prune \) \
 		-o \( -name '*.[hcS]' -type f -print \) \
+		-o \( -name '*.sh' -type f -print \) \
 	)
 
 $(ETAGS_TARGET): FORCE
-- 
2.11.0.341.g202cd3142

