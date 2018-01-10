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
	by dcvr.yhbt.net (Postfix) with ESMTP id 836A31FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756121AbeAJJgs (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:36:48 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:37926
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754094AbeAJJgm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 04:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515577001;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=IE1ZjIMaUIeJ46+YnQDA1B1uvmAwDU4OdIyVLUKisEg=;
        b=JFgTdSxFCEwPSl34Lb7zMJv4xyurrmgCklTz/5ziCuLPt3ZNdSr85/Y7QvJb4Azh
        2kgnK3Zu3ysWcHnHm/VFoMIRdARlnTIdKbJB3rS7Zsf8ir/hkrz+ibGl3LjZpgcIxYE
        0YNDddWO0W+8eU/3baZSZspVfB0yY+xn26GHMFV8=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 01/18] cat-file: split expand_atom into 2 functions
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jan 2018 09:36:41 +0000
X-SES-Outgoing: 2018.01.10-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split expand_atom function into 2 different functions,
expand_atom_into_fields prepares variable for further filling,
(new) expand_atom creates resulting string.
Need that for further reusing of formatting logic from ref-filter.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 73 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5fa4fd75af26..f783b39b9bd5c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -217,47 +217,49 @@ static int is_atom(const char *atom, const char *s, int slen)
 	return alen == slen && !memcmp(atom, s, alen);
 }
 
-static void expand_atom(struct strbuf *sb, const char *atom, int len,
-			void *vdata)
+static void expand_atom_into_fields(struct strbuf *sb, const char *atom, int len,
+			struct expand_data *data)
 {
-	struct expand_data *data = vdata;
+	if (is_atom("objectname", atom, len))
+		; /* do nothing */
+	else if (is_atom("objecttype", atom, len))
+		data->info.typep = &data->type;
+	else if (is_atom("objectsize", atom, len))
+		data->info.sizep = &data->size;
+	else if (is_atom("objectsize:disk", atom, len))
+		data->info.disk_sizep = &data->disk_size;
+	else if (is_atom("rest", atom, len))
+		data->split_on_whitespace = 1;
+	else if (is_atom("deltabase", atom, len))
+		data->info.delta_base_sha1 = data->delta_base_oid.hash;
+	else
+		die("unknown format element: %.*s", len, atom);
+}
 
-	if (is_atom("objectname", atom, len)) {
-		if (!data->mark_query)
-			strbuf_addstr(sb, oid_to_hex(&data->oid));
-	} else if (is_atom("objecttype", atom, len)) {
-		if (data->mark_query)
-			data->info.typep = &data->type;
-		else
-			strbuf_addstr(sb, typename(data->type));
-	} else if (is_atom("objectsize", atom, len)) {
-		if (data->mark_query)
-			data->info.sizep = &data->size;
-		else
-			strbuf_addf(sb, "%lu", data->size);
-	} else if (is_atom("objectsize:disk", atom, len)) {
-		if (data->mark_query)
-			data->info.disk_sizep = &data->disk_size;
-		else
-			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
-	} else if (is_atom("rest", atom, len)) {
-		if (data->mark_query)
-			data->split_on_whitespace = 1;
-		else if (data->rest)
+static void expand_atom(struct strbuf *sb, const char *atom, int len,
+			 struct expand_data *data)
+{
+	if (is_atom("objectname", atom, len))
+		strbuf_addstr(sb, oid_to_hex(&data->oid));
+	else if (is_atom("objecttype", atom, len))
+		strbuf_addstr(sb, typename(data->type));
+	else if (is_atom("objectsize", atom, len))
+		strbuf_addf(sb, "%lu", data->size);
+	else if (is_atom("objectsize:disk", atom, len))
+		strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
+	else if (is_atom("rest", atom, len)) {
+		if (data->rest)
 			strbuf_addstr(sb, data->rest);
-	} else if (is_atom("deltabase", atom, len)) {
-		if (data->mark_query)
-			data->info.delta_base_sha1 = data->delta_base_oid.hash;
-		else
-			strbuf_addstr(sb,
-				      oid_to_hex(&data->delta_base_oid));
-	} else
+	} else if (is_atom("deltabase", atom, len))
+		strbuf_addstr(sb, oid_to_hex(&data->delta_base_oid));
+	else
 		die("unknown format element: %.*s", len, atom);
 }
 
-static size_t expand_format(struct strbuf *sb, const char *start, void *data)
+static size_t expand_format(struct strbuf *sb, const char *start, void *vdata)
 {
 	const char *end;
+	struct expand_data *data = vdata;
 
 	if (*start != '(')
 		return 0;
@@ -265,7 +267,10 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *data)
 	if (!end)
 		die("format element '%s' does not end in ')'", start);
 
-	expand_atom(sb, start + 1, end - start - 1, data);
+	if (data->mark_query)
+		expand_atom_into_fields(sb, start + 1, end - start - 1, data);
+	else
+		expand_atom(sb, start + 1, end - start - 1, data);
 
 	return end - start + 1;
 }

--
https://github.com/git/git/pull/450
