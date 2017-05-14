Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D118220188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758807AbdENDQb (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:31 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33476 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758654AbdENDQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:19 -0400
Received: by mail-oi0-f68.google.com with SMTP id h4so14344162oib.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BgK+DuS/tQLcmicnTbG0QJ6D+ZsoCG5b76UivDFlFEE=;
        b=n6xl4doe7zhgxg369JUWnZZ4VcoOLD1MnD6mSpErscuNCWuVeQsdLIgPogoaId5YHU
         kUDmZoO+Ydp9OWTH1PyS7xCKPt2PedqPGy5U14M0HKdOrXW2ki9/78eiCHEdVglvZtS3
         /3vKjWx9YZ//OnTQYGVjTMddOd6GpcGUroBATplApEymQiINvFol1RGBqvUw4hq/nCWT
         2rVACTOz27UcWwaOMrAdvNd73Ez2DvnNpQypFDoxCs9pSC52EGKGs5wC4xYOhFcaVSJ4
         sGAFQvuB1tm954QN7gD4BDGL/+To5HxeZYaqWEzqUiEr35ejpjDWkkRUP7wLrsWDMCPj
         VnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BgK+DuS/tQLcmicnTbG0QJ6D+ZsoCG5b76UivDFlFEE=;
        b=KO6abII5HvDXzUeag/qYV309zV44obHKvXVzCbPbMvvKXX37YoXLX03eK6pv/ke0Cj
         pkRsjO0e0NBLAX1Tr5A6+LX+x87BIPBjBaJHqcbRXRqfkfj/cJ1zf2ytnytA1GwuSKjb
         ivu22NF7gjzg9lLHpFwCBY+kQvV8r3Q9DeJy6tWdsdn9d+1NPsYqH12XLMFS0W9VIwJq
         I81pI8uUrrUiYsTUuyZ/ynKWmAN5b5UiudDzKw3PAiSbcRHdA6iwuFgB5R+juvNnTH4p
         tcywbwC75y4wOaBqHAUmKSQaGk0207DdMvIftCbH6EmOs/l4hp9hlZr5ynaPylDSQxvw
         EcGA==
X-Gm-Message-State: AODbwcAq1kxreW5rR3AlDLCL3yb5lHUaXMVFGFSq5JDiZQSGbtNcYWW7
        IVNxX7ZRShxSHA==
X-Received: by 10.202.46.81 with SMTP id u78mr5553498oiu.166.1494731779181;
        Sat, 13 May 2017 20:16:19 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:18 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 10/22] blame: move show_root flag to scoreboard
Date:   Sat, 13 May 2017 22:15:01 -0500
Message-Id: <20170514031513.9042-11-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The show_root flag is used in parts of blame that are being moved to
libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         | 1 +
 builtin/blame.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/blame.h b/blame.h
index 85703dd..7691256 100644
--- a/blame.h
+++ b/blame.h
@@ -131,6 +131,7 @@ struct blame_scoreboard {
 
 	/* flags */
 	int reverse;
+	int show_root;
 };
 
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index ed50eda..77fb71f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1660,7 +1660,7 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 				mark_parents_uninteresting(commit);
 		}
 		/* treat root commit as boundary */
-		if (!commit->parents && !show_root)
+		if (!commit->parents && !sb->show_root)
 			commit->object.flags |= UNINTERESTING;
 
 		/* Take responsibility for the remaining entries */
@@ -2761,6 +2761,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (blame_copy_score)
 		sb.copy_score = blame_copy_score;
 
+	sb.show_root = show_root;
+
 	read_mailmap(&mailmap, NULL);
 
 	assign_blame(&sb, opt);
-- 
2.9.3

