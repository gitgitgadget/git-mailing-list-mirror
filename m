Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6332023D
	for <e@80x24.org>; Mon, 22 May 2017 18:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760944AbdEVS6m (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 14:58:42 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:25670 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760390AbdEVS6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 14:58:37 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wWnxR6L6Lz5tlL;
        Mon, 22 May 2017 20:58:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E3E5D4327;
        Mon, 22 May 2017 20:58:32 +0200 (CEST)
Subject: [PATCH v2 1/2] mingw.h: permit arguments with side effects for
 is_dir_sep
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <cover.1495261020.git.j6t@kdbg.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7b1f97ff-52b7-72c3-211f-e73dce562911@kdbg.org>
Date:   Mon, 22 May 2017 20:58:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <cover.1495261020.git.j6t@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taking git-compat-util.h's cue (which uses an inline function to back
is_dir_sep()), let's use an inline function to back also the Windows
version of is_dir_sep(). This avoids problems when calling the function
with arguments that do more than just provide a single character, e.g.
incrementing a pointer. Example:

    is_dir_sep(*p++)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This v2 takes your commit message body because I like it better
 than mine. I did not change the subject because your suggestion
 sounded like the exact opposite of what this patch wants to achieve
 on first reading. Patch text is unchanged.

 compat/mingw.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 034fff9479..d2168c1e5e 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -395,7 +395,11 @@ HANDLE winansi_get_osfhandle(int fd);
 	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
 int mingw_skip_dos_drive_prefix(char **path);
 #define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
-#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
+static inline int mingw_is_dir_sep(int c)
+{
+	return c == '/' || c == '\\';
+}
+#define is_dir_sep mingw_is_dir_sep
 static inline char *mingw_find_last_dir_sep(const char *path)
 {
 	char *ret = NULL;
-- 
2.13.0.55.g17b7d13330

