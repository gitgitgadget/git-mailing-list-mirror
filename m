Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C981F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfBLBXc (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:32 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727137AbfBLBXb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:31 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4FE3C60E54;
        Tue, 12 Feb 2019 01:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934609;
        bh=6/MpCrAvByESSVRztzgd2v91iFyfOXnmCzNrwVKOTDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=prEqiEAPb03q9XNrv+c4zB4tM3ib4HwdUh/dxA37/hxfACAMIbJYLxXGSs9WPrRi4
         bxRC9K4QoWceyLn3n9VIWSoNDyqWwVfWphj1ooTtiuKjzXCi/Neaa6K2+/n1JXjprt
         5hPb8avjmxQCy6wXI9ZHfs/Gpr2cl3H58KHDDgrX/RiufEa+SC28Euo6yjOHSgFrQH
         u462nLys1O5y7qjths+xtuV3ISTgTfeTCrJ6ySRS2p73CCGuGdrPRQYcrvdAU/A9vI
         OiG6KhjikuaKKpsgoJIz13AN4WwzNXFe4Q3t94xt2PUDNYANoWkUjUG5v5EF3SU5t2
         rn5+SIcbikdr+StC2epeQfkJUecqBoKQDwR9y4GryLIDl6F7szVvPD0ZxSLSlivyw8
         99r/KAgYr2oi8Xc4lw6lFvQIkaNiV+6qS3ZtLkhMQ2y0Hjn/foqqwm3T6KE3mcKCHc
         wJCQYuNwEOuaZ7ivsJNn+4vowWeGyjkTOOK37sCrRVFZZ25McO2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 15/31] builtin/pull: make hash-size independent
Date:   Tue, 12 Feb 2019 01:22:40 +0000
Message-Id: <20190212012256.1005924-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using get_oid_hex and GIT_SHA1_HEXSZ, use parse_oid_hex to
avoid the need for a constant and simplify the code.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pull.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 701d1473dc..52d93c1e3b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -365,9 +365,10 @@ static void get_merge_heads(struct oid_array *merge_heads)
 
 	fp = xfopen(filename, "r");
 	while (strbuf_getline_lf(&sb, fp) != EOF) {
-		if (get_oid_hex(sb.buf, &oid))
+		const char *p;
+		if (parse_oid_hex(sb.buf, &oid, &p))
 			continue;  /* invalid line: does not start with SHA1 */
-		if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge\t"))
+		if (starts_with(p, "\tnot-for-merge\t"))
 			continue;  /* ref is not-for-merge */
 		oid_array_append(merge_heads, &oid);
 	}
