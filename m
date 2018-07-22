Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD961F597
	for <e@80x24.org>; Sun, 22 Jul 2018 05:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeGVGoa (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 02:44:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33155 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeGVGoa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 02:44:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so659161wmh.0
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 22:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tU4jtnlAmAm/zo8RUQVelmkOR5zSD+kmhqOzcejKQNE=;
        b=GVLXfefffQVYD7Pe71kJB38Tt9wPdr01kyouiD8q0HYOqUmp+bnBVvRXqiEI4wXqc1
         uMEc9rWJi5sFg9rB0iKMePwppfsZe920fkxNOzOjtvFmV730hqd3IQ/znyGqWJu23umd
         ucbigr9jNgVnwl/r+46jtPKNszUkwSlRNgTdEKBcpnIiHvGf6ZEW1+BoCphMrkq7kv+F
         teVKzTmO2+xCIO/rxh3h6RlnuLAB+zucfhIzTaddz9YSVO2v+MkVXa+ULv8+E7W5Ow7u
         QUYLiGaCq6a3Wx+3VtcGctOHbmn8JfjzxbVdqHnvJkgbgf4wX4/Vp1zOW7AdT+9t3DfM
         +v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tU4jtnlAmAm/zo8RUQVelmkOR5zSD+kmhqOzcejKQNE=;
        b=swovfPfBsC7IjwB0ov3yQ9+01CpQUcFYF/WIWsQp7vIVc1Ep/2vZ+eua2Ua4eW101u
         +inr9GmUI26DF59sm3Kj3n6jdj/DIwLA/FwcpwI27Tvp9UF5cpiooSP+37MwsR0ZWUzO
         xJS0RReApMBSSqyJWlG/9k0+uNb71bPWCSColNAFi0rhwUF526yLo8Pl4OcqW2ATrXz0
         qWIbDdAfABymqjQXylBwuHZ5aLHVxDRb3wYeZvDqOIj5kHrOhqY7DR3M39+IGEoxIIi/
         hXzeSPe0c8fuUOXeKAOSPXgM+roXsd8QY+l+wnrhn6cMUMSQHERrC08rmJleaSTYzolI
         5AVA==
X-Gm-Message-State: AOUpUlG+wejdQuqikDUxKtPIuehL1QSiDWEy4JNXH31aSkWocKjVK73E
        6gB7ShPMOpqFyQS40EDMNq3XbQh6
X-Google-Smtp-Source: AAOMgpdH+X7uhbars1Ycdt+X/NgaVeguZ4XzmhLRyPUlH9lyWLoUige5hs05XQ8R35U7il7vb81BWg==
X-Received: by 2002:a1c:910f:: with SMTP id t15-v6mr5019723wmd.51.1532238542432;
        Sat, 21 Jul 2018 22:49:02 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id d102-v6sm10591856wma.10.2018.07.21.22.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 22:49:01 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 4/5] repack: add delta-islands support
Date:   Sun, 22 Jul 2018 07:48:35 +0200
Message-Id: <20180722054836.28935-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.237.gffdb1dbdaa
In-Reply-To: <20180722054836.28935-1-chriscool@tuxfamily.org>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Implement simple support for --delta-islands option and
repack.useDeltaIslands config variable in git repack.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt     | 4 ++++
 Documentation/git-repack.txt | 5 +++++
 builtin/repack.c             | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f682e92a1a..1da39da2a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3091,6 +3091,10 @@ repack.packKeptObjects::
 	index is being written (either via `--write-bitmap-index` or
 	`repack.writeBitmaps`).
 
+repack.useDeltaIslands::
+	If set to true, makes `git repack` act as if `--delta-islands`
+	was passed. Defaults to `false`.
+
 repack.writeBitmaps::
 	When true, git will write a bitmap index when packing all
 	objects to disk (e.g., when `git repack -a` is run).  This
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d90e7907f4..a8b2d4722f 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -155,6 +155,11 @@ depth is 4095.
 	being removed. In addition, any unreachable loose objects will
 	be packed (and their loose counterparts removed).
 
+-i::
+--delta-islands::
+	Pass the `--delta-islands` option to `git-pack-objects`, see
+	linkgit:git-pack-objects[1].
+
 Configuration
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159e..5ab9ee69e4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -12,6 +12,7 @@
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
 static int write_bitmaps;
+static int use_delta_islands;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -40,6 +41,10 @@ static int repack_config(const char *var, const char *value, void *cb)
 		write_bitmaps = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "repack.usedeltaislands")) {
+		use_delta_islands = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -194,6 +199,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("pass --local to git-pack-objects")),
 		OPT_BOOL('b', "write-bitmap-index", &write_bitmaps,
 				N_("write bitmap index")),
+		OPT_BOOL('i', "delta-islands", &use_delta_islands,
+				N_("pass --delta-islands to git-pack-objects")),
 		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
 				N_("with -A, do not loosen objects older than this")),
 		OPT_BOOL('k', "keep-unreachable", &keep_unreachable,
@@ -267,6 +274,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_pushf(&cmd.args, "--no-reuse-object");
 	if (write_bitmaps)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
+	if (use_delta_islands)
+		argv_array_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
-- 
2.18.0.237.gffdb1dbdaa

