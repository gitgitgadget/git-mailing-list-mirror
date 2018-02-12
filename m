Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE351F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933029AbeBLIJm (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:09:42 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:51926
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932992AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=tze78bCVC+7Nf+V/3jdMU8EoP+IkqgJ9bVH+znZJLdk=;
        b=T7sf+Bh9x1QCZxib4tNdwEX6w9H6Ja7fX9liayKx/6N2y1f3hiMJGfiKRHOkbes9
        zEArdu6cR4xEMpb/6rwogk/k+Y3mlNoQZ1Mn2Wp3UUmbC8v8xqEfzW6PVmjbQCi/s2M
        KdTgQiHFpmovM1VOytMD3ObvI0RD5P5V0KiaR1Go=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f437a-302b1577-f034-4a24-a3a2-851d1cda0044-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 20/23] ref-filter: unifying formatting of cat-file opts
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cat-file options are now filled by general logic.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8d104b567eb7c..5781416cf9126 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -824,8 +824,12 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 		else if (!strcmp(name, "objectsize")) {
 			v->value = sz;
 			v->s = xstrfmt("%lu", sz);
-		}
-		else if (deref)
+		} else if (!strcmp(name, "objectsize:disk")) {
+			if (cat_file_info.is_cat_file) {
+				v->value = cat_file_info.disk_size;
+				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)v->value);
+			}
+		} else if (deref)
 			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
 	}
 }
@@ -1465,21 +1469,7 @@ static int populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (cat_file_info.is_cat_file) {
-			if (starts_with(name, "objectname"))
-				v->s = oid_to_hex(&ref->oid);
-			else if (starts_with(name, "objecttype"))
-				v->s = typename(ref->type);
-			else if (starts_with(name, "objectsize")) {
-				v->s = xstrfmt("%lu", ref->size);
-			} else if (starts_with(name, "objectsize:disk")) {
-				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)ref->disk_size);
-			} else if (starts_with(name, "rest"))
-				v->s = ref->rest;
-			else if (starts_with(name, "deltabase"))
-				v->s = xstrdup(oid_to_hex(ref->delta_base_oid));
-			continue;
-		} else if (starts_with(name, "refname"))
+		if (starts_with(name, "refname"))
 			refname = get_refname(atom, ref);
 		else if (starts_with(name, "symref"))
 			refname = get_symref(atom, ref);
@@ -1535,6 +1525,15 @@ static int populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (starts_with(name, "rest")) {
+			v->s = ref->rest ? ref->rest : "";
+			continue;
+		} else if (starts_with(name, "deltabase")) {
+			if (ref->delta_base_oid)
+				v->s = xstrdup(oid_to_hex(ref->delta_base_oid));
+			else
+				v->s = "";
+			continue;
 		} else if (starts_with(name, "align")) {
 			v->handler = align_atom_handler;
 			continue;

--
https://github.com/git/git/pull/452
