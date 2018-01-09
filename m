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
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CF01F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757155AbeAINFv (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:05:51 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:45794
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757014AbeAINFZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503123;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=jEpFGYgej7FTlltVuihwlZ3kR1Iskq/6bQaRpIx6UbM=;
        b=ZBAa8Wp69F4r8uyz9D47sHz6CieiiKAEsQM0PORTQjWUknMM5q4Fe+z84r50SRyy
        lY77Ra1957gg7eBe0nK0j5XQVROd/LFElDm1tZ3wqJCBbdFf/pNAvpzYAwCnCqO844M
        W/HAcArjySeHuhW15IIBVvx03ziwz73ovHSOu838=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067c88-b3fd99cb-2155-43d7-875a-f3f0d2ad0e1e-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 15/20] cat-file: start reusing populate_value
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move logic related to getting object info from cat-file to ref-filter.
It will help to reuse whole formatting logic from ref-filter further.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 16 +++-------------
 ref-filter.c       | 15 +++++++++++++++
 ref-filter.h       |  2 ++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1c92194faaede..e11dbf88e386c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -284,21 +284,11 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	struct strbuf buf = STRBUF_INIT;
 	struct ref_array_item item;
 
-	if (!data->skip_object_info &&
-	    sha1_object_info_extended(data->oid.hash, &data->info,
-				      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
-		printf("%s missing\n",
-		       obj_name ? obj_name : oid_to_hex(&data->oid));
-		fflush(stdout);
-		return;
-	}
-
 	item.objectname = data->oid;
-	item.type = data->type;
-	item.size = data->size;
-	item.disk_size = data->disk_size;
 	item.rest = data->rest;
-	item.delta_base_oid = data->delta_base_oid;
+	item.start_of_request = obj_name;
+
+	if (populate_value(&item)) return;
 
 	strbuf_expand(&buf, opt->format->format, expand_format, &item);
 	strbuf_addch(&buf, '\n');
diff --git a/ref-filter.c b/ref-filter.c
index ed1b78943b8b4..7df6d7e3d6511 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1469,6 +1469,21 @@ int populate_value(struct ref_array_item *ref)
 			ref->symref = "";
 	}
 
+	if (cat_file_info) {
+		if (!cat_file_info->skip_object_info &&
+		    sha1_object_info_extended(ref->objectname.hash, &cat_file_info->info,
+					      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
+			const char *e = ref->start_of_request;
+			printf("%s missing\n", e ? e : oid_to_hex(&ref->objectname));
+			fflush(stdout);
+			return -1;
+		}
+		ref->type = cat_file_info->type;
+		ref->size = cat_file_info->size;
+		ref->disk_size = cat_file_info->disk_size;
+		ref->delta_base_oid = cat_file_info->delta_base_oid;
+	}
+
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atoms[i];
diff --git a/ref-filter.h b/ref-filter.h
index d541749f9b1dc..9e4444cf3ef9a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -45,6 +45,8 @@ struct ref_array_item {
 	off_t disk_size;
 	const char *rest;
 	struct object_id delta_base_oid;
+	/* Need it for better explanation in error log. */
+	const char *start_of_request;
 	char refname[FLEX_ARRAY];
 };
 

--
https://github.com/git/git/pull/450
