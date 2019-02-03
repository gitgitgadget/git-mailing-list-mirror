Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9771F453
	for <e@80x24.org>; Sun,  3 Feb 2019 16:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfBCQv6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 11:51:58 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:18847 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbfBCQv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 11:51:58 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43sxhC5KFXz5tlB;
        Sun,  3 Feb 2019 17:51:55 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B3EB04182;
        Sun,  3 Feb 2019 17:51:54 +0100 (CET)
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
Message-ID: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org>
Date:   Sun, 3 Feb 2019 17:51:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_vinsertf inserts a formatted string in the middle of an existing
strbuf value. It makes room in the strbuf by moving existing string to
the back, then formats the string to insert directly into the hole.

It uses vsnprintf to format the string. The buffer size provided in the
invocation is the number of characters available in the allocated space
behind the final string. This does not make any sense at all.

Fix it to pass the length of the inserted string plus one for the NUL.
(The functions saves and restores the character that the NUL occupies.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I found this, because in my environment I have to compile with
 SNPRINTF_RETURNS_BOGUS. Our implementation of vsnprintf in
 compat/snprintf.c writes into the end of the buffer unconditionally,
 at a spot that is unrelated to the formatted string, and this leads to
 "BUG: a NUL byte in commit log message not allowed" in some "stash"
 tests.

 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index bfbbdadbf3..87ecf7f975 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -270,7 +270,7 @@ void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt, va_list ap)
 	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
 	/* vsnprintf() will append a NUL, overwriting one of our characters */
 	save = sb->buf[pos + len];
-	len2 = vsnprintf(sb->buf + pos, sb->alloc - sb->len, fmt, ap);
+	len2 = vsnprintf(sb->buf + pos, len + 1, fmt, ap);
 	sb->buf[pos + len] = save;
 	if (len2 != len)
 		BUG("your vsnprintf is broken (returns inconsistent lengths)");
-- 
2.20.1.86.gb0de946387
