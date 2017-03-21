Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0707F20958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754788AbdCUBcN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:32:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:48326 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755727AbdCUBcM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:32:12 -0400
Received: (qmail 11060 invoked by uid 109); 21 Mar 2017 01:31:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:31:32 +0000
Received: (qmail 9942 invoked by uid 111); 21 Mar 2017 01:31:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:31:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:31:27 -0400
Date:   Mon, 20 Mar 2017 21:31:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] bundle: use prefix_filename with bundle path
Message-ID: <20170321013126.kcupajrxl7mrqq7i@sigill.intra.peff.net>
References: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We may take the path to a bundle file as an argument, and
need to adjust the filename based on the prefix we
discovered while setting up the git directory. We do so
manually into a fixed-size buffer, but using
prefix_filename() is the normal way.

Besides being more concise, there are two subtle
improvements:

  1. The original inserted a "/" between the two paths, even
     though the "prefix" argument always has the "/"
     appended. That means that:

       cd subdir && git bundle verify ../foo.bundle

     was looking at (and reporting) subdir//../foo.bundle.
     Harmless, but ugly.  Using prefix_filename() gets this
     right.

  2. The original checked for an absolute path by looking
     for a leading '/'. It should have been using
     is_absolute_path(), which also covers more cases on
     Windows (backslashes and dos drive prefixes).

     But it's easier still to just pass the name to
     prefix_filename(), which handles this case
     automatically.

Note that we'll just leak the resulting buffer in the name
of simplicity, since it needs to last through the duration
of the program anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/bundle.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 4883a435a..d0de59b94 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -20,21 +20,15 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	struct bundle_header header;
 	const char *cmd, *bundle_file;
 	int bundle_fd = -1;
-	char buffer[PATH_MAX];
 
 	if (argc < 3)
 		usage(builtin_bundle_usage);
 
 	cmd = argv[1];
-	bundle_file = argv[2];
+	bundle_file = prefix_filename(prefix, argv[2]);
 	argc -= 2;
 	argv += 2;
 
-	if (prefix && bundle_file[0] != '/') {
-		snprintf(buffer, sizeof(buffer), "%s/%s", prefix, bundle_file);
-		bundle_file = buffer;
-	}
-
 	memset(&header, 0, sizeof(header));
 	if (strcmp(cmd, "create") && (bundle_fd =
 				read_bundle_header(bundle_file, &header)) < 0)
-- 
2.12.1.683.gcd02edfec
