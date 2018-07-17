Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6140C1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 08:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbeGQIyY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 04:54:24 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:38160
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728089AbeGQIyY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Jul 2018 04:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1531815777;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=L/paqk71jv36TwffOd4wtn6uFHffeFreueGZckTC4/I=;
        b=c4hc5A7TqFXRerb56aL5XvSlIQlzcRaWYhr+8deIz3sbODW6D1HStiU3WxG/eLCs
        o4FqeIOCamcOg/MvGttl7pKNsAD2faIjesQlizLHIXjLJyzy/dLiOXatGQVWxrcUHrI
        t6Ei50VnjmAxfqv9uihCLIGzxT7T/cTtVo8vbGOM=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020164a755d424-fc32ede3-5629-40f6-8b1d-12f306c0fe12-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020164a755d376-b1b86aec-5d26-4d6c-8f8f-2adbb6a8ed65-000000@eu-west-1.amazonses.com>
References: <01020164a755d376-b1b86aec-5d26-4d6c-8f8f-2adbb6a8ed65-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 4/5] ref-filter: merge get_obj and get_object
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Jul 2018 08:22:57 +0000
X-SES-Outgoing: 2018.07.17-54.240.7.19
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
index 8db7ca95b12c0..2b401a17c4689 100644
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
@@ -1437,21 +1419,25 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 }
 
 static int get_object(struct ref_array_item *ref, const struct object_id *oid,
-		       int deref, struct object **obj, struct strbuf *err)
+		      int deref, struct object **obj, struct strbuf *err)
 {
 	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
 	int eaten = 1;
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
