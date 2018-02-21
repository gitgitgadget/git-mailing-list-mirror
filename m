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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E23E1F576
	for <e@80x24.org>; Wed, 21 Feb 2018 06:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeBUG7D (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 01:59:03 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:57190
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750752AbeBUG7C (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Feb 2018 01:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1519196341;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=iIFREaDJoXJamPkYBjGTffzJ5G+QIKcpNXCmTpLny1c=;
        b=XoxE6crxDvIVg07fVs+YtjKixchWTIgi0EVxCFXMwa/7KZmvzUC/Xlf21z/zhK7y
        BOgNsiKOq+nznd0lwgW9X/UTO1/SKCCIeR2ozNrGY13r1nF+jtZkO5Lq1LrBUiuugGx
        13CnzAMK2ouhvo4NR2oJ7PE9Nw71wENtqVLrIDFY=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161b728823f-daec904e-44ff-45f9-9c89-d447b89c7802-000000@eu-west-1.amazonses.com>
Subject: [PATCH 1/2] ref-filter: get rid of duplicate code
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Feb 2018 06:59:00 +0000
X-SES-Outgoing: 2018.02.21-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make one function from 2 duplicate pieces and invoke it twice.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f9e25aea7a97e..83ffd84affe52 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1354,15 +1354,31 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 	return show_ref(&atom->u.refname, ref->refname);
 }
 
+static void get_object(struct ref_array_item *ref, const struct object_id *oid,
+		       int deref, struct object **obj)
+{
+	int eaten;
+	unsigned long size;
+	void *buf = get_obj(oid, obj, &size, &eaten);
+	if (!buf)
+		die(_("missing object %s for %s"),
+		    oid_to_hex(oid), ref->refname);
+	if (!*obj)
+		die(_("parse_object_buffer failed on %s for %s"),
+		    oid_to_hex(oid), ref->refname);
+
+	grab_values(ref->value, deref, *obj, buf, size);
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
 	struct object *obj;
-	int eaten, i;
-	unsigned long size;
+	int i;
 	const struct object_id *tagged;
 
 	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
@@ -1483,17 +1499,7 @@ static void populate_value(struct ref_array_item *ref)
 	return;
 
  need_obj:
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
+	get_object(ref, &ref->objectname, 0, &obj);
 
 	/*
 	 * If there is no atom that wants to know about tagged
@@ -1514,16 +1520,7 @@ static void populate_value(struct ref_array_item *ref)
 	 * is not consistent with what deref_tag() does
 	 * which peels the onion to the core.
 	 */
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
+	get_object(ref, tagged, 1, &obj);
 }
 
 /*

--
https://github.com/git/git/pull/460
