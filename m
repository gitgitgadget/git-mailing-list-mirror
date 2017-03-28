Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383381FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbdC1Tp2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:45:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:53148 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752582AbdC1Tp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:45:28 -0400
Received: (qmail 11712 invoked by uid 109); 28 Mar 2017 19:45:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:45:27 +0000
Received: (qmail 31908 invoked by uid 111); 28 Mar 2017 19:45:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:45:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:45:25 -0400
Date:   Tue, 28 Mar 2017 15:45:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/18] do not check odb_mkstemp return value for errors
Message-ID: <20170328194524.wmj6tg756fze3ab7@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The odb_mkstemp function does not return an error; it dies
on failure instead. But many of its callers compare the
resulting descriptor against -1 and die themselves.

Mostly this is just pointless, but it does raise a question
when looking at the callers: if they show the results of the
"template" buffer after a failure, what's in it? The answer
is: it doesn't matter, because it cannot happen.

So let's make that clear by removing the bogus error checks.
In bitmap_writer_finish(), we can drop the error-handling
code entirely. In the other two cases, it's shared with the
open() in another code path; we can just move the
error-check next to that open() call.

And while we're at it, let's flesh out the function's
docstring a bit to make the error behavior clear.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 7 ++++---
 cache.h              | 5 ++++-
 pack-bitmap-write.c  | 2 --
 pack-write.c         | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 88d205f85..49e7175d9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -311,10 +311,11 @@ static const char *open_pack_file(const char *pack_name)
 			output_fd = odb_mkstemp(tmp_file, sizeof(tmp_file),
 						"pack/tmp_pack_XXXXXX");
 			pack_name = xstrdup(tmp_file);
-		} else
+		} else {
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
-		if (output_fd < 0)
-			die_errno(_("unable to create '%s'"), pack_name);
+			if (output_fd < 0)
+				die_errno(_("unable to create '%s'"), pack_name);
+		}
 		nothread_data.pack_fd = output_fd;
 	} else {
 		input_fd = open(pack_name, O_RDONLY);
diff --git a/cache.h b/cache.h
index db4120c23..acad7078d 100644
--- a/cache.h
+++ b/cache.h
@@ -1673,7 +1673,10 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 extern void pack_report(void);
 
 /*
- * Create a temporary file rooted in the object database directory.
+ * Create a temporary file rooted in the object database directory, or
+ * die on failure. The filename is taken from "pattern", which should have the
+ * usual "XXXXXX" trailer, and the resulting filename is written into the
+ * "template" buffer. Returns the open descriptor.
  */
 extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 970559601..44492c346 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -517,8 +517,6 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 
 	int fd = odb_mkstemp(tmp_file, sizeof(tmp_file), "pack/tmp_bitmap_XXXXXX");
 
-	if (fd < 0)
-		die_errno("unable to create '%s'", tmp_file);
 	f = sha1fd(fd, tmp_file);
 
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
diff --git a/pack-write.c b/pack-write.c
index 88bc7f9f7..19cb514ea 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -77,9 +77,9 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		} else {
 			unlink(index_name);
 			fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+			if (fd < 0)
+				die_errno("unable to create '%s'", index_name);
 		}
-		if (fd < 0)
-			die_errno("unable to create '%s'", index_name);
 		f = sha1fd(fd, index_name);
 	}
 
-- 
2.12.2.845.g55fcf8b10

