Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0DE1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 17:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390243AbfBRRFX (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 12:05:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:56254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388060AbfBRRFW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 12:05:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8213DAED7;
        Mon, 18 Feb 2019 17:05:21 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     git@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] setup: don't fail if commondir reference is deleted.
Date:   Mon, 18 Feb 2019 18:04:57 +0100
Message-Id: <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550508544.git.msuchanek@suse.de>
References: <cover.1550508544.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When adding wotktrees git can die in get_common_dir_noenv while
examining existing worktrees because the commondir file does not exist.
Rather than testing if the file exists before reading it handle ENOENT.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2:
- do not test file existence first, just read it and handle ENOENT.
- handle zero size file correctly
---
 setup.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/setup.c b/setup.c
index ca9e8a949ed8..dd865f280d34 100644
--- a/setup.c
+++ b/setup.c
@@ -270,12 +270,20 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 {
 	struct strbuf data = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
-	int ret = 0;
+	int ret;
 
 	strbuf_addf(&path, "%s/commondir", gitdir);
-	if (file_exists(path.buf)) {
-		if (strbuf_read_file(&data, path.buf, 0) <= 0)
+	ret = strbuf_read_file(&data, path.buf, 0);
+	if (ret <= 0) {
+		/*
+		 * if file is missing or zero size (just being written)
+		 * assume default, bail otherwise
+		 */
+		if (ret && errno != ENOENT)
 			die_errno(_("failed to read %s"), path.buf);
+		strbuf_addstr(sb, gitdir);
+		ret = 0;
+	} else {
 		while (data.len && (data.buf[data.len - 1] == '\n' ||
 				    data.buf[data.len - 1] == '\r'))
 			data.len--;
@@ -286,8 +294,6 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 		strbuf_addbuf(&path, &data);
 		strbuf_add_real_path(sb, path.buf);
 		ret = 1;
-	} else {
-		strbuf_addstr(sb, gitdir);
 	}
 
 	strbuf_release(&data);
-- 
2.20.1

