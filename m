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
	by dcvr.yhbt.net (Postfix) with ESMTP id C914620248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfBVQGQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:06:16 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:35514
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727039AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Os6L/s3RhrXJdYF+q+g8N/I/qRtik+YGNfclqaZs9iE=;
        b=FURziE/2qyJ7TqaCilYQTjaNJTdSzWsLZ5ZnTE+57tW5Z9zjhondmwff0J7jSk8A
        JVieY2QBCERSdd+dQBnNNEgRXbFX6bDLx/xQ+EDRxSf+EmpS1CXK0jlU+l1yYJUa9wQ
        hFPJTBPkhy96T9XemwA5KCHFeYwrS62THSN9pR2w=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a63-de2f8b31-3571-4bf8-9663-c8c576c2d5ff-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 12/20] cat-file: remove batch_write function
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct me if I am wrong, but it was not really good idea
to implement batch_write in cmd_cat_file. Maybe it's
a good task for newbies to add flag
(whether we accept batch write or not) to write_or_die?

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 41f333b73d851..a4e56762f9e56 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -226,15 +226,6 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *data)
 	return end - start + 1;
 }
 
-static void batch_write(struct batch_options *opt, const void *data, int len)
-{
-	if (opt->buffer_output) {
-		if (fwrite(data, 1, len, stdout) != len)
-			die_errno("unable to write to stdout");
-	} else
-		write_or_die(1, data, len);
-}
-
 static void print_object_or_die(struct batch_options *opt, struct expand_data *data)
 {
 	const struct object_id *oid = &data->oid;
@@ -269,7 +260,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 					    oid_to_hex(oid), rest);
 			} else
 				BUG("invalid cmdmode: %c", opt->cmdmode);
-			batch_write(opt, contents, size);
+			write_or_die(1, contents, size);
 			free(contents);
 		} else if (stream_blob_to_fd(1, oid, NULL, 0))
 			die("unable to stream %s to stdout", oid_to_hex(oid));
@@ -287,7 +278,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		if (data->info.sizep && size != data->size)
 			die("object %s changed size!?", oid_to_hex(oid));
 
-		batch_write(opt, contents, size);
+		write_or_die(1, contents, size);
 		free(contents);
 	}
 }
@@ -309,11 +300,11 @@ static void batch_object_write(const char *obj_name,
 	strbuf_reset(scratch);
 	strbuf_expand(scratch, opt->format.format, expand_format, data);
 	strbuf_addch(scratch, '\n');
-	batch_write(opt, scratch->buf, scratch->len);
+	write_or_die(1, scratch->buf, scratch->len);
 
 	if (opt->print_contents) {
 		print_object_or_die(opt, data);
-		batch_write(opt, "\n", 1);
+		write_or_die(1, "\n", 1);
 	}
 }
 

--
https://github.com/git/git/pull/568
