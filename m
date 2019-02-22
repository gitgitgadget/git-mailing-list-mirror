Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9FF220248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfBVQFr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:05:47 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:35960
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727228AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=KIwMEX8isseoq2YJTm0KpxNxDPKxdNGF0UHcKIjFw7Q=;
        b=ZbqcHQaUWcwfAkTuVdkQWXL9GodYVhyRSvQ/MPhHQci98s8QmKOxSoBejI4Cpgt8
        fN5l8LvOmdDcJORv6CbnuhKxGa/Aum6ITyjzLwQkmRX0SCYVvQ4crO9/tFZ/63FDbe3
        o+gtlRW1YGAq55MKLhjdMzHFjy2cycgIZKngxWmU=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a66-7e179c2f-b7d4-4d4d-935f-ff1431f86a77-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 14/20] cat-file: move print_object_or_die to ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move printing function to ref-filter, it is logical because
we move all formatting/printing logic to ref-filter.
It could be much better if we embed this logic into current
flows in ref-filter, but it looks like the task for another patch.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 51 ---------------------------------------------
 ref-filter.c       | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 ref-filter.h       |  3 +++
 3 files changed, 55 insertions(+), 51 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2066ff1e697e4..6c0cbf71f0f0c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -226,57 +226,6 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *data)
 	return end - start + 1;
 }
 
-static void print_object_or_die(struct expand_data *data, int cmdmode,
-				int buffered, const char *rest)
-{
-	const struct object_id *oid = &data->oid;
-	unsigned long size;
-	char *contents;
-
-	assert(data->info.typep);
-
-	if (data->type != OBJ_BLOB) {
-		enum object_type type;
-		contents = read_object_file(oid, &type, &size);
-		if (!contents)
-			die("object %s disappeared", oid_to_hex(oid));
-		if (type != data->type)
-			die("object %s changed type!?", oid_to_hex(oid));
-		if (data->info.sizep && size != data->size)
-			die("object %s changed size!?", oid_to_hex(oid));
-
-		write_or_die(1, contents, size);
-		free(contents);
-		return;
-	}
-
-	if (buffered)
-		fflush(stdout);
-	if (!cmdmode) {
-		if (stream_blob_to_fd(1, oid, NULL, 0))
-			die("unable to stream %s to stdout", oid_to_hex(oid));
-		return;
-	}
-
-	if (!rest)
-		die("missing path for '%s'", oid_to_hex(oid));
-
-	if (cmdmode == 'w') {
-		if (filter_object(rest, 0100644, oid, &contents, &size))
-			die("could not convert '%s' %s", oid_to_hex(oid), rest);
-	} else if (cmdmode == 'c') {
-		enum object_type type;
-		if (!textconv_object(the_repository, rest, 0100644, oid, 1,
-				     &contents, &size))
-			contents = read_object_file(oid, &type, &size);
-		if (!contents)
-			die("could not convert '%s' %s", oid_to_hex(oid), rest);
-	} else
-		BUG("invalid cmdmode: %c", cmdmode);
-	write_or_die(1, contents, size);
-	free(contents);
-}
-
 static void batch_object_write(const char *obj_name,
 			       struct strbuf *scratch,
 			       struct batch_options *opt,
diff --git a/ref-filter.c b/ref-filter.c
index 65b94ea21e54f..68d9741a56468 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -20,6 +20,7 @@
 #include "commit-slab.h"
 #include "commit-graph.h"
 #include "commit-reach.h"
+#include "streaming.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -2366,3 +2367,54 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 
 	return 0;
 }
+
+void print_object_or_die(struct expand_data *data, int cmdmode,
+			 int buffered, const char *rest)
+{
+	const struct object_id *oid = &data->oid;
+	unsigned long size;
+	char *contents;
+
+	assert(data->info.typep);
+
+	if (data->type != OBJ_BLOB) {
+		enum object_type type;
+		contents = read_object_file(oid, &type, &size);
+		if (!contents)
+			die("object %s disappeared", oid_to_hex(oid));
+		if (type != data->type)
+			die("object %s changed type!?", oid_to_hex(oid));
+		if (data->info.sizep && size != data->size)
+			die("object %s changed size!?", oid_to_hex(oid));
+
+		write_or_die(1, contents, size);
+		free(contents);
+		return;
+	}
+
+	if (buffered)
+		fflush(stdout);
+	if (!cmdmode) {
+		if (stream_blob_to_fd(1, oid, NULL, 0))
+			die("unable to stream %s to stdout", oid_to_hex(oid));
+		return;
+	}
+
+	if (!rest)
+		die("missing path for '%s'", oid_to_hex(oid));
+
+	if (cmdmode == 'w') {
+		if (filter_object(rest, 0100644, oid, &contents, &size))
+			die("could not convert '%s' %s", oid_to_hex(oid), rest);
+	} else if (cmdmode == 'c') {
+		enum object_type type;
+		if (!textconv_object(the_repository, rest, 0100644, oid, 1,
+				     &contents, &size))
+			contents = read_object_file(oid, &type, &size);
+		if (!contents)
+			die("could not convert '%s' %s", oid_to_hex(oid), rest);
+	} else
+		BUG("invalid cmdmode: %c", cmdmode);
+	write_or_die(1, contents, size);
+	free(contents);
+}
diff --git a/ref-filter.h b/ref-filter.h
index fc61457d4d660..3422f39e64b5b 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -157,4 +157,7 @@ struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
 				      const struct object_id *oid);
 
+void print_object_or_die(struct expand_data *data, int cmdmode,
+			 int buffered, const char *rest);
+
 #endif /*  REF_FILTER_H  */

--
https://github.com/git/git/pull/568
