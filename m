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
	by dcvr.yhbt.net (Postfix) with ESMTP id 71DA91FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756153AbeAJJhB (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:37:01 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:59396
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755902AbeAJJgm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 04:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515577001;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=BQn5MT3Mtqm/8kltGzOAvoBMq2XoQUNd6DLbVIvckQw=;
        b=GeckH3JoMc73VgvJ+83RSXdfSAk7RhjnDPZRx4pBTH72wAC6E3tTv5RW+gds542+
        U3tI/+yl7vLCj5G/L30F66O98O5PIScUhJV45OgEaBu5OZ/popzqyyZErL5pgHuRt2d
        PbOV7wDGlVhnefuuUinFcqrCllb9xLIairBP/66k=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160df6dc55c-8460a406-3567-42b0-9f03-733e7c64792a-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 08/18] ref-filter: get rid of goto
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jan 2018 09:36:41 +0000
X-SES-Outgoing: 2018.01.10-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of goto command in ref-filter for better readability.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 103 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 53 insertions(+), 50 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index bb09875e2dbf4..575c5351d0f79 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1403,16 +1403,60 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 	return show_ref(&atom->u.refname, ref->refname);
 }
 
+static void need_object(struct ref_array_item *ref) {
+	struct object *obj;
+	const struct object_id *tagged;
+	unsigned long size;
+	int eaten;
+	void *buf = get_obj(&ref->objectname, &obj, &size, &eaten);
+	if (!buf)
+		die(_("missing object %s for %s"),
+		    oid_to_hex(&ref->objectname), ref->refname);
+	if (!obj)
+		die(_("parse_object_buffer failed on %s for %s"),
+		    oid_to_hex(&ref->objectname), ref->refname);
+
+	grab_values(ref->value, 0, obj, buf, size);
+	if (!eaten)
+		free(buf);
+
+	/*
+	 * If there is no atom that wants to know about tagged
+	 * object, we are done.
+	 */
+	if (!need_tagged || (obj->type != OBJ_TAG))
+		return;
+
+	/*
+	 * If it is a tag object, see if we use a value that derefs
+	 * the object, and if we do grab the object it refers to.
+	 */
+	tagged = &((struct tag *)obj)->tagged->oid;
+
+	/*
+	 * NEEDSWORK: This derefs tag only once, which
+	 * is good to deal with chains of trust, but
+	 * is not consistent with what deref_tag() does
+	 * which peels the onion to the core.
+	 */
+	buf = get_obj(tagged, &obj, &size, &eaten);
+	if (!buf)
+		die(_("missing object %s for %s"),
+		    oid_to_hex(tagged), ref->refname);
+	if (!obj)
+		die(_("parse_object_buffer failed on %s for %s"),
+		    oid_to_hex(tagged), ref->refname);
+	grab_values(ref->value, 1, obj, buf, size);
+	if (!eaten)
+		free(buf);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
 static void populate_value(struct ref_array_item *ref)
 {
-	void *buf;
-	struct object *obj;
-	int eaten, i;
-	unsigned long size;
-	const struct object_id *tagged;
+	int i;
 
 	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
 
@@ -1526,53 +1570,12 @@ static void populate_value(struct ref_array_item *ref)
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct atom_value *v = &ref->value[i];
-		if (v->s == NULL)
-			goto need_obj;
+		if (v->s == NULL) {
+			need_object(ref);
+			break;
+		}
 	}
 	return;
-
- need_obj:
-	buf = get_obj(&ref->objectname, &obj, &size, &eaten);
-	if (!buf)
-		die(_("missing object %s for %s"),
-		    oid_to_hex(&ref->objectname), ref->refname);
-	if (!obj)
-		die(_("parse_object_buffer failed on %s for %s"),
-		    oid_to_hex(&ref->objectname), ref->refname);
-
-	grab_values(ref->value, 0, obj, buf, size);
-	if (!eaten)
-		free(buf);
-
-	/*
-	 * If there is no atom that wants to know about tagged
-	 * object, we are done.
-	 */
-	if (!need_tagged || (obj->type != OBJ_TAG))
-		return;
-
-	/*
-	 * If it is a tag object, see if we use a value that derefs
-	 * the object, and if we do grab the object it refers to.
-	 */
-	tagged = &((struct tag *)obj)->tagged->oid;
-
-	/*
-	 * NEEDSWORK: This derefs tag only once, which
-	 * is good to deal with chains of trust, but
-	 * is not consistent with what deref_tag() does
-	 * which peels the onion to the core.
-	 */
-	buf = get_obj(tagged, &obj, &size, &eaten);
-	if (!buf)
-		die(_("missing object %s for %s"),
-		    oid_to_hex(tagged), ref->refname);
-	if (!obj)
-		die(_("parse_object_buffer failed on %s for %s"),
-		    oid_to_hex(tagged), ref->refname);
-	grab_values(ref->value, 1, obj, buf, size);
-	if (!eaten)
-		free(buf);
 }
 
 /*

--
https://github.com/git/git/pull/450
