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
	by dcvr.yhbt.net (Postfix) with ESMTP id B048B1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeBLIJO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:09:14 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:46184
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932995AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=kY/Ne3SrM7fccwcvXS7akd15J2V+hRGBKfciudazGwc=;
        b=HgIbG8KKObSqo1qvXdI3+DU4kGtyKDuoTC4jGb0+ZcdiYVDEJYPWlnQnr7SOzfM9
        OTSMLjKDX4RbYycfY6qf8XStisJsae3yht2PlAUr/nIZNC7Pn1cIA5s9hrJ2xqXg5r0
        whKlXFYH2q4F16flQbS1fD++s1fjAidKqS45r1kw=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4354-a54075a4-9dba-45df-9e5c-196362b4e300-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 11/23] ref-filter: rename field in ref_array_item stuct
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename objectname field to oid in struct ref_array_item.
Next commit will add objectname field that will contain
string representation of object id.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c |  4 ++--
 ref-filter.c       | 10 +++++-----
 ref-filter.h       |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5b7bc34f1ec6d..0c362828ad81e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -186,7 +186,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			 struct ref_array_item *item)
 {
 	if (is_atom("objectname", atom, len))
-		strbuf_addstr(sb, oid_to_hex(&item->objectname));
+		strbuf_addstr(sb, oid_to_hex(&item->oid));
 	else if (is_atom("objecttype", atom, len))
 		strbuf_addstr(sb, typename(item->type));
 	else if (is_atom("objectsize", atom, len))
@@ -294,7 +294,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 		return;
 	}
 
-	item.objectname = data->oid;
+	item.oid = data->oid;
 	item.type = data->type;
 	item.size = data->size;
 	item.disk_size = data->disk_size;
diff --git a/ref-filter.c b/ref-filter.c
index 4acd391b5dfac..d09ec1bde6d54 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1489,7 +1489,7 @@ int populate_value(struct ref_array_item *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname.hash, v, atom)) {
+		} else if (!deref && grab_objectname(name, ref->oid.hash, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
@@ -1534,13 +1534,13 @@ int populate_value(struct ref_array_item *ref)
 	if (used_atom_cnt <= i)
 		return 0;
 
-	buf = get_obj(&ref->objectname, &obj, &size, &eaten);
+	buf = get_obj(&ref->oid, &obj, &size, &eaten);
 	if (!buf)
 		die(_("missing object %s for %s"),
-		    oid_to_hex(&ref->objectname), ref->refname);
+		    oid_to_hex(&ref->oid), ref->refname);
 	if (!obj)
 		die(_("parse_object_buffer failed on %s for %s"),
-		    oid_to_hex(&ref->objectname), ref->refname);
+		    oid_to_hex(&ref->oid), ref->refname);
 
 	grab_values(ref->value, 0, obj, buf, size);
 	if (!eaten)
@@ -1890,7 +1890,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 {
 	struct ref_array_item *ref;
 	FLEX_ALLOC_STR(ref, refname, refname);
-	hashcpy(ref->objectname.hash, objectname);
+	hashcpy(ref->oid.hash, objectname);
 	ref->flag = flag;
 
 	return ref;
diff --git a/ref-filter.h b/ref-filter.h
index e16ea2a990119..87b026b8b76d0 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -34,7 +34,7 @@ struct ref_sorting {
 };
 
 struct ref_array_item {
-	struct object_id objectname;
+	struct object_id oid;
 	int flag;
 	unsigned int kind;
 	const char *symref;

--
https://github.com/git/git/pull/452
