Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84F7201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 00:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdBRAHP (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 19:07:15 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:60152 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751435AbdBRAHF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 19:07:05 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 793F4280AE;
        Sat, 18 Feb 2017 00:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487376422;
        bh=jHQnwaMgK8Agc+/uxk+DuietfSN4QsJpBqKdzfZGUu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCzDj+DYHzv22Orl2pegfNpkxZya7Dj21Kf7ySDsJBZmE7wPkHJlCtCKOuILd+y9H
         zuahbf3JXHdqmWd/SMCAa1oboLRsesi46pD1mvwzCzc8aEdGO8NUb8X+5RFEa2500o
         I7neIokZ4TKwBwGg4E+NJlyrURoyGWp3vaKxyHoAGz+7luu33r0sMgm4eZS+E221a7
         RWHAx9I+nDOCoHOUaw1mixJgb4cxgC5Br655K9tR7ttUWienSrJgWbY9tDJfmxBQU5
         4CSIJmQLc3NT9AO6Fy4jNe98sNXqC8OGchiFONlT5Cia8YFH2voo9fv8MCEEF5Fx/O
         wb0/w2sJow2N1sUU59WnZGQeOLeoSeTv3Njj0uTBTyJ0cAmjkMRynPIV61WYS75LBl
         wosvKeikprYhvvV2uzh3D9koUVGoe5gcRmt2sjTWMsJrHv4rNSyJfIPIe4RKTw1Kny
         PQefl2pYUC3/sDNCmEMIAds5YWUyMW/PzkEzD7gYReHr6zX0qh1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/19] refs: simplify parsing of reflog entries
Date:   Sat, 18 Feb 2017 00:06:48 +0000
Message-Id: <20170218000652.375129-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170218000652.375129-1-sandals@crustytoothpaste.net>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
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

