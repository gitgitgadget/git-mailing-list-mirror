Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE9E1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 01:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757055AbeBPBPK (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 20:15:10 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34515 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757051AbeBPBPI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 20:15:08 -0500
Received: by mail-wm0-f68.google.com with SMTP id j21so3461304wmh.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 17:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eZzGBxnN9F3YeyClVLfddSUbGB9dEn3xQorcKJUH0Sw=;
        b=cAAfTReodvCmBmUtu+cVcO1p0CBeqgUdupCYl2pXz9cyUEBgSZ4osIxhc1v9Wkl9VJ
         QX+VmupP+J7s88oyLniTK9HCV9d4fdmU5c8/RThGHa2Ev6Rj7QePDjA8hpj1srES3U7d
         4AHZCkhX3LqsOoodo3iTbB06t+gfALAWBwEx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eZzGBxnN9F3YeyClVLfddSUbGB9dEn3xQorcKJUH0Sw=;
        b=DKI+KcMpPu+cT9lM6+qPRFgGXhJRIxDQDJhf/1CsgppZM3fmtQ9ZtPeUtpNoTa5Xj5
         RD/VGAUbNea1SrDT4megizgy8Nigq9yUBZ/VU8z9S1raRrhvfA1D+7J6OdKbEbr8sSFa
         MHtx75D66suykXAn+KzxZE6PQjU/51klnMeg4w4T1e0ipl/zgEreWwYt92y1/4BgMPSb
         GZ3hXqm0YCnJAe8QB3d51esODA1N3SbmnMvNrUvERnfdJWtSE//5pyU18TWY3VPxNC5r
         Un65CFpK2RwkpZh2pvGFJIr2DiadUCF/vTgoFuVzO5e6YYg8TuWeAhdOU5Cgghah70GZ
         GNTg==
X-Gm-Message-State: APf1xPDvLFZhGtvkZn7ehYI4kl8XhhqSh2vina7RVC9E+N4UUx3jZile
        H8fEZahB6bOIvOqBZj7U2JfC15ADPWw=
X-Google-Smtp-Source: AH8x227fm+wbduM7aKPaZZ3veUoLAcI1UhFMwRdAsVoDKYF+I2wxWYN9ndhmsHeTlyc8wh+1O2RD6g==
X-Received: by 10.80.164.161 with SMTP id w30mr5773388edb.283.1518743707276;
        Thu, 15 Feb 2018 17:15:07 -0800 (PST)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-126-104.cgn.ip.fibianet.dk. [5.186.126.104])
        by smtp.gmail.com with ESMTPSA id s23sm11620917edd.6.2018.02.15.17.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Feb 2018 17:15:06 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC PATCH] cherry: teach git cherry to respect pathspec
Date:   Fri, 16 Feb 2018 02:15:01 +0100
Message-Id: <20180216011501.889-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a very naive attempt at teaching git cherry to restrict
attention to a given pathspec. Very much RFC, hence no documentation
update or test cases for now.

The first problem is the existing signature, with between 0 and 3
arguments. In order to preserve having defaults for limit, head,
upstream, I decided to make use of -- mandatory. The alternative seems
to be to only take a pathspec as arguments 4+, forcing the users to
write out the default values for head and/or limit (and how does one
actually write the default "no limit"?).

At first I just tried parse_pathspec directly to &revs.prune_data, but
that didn't seem to have any effect, and from staring at revision.c for
a while, it seems that one has to go through setup_revisions(). But that
fits well with insisting on the -- above, since we then have an argv[]
that ensures we never hit the handle_revision_arg() or
handle_revision_pseudo_opt() calls.

The motivation for this is that I'm in the process of switching a BSP
from a vendor kernel to one much closer to mainline's master branch. I
do need to apply/port some out-of-tree patches from the vendor kernel,
but it's much more managable if one can do a per-subsystem survey of
what might need porting. So I naively started by doing

  git cherry -v linus/master LSDK-17.12-V4.9 v4.9.62 -- drivers/mtd/spi-nor/

assuming that would Just Work. I was somewhat surprised that this didn't
give any output, but digging into the source revealed that (1) there
isn't actually any pathspec handling and (2) any argc other than 1..3 is
treated as 0 - something which is probably also worth fixing.

With this patch, the command above does give something reasonable, and
t3500-cherry.sh also seems to pass.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/log.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 46b4ca13e..2d4534b5c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1890,6 +1890,8 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	const char *head = "HEAD";
 	const char *limit = NULL;
 	int verbose = 0, abbrev = 0;
+	int pathspec_argc = 0;
+	int i;
 
 	struct option options[] = {
 		OPT__ABBREV(&abbrev),
@@ -1897,17 +1899,27 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, cherry_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, cherry_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	for (i = 1; i < argc; ++i) {
+		if (!strcmp(argv[i], "--")) {
+			pathspec_argc = 1 + argc - i;
+			argc = i;
+			break;
+		}
+	}
 
 	switch (argc) {
+	case 4:
+		limit = argv[3];
+		/* FALLTHROUGH */
 	case 3:
-		limit = argv[2];
+		head = argv[2];
 		/* FALLTHROUGH */
 	case 2:
-		head = argv[1];
-		/* FALLTHROUGH */
-	case 1:
-		upstream = argv[0];
+		upstream = argv[1];
 		break;
 	default:
 		current_branch = branch_get(NULL);
@@ -1921,6 +1933,15 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	}
 
 	init_revisions(&revs, prefix);
+	if (pathspec_argc) {
+		/*
+		 * hack: this reuses the element of argv before "--"
+		 * as argv[0] - setup_revisions assumes argv[0] is
+		 * present and ignores it, and starts its search for
+		 * "--" at argv[1].
+		 */
+		setup_revisions(pathspec_argc, &argv[argc-1], &revs, NULL);
+	}
 	revs.max_parents = 1;
 
 	if (add_pending_commit(head, &revs, 0))
-- 
2.15.1

