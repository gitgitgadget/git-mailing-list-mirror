Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975FC1F462
	for <e@80x24.org>; Sun, 16 Jun 2019 18:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfFPSyG (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 14:54:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60236 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727428AbfFPSyE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Jun 2019 14:54:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:159e:486:c87b:cfd7])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6D3A360100;
        Sun, 16 Jun 2019 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560711242;
        bh=xjTSe1NU0gagAs6yAUNobAN1oT6R968FF3aG7B68HmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Wnkxrc/rHmde3qtqrvTZkRhBnvdM2vrGKSX7cYO9sNwEqw4+MQFn0lBCHWFThZlj+
         J5QFt6mmzaUJIVEDbnbxqlzRXNtzZluagq2ZhzOyxUXlOt9pQIKOOzP8dSXm8ZQSEi
         cddXQQ5l7Sa84Joa4pe64Df2qL5oo4peL96J1MTy/HrABzFVn7X8q/mZaD+5neAEjb
         2IfEqast0CJ4GNnVM73PayD4+/k8enBY4y+NE4udc7mckn5KB4kIw9LiWMH/Zdw0Ah
         TA2vCty6ubDELyO8/VRN6pBuPmz5tIw9UARrE3PjgVyuN6xFV6ivS6A59qhrET0jW+
         Lx49yEK66n2wcQtAGJNjWr5E9T247YpTXJR01u35UpmDxDshH2VK8B0/eW0OVQpWvV
         E9XHUL74rqU55uFBwhWBcsPHim8HmvdXV1SX85m4EFTWREx97b+JeXnqKFCjHz5yke
         PW/xaiRjUXWbTSegb1RI/VbB8z/l0kJhWfBmBmHp5HRMJgTQX9s
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/10] t2203: avoid hard-coded object ID values
Date:   Sun, 16 Jun 2019 18:53:30 +0000
Message-Id: <20190616185330.549436-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5
In-Reply-To: <20190616185330.549436-1-sandals@crustytoothpaste.net>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make this test work with multiple hash algorithms, compute
the object ID used in this test instead of hard-coding it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t2203-add-intent.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 68e54d5c44..5bbe8dcce4 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -247,12 +247,14 @@ test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
 test_expect_success '"diff HEAD" includes ita as new files' '
 	git reset --hard &&
 	echo new >new-ita &&
+	oid=$(git hash-object new-ita) &&
+	oid=$(git rev-parse --short $oid) &&
 	git add -N new-ita &&
 	git diff HEAD >actual &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	diff --git a/new-ita b/new-ita
 	new file mode 100644
-	index 0000000..3e75765
+	index 0000000..$oid
 	--- /dev/null
 	+++ b/new-ita
 	@@ -0,0 +1 @@
