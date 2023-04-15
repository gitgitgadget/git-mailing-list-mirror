Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBB4C77B71
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 11:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjDOLGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 07:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjDOLGj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 07:06:39 -0400
Received: from mailproxy03.manitu.net (mailproxy03.manitu.net [217.11.48.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6AB3582
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 04:06:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a4d:e900:272c:4c3e:5f23:14d9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id 592A812A01BF;
        Sat, 15 Apr 2023 13:06:33 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH/RFD] fix connection via git protocol
Date:   Sat, 15 Apr 2023 13:06:32 +0200
Message-ID: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
X-Mailer: git-send-email 2.40.0.403.g8e07f5f217
In-Reply-To: <20230411074204.3024420-2-newren@gmail.com>
References: <20230411074204.3024420-2-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

5579f44d2f ("treewide: remove unnecessary cache.h inclusion", 2023-04-11)
broke connections via git protocol because it removed the inclusion of
the default port macro. While some may consider this transport to be
deprecated, it still serves some purpose.

connect.c (no more chache.h) and daemon.c (which still includes cache.h)
are the only users of the macro. Hot fix the issue by copying the
definition to connect.c.

A real fix will identify a proper common header file (I couldn't) or
create a new one.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 connect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/connect.c b/connect.c
index 5d8036197d..64f89e33cf 100644
--- a/connect.c
+++ b/connect.c
@@ -20,6 +20,8 @@
 #include "alias.h"
 #include "bundle-uri.h"
 
+#define DEFAULT_GIT_PORT 9418
+
 static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
 static const char *next_server_feature_value(const char *feature, int *len, int *offset);
-- 
2.40.0.403.g8e07f5f217

