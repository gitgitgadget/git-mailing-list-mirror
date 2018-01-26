Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB5A1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeAZToG (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:06 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:37508
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752141AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=TWGTVZ7K9DD+VniJCmtxK7rdANcKFxJtmdPat9XWIgo=;
        b=I80foaS4uP6bQZE2AWZd1kd5fKm0h8txQs5GjgDAslHlE+hxJuobTDTCpjA98nbN
        6tPoWACbJv2Q/xWFW/5++Wg23R12OHXXQVJw9EAWMVdM0UBCR/6VV1+JaV2CUD9PR4X
        pRc6smuzthaOZqX4ad4OFBBWbs/od8FLPTWoii9k=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b49-fe78f01d-12a2-4f53-afae-fe88d9d73754-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 20/24] ref-filter: unifying formatting of cat-file opts
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.11
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
index c3a5c3897295f..2cac394e93f52 100644
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
@@ -1509,21 +1511,7 @@ static int populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (is_cat) {
-			if (starts_with(name, "objectname"))
-				v->s = oid_to_hex(&ref->objectname);
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
@@ -1579,6 +1567,15 @@ static int populate_value(struct ref_array_item *ref)
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
