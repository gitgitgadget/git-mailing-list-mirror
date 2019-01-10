Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547A91F803
	for <e@80x24.org>; Thu, 10 Jan 2019 04:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfAJE0I (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 23:26:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58358 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbfAJE0I (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Jan 2019 23:26:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9730360FE3;
        Thu, 10 Jan 2019 04:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547094365;
        bh=nNY1lWhS73F/ZXSilEKCdaFzRy1xpBdRfAJlx08KRcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FLL/FvaHUvVndR8j9CKmiORbYjajCdSUN/+bjZdRfrlUyO+P9OFwlFKpFWjXNrC2+
         Z+bjJiL0cSuRQeXrshYx+LsJVIXARqCaGl0iNbJhtdLhHCxhJ+h76/vaGnoxW1Uf4G
         0pvUN2WHmHDTEjQ1RIgU04ROaMqNd9vcZ945IysGCh6Cc/FmIwTBS+AwEeOKW5TYU7
         LcXsZgh0ZyuSQxJLEunjAuEvR6at4TNuujejoqQ7b+AibTI6Wn7nCedHbk9ZJXUphn
         knoF+P0aYVXh0i0sjRmTSGJVCTSP05Fe19NmVA38p29S6KAmgNjtRTNdzQqbMVua3R
         0KUBqkX0moYAjcgGv0kbBlorCmxGxIG9xcuNFQdcrH9S5/WjJkcWNomlwCeFaVZSin
         YUqBOfiDWgXpKaAVlW/JmxBcBkrcgKYoV7vD+WIV4FuBn361e9twxV9QeVXUUxEUsn
         wCPLpcjv61K0+gprx0fPwZB35vcGg+1B4qLcMGOFQuCixoHNDKE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] tree-walk: copy object ID before use
Date:   Thu, 10 Jan 2019 04:25:47 +0000
Message-Id: <20190110042551.915769-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3
In-Reply-To: <20190110042551.915769-1-sandals@crustytoothpaste.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, the pointer returned by tree_entry_extract will
point into the struct tree_desc, causing its lifetime to be bound to
that of the struct tree_desc itself.  To ensure this code path keeps
working, copy the object_id into a local variable so that it lives long
enough.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 tree-walk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 79bafbd1a2..1e040fc20e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -498,10 +498,10 @@ static int find_tree_entry(struct tree_desc *t, const char *name, struct object_
 	int namelen = strlen(name);
 	while (t->size) {
 		const char *entry;
-		const struct object_id *oid;
+		struct object_id oid;
 		int entrylen, cmp;
 
-		oid = tree_entry_extract(t, &entry, mode);
+		oidcpy(&oid, tree_entry_extract(t, &entry, mode));
 		entrylen = tree_entry_len(&t->entry);
 		update_tree_entry(t);
 		if (entrylen > namelen)
@@ -512,7 +512,7 @@ static int find_tree_entry(struct tree_desc *t, const char *name, struct object_
 		if (cmp < 0)
 			break;
 		if (entrylen == namelen) {
-			oidcpy(result, oid);
+			oidcpy(result, &oid);
 			return 0;
 		}
 		if (name[entrylen] != '/')
@@ -520,10 +520,10 @@ static int find_tree_entry(struct tree_desc *t, const char *name, struct object_
 		if (!S_ISDIR(*mode))
 			break;
 		if (++entrylen == namelen) {
-			oidcpy(result, oid);
+			oidcpy(result, &oid);
 			return 0;
 		}
-		return get_tree_entry(oid, name + entrylen, result, mode);
+		return get_tree_entry(&oid, name + entrylen, result, mode);
 	}
 	return -1;
 }
