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
	by dcvr.yhbt.net (Postfix) with ESMTP id 212C41F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 08:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeGIIM6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 04:12:58 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:47742
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754011AbeGIIM4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2018 04:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1531123974;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=KjJRaGNKw9Kdk24/PLBXCnfEuapYecSnW0Vv5257P+w=;
        b=JuuZTAsztT65T3C8HzXBzwBI+UQBkFeFImy5XeWx25YLbzDyeVoyTKd2FJO0f38T
        VRanlj2Vd1o4WLKkNJHKRnv5FcMedPw1bbGGahcQ2QzTrRZm7URW+MtHesW1BUYxvJD
        LnKE0sk8uISzmKIM/vEhx1bB1kYI+GVb2QmAwWCg=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201647e19c24c-fd353913-225a-4153-aa0f-6ddf41ae6354-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com>
References: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com>
Subject: [PATCH 3/4] ref-filter: merge get_obj and get_object
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 9 Jul 2018 08:12:54 +0000
X-SES-Outgoing: 2018.07.09-54.240.7.19
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
