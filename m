Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD341F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 19:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440154AbfJRTqC (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 15:46:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfJRTqC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 15:46:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46A0A306059B;
        Fri, 18 Oct 2019 19:46:02 +0000 (UTC)
Received: from trillian.uncooperative.org.com (dhcp-10-20-1-15.bss.redhat.com [10.20.1.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD3D5C1B5;
        Fri, 18 Oct 2019 19:45:58 +0000 (UTC)
From:   Peter Jones <pjones@redhat.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH v2 1/4] libgit: Add a read-only helper to test the worktree lock
Date:   Fri, 18 Oct 2019 15:45:39 -0400
Message-Id: <20191018194542.1316981-1-pjones@redhat.com>
In-Reply-To: <20191018194317.wvqphshpkfskvkyh@redhat.com>
References: <20191018194317.wvqphshpkfskvkyh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 18 Oct 2019 19:46:02 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the function is_worktree_locked(), which is a helper to tell if a
worktree is locked without having to be able to modify it.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 builtin/worktree.c |  2 +-
 worktree.c         | 16 ++++++++++++++++
 worktree.h         |  5 +++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4de44f579af..86305cc1fe1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -245,7 +245,7 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
 	if (!wt)
 		goto done;
 
-	locked = !!worktree_lock_reason(wt);
+	locked = is_worktree_locked(wt);
 	if ((!locked && opts->force) || (locked && opts->force > 1)) {
 		if (delete_git_dir(wt->id))
 		    die(_("unable to re-add worktree '%s'"), path);
diff --git a/worktree.c b/worktree.c
index 5b4793caa34..4924805c389 100644
--- a/worktree.c
+++ b/worktree.c
@@ -244,6 +244,22 @@ int is_main_worktree(const struct worktree *wt)
 	return !wt->id;
 }
 
+int is_worktree_locked(const struct worktree *wt)
+{
+	struct strbuf path = STRBUF_INIT;
+	int locked = 0;
+
+	if (wt->lock_reason_valid && wt->lock_reason)
+		return 1;
+
+	strbuf_addstr(&path, worktree_git_path(wt, "locked"));
+	if (file_exists(path.buf))
+		locked = 1;
+
+	strbuf_release(&path);
+	return locked;
+}
+
 const char *worktree_lock_reason(struct worktree *wt)
 {
 	assert(!is_main_worktree(wt));
diff --git a/worktree.h b/worktree.h
index caecc7a281c..5ff16c414b5 100644
--- a/worktree.h
+++ b/worktree.h
@@ -56,6 +56,11 @@ struct worktree *find_worktree(struct worktree **list,
  */
 int is_main_worktree(const struct worktree *wt);
 
+/*
+ * Return true if the given worktree is locked
+ */
+int is_worktree_locked(const struct worktree *wt);
+
 /*
  * Return the reason string if the given worktree is locked or NULL
  * otherwise.
-- 
2.23.0

