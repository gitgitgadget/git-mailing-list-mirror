Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE83C33CAF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B853320678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kWzO40xB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgAMMkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:52 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728738AbgAMMkp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:45 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3C40860807;
        Mon, 13 Jan 2020 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919243;
        bh=v2ra5Eax7vyEoIVpdVzxoQPYGq+Dzugdnx/nwcCR7xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kWzO40xBIqnaH2GxJrt8XVQ+rrt12ojALyya1RlAreEk2cYAzjhCGcsJ+ddCGfHO4
         BlVvQkYYJzD1eL9qcMCxff+NMKhnPiS3o5vvq6tPQEM3HGAqA96Q790+A2DbnjFTc0
         epZo5ylir9TWqtEZ9i2tARw2Q2rjxwA3Tv7ZcfdPweX97AKiaj1MQD2XzTsevG1SJx
         BQfcUlRj/r5k3PEvc/e30kANEM04ewHvAHTTUCtAIynCX57Sc9xV80EgafZwdZRPDV
         8Bs1qBDd3EiOpawXxSPzHDkIawJmYY5AElKudhu7pWI+p3aL5urmQdCZrmDMX+FGDU
         VRii+fEUB0/c5++b2eFfXkla6YAdrrVlgQzwcNSGrhAzukIalazdCw8z2zWwBkmYFs
         earudX1lW7vj1MshbUJGAnBfRueM3sb2+QWiT03KBjoMFbihJmbRnCdXFtHIl1VNNX
         z4jxXjwm49qXMxwQCR6hI1cO9Hlag+0/IxUD8/8wSlynPkc1JFI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 22/24] t6000: abstract away SHA-1-specific constants
Date:   Mon, 13 Jan 2020 12:38:55 +0000
Message-Id: <20200113123857.3684632-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6000-rev-list-misc.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index b8cf82349b..a0baf9ee43 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -104,13 +104,16 @@ test_expect_success 'rev-list can show index objects' '
 	#   - we do not show the root tree; since we updated the index, it
 	#     does not have a valid cache tree
 	#
-	cat >expect <<-\EOF &&
-	8e4020bb5a8d8c873b25de15933e75cc0fc275df one
-	d9d3a7417b9605cfd88ee6306b28dadc29e6ab08 only-in-index
-	9200b628cf9dc883a85a7abc8d6e6730baee589c two
-	EOF
 	echo only-in-index >only-in-index &&
 	test_when_finished "git reset --hard" &&
+	rev1=$(git rev-parse HEAD:one) &&
+	rev2=$(git rev-parse HEAD:two) &&
+	revi=$(git hash-object only-in-index) &&
+	cat >expect <<-EOF &&
+	$rev1 one
+	$revi only-in-index
+	$rev2 two
+	EOF
 	git add only-in-index &&
 	git rev-list --objects --indexed-objects >actual &&
 	test_cmp expect actual
