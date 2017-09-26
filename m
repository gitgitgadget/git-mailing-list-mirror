Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2301E202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 03:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964871AbdIZDbj (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 23:31:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35873 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbdIZDbi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 23:31:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id d8so5993267pgt.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 20:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GRoVtzTz3ldVP0UZQecmZP0iOinuCXttxuU2fkEHSHA=;
        b=brRvY4/+thGvd1LzbEczpF8/92TfoJiKGFFRGDWjXoIGB15SPOfZKps7Ab9VyKbAlt
         QuXhEWpKI3m5QAKU03Fdt6uEBHzEu+LZ2/zcbNwGl6bsvwjpIPvzS531Cdg6eyMn4yVa
         RE0TgZovx8W3xblSBf19RhqhgQtT12fF2Cvms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GRoVtzTz3ldVP0UZQecmZP0iOinuCXttxuU2fkEHSHA=;
        b=uJOsmTYkgbkCbnKplzWAzdL5lxBxCC/LSvbSnn0z4jM+ss/PQtLBVrqPlo34s4xQ2v
         DJJWSAWPmbPxp6tt9A1TYou71iMhRUG7wH2K35WjIiN0u//q1SvvGjaJR8uaab6TxF0K
         cOoS590woAnJagaj6g+NeHMFni0Rxv/uZiQH3EaVG0SOASgDMsvU7KMznsPyXew5R6cd
         wq6w7rvB43PstSfh7KcUQ77EOsMJhNKsiw48g8x6DU8N/7SKER51hHBUz96I7prfqPGq
         xBMDQWsqIbEaMFyLBTNdK/vys6svnQzoiiQsMBOkM3AiLD74eeoDRQNWVlSaro0rUDzu
         vE4g==
X-Gm-Message-State: AHPjjUg9sj45gRIiw/xIHrivEm7FHt3PtJdRmrl/a7TRxP36FQXpoHbF
        PqfbFd6zhe74yNP06Spjc+kFeugVOxg=
X-Google-Smtp-Source: AOwi7QCBoDavMX503YnFezd33mtOw3m4SzrVSsNUdFoVjkA7+3hNHKRrOhSp1CM95Afk6cLte2DSNg==
X-Received: by 10.99.124.87 with SMTP id l23mr1272490pgn.351.1506396697457;
        Mon, 25 Sep 2017 20:31:37 -0700 (PDT)
Received: from localhost (node-1w7jr9qppj83lps4xk3hyfn0o.ipv6.telus.net. [2001:569:78d7:e800:bae8:56ff:fe42:9848])
        by smtp.gmail.com with ESMTPSA id u20sm12521320pfh.171.2017.09.25.20.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Sep 2017 20:31:36 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Mon, 25 Sep 2017 20:31:35 -0700
From:   "Eric Rannaud" <e@nanocritical.com>
To:     git@vger.kernel.org
Cc:     jeremy.serror@gmail.com, "Shawn O . Pearce" <spearce@spearce.org>,
        Eric Rannaud <e@nanocritical.com>
Subject: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
Date:   Mon, 25 Sep 2017 20:30:52 -0700
Message-Id: <598f0addb8b1a5dd535b5bea5f2685ab4c3eb2b0.1506396652.git.e@nanocritical.com>
X-Mailer: git-send-email 2.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The checkpoint command cycles packfiles if object_count != 0, a sensible
test or there would be no pack files to write. Since 820b931012, the
command also dumps branches, tags and marks, but still conditionally.
However, it is possible for a command stream to modify refs or create
marks without creating any new objects.

For example, reset a branch:

	$ git fast-import
	reset refs/heads/master
	from refs/heads/master^

	checkpoint

but refs/heads/master remains unchanged.

Other example: a commit command that re-creates an object that already
exists in the object database.

This fix unconditionally calls dump_{branches,tags,marks}() for all
checkpoint commands. dump_branches() and dump_tags() are cheap to call
in the case of a no-op.

Signed-off-by: Eric Rannaud <e@nanocritical.com>
---
 fast-import.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 35bf671f12c4..d5e4cf0bad41 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3189,10 +3189,10 @@ static void checkpoint(void)
 	checkpoint_requested = 0;
 	if (object_count) {
 		cycle_packfile();
-		dump_branches();
-		dump_tags();
-		dump_marks();
 	}
+	dump_branches();
+	dump_tags();
+	dump_marks();
 }
 
 static void parse_checkpoint(void)
-- 
2.14.1

