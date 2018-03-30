Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C371F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeC3SfO (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:35:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:49074 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752206AbeC3SfO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:35:14 -0400
Received: (qmail 24200 invoked by uid 109); 30 Mar 2018 18:35:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 18:35:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31125 invoked by uid 111); 30 Mar 2018 18:36:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 14:36:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 14:35:12 -0400
Date:   Fri, 30 Mar 2018 14:35:12 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 5/5] refs: use chdir_notify to update cached relative paths
Message-ID: <20180330183512.GE31135@sigill.intra.peff.net>
References: <20180330183425.GA30575@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180330183425.GA30575@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit f57f37e2e1 (files-backend: remove the use of
git_path(), 2017-03-26) introduced a regression when a
relative $GIT_DIR is used in a working tree:

  - when we initialize the ref backend, we make a copy of
    get_git_dir(), which may be relative

  - later, we may call setup_work_tree() and chdir to the
    root of the working tree

  - further calls to the ref code will use the stored git
    directory, but relative paths will now point to the
    wrong place

The new test in t1501 demonstrates one such instance (the
bug causes us to write the ref update to the nonsense
"relative/relative/.git").

Since setup_work_tree() now uses chdir_notify, we can just
ask it update our relative paths when necessary.

Reported-by: Rafael Ascensao <rafa.almas@gmail.com>
Helped-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c  |  6 ++++++
 refs/packed-backend.c |  3 +++
 t/t1501-work-tree.sh  | 12 ++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bec8e30e9e..a92a2aa821 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -9,6 +9,7 @@
 #include "../lockfile.h"
 #include "../object.h"
 #include "../dir.h"
+#include "../chdir-notify.h"
 
 /*
  * This backend uses the following flags in `ref_update::flags` for
@@ -106,6 +107,11 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 	refs->packed_ref_store = packed_ref_store_create(sb.buf, flags);
 	strbuf_release(&sb);
 
+	chdir_notify_reparent("files-backend $GIT_DIR",
+			      &refs->gitdir);
+	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
+			      &refs->gitcommondir);
+
 	return ref_store;
 }
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 65288c6472..369c34f886 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -5,6 +5,7 @@
 #include "packed-backend.h"
 #include "../iterator.h"
 #include "../lockfile.h"
+#include "../chdir-notify.h"
 
 enum mmap_strategy {
 	/*
@@ -202,6 +203,8 @@ struct ref_store *packed_ref_store_create(const char *path,
 	refs->store_flags = store_flags;
 
 	refs->path = xstrdup(path);
+	chdir_notify_reparent("packed-refs", &refs->path);
+
 	return ref_store;
 }
 
diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index b06210ec5e..a5db53337b 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -431,4 +431,16 @@ test_expect_success 'error out gracefully on invalid $GIT_WORK_TREE' '
 	)
 '
 
+test_expect_success 'refs work with relative gitdir and work tree' '
+	git init relative &&
+	git -C relative commit --allow-empty -m one &&
+	git -C relative commit --allow-empty -m two &&
+
+	GIT_DIR=relative/.git GIT_WORK_TREE=relative git reset HEAD^ &&
+
+	git -C relative log -1 --format=%s >actual &&
+	echo one >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.17.0.rc2.594.gdb94a0ce02
