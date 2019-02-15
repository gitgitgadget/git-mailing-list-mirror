Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020D41F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfBOSQX (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 13:16:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:48580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfBOSQW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:16:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6258B12F
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 18:16:21 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     git@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 1/2] worktree: fix worktree add race.
Date:   Fri, 15 Feb 2019 19:16:11 +0100
Message-Id: <429046b2c9f02c5e4f0af88db51f6c0c099f08a9.1550254374.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git runs a stat loop to find a worktree name that's available and then does
mkdir on the found name. Turn it to mkdir loop to avoid another invocation of
worktree add finding the same free name and creating the directory first.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 builtin/worktree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3f9907fcc994..e1a2a56c03c5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -268,10 +268,9 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	const char *name;
-	struct stat st;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct argv_array child_env = ARGV_ARRAY_INIT;
-	int counter = 0, len, ret;
+	int counter = 1, len, ret;
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
 	int is_branch = 0;
@@ -295,19 +294,21 @@ static int add_worktree(const char *path, const char *refname,
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_repo.buf);
-	while (!stat(sb_repo.buf, &st)) {
+
+	while (mkdir(sb_repo.buf, 0777)) {
 		counter++;
+		if(!counter) break; /* don't loop forever */
 		strbuf_setlen(&sb_repo, len);
 		strbuf_addf(&sb_repo, "%d", counter);
 	}
+	if (!counter)
+		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
 	name = strrchr(sb_repo.buf, '/') + 1;
 
 	junk_pid = getpid();
 	atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
 
-	if (mkdir(sb_repo.buf, 0777))
-		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
 	junk_git_dir = xstrdup(sb_repo.buf);
 	is_junk = 1;
 
-- 
2.20.1

