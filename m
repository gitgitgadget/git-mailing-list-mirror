Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F2F201A8
	for <e@80x24.org>; Mon, 20 Feb 2017 00:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbdBTAKv (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 19:10:51 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36340 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751833AbdBTAKs (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Feb 2017 19:10:48 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A1891280BC;
        Mon, 20 Feb 2017 00:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487549447;
        bh=jHQnwaMgK8Agc+/uxk+DuietfSN4QsJpBqKdzfZGUu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnc5KFhWspGqpuQMyObOGH602mD5zICOyc19Hcrrs2ruecDa06HPbG80k2LRnnu5t
         fpEFF6jWnc9BNpz6BRDvWpFFXWx+15xr4mI6Xlba1sG1QzoqEfmhvmtNING/iJKu4j
         SalZ17tWGPfz5Z/M5nlNOz+tVrUI6klHbdpv8N4/SnLssakNvhuPLV4LL6a2jtWV/h
         fguBtJzssCkK8EeMbT/Lx1RmjcuHq7zqzlayZeA9TmilnQXJRKQzZkEhC6S241mIW+
         Hr7tQDR8pGzfhOPVhNePZ9s6N5UikuXZhiE6HFypOB3G7ccBjNbHvW93iWfar1povQ
         +w4jGM6jtInQZ1Exyp1iNARZQXHC/xEzUKgtGKXYAM+JPZZdW+6H/fljWSWG1AhGEq
         Y54G2feOsPwYzgyhKnyqGLgDuGi8/TtgblDbvJHhhB1FMiLolU0Os8H3BvOEeSqd+c
         pY1wNG9mEYseCE8keBQiCU4V3rm+hBb4p9MUkWfxJTNbmyB3fkR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 15/19] refs: simplify parsing of reflog entries
Date:   Mon, 20 Feb 2017 00:10:27 +0000
Message-Id: <20170220001031.559931-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170220001031.559931-1-sandals@crustytoothpaste.net>
References: <20170220001031.559931-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current code for reflog entries uses a lot of hard-coded constants,
making it hard to read and modify.  Use parse_oid_hex and two temporary
variables to simplify the code and reduce the use of magic constants.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs/files-backend.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d7a5fd2a7c..fea20e99fe 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3117,12 +3117,13 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	char *email_end, *message;
 	unsigned long timestamp;
 	int tz;
+	const char *p = sb->buf;
 
 	/* old SP new SP name <email> SP time TAB msg LF */
-	if (sb->len < 83 || sb->buf[sb->len - 1] != '\n' ||
-	    get_oid_hex(sb->buf, &ooid) || sb->buf[40] != ' ' ||
-	    get_oid_hex(sb->buf + 41, &noid) || sb->buf[81] != ' ' ||
-	    !(email_end = strchr(sb->buf + 82, '>')) ||
+	if (!sb->len || sb->buf[sb->len - 1] != '\n' ||
+	    parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
+	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
+	    !(email_end = strchr(p, '>')) ||
 	    email_end[1] != ' ' ||
 	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
 	    !message || message[0] != ' ' ||
@@ -3136,7 +3137,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 		message += 6;
 	else
 		message += 7;
-	return fn(&ooid, &noid, sb->buf + 82, timestamp, tz, message, cb_data);
+	return fn(&ooid, &noid, p, timestamp, tz, message, cb_data);
 }
 
 static char *find_beginning_of_line(char *bob, char *scan)
-- 
2.11.0

