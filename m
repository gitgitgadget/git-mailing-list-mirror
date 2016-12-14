Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A521FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 14:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756075AbcLNO2J (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 09:28:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:56394 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755424AbcLNO2I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 09:28:08 -0500
Received: (qmail 31282 invoked by uid 109); 14 Dec 2016 14:28:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 14:28:06 +0000
Received: (qmail 25314 invoked by uid 111); 14 Dec 2016 14:28:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 09:28:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 09:28:04 -0500
Date:   Wed, 14 Dec 2016 09:28:04 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 2/4] Makefile: exclude test cruft from FIND_SOURCE_FILES
Message-ID: <20161214142804.b6q7enowcavagmam@sigill.intra.peff.net>
References: <20161214142533.svktxk63eiwaaeor@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214142533.svktxk63eiwaaeor@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test directory may contain three types of files that
match our patterns:

  1. Helper programs in t/helper.

  2. Sample data files (e.g., t/t4051/hello.c).

  3. Untracked cruft in trash directories and t/perf/build.

We want to match (1), but not the other two, as they just
clutter up the list.

For the ls-files method, we can drop (2) with a negative
pathspec. We do not have to care about (3), since ls-files
will not list untracked files.

For `find`, we can match both cases with `-prune` patterns.

Signed-off-by: Jeff King <peff@peff.net>
---
I expected that:

  ':![tp][0-9][0-9][0-9][0-9]'

would work, but it doesn't. I think because we don't match intermediate
directories against pathspecs. So you have to use wildcards to match the
rest of the path.

 Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f42b1953d..001126931 100644
--- a/Makefile
+++ b/Makefile
@@ -2150,9 +2150,15 @@ po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
 
 FIND_SOURCE_FILES = ( \
-	git ls-files '*.[hcS]' 2>/dev/null || \
+	git ls-files \
+		'*.[hcS]' \
+		':!*[tp][0-9][0-9][0-9][0-9]*' \
+		2>/dev/null || \
 	$(FIND) . \
 		\( -name .git -type d -prune \) \
+		-o \( -name '[tp][0-9][0-9][0-9][0-9]' -type d -prune \) \
+		-o \( -name build -type d -prune \) \
+		-o \( -name 'trash*' -type d -prune \) \
 		-o \( -name '*.[hcS]' -type f -print \) \
 	)
 
-- 
2.11.0.341.g202cd3142

