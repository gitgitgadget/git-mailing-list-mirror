Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DBEC433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 08:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC1820720
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 08:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGBIOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:14:00 -0400
Received: from smtp01.domein-it.com ([92.48.232.134]:58188 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBIN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 04:13:59 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id A2B2B8086983; Thu,  2 Jul 2020 10:13:55 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id 6717D8086993;
        Thu,  2 Jul 2020 10:13:41 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:51758 helo=ben.dynamic.ziggo.nl)
        by ferret.domein-it.nl with esmtpa (Exim 4.93)
        (envelope-from <ben@wijen.net>)
        id 1jquLh-0000G0-Br; Thu, 02 Jul 2020 10:13:37 +0200
From:   Ben Wijen <ben@wijen.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Ben Wijen <ben@wijen.net>
Subject: [PATCH v2 1/1] git clone: don't clone into non-empty directory
Date:   Thu,  2 Jul 2020 10:13:35 +0200
Message-Id: <20200702081335.16786-2-ben@wijen.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAPig+cS6XnUK9MQL68_yoR9Gve4_itmawsd_0-yJr3S5=3-zPQ@mail.gmail.com>
References: <CAPig+cS6XnUK9MQL68_yoR9Gve4_itmawsd_0-yJr3S5=3-zPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1jquLh-0000G0-Br
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git clone with --separate-git-dir realgitdir and
realgitdir already exists, it's content is destroyed.

So, make sure we don't clone into an existing non-empty directory.

Signed-off-by: Ben Wijen <ben@wijen.net>
---
 builtin/clone.c  | 12 ++++++++++--
 t/t5601-clone.sh |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 2a8e3aaaed..e470193bb8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -946,7 +946,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int is_bundle = 0, is_local;
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir, *display_repo = NULL;
-	int dest_exists;
+	int dest_exists, real_dest_exists = 0;
 	const struct ref *refs, *remote_head;
 	const struct ref *remote_head_points_at;
 	const struct ref *our_head_points_at;
@@ -1021,6 +1021,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die(_("destination path '%s' already exists and is not "
 			"an empty directory."), dir);
 
+	if (real_git_dir) {
+		real_dest_exists = path_exists(real_git_dir);
+		if (real_dest_exists && !is_empty_dir(real_git_dir))
+			die(_("repository path '%s' already exists and is not "
+				"an empty directory."), real_git_dir);
+	}
+
+
 	strbuf_addf(&reflog_msg, "clone: from %s",
 		    display_repo ? display_repo : repo);
 	free(display_repo);
@@ -1057,7 +1065,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	if (real_git_dir) {
-		if (path_exists(real_git_dir))
+		if (real_dest_exists)
 			junk_git_dir_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
 		junk_git_dir = real_git_dir;
 	} else {
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 84ea2a3eb7..eb9a093e25 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -271,7 +271,9 @@ test_expect_success 'fetch from gitfile parent' '
 
 test_expect_success 'clone separate gitdir where target already exists' '
 	rm -rf dst &&
-	test_must_fail git clone --separate-git-dir realgitdir src dst
+	echo foo=bar >>realgitdir/config &&
+	test_must_fail git clone --separate-git-dir realgitdir src dst &&
+	grep foo=bar realgitdir/config
 '
 
 test_expect_success 'clone --reference from original' '
-- 
2.27.0

