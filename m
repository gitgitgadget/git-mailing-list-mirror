Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D971F453
	for <e@80x24.org>; Fri,  9 Nov 2018 07:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeKIRXX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:23:23 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:50742
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727962AbeKIRXX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Nov 2018 12:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1541749441;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=weLXUAd52s08c0uBhFga8+Vx41ucQ3SKE1umj3mue+Q=;
        b=ez94Vr2s8RcDuC2zI7HyGZw7+Wt2LBm4YmDK9VmOulQW7Mf7oW5xOKY2gE9yGbY4
        04tmNepfKoIzsuLhV3J+R5EaO4XpL4SeuBb2/9MPuWfYhIurrBJMl7vfkeoe5EKWbjK
        z0k4bspn3jFPutQx3oCiDiKzrj0G0/D+r5afkpMI=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020166f76d84e0-d2e0c0ad-bb3d-46ab-8834-3760546086d4-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
References: <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
Subject: [RFC PATCH 3/5] ref-filter: add deltabase option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 9 Nov 2018 07:44:01 +0000
X-SES-Outgoing: 2018.11.09-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new formatting option: deltabase.
If the object is stored as a delta on-disk, this expands
to the 40-hex sha1 of the delta base object.
Otherwise, expands to the null sha1 (40 zeroes).
We have same option in cat-file command.
Hopefully, in the end I will remove formatting code from
cat-file and reuse formatting parts from ref-filter.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8ba1a4e72f2c3..3cfe01a039f8b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -246,6 +246,18 @@ static int objectsize_atom_parser(const struct ref_format *format, struct used_a
 	return 0;
 }
 
+static int deltabase_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				 const char *arg, struct strbuf *err)
+{
+	if (arg)
+		return strbuf_addf_ret(err, -1, _("%%(deltabase) does not take arguments"));
+	if (*atom->name == '*')
+		oi_deref.info.delta_base_sha1 = oi_deref.delta_base_oid.hash;
+	else
+		oi.info.delta_base_sha1 = oi.delta_base_oid.hash;
+	return 0;
+}
+
 static int body_atom_parser(const struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
@@ -437,6 +449,7 @@ static struct {
 	{ "objecttype", SOURCE_OTHER, FIELD_STR, objecttype_atom_parser },
 	{ "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
 	{ "objectname", SOURCE_OTHER, FIELD_STR, objectname_atom_parser },
+	{ "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
 	{ "tree", SOURCE_OBJ },
 	{ "parent", SOURCE_OBJ },
 	{ "numparent", SOURCE_OBJ, FIELD_ULONG },
@@ -888,7 +901,9 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 		} else if (!strcmp(name, "objectsize")) {
 			v->value = oi->size;
 			v->s = xstrfmt("%lu", oi->size);
-		} else if (deref)
+		} else if (!strcmp(name, "deltabase"))
+			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
+		else if (deref)
 			grab_objectname(name, &oi->oid, v, &used_atom[i]);
 	}
 }

--
https://github.com/git/git/pull/552
