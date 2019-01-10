Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA3F1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 06:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbfAJGcU (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 01:32:20 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:33996
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727313AbfAJGcS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Jan 2019 01:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1547101937;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Dl5j5Pn3N1gMlnqwJWiqQQPVfG9T9EmdcQAngmcepgI=;
        b=aweqI7fXcyXKTQuJJFyJVyV5nremg313wYL0LY7Ma+rlwB6Jc1A2rJ/w/7CQHTqT
        7MIIL8HD+AsQlkLT4zZ4ceP+LlSyfOVw40wdD6nab9OSgFvUWMEeNjE1j+2atN66q0O
        iFqkdiUCGwKF1VYproEC1zWWhpmmeMKtlRqNZgUk=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016836761cc9-d3a542af-7089-45c0-a5ae-413ba6909096-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016836761b8b-8616fc01-3489-4e53-a5b7-cd4b52e20e01-000000@eu-west-1.amazonses.com>
References: <0102016836761b8b-8616fc01-3489-4e53-a5b7-cd4b52e20e01-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 4/6] ref-filter: add deltabase option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jan 2019 06:32:16 +0000
X-SES-Outgoing: 2019.01.10-54.240.7.11
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
 ref-filter.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 57f3789d1040d..422a9c9ae3fd2 100644
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
@@ -892,7 +905,8 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 		} else if (!strcmp(name, "objectsize")) {
 			v->value = oi->size;
 			v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
-		}
+		} else if (!strcmp(name, "deltabase"))
+			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
 		else if (deref)
 			grab_objectname(name, &oi->oid, v, &used_atom[i]);
 	}

--
https://github.com/git/git/pull/552
