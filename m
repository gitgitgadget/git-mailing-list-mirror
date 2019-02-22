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
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD3820248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBVQF4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:05:56 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:49312
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727249AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=2+kM/udfUYvphRhw5F6t7IYqjBoZ5loOdHYwugsK63c=;
        b=HL4mQEUZVkeXNtRGaY1aiiWkNZeSVZ/swl3Ithk/rNe+h0O/ZB2ioeYa/5YILt6p
        AiWcFS+ID8ihraQ6c5wZM/yWqzIfaKbLMP+1wsxQ0DbJBqpjRiezJLslYDS3TgKhDwk
        R1uDkyKd1lRejsdr85uVSbjMSL8eu+Rd43nesPNY=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a66-0b8bf78d-6879-41da-b5e6-de6e7edbe71a-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 13/20] cat-file: rewrite print_object_or_die
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next commit I will move function print_object_or_die
to ref-filter, and I decided to rewrite it a little so that it
becomes much more flatten and a little bit shorter.
I also changed input parameters, it allows me to move it
to ref-filter, ref-filter knows nothing about batch_options.

The logic of the function remains the same.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 72 +++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index a4e56762f9e56..2066ff1e697e4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -226,50 +226,17 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *data)
 	return end - start + 1;
 }
 
-static void print_object_or_die(struct batch_options *opt, struct expand_data *data)
+static void print_object_or_die(struct expand_data *data, int cmdmode,
+				int buffered, const char *rest)
 {
 	const struct object_id *oid = &data->oid;
+	unsigned long size;
+	char *contents;
 
 	assert(data->info.typep);
 
-	if (data->type == OBJ_BLOB) {
-		if (opt->buffer_output)
-			fflush(stdout);
-		if (opt->cmdmode) {
-			char *contents;
-			unsigned long size;
-
-			if (!rest)
-				die("missing path for '%s'", oid_to_hex(oid));
-
-			if (opt->cmdmode == 'w') {
-				if (filter_object(rest, 0100644, oid,
-						  &contents, &size))
-					die("could not convert '%s' %s",
-					    oid_to_hex(oid), rest);
-			} else if (opt->cmdmode == 'c') {
-				enum object_type type;
-				if (!textconv_object(the_repository,
-						     rest, 0100644, oid,
-						     1, &contents, &size))
-					contents = read_object_file(oid,
-								    &type,
-								    &size);
-				if (!contents)
-					die("could not convert '%s' %s",
-					    oid_to_hex(oid), rest);
-			} else
-				BUG("invalid cmdmode: %c", opt->cmdmode);
-			write_or_die(1, contents, size);
-			free(contents);
-		} else if (stream_blob_to_fd(1, oid, NULL, 0))
-			die("unable to stream %s to stdout", oid_to_hex(oid));
-	}
-	else {
+	if (data->type != OBJ_BLOB) {
 		enum object_type type;
-		unsigned long size;
-		void *contents;
-
 		contents = read_object_file(oid, &type, &size);
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
@@ -280,7 +247,34 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 
 		write_or_die(1, contents, size);
 		free(contents);
+		return;
+	}
+
+	if (buffered)
+		fflush(stdout);
+	if (!cmdmode) {
+		if (stream_blob_to_fd(1, oid, NULL, 0))
+			die("unable to stream %s to stdout", oid_to_hex(oid));
+		return;
 	}
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
 }
 
 static void batch_object_write(const char *obj_name,
@@ -303,7 +297,7 @@ static void batch_object_write(const char *obj_name,
 	write_or_die(1, scratch->buf, scratch->len);
 
 	if (opt->print_contents) {
-		print_object_or_die(opt, data);
+		print_object_or_die(data, opt->cmdmode, opt->buffer_output, rest);
 		write_or_die(1, "\n", 1);
 	}
 }

--
https://github.com/git/git/pull/568
