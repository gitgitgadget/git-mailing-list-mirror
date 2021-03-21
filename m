Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D0C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE8661946
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCUMf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:58 -0400
Received: from smtp5.ctinetworks.com ([205.166.61.198]:55294 "EHLO
        smtp5.ctinetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCUMfv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:51 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2021 08:35:51 EDT
Received: from localhost (unknown [117.193.5.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: enometh@meer.net)
        by smtp5.ctinetworks.com (Postfix) with ESMTPSA id CBDE4163B98
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 08:29:25 -0400 (EDT)
Date:   Sun, 21 Mar 2021 17:58:21 +0530 (IST)
Message-Id: <20210321.175821.1385189088303987287.enometh@meer.net>
To:     git@vger.kernel.org
Subject: [PATCH] init: don't reset core.filemode on git-new-workdirs.
From:   Madhu <enometh@meer.net>
X-Mailer: Mew version 6.8 on Emacs 28.0
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ctinetworks-Information: Please contact the ISP for more information
X-ctinetworks-MailScanner-ID: CBDE4163B98.A7A36
X-ctinetworks-VirusCheck: Found to be clean
X-ctinetworks-SpamCheck: 
X-ctinetworks-Watermark: 1617193768.10664@yY8dBmQWBKWufd5Gnh35AA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Madhu <enometh@net.meer>

If the .git/config file is a symlink (as is the case of a .git created
by the contrib/workdir/git-new-workdir script) then the filemode tests
fail, and the filemode is reset to be false.  To avoid this only munge
core.filemode if .git/config is a regular file.
---
 builtin/init-db.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index dcc45bef51..b053107336 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -285,7 +285,8 @@ static int create_default_files(const char *template_path,
 	/* Check filemode trustability */
 	path = git_path_buf(&buf, "config");
 	filemode = TEST_FILEMODE;
-	if (TEST_FILEMODE && !lstat(path, &st1)) {
+	if (TEST_FILEMODE && !lstat(path, &st1)
+	    && (st1.st_mode & S_IFMT) == S_IFREG) {
 		struct stat st2;
 		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
 				!lstat(path, &st2) &&
-- 
2.31.0.dirty
