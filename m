Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD1B208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbdHJSrb (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:47:31 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37483 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbdHJSra (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:47:30 -0400
Received: by mail-pg0-f68.google.com with SMTP id 83so1256094pgb.4
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/kaNRrC9W5ro2ZqoxjDMycX0qrpcwbhmNkiowVXAMkI=;
        b=MypOzbJKWO4IUIa9knKWNaZ764tcDiqtgF4jWwVQI34nzJlrToSiZxeTTYU1anYoPN
         Ap+7xevYRIsKXXvKWwUFZf5IT/ey3TNiBZ1VxSHCwjWrxAdRBSjQXrLmnKOEZigcf6+0
         wfmXqr+2cPfvC+JFUDPrsvH0xgZklSpd/fmNqYHjUxKtdPajPrA9no5IiGrbkbd5R3oF
         2iGn8DF6hrUk1PM/F2TxuwLQzbhmuaKfDoJbZ9KOPMcwZr1uJpiTd++BKa+hjfV4aQhQ
         pHcHn5T1lGnmsmEd+dAUz8U0TC1qfMz0k0nyHyUnfO0eKAe8Kk7+zJ9/8FllaPn+J3PF
         TFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/kaNRrC9W5ro2ZqoxjDMycX0qrpcwbhmNkiowVXAMkI=;
        b=ZMqkLgSxFyAeI8qgvtG0ObPkLjhYXptJGq4Hr1zb9TkIDf/LAQieZv2uxfETaUgTO5
         VwU3Qg+a2LLP4n1zXEMcuNQWTm4WmMBdrgs43vyNMYxCZ4qeRQWL93/ZCy/mpzKnz/GB
         6Sv1Vay90hLAdoqMCKBlz9slK0YJjOiBwKQk2ycw2OMkAFAwCAQRzVuy8OeUlswqWseP
         xtbr/QKCxZMK9NZCPS+YF2KDkTsj5H+mZxwtCboSbsswBRhxFD9ypAcUKrXv5/cfUH/f
         zVb4wPXZrWH+3JbrkUIMgt93TnThZRoUBoSe9prP963y+KEK4lUpA9u6YcKXTgD1jB/F
         ci0Q==
X-Gm-Message-State: AHYfb5g+xMh7E4adidDFk7nPEHhYyDbKDHRecIIt2mU13zDemXy7TBRc
        Lw0+bVof58qpaqHBV6s=
X-Received: by 10.84.254.71 with SMTP id a7mr14506211pln.69.1502390850013;
        Thu, 10 Aug 2017 11:47:30 -0700 (PDT)
Received: from kewillf-git01.redmond.corp.microsoft.com ([2001:4898:80e8::54f])
        by smtp.gmail.com with ESMTPSA id a86sm15178039pfe.181.2017.08.10.11.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Aug 2017 11:47:29 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, peartben@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH] cache-tree: remove use of strbuf_addf in update_one
Date:   Thu, 10 Aug 2017 14:47:23 -0400
Message-Id: <20170810184723.12424-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.0.rc0.286.g44127d70e4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

String formatting can be a performance issue when there are
hundreds of thousands of trees.

Change to stop using the strbuf_addf and just add the strings
or characters individually.

There are a limited number of modes so added a switch for the
known ones and a default case if something comes through that
are not a known one for git.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 cache-tree.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 2440d1dc89..41744b3db7 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -390,7 +390,29 @@ static int update_one(struct cache_tree *it,
 			continue;
 
 		strbuf_grow(&buffer, entlen + 100);
-		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
+
+		switch (mode) {
+		case 0100644:
+			strbuf_add(&buffer, "100644 ", 7);
+			break;
+		case 0100664:
+			strbuf_add(&buffer, "100664 ", 7);
+			break;
+		case 0100755:
+			strbuf_add(&buffer, "100755 ", 7);
+			break;
+		case 0120000:
+			strbuf_add(&buffer, "120000 ", 7);
+			break;
+		case 0160000:
+			strbuf_add(&buffer, "160000 ", 7);
+			break;
+		default:
+			strbuf_addf(&buffer, "%o ", mode);
+			break;
+		}
+		strbuf_add(&buffer, path + baselen, entlen);
+		strbuf_addch(&buffer, '\0');
 		strbuf_add(&buffer, sha1, 20);
 
 #if DEBUG
-- 
2.14.0.rc0.286.g44127d70e4

