Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400E51FBB0
	for <e@80x24.org>; Sat,  3 Dec 2016 10:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbcLCKfo (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 05:35:44 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:35310 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbcLCKfn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 05:35:43 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 2E495C3472;
        Sat,  3 Dec 2016 11:35:38 +0100 (CET)
Received: from drbeat.li (215-243-153-5.dyn.cable.fcom.ch [5.153.243.215])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 0F166C346D;
        Sat,  3 Dec 2016 11:35:38 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id BB7F6201A2; Sat,  3 Dec 2016 11:35:37 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 3/3] unicode_width.h: fix the double_width[] table
Date:   Sat,  3 Dec 2016 11:35:20 +0100
Message-Id: <1480761320-27967-1-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1480713995-16157-1-git-send-email-dev+git@drbeat.li>
References: <1480713995-16157-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function bisearch() in utf8.c does a pure binary search in
double_width. It does not care about the 17 plane offsets which
unicode/uniset/uniset prepends. Leaving the plane offsets in the table
may cause wrong results.

Filter out the plane offsets in the update-unicode.sh and regenerate
the table.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 unicode_width.h   | 17 -----------------
 update_unicode.sh |  2 +-
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/unicode_width.h b/unicode_width.h
index 73b5fd6..02207be 100644
--- a/unicode_width.h
+++ b/unicode_width.h
@@ -297,23 +297,6 @@ static const struct interval zero_width[] = {
 { 0xE0100, 0xE01EF }
 };
 static const struct interval double_width[] = {
-{ /* plane */ 0x0, 0x3D },
-{ /* plane */ 0x3D, 0x68 },
-{ /* plane */ 0x68, 0x69 },
-{ /* plane */ 0x69, 0x6A },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
-{ /* plane */ 0x0, 0x0 },
 { 0x1100, 0x115F },
 { 0x231A, 0x231B },
 { 0x2329, 0x232A },
diff --git a/update_unicode.sh b/update_unicode.sh
index 3c84270..4c1ec8d 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -30,7 +30,7 @@ fi &&
 		  grep -v plane)
 	};
 	static const struct interval double_width[] = {
-		$(uniset/uniset --32 eaw:F,W)
+		$(uniset/uniset --32 eaw:F,W | grep -v plane)
 	};
 	EOF
 )
-- 
2.7.2
