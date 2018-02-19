Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C1E1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 22:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeBSW7s (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 17:59:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33314 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932253AbeBSW7l (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:41 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E80AF609DE;
        Mon, 19 Feb 2018 22:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081180;
        bh=+kq+WVQ60QMpAl2aeoeBV1AvO6KTfLPVEOaIs+V5fro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jXbJEON6Kre+/9KPYTpMHRHWiCPBOY+5GBeOidHL5+p34Swy3biKIBaQyaSSzcBAI
         cY+VOSA75EYe2CYE5SpmdGWsiXZBGsXTFl/YV6KMhIIyuBLToC2bsDKx3cv3vd/huj
         g833V18OGtyr/VAYy+nC0sDMX9qKRGKOZXPgQQ8zCQTlVOVb8FJw0jNoV3BSAsyfM/
         Fz0CCzGcpgio1/KqyAUbiJTOMuGJ5VZnxXI2p8U4ZkplapPfdCt6uata8CteJETM8S
         hEm2Eivmcm3OrD+t/DtJzzzcQbMW5SMlcReFbvJLvHbitg9c7LeMNAH4j6K9vpkTCM
         XiYJt8N58ojrjo4pRyqI45absGsAOPH3Oc3GmChZj0U641BB6krMmnn8zQ8aVbbRyh
         trMmZUqlBzY0wsNRAfiX81hC7hKMA9lEE+05WnUiUkZ4evKWa6iR8OpJXAxL9ZKVEz
         DMbUgHnrIbTGqZJvmO51pu3L09GNgrDm6x8PE9xLVSOrGmDDI+v
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 07/36] ref-filter: convert grab_objectname to struct object_id
Date:   Mon, 19 Feb 2018 22:58:58 +0000
Message-Id: <20180219225927.386065-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is necessary in order to convert find_unique_abbrev.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ref-filter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f9e25aea7a..9cbd92611c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -737,18 +737,18 @@ static void *get_obj(const struct object_id *oid, struct object **obj, unsigned
 	return buf;
 }
 
-static int grab_objectname(const char *name, const unsigned char *sha1,
+static int grab_objectname(const char *name, const struct object_id *oid,
 			   struct atom_value *v, struct used_atom *atom)
 {
 	if (starts_with(name, "objectname")) {
 		if (atom->u.objectname.option == O_SHORT) {
-			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			v->s = xstrdup(find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
 			return 1;
 		} else if (atom->u.objectname.option == O_FULL) {
-			v->s = xstrdup(sha1_to_hex(sha1));
+			v->s = xstrdup(oid_to_hex(oid));
 			return 1;
 		} else if (atom->u.objectname.option == O_LENGTH) {
-			v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
+			v->s = xstrdup(find_unique_abbrev(oid->hash, atom->u.objectname.length));
 			return 1;
 		} else
 			die("BUG: unknown %%(objectname) option");
@@ -775,7 +775,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
-			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
+			grab_objectname(name, &obj->oid, v, &used_atom[i]);
 	}
 }
 
@@ -1439,7 +1439,7 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname.hash, v, atom)) {
+		} else if (!deref && grab_objectname(name, &ref->objectname, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
