Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7171220D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750993AbdE3FRp (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:17:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:59629 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbdE3FRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:17:44 -0400
Received: (qmail 13029 invoked by uid 109); 30 May 2017 05:17:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 05:17:44 +0000
Received: (qmail 20887 invoked by uid 111); 30 May 2017 05:18:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 01:18:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 01:17:42 -0400
Date:   Tue, 30 May 2017 01:17:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 6/8] version: convert to parse-options
Message-ID: <20170530051742.3j3yn3ipfmyrrteu@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git version" command didn't traditionally accept any
options, and in fact ignores any you give it. When we added
simple option parsing for "--build-options" in 6b9c38e14, we
didn't improve this; we just loop over the arguments and
pick out the one we recognize.

Instead, let's move to a real parsing loop, complain about
nonsense options, and recognize conventions like "-h".

Signed-off-by: Jeff King <peff@peff.net>
---
I assume nobody was running "git version --foobar" and expecting it to
work. I guess we could also complain about "git version foobar" (no
dashes), but this patch doesn't. Mainly I wanted the auto-generated
options list.

 help.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/help.c b/help.c
index a07f01e6f..41017e88e 100644
--- a/help.c
+++ b/help.c
@@ -8,6 +8,7 @@
 #include "column.h"
 #include "version.h"
 #include "refs.h"
+#include "parse-options.h"
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -424,16 +425,30 @@ const char *help_unknown_cmd(const char *cmd)
 
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
+	int build_options = 0;
+	const char * const usage[] = {
+		N_("git version [<options>]"),
+		NULL
+	};
+	struct option options[] = {
+		OPT_BOOL(0, "build-options", &build_options,
+			 "also print build options"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
 	/*
 	 * The format of this string should be kept stable for compatibility
 	 * with external projects that rely on the output of "git version".
+	 *
+	 * Always show the version, even if other options are given.
 	 */
 	printf("git version %s\n", git_version_string);
-	while (*++argv) {
-		if (!strcmp(*argv, "--build-options")) {
-			printf("sizeof-long: %d\n", (int)sizeof(long));
-			/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
-		}
+
+	if (build_options) {
+		printf("sizeof-long: %d\n", (int)sizeof(long));
+		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
 	return 0;
 }
-- 
2.13.0.613.g11c956365

