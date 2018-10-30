Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B481F453
	for <e@80x24.org>; Tue, 30 Oct 2018 23:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeJaIp6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 04:45:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:33574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726366AbeJaIp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 04:45:57 -0400
Received: (qmail 29127 invoked by uid 109); 30 Oct 2018 23:23:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Oct 2018 23:23:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5436 invoked by uid 111); 30 Oct 2018 23:22:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Oct 2018 19:22:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2018 19:23:38 -0400
Date:   Tue, 30 Oct 2018 19:23:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 3/3] cat-file: handle streaming failures consistently
Message-ID: <20181030232337.GC32038@sigill.intra.peff.net>
References: <20181030231232.GA6141@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181030231232.GA6141@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are three ways to convince cat-file to stream a blob:

  - cat-file -p $blob

  - cat-file blob $blob

  - echo $batch | cat-file --batch

In the first two, we simply exit with the error code of
streaw_blob_to_fd(). That means that an error will cause us
to exit with "-1" (which we try to avoid) without printing
any kind of error message (which is confusing to the user).

Instead, let's match the third case, which calls die() on an
error. Unfortunately we cannot be more specific, as
stream_blob_to_fd() does not tell us whether the problem was
on reading (e.g., a corrupt object) or on writing (e.g.,
ENOSPC). That might be an opportunity for future work, but
for now we will at least exit with a sane message and exit
code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8d97c84725..0d403eb77d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -50,6 +50,13 @@ static int filter_object(const char *path, unsigned mode,
 	return 0;
 }
 
+static int stream_blob(const struct object_id *oid)
+{
+	if (stream_blob_to_fd(1, oid, NULL, 0))
+		die("unable to stream %s to stdout", oid_to_hex(oid));
+	return 0;
+}
+
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			int unknown_type)
 {
@@ -132,7 +139,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		}
 
 		if (type == OBJ_BLOB)
-			return stream_blob_to_fd(1, &oid, NULL, 0);
+			return stream_blob(&oid);
 		buf = read_object_file(&oid, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
@@ -155,7 +162,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 				oidcpy(&blob_oid, &oid);
 
 			if (oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB)
-				return stream_blob_to_fd(1, &blob_oid, NULL, 0);
+				return stream_blob(&blob_oid);
 			/*
 			 * we attempted to dereference a tag to a blob
 			 * and failed; there may be new dereference
@@ -319,8 +326,9 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 				BUG("invalid cmdmode: %c", opt->cmdmode);
 			batch_write(opt, contents, size);
 			free(contents);
-		} else if (stream_blob_to_fd(1, oid, NULL, 0) < 0)
-			die("unable to stream %s to stdout", oid_to_hex(oid));
+		} else {
+			stream_blob(oid);
+		}
 	}
 	else {
 		enum object_type type;
-- 
2.19.1.1235.g6b27db57c2
