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
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F7C1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeAZTnm (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:43:42 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:37172
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751291AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=jFP4Rzw3ga+js/KYeLO9x/mEdt3jqpQEMM7D3eSbfSw=;
        b=WSyY2WnSq++tRsPJRqqEeDpBYnNRZqzMV8Bx32gDhMnRHOTsl9soWpz/BIRwENXI
        3n6bFA6of2HEel8zxHo0C4m6jEX+SOmN0v7S2oIyCHVQhUSJZOKZj/EwXXv99Qv/1cc
        oN0n+CbYJv9cAQ33gaEv5O8oR606iWL82QMDVdNo=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 01/24] ref-filter: get rid of goto
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.18
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
index f9e25aea7a97e..37337b57aacf4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1354,16 +1354,60 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
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
 
@@ -1477,53 +1521,12 @@ static void populate_value(struct ref_array_item *ref)
 
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
https://github.com/git/git/pull/452
