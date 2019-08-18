Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3181F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfHRUFl (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57968 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727199AbfHRUFi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3BEFB6075B;
        Sun, 18 Aug 2019 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158737;
        bh=6F5x8SuAlKA42m1Akf2Iqxsl2men4kZfjmMEVU/UwgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=dVgTTrlwlsGZkRPoagf4aUrsVJI7zQuSFkDa7IefmANcND/KTIPxNwFAzlWAzqFRh
         OL1Fg493sFWGpn6VNmaiGgYwA0xGizSUPV3YjC5u9Zzr0rxGpSATaM5+vltGxGeDtt
         BfZRkAxNxPnIDUauqZnKu5wXdfZnzbduEtNDx0TnVBkQEx4QIQnqS2/npY5z8W4gXi
         GPO7PnVOqYwdsS9w536cpAyxApOlgu5L0626LJLyIRgs6COTymbnJr/uaaEc8IAeNZ
         XN40dLEFp3/omwxG/Vwsv2P3KF5VBWkoL2Ps9Y5/nwtfXsg2EhYO7N/+1CNSbrzyOC
         nqQs2KB6p17dH8XMCc9lKyTWgeoll5c2EkqT8VV4FB/d3bddOHJUT18P7TgaFXH81Z
         W5A+tmd2XXI+iV/DeyDUqJ13AscpCJthZIlI/HeJ0LSSXbPB21kmn4g0n0iWyR2gTn
         U42IRzmrWH2OTmsxZwANBg4eLlmFPK1Rs2RR6e1ANi8yrQeTiqf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 10/26] bundle: switch to use the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:11 +0000
Message-Id: <20190818200427.870753-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch a use of the constant 40 and a use of GIT_SHA1_HEXSZ to use
the_hash_algo instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bundle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index b5d21cd80f..a85ed3f7bc 100644
--- a/bundle.c
+++ b/bundle.c
@@ -282,7 +282,7 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs)
 		struct object *object = revs->pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
 			write_or_die(pack_objects.in, "^", 1);
-		write_or_die(pack_objects.in, oid_to_hex(&object->oid), GIT_SHA1_HEXSZ);
+		write_or_die(pack_objects.in, oid_to_hex(&object->oid), the_hash_algo->hexsz);
 		write_or_die(pack_objects.in, "\n", 1);
 	}
 	close(pack_objects.in);
@@ -414,7 +414,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		}
 
 		ref_count++;
-		write_or_die(bundle_fd, oid_to_hex(&e->item->oid), 40);
+		write_or_die(bundle_fd, oid_to_hex(&e->item->oid), the_hash_algo->hexsz);
 		write_or_die(bundle_fd, " ", 1);
 		write_or_die(bundle_fd, display_ref, strlen(display_ref));
 		write_or_die(bundle_fd, "\n", 1);
