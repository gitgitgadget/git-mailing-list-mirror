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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BF6D20248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfBVQGC (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:06:02 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:35956
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727209AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=wLBlMjFTK0KLhr6l5xcKZJalFahfGw5BHhzD1SNAWW8=;
        b=kd98fYtT16DxdVJAO9iUcAGJBE8hQpntZraJMzXZK5KggxjuKLGeVBb8NHr+DztD
        E4gwIVv2jhl5bpLKWL+HkpSYjlNORMfewRAB6FNYK4l6j1Zn6P0mTxabdBpv/K/AflQ
        KbN3wCxoFMs3QyRyzjScjxWC8bZylGR0iTp+MZFw=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a5c-cbf0d726-b7dd-4da8-9cdb-5cc78dc449e9-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 10/20] cat-file: inline stream_blob
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

Inline function stream_blob, it simplifies further
migrating process.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index edf45f078b919..cd9a4447c8da9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -56,13 +56,6 @@ static int filter_object(const char *path, unsigned mode,
 	return 0;
 }
 
-static int stream_blob(const struct object_id *oid)
-{
-	if (stream_blob_to_fd(1, oid, NULL, 0))
-		die("unable to stream %s to stdout", oid_to_hex(oid));
-	return 0;
-}
-
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			int unknown_type)
 {
@@ -145,8 +138,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			return cmd_ls_tree(2, ls_args, NULL);
 		}
 
-		if (type == OBJ_BLOB)
-			return stream_blob(&oid);
+		if (type == OBJ_BLOB) {
+			if (stream_blob_to_fd(1, &oid, NULL, 0))
+				die("unable to stream %s to stdout", oid_to_hex(&oid));
+			return 0;
+		}
 		buf = read_object_file(&oid, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
@@ -168,8 +164,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			} else
 				oidcpy(&blob_oid, &oid);
 
-			if (oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB)
-				return stream_blob(&blob_oid);
+			if (oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB) {
+				if (stream_blob_to_fd(1, &blob_oid, NULL, 0))
+					die("unable to stream %s to stdout", oid_to_hex(&blob_oid));
+				return 0;
+			}
 			/*
 			 * we attempted to dereference a tag to a blob
 			 * and failed; there may be new dereference
@@ -295,9 +294,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 				BUG("invalid cmdmode: %c", opt->cmdmode);
 			batch_write(opt, contents, size);
 			free(contents);
-		} else {
-			stream_blob(oid);
-		}
+		} else if (stream_blob_to_fd(1, oid, NULL, 0))
+			die("unable to stream %s to stdout", oid_to_hex(oid));
 	}
 	else {
 		enum object_type type;

--
https://github.com/git/git/pull/568
