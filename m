Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24E51F453
	for <e@80x24.org>; Mon, 18 Feb 2019 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbfBRRFW (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 12:05:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:56230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388056AbfBRRFW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 12:05:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38564AE1F;
        Mon, 18 Feb 2019 17:05:21 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     git@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] worktree: fix worktree add race.
Date:   Mon, 18 Feb 2019 18:04:56 +0100
Message-Id: <c7c66ca1f954e20dad8eeec3fb10c53ad844c800.1550508544.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550508544.git.msuchanek@suse.de>
References: <cover.1550508544.git.msuchanek@suse.de>
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
v2:
- simplify loop exit condition
- exit early if the mkdir fails for reason other than already present
worktree
- make counter unsigned
---
 builtin/worktree.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3f9907fcc994..85a604cfe98c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -268,10 +268,10 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	const char *name;
-	struct stat st;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct argv_array child_env = ARGV_ARRAY_INIT;
-	int counter = 0, len, ret;
+	unsigned int counter = 0;
+	int len, ret;
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
 	int is_branch = 0;
@@ -295,8 +295,12 @@ static int add_worktree(const char *path, const char *refname,
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_repo.buf);
-	while (!stat(sb_repo.buf, &st)) {
+
+	while (mkdir(sb_repo.buf, 0777)) {
 		counter++;
+		if ((errno != EEXIST) || !counter /* overflow */)
+			die_errno(_("could not create directory of '%s'"),
+				  sb_repo.buf);
 		strbuf_setlen(&sb_repo, len);
 		strbuf_addf(&sb_repo, "%d", counter);
 	}
@@ -306,8 +310,6 @@ static int add_worktree(const char *path, const char *refname,
 	atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
 
-	if (mkdir(sb_repo.buf, 0777))
-		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
 	junk_git_dir = xstrdup(sb_repo.buf);
 	is_junk = 1;
 
-- 
2.20.1

