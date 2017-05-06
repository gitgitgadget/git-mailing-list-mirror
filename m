Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC34F207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbdEFWMq (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:12:46 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37758 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754232AbdEFWL0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9101B280D0;
        Sat,  6 May 2017 22:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108675;
        bh=NuenTu60tArmzInQDW7qksZqzuMS9NQ5l0b+2dAiuNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8A5d3YU6/gcO4Yv2amElK+doesfjjpXSsvfWuDKk3ouxxMBp2ee0tCO7OcTETsUM
         uZnDAzNbvNvG9WqEeftBUj7W0+mJE/ZPTfuPWWrYDfQoe3iCIH6T2oQ9Jg4hzUOkFa
         ew4C44fUvSfxC8IAKwkEoLV43A3xzU0cK9nfQSIe51spHeDaDrqqieGTSb8s47Pm5l
         vIcKlvZXoCQM/488rGsxWz9+A/CTU8btb/V+UCFtQMheBpv5lKawF9tdK89+RqVLLY
         eeYo13mjPQm5zlg+GJslztSHGJKa7UJZstOjj2kPNKaNwkOdcuGX8UOO8kFS73ifKw
         ReIx2KkyBuVt4hkB0vbG8W0ncp+Afj578g+1jL6sgeUS9eke6N5PjslG7va4oV2plj
         WOFnH0PmUqbyvAY80fCD9c6sHCsJFxgvj6riOnYpZNGgG+hjIYC5+mtMv4VO1qxQ1H
         Irj3P2FweceYPLaimqlnFNYqw4EYvclEeciUA+2Yy22mbyGqWzr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 36/53] Convert struct ref_array_item to struct object_id
Date:   Sat,  6 May 2017 22:10:21 +0000
Message-Id: <20170506221038.296722-37-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct ref_array_item to use struct object_id by changing the
definition and applying the following semantic patch, plus the standard
object_id transforms:

@@
struct ref_array_item E1;
@@
- E1.objectname
+ E1.objectname.hash

@@
struct ref_array_item *E1;
@@
- E1->objectname
+ E1->objectname.hash

This transformation allows us to convert get_obj, which is needed to
convert parse_object_buffer.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ref-filter.c | 10 +++++-----
 ref-filter.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e1d18ac0d..77aee273f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1366,7 +1366,7 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname, v, atom)) {
+		} else if (!deref && grab_objectname(name, ref->objectname.hash, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
@@ -1415,13 +1415,13 @@ static void populate_value(struct ref_array_item *ref)
 	return;
 
  need_obj:
-	buf = get_obj(ref->objectname, &obj, &size, &eaten);
+	buf = get_obj(ref->objectname.hash, &obj, &size, &eaten);
 	if (!buf)
 		die(_("missing object %s for %s"),
-		    sha1_to_hex(ref->objectname), ref->refname);
+		    oid_to_hex(&ref->objectname), ref->refname);
 	if (!obj)
 		die(_("parse_object_buffer failed on %s for %s"),
-		    sha1_to_hex(ref->objectname), ref->refname);
+		    oid_to_hex(&ref->objectname), ref->refname);
 
 	grab_values(ref->value, 0, obj, buf, size);
 	if (!eaten)
@@ -1704,7 +1704,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 {
 	struct ref_array_item *ref;
 	FLEX_ALLOC_STR(ref, refname, refname);
-	hashcpy(ref->objectname, objectname);
+	hashcpy(ref->objectname.hash, objectname);
 	ref->flag = flag;
 
 	return ref;
diff --git a/ref-filter.h b/ref-filter.h
index c20167aa3..6552024f0 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -34,7 +34,7 @@ struct ref_sorting {
 };
 
 struct ref_array_item {
-	unsigned char objectname[20];
+	struct object_id objectname;
 	int flag;
 	unsigned int kind;
 	const char *symref;
