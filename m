Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3AF201CF
	for <e@80x24.org>; Sat, 20 May 2017 06:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbdETG3b (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 02:29:31 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:53978 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdETG3a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 02:29:30 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wVFQ03jByz5tl9;
        Sat, 20 May 2017 08:29:28 +0200 (CEST)
Received: from dx.site (localhost [127.0.0.1])
        by dx.site (Postfix) with ESMTP id 3F06942E7;
        Sat, 20 May 2017 08:29:28 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] Windows: do not treat a path with backslashes as a remote's nick name
Date:   Sat, 20 May 2017 08:28:39 +0200
Message-Id: <6347731f26396b1256070e02376bf3623bfb7102.1495261020.git.j6t@kdbg.org>
X-Mailer: git-send-email 2.13.0.55.g17b7d13330
In-Reply-To: <cover.1495261020.git.j6t@kdbg.org>
References: <cover.1495261020.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fetching from a remote using a native Windows path produces these warnings:

C:\Temp\gittest>git fetch C:\Temp\gittest
warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid argument
warning: unable to access '.git/branches/C:\Temp\gittest': Invalid argument
From C:\Temp\gittest
 * branch            HEAD       -> FETCH_HEAD

The functions that read the branches and remotes files are protected by
a valid_remote_nick() check. Its implementation does not take Windows
paths into account, so that the caller simply concatenates the paths,
leading to the error seen above.

Use is_dir_sep() to check for both slashes and backslashes on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 remote.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 9584af366d..9501357c06 100644
--- a/remote.c
+++ b/remote.c
@@ -649,7 +649,10 @@ static int valid_remote_nick(const char *name)
 {
 	if (!name[0] || is_dot_or_dotdot(name))
 		return 0;
-	return !strchr(name, '/'); /* no slash */
+	while (*name)
+		if (is_dir_sep(*name++))	/* no slash */
+			return 0;
+	return 1;
 }
 
 const char *remote_for_branch(struct branch *branch, int *explicit)
-- 
2.13.0.55.g17b7d13330

