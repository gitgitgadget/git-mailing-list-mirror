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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6301F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbeBEL2f (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:28:35 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:42244
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752811AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=boAH65qt6mE/yiSuz+0cgU0sITKyBQEAHHii0DWRGvg=;
        b=I0Q4XTy8pdCn5sWu98vjTVlNVC1/zypKzwO6Kydj8Ew9actBNYXkiQvo7rPSjE6H
        Fq1D4ljSFbZuUzn0h/zUgp0NdbckZVdIjyVdI1srbym5ysZUOqmr6mUFt4RfXnXCzFV
        S/HdfVzEwMhV911rM3gVAZLjvVY+NtlioaGtw4rg=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b477-dde9b525-d0a3-4b32-a049-3b5a7042ddab-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 21/25] ref-filter: unifying formatting of cat-file
 opts
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:39 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.17
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
 ref-filter.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 70c685851466b..aa15dd0b4723e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -825,8 +825,10 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 		else if (!strcmp(name, "objectsize")) {
 			v->value = sz;
 			v->s = xstrfmt("%lu", sz);
-		}
-		else if (deref)
+		} else if (!strcmp(name, "objectsize:disk")) {
+			v->value = cat_file_info.disk_size;
+			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)v->value);
+		} else if (deref)
 			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
 	}
 }
@@ -1466,21 +1468,7 @@ static int populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (is_cat) {
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
@@ -1536,6 +1524,15 @@ static int populate_value(struct ref_array_item *ref)
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
