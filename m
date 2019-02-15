Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD67F1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbfBOSQZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 13:16:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:48598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfBOSQY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:16:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94B4CB12F
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 18:16:23 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     git@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 2/2] setup: don't fail if commondir is deleted.
Date:   Fri, 15 Feb 2019 19:16:12 +0100
Message-Id: <dd42ab7054077c7d29ad62e7481c00ab5c1bf864.1550254374.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <429046b2c9f02c5e4f0af88db51f6c0c099f08a9.1550254374.git.msuchanek@suse.de>
References: <429046b2c9f02c5e4f0af88db51f6c0c099f08a9.1550254374.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When adding wotktrees git can die in get_common_dir_noenv while
examining existing worktrees because the commondir file does not exist.
Handle ENOENT so adding a worktree does not fail because of incompletely
set-up other worktree.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 setup.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/setup.c b/setup.c
index ca9e8a949ed8..7dec2e5589d9 100644
--- a/setup.c
+++ b/setup.c
@@ -274,22 +274,25 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 
 	strbuf_addf(&path, "%s/commondir", gitdir);
 	if (file_exists(path.buf)) {
-		if (strbuf_read_file(&data, path.buf, 0) <= 0)
-			die_errno(_("failed to read %s"), path.buf);
-		while (data.len && (data.buf[data.len - 1] == '\n' ||
-				    data.buf[data.len - 1] == '\r'))
-			data.len--;
-		data.buf[data.len] = '\0';
-		strbuf_reset(&path);
-		if (!is_absolute_path(data.buf))
-			strbuf_addf(&path, "%s/", gitdir);
-		strbuf_addbuf(&path, &data);
-		strbuf_add_real_path(sb, path.buf);
-		ret = 1;
-	} else {
-		strbuf_addstr(sb, gitdir);
+		if (strbuf_read_file(&data, path.buf, 0) <= 0) {
+			if (errno != ENOENT)
+				die_errno(_("failed to read %s"), path.buf);
+		} else {
+			while (data.len && (data.buf[data.len - 1] == '\n' ||
+						data.buf[data.len - 1] == '\r'))
+				data.len--;
+			data.buf[data.len] = '\0';
+			strbuf_reset(&path);
+			if (!is_absolute_path(data.buf))
+				strbuf_addf(&path, "%s/", gitdir);
+			strbuf_addbuf(&path, &data);
+			strbuf_add_real_path(sb, path.buf);
+			ret = 1;
+			goto out;
+		}
 	}
-
+	strbuf_addstr(sb, gitdir);
+out:
 	strbuf_release(&data);
 	strbuf_release(&path);
 	return ret;
-- 
2.20.1

