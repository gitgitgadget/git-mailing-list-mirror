Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A9F1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfHRTUw (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:20:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57782 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbfHRTUw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 15:20:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1C39060748;
        Sun, 18 Aug 2019 19:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566156050;
        bh=sqDqmzcAnVDIFDb/zQUwfajaGniHUQyxH1FfBFGE/oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=d1YY6YkiJPB3gHha/fq+VmyE6f4lEc4GH0pCqzH9mZgln1xMuamwmBpe7upAcIE3T
         BHITq13P9A/kIIMVv+zn32kJn46Z3AHkfZgW5dysDaoehDXIGKbsdnlTAOqGM9v0jj
         3YDTsDLdoo04uJwyawmkQPLpHmset40bxs+fpW7cDPBlitzyIKuE1QWSp7uqbXAioO
         GJl2O+wC9eIAbabyuu0D3ODnfZYoRJmUQeJFsJkFlNaxjjGClCYhbuvJ8X3swXRpIq
         2zNcsKBUAv++BZ5z54X/3R6ZXPCmCBgXo9oNNFOSpa4kxxLWWurg8LbTsH8J5ScJNh
         G7cPIm+PmfS6NMtkoK8Ry/KymxqAJ7/2jIWiX/yq/yTahx6rp8f+3hHa76r96QoDVF
         65h9W7nySfzQBUWhinMDpogIcSDdZLJFed6mNjBYfU9klHheaKCVWp5BNxEYHXX9cT
         E2tAnB7F8sVuekCYeArfa/7ZhsrRCo/l0P7M1VhSnMmH8QSbD+q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 04/14] t3305: make hash size independent
Date:   Sun, 18 Aug 2019 19:16:36 +0000
Message-Id: <20190818191646.868106-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818191646.868106-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
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
 
