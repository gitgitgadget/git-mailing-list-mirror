Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70FC72023D
	for <e@80x24.org>; Mon, 22 May 2017 19:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761105AbdEVTBK (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:01:10 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:24223 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbdEVTBK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:01:10 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wWp0N2vKdz5tlJ;
        Mon, 22 May 2017 21:01:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 20B894327;
        Mon, 22 May 2017 21:01:08 +0200 (CEST)
Subject: [PATCH v2 2/2] Windows: do not treat a path with backslashes as a
 remote's nick name
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <cover.1495261020.git.j6t@kdbg.org>
 <7b1f97ff-52b7-72c3-211f-e73dce562911@kdbg.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b2fa1cff-9902-5bef-0392-1371bf1f4268@kdbg.org>
Date:   Mon, 22 May 2017 21:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <7b1f97ff-52b7-72c3-211f-e73dce562911@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 This v2 writes your suggested comment in front of the loop (not just
 the 'if' because then I feel I would have to add braces).

 remote.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index ad6c5424ed..1949882c10 100644
--- a/remote.c
+++ b/remote.c
@@ -645,7 +645,12 @@ static int valid_remote_nick(const char *name)
 {
 	if (!name[0] || is_dot_or_dotdot(name))
 		return 0;
-	return !strchr(name, '/'); /* no slash */
+
+	/* remote nicknames cannot contain slashes */
+	while (*name)
+		if (is_dir_sep(*name++))
+			return 0;
+	return 1;
 }
 
 const char *remote_for_branch(struct branch *branch, int *explicit)
-- 
2.13.0.55.g17b7d13330
