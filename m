Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E902B1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeGPBx3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59028 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbeGPBx3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 85E2460779;
        Mon, 16 Jul 2018 01:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704512;
        bh=ztqasaOmoQDGH6jIPHFZ0M63zs0LMlOFPASYjnLT6NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Hi0bq86SZqApY5Q/0xgqPHD4Zjiyvb7xQM8bgzhl3/YqyYnfCuo9B6SyJyVYqzM+1
         7Qu009Wz0nfwGf025hV2owrOVFua4p14sNgORdpS5Rv8PbmPZy+VrMmUaHF20nVbGp
         Nw4DlACK5DbwaLcdDQRGIH6fHpHGwnQkqtGTTbtwzQgImzlzBfcK4Djg9qfquad6lC
         CgwZZSnYFdBSvZrOlIiQc0GI6BuWGCqnzdShpHSqD+VXf+J3yboSSoNPA/Yy4sfXLO
         FI+rXnFRctiZMtvV5MKf37JLGRbSCvxgdqhGV4+KIKrpn6Jg0F7scK/RWz7x5f5II0
         evQCwX7JjnNcmPpMTrDUEv6Z8z2cJrgctnNMibfNZCW7CVjh3mm35G4QecU5Hg7w0w
         5CBgo+DSmzrT8LThlQwxB1TuEcLkfzakX+EOlwdMEpugbdv6oUhaOcrXF2VVwP1lHZ
         Gar3yTC1sgcyH41KW+5CvKuiblwyZp11pT6VxSAkZxFlCKZ27ny
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 12/16] builtin/merge-recursive: make hash independent
Date:   Mon, 16 Jul 2018 01:28:04 +0000
Message-Id: <20180716012808.961328-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use GIT_MAX_HEXSZ instead of GIT_SHA1_HEXSZ for an allocation so that it
is sufficiently large.  Switch a comparison to use the_hash_algo to
determine the length of a hex object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 0dd9021958..9b2f707c29 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -9,10 +9,10 @@ static const char builtin_merge_recursive_usage[] =
 
 static const char *better_branch_name(const char *branch)
 {
-	static char githead_env[8 + GIT_SHA1_HEXSZ + 1];
+	static char githead_env[8 + GIT_MAX_HEXSZ + 1];
 	char *name;
 
-	if (strlen(branch) != GIT_SHA1_HEXSZ)
+	if (strlen(branch) != the_hash_algo->hexsz)
 		return branch;
 	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
 	name = getenv(githead_env);
