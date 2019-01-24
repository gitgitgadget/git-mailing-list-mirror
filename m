Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5641F453
	for <e@80x24.org>; Thu, 24 Jan 2019 13:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfAXNLy (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 08:11:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:47190 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726105AbfAXNLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 08:11:53 -0500
Received: (qmail 27437 invoked by uid 109); 24 Jan 2019 13:11:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 13:11:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28264 invoked by uid 111); 24 Jan 2019 13:11:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 08:11:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 08:11:51 -0500
Date:   Thu, 24 Jan 2019 08:11:51 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/8] create_bundle(): drop unused "header" parameter
Message-ID: <20190124131151.GC22398@sigill.intra.peff.net>
References: <20190124131104.GA24017@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to pass a header struct to create_bundle(); it writes
the header information directly to a descriptor (and does not report
back details to the caller).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/bundle.c | 3 +--
 bundle.c         | 4 ++--
 bundle.h         | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 9e9c65d9c6..1ea4bfdfc1 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -56,8 +56,7 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		}
 		if (!startup_info->have_repository)
 			die(_("Need a repository to create a bundle."));
-		return !!create_bundle(the_repository, &header,
-				       bundle_file, argc, argv);
+		return !!create_bundle(the_repository, bundle_file, argc, argv);
 	} else if (!strcmp(cmd, "unbundle")) {
 		if (!startup_info->have_repository)
 			die(_("Need a repository to unbundle."));
diff --git a/bundle.c b/bundle.c
index 37b1daa691..b45666c49b 100644
--- a/bundle.c
+++ b/bundle.c
@@ -424,8 +424,8 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 	return ref_count;
 }
 
-int create_bundle(struct repository *r, struct bundle_header *header,
-		  const char *path, int argc, const char **argv)
+int create_bundle(struct repository *r, const char *path,
+		  int argc, const char **argv)
 {
 	struct lock_file lock = LOCK_INIT;
 	int bundle_fd = -1;
diff --git a/bundle.h b/bundle.h
index 781e6f5c3a..37c37d7f65 100644
--- a/bundle.h
+++ b/bundle.h
@@ -18,8 +18,8 @@ struct bundle_header {
 
 int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
-int create_bundle(struct repository *r, struct bundle_header *header,
-		  const char *path, int argc, const char **argv);
+int create_bundle(struct repository *r, const char *path,
+		  int argc, const char **argv);
 int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
 #define BUNDLE_VERBOSE 1
 int unbundle(struct repository *r, struct bundle_header *header,
-- 
2.20.1.842.g8986705066

