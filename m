Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04F61FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 02:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbdBNCce (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 21:32:34 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:50648 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751355AbdBNCcQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Feb 2017 21:32:16 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 146D1280BC;
        Tue, 14 Feb 2017 02:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487039519;
        bh=9vLbLUkQlnFp3jHgWk1F6YXAA0H0xFneDezWLIrJHZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fS9qpDmgvikIjiaLRlQQpFimKx5XujkY/kYpraV2xPGi/GemHqB2IpWeeXnjEsRwn
         A/pWOcWSBWw+7S2KhRQrK/aVppMEzjM6PIeQYgd8xnXS+ChhDH0nhiaMZp5PhG4P9D
         JySmLkkrlnY/3o0y78QKfeSZZ4Z3WNTcEHflNtm9wLTG5lVlNWo/SwhAvW7U5ai/QL
         yNrh3imY5v5ZG8yX7imXZJYHGBnMGQkXDc9FQ0x96xJ8qBxl+ffmN28WoxM34lEWUe
         T0QQnslir57Akm/sZdfkvm6j914rzzkiSpMQrV6OtFetbpNLJoNwds5eUIcLbAxzCh
         3Ig/IERrsQNYn5tujMDnFHqd6b4Ko+ozjBDrul1OROBAXR29v+navt4eC+1tbpc4Fb
         2sSluKsBPBw4i298PtsukcTYhc9ELmHpPVMYNXueBX7OOG639x9Ym/FKE+7CYYX3ec
         CLEGWGmbLF+oqA0g+j/8zYymXts1wGXsQVlj7aB9T2rntefSmmY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/19] refs: simplify parsing of reflog entries
Date:   Tue, 14 Feb 2017 02:31:37 +0000
Message-Id: <20170214023141.842922-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170214023141.842922-1-sandals@crustytoothpaste.net>
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current code for reflog entries uses a lot of hard-coded constants,
making it hard to read and modify.  Use parse_oid_hex and two temporary
variables to simplify the code and reduce the use of magic constants.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs/files-backend.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d7a5fd2a7c..09227a3f63 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3117,12 +3117,14 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	char *email_end, *message;
 	unsigned long timestamp;
 	int tz;
+	const char *p = sb->buf;
+	const int minlen = 2 * GIT_SHA1_HEXSZ + 3;
 
 	/* old SP new SP name <email> SP time TAB msg LF */
-	if (sb->len < 83 || sb->buf[sb->len - 1] != '\n' ||
-	    get_oid_hex(sb->buf, &ooid) || sb->buf[40] != ' ' ||
-	    get_oid_hex(sb->buf + 41, &noid) || sb->buf[81] != ' ' ||
-	    !(email_end = strchr(sb->buf + 82, '>')) ||
+	if (sb->len < minlen || sb->buf[sb->len - 1] != '\n' ||
+	    parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
+	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
+	    !(email_end = strchr(p, '>')) ||
 	    email_end[1] != ' ' ||
 	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
 	    !message || message[0] != ' ' ||
@@ -3136,7 +3138,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 		message += 6;
 	else
 		message += 7;
-	return fn(&ooid, &noid, sb->buf + 82, timestamp, tz, message, cb_data);
+	return fn(&ooid, &noid, sb->buf + minlen - 1, timestamp, tz, message, cb_data);
 }
 
 static char *find_beginning_of_line(char *bob, char *scan)
-- 
2.11.0

