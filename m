Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3C41F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfHZBoH (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58284 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbfHZBoG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1707160748;
        Mon, 26 Aug 2019 01:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783845;
        bh=sqDqmzcAnVDIFDb/zQUwfajaGniHUQyxH1FfBFGE/oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ek/rp+JslF9P3HzbuWxrleCfQWq/Wt3TZ7B0Pd+wjxeTNgWxYaSGoCbedywEBHyGk
         MlqoGir+FoxLFAAFgD0afal6jfUj+rLxEfFR1taU6KGBpMTbDzqlSX5DVe7dXu1Ff9
         GY1ZPE73urbF0Qdz0OzhBvCwG7Bi12rTTw125EloHadAN1hBaTF+P+nZpA/emj9dLW
         /BOcW9p6HBW4J0ddLcC3v+tGVhEIhTeHVqIGCBJ4qmG4wE8rSjThFVroFdDSgIFvFP
         kyMdlDDskGD7/ejfqqRaJrivnTdbmURDjAGe5+BARJ8ITdXBvn4nZY2s74kSw45NR/
         LPu9tLrgip+DoM+8s9HBk23t8G9s1KFJ+ozMdZSWiw7brC8qshXAM9980Qfo9pyCp4
         mux/Vtm61NuRf8Ib4C2OOoy0+32G1pdBDgXH2GPN14ygNPy8Udc1TIvLnAY1VCIgus
         gcCG19bCqiZas2HUPr7lZ2oP3VTFyLrlRgdxAWs7bUaIT3nGnZ5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 04/14] t3305: make hash size independent
Date:   Mon, 26 Aug 2019 01:43:34 +0000
Message-Id: <20190826014344.16008-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding 40-character shell patterns, use grep to
determine if all of the paths have either zero or one levels of fanout,
as appropriate.

Note that the final test is implicitly dependent on the hash algorithm.
Depending on the algorithm in use, the fanout may or may not completely
compress.  In its current state, this is not a problem, but it could be
if the hash algorithm changes again.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3305-notes-fanout.sh | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 54460beec4..831f83d211 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -35,15 +35,10 @@ test_expect_success 'many notes created with git-notes triggers fanout' '
 	git ls-tree -r --name-only refs/notes/commits |
 	while read path
 	do
-		case "$path" in
-		??/??????????????????????????????????????)
-			: true
-			;;
-		*)
+		echo $path | grep "^../[0-9a-f]*$" || {
 			echo "Invalid path \"$path\"" &&
-			return 1
-			;;
-		esac
+			return 1;
+		}
 	done
 '
 
@@ -77,15 +72,10 @@ test_expect_success 'deleting most notes triggers fanout consolidation' '
 	git ls-tree -r --name-only refs/notes/commits |
 	while read path
 	do
-		case "$path" in
-		????????????????????????????????????????)
-			: true
-			;;
-		*)
+		echo $path | grep -v "^../.*" || {
 			echo "Invalid path \"$path\"" &&
-			return 1
-			;;
-		esac
+			return 1;
+		}
 	done
 '
 
