Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7AD1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfHRTVD (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:21:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57828 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbfHRTVB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 15:21:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BC07860745;
        Sun, 18 Aug 2019 19:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566156060;
        bh=FfLfvtTNME7iELnEARnT73jkhI72fgAEvL/e/thv4GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=iHQ60cIeK53JwFB/04zY7CKYFMHTdFoBJovJaRmpjgjwRC7U0BXPxkSCcy0LCjfG8
         BAw0PKPcToQftcMHeNNOUmmDYTwS3vFqvRMz+6960g5WHISxjtdI/f81wyDJrMTcX+
         Nc/+5k/JlIAr1Tw7hP1wdQLpLL35pr4Oty6cdv2x8wE6gQokXM0LyQL68gUdbe4eiC
         S5CvEi+SaDA0LIgJnOAMkISR3ML9UcX5undMzeZDOTdp8YUuYeiFWhUmvVDw+5WRel
         T5yMJTPmwk/fEPJs2cFFREaZj5xP2xKPcdhGAPeu35eJRHGSK9qKFsLJpzCcdl7gca
         zcs5q4ad1KQDZAgeltG/dwOU1nTDDrpW55rPcQaWwM43/kuh0kgoxbDcs3k/14sCS4
         Squm7EUaB5J/134exQRwHqt1ErqjafFyjAOFB2kdstorTj9soNGPhDwzSC/pSzjsma
         ssA/VcR+serAwwlLoAgQRVQSCjfc83A/M5OJq2bB1CNuJ9/Uogk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 09/14] t3600: make hash size independent
Date:   Sun, 18 Aug 2019 19:16:41 +0000
Message-Id: <20190818191646.868106-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818191646.868106-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a fixed length invalid object ID in the test,
compute one using the lookup tables.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3600-rm.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 66282a720e..8c8cca5bfb 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -240,12 +240,14 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
 '
 
 test_expect_success 'choking "git rm" should not let it die with cruft' '
+	test_oid_init &&
 	git reset -q --hard &&
 	test_when_finished "rm -f .git/index.lock && git reset -q --hard" &&
 	i=0 &&
+	hash=$(test_oid deadbeef) &&
 	while test $i -lt 12000
 	do
-		echo "100644 1234567890123456789012345678901234567890 0	some-file-$i"
+		echo "100644 $hash 0	some-file-$i"
 		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
 	git rm -n "some-file-*" | : &&
