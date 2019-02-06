Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A07B1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 23:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfBFX7r (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 18:59:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33774 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfBFX7q (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Feb 2019 18:59:46 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c489:9935:372d:73bb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DAFA860129;
        Wed,  6 Feb 2019 23:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549497585;
        bh=XXUoUUzP/dFBK9GB9kRP2+OvLmgw5zdWhKBkGXjU/6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=p03Q9TKVSK6teM67vE+50g3js/4XSA1HOAEDBCBgf9IkDRlycoCPnuaD0FCoK2i8f
         gEwdP8Vf/6KOxY/aSFPevM6+wy17+ENl2IvpqwsC1gzq8lk7ytPP457/bg/AB8Pqba
         RjYHC15Cif8gYAYiOE1jyUx+sPOOP2jKEoFz+xb6Y27uknJyJizWcB/W1vAvbc+cv4
         BYETN561A7WaU/Fra9G7FA1OCOzba7lYhvMKaD3K/UXQHhhC/tzbMBRprLwttL50T9
         Z4wIArr2cpcgfLkSsEOp2MiInSaLxW6FlL1an8xap/hV7f+Ok/owmScfkiawnPaMEV
         ssA8UNmwfcQSLpUniH/twrqcmHv/f+RtPqMmp+XQfvycJXrAJFTYW3DobVjYMpFjl/
         yut4l6YR+UFdnRnzoY/qYADJMwBtpKMrCo99qmJZx/0sI/7OIr5rCyn0WFgO7SCT0+
         O37CaIhqZl9l9bXTaFdfcac5LGDtHnkAS+K4jqMD30GQtFdzbWm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2] fetch-pack: clear alternate shallow when complete
Date:   Wed,  6 Feb 2019 23:59:37 +0000
Message-Id: <20190206235937.201663-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b
In-Reply-To: <20190204000650.686175-1-sandals@crustytoothpaste.net>
References: <20190204000650.686175-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we write an alternate shallow file in update_shallow, we write it
into the lock file. The string stored in alternate_shallow_file is
copied from the lock file path, but it is freed the moment that the lock
file is closed, since we call strbuf_release to free that path.

This used to work, since we did not invoke git index-pack more than
once. However, we now do, and starting with bd0b42aed3 (fetch-pack: do
not take shallow lock unnecessarily - 2019-01-10), we no longer reset
this value unconditionally; consequently, we reuse the freed memory.
Ensure we reset the value to NULL to avoid using freed memory. git
index-pack will read the repository's shallow file, which will have been
updated with the correct information.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 577faa6229..a92621a388 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1272,6 +1272,8 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
 		args->deepen = 1;
+	} else {
+		alternate_shallow_file = NULL;
 	}
 }
 
@@ -1489,6 +1491,7 @@ static void update_shallow(struct fetch_pack_args *args,
 			rollback_lock_file(&shallow_lock);
 		} else
 			commit_lock_file(&shallow_lock);
+		alternate_shallow_file = NULL;
 		return;
 	}
 
@@ -1512,6 +1515,7 @@ static void update_shallow(struct fetch_pack_args *args,
 						&alternate_shallow_file,
 						&extra);
 			commit_lock_file(&shallow_lock);
+			alternate_shallow_file = NULL;
 		}
 		oid_array_clear(&extra);
 		return;
@@ -1551,6 +1555,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		commit_lock_file(&shallow_lock);
 		oid_array_clear(&extra);
 		oid_array_clear(&ref);
+		alternate_shallow_file = NULL;
 		return;
 	}
 
