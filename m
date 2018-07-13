Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399271F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 12:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeGMM62 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 08:58:28 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:38884
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729658AbeGMM62 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 08:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1531485836;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=KjJRaGNKw9Kdk24/PLBXCnfEuapYecSnW0Vv5257P+w=;
        b=wnRYc20FQnSS1DOJ3nkYeGsSiHXTPlmN1MoR62it/gOuQpW1GOE3nbhSEVA47Pxu
        TCjvGN6aQ5URIKmpSqw8OrSC5D4H94ZaQJJMoqB3difZfA2/A+xIKUY3g9jGWsMxb6S
        2nIxqq4piZpz1iGjKkgPO9e8jpUOlUBRoQNA5RGs=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016493ab5420-51c1c19d-e1ca-43cb-8f9e-36f242f5c972-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016493ab5347-c0429041-6e66-4550-894c-2d500cb2ed8e-000000@eu-west-1.amazonses.com>
References: <0102016493ab5347-c0429041-6e66-4550-894c-2d500cb2ed8e-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 3/4] ref-filter: merge get_obj and get_object
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Jul 2018 12:43:56 +0000
X-SES-Outgoing: 2018.07.13-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inline get_obj(): it would be easier to edit the code
without this split.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 27733ef013bed..f04169f0ea0e3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -797,24 +797,6 @@ int verify_ref_format(struct ref_format *format)
 	return 0;
 }
 
-/*
- * Given an object name, read the object data and size, and return a
- * "struct object".  If the object data we are returning is also borrowed
- * by the "struct object" representation, set *eaten as well---it is a
- * signal from parse_object_buffer to us not to free the buffer.
- */
-static void *get_obj(const struct object_id *oid, struct object **obj, unsigned long *sz, int *eaten)
-{
-	enum object_type type;
-	void *buf = read_object_file(oid, &type, sz);
-
-	if (buf)
-		*obj = parse_object_buffer(oid, type, *sz, buf, eaten);
-	else
-		*obj = NULL;
-	return buf;
-}
-
 static int grab_objectname(const char *name, const struct object_id *oid,
 			   struct atom_value *v, struct used_atom *atom)
 {
@@ -1437,20 +1419,24 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 }
 
 static int get_object(struct ref_array_item *ref, const struct object_id *oid,
-		       int deref, struct object **obj, struct strbuf *err)
+		      int deref, struct object **obj, struct strbuf *err)
 {
 	int eaten;
 	int ret = 0;
 	unsigned long size;
-	void *buf = get_obj(oid, obj, &size, &eaten);
+	enum object_type type;
+	void *buf = read_object_file(oid, &type, &size);
 	if (!buf)
 		ret = strbuf_addf_ret(err, -1, _("missing object %s for %s"),
 				      oid_to_hex(oid), ref->refname);
-	else if (!*obj)
-		ret = strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
-				      oid_to_hex(oid), ref->refname);
-	else
-		grab_values(ref->value, deref, *obj, buf, size);
+	else {
+		*obj = parse_object_buffer(oid, type, size, buf, &eaten);
+		if (!*obj)
+			ret = strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
+					      oid_to_hex(oid), ref->refname);
+		else
+			grab_values(ref->value, deref, *obj, buf, size);
+	}
 	if (!eaten)
 		free(buf);
 	return ret;

--
https://github.com/git/git/pull/520
