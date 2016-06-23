Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448901FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 23:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbcFWXWF (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 19:22:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:59439 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287AbcFWXWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 19:22:04 -0400
Received: (qmail 12331 invoked by uid 102); 23 Jun 2016 23:22:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 19:22:03 -0400
Received: (qmail 15963 invoked by uid 107); 23 Jun 2016 23:22:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 19:22:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 19:21:59 -0400
Date:	Thu, 23 Jun 2016 19:21:59 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH v3 4/4] archive-tar: drop return value
Message-ID: <20160623232158.GD3668@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623231512.GA27683@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We never do any error checks, and so never return anything
but "0". Let's just drop this to simplify the code.

Signed-off-by: Jeff King <peff@peff.net>
---
I wasn't sure if this was perhaps kept as an interface decision, in case
the function grew errors later on. If so, it can still drop the "err"
variable internally. :)

 archive-tar.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 0bb164c..903b74d 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -309,13 +309,12 @@ static int write_tar_entry(struct archiver_args *args,
 	return err;
 }
 
-static int write_global_extended_header(struct archiver_args *args)
+static void write_global_extended_header(struct archiver_args *args)
 {
 	const unsigned char *sha1 = args->commit_sha1;
 	struct strbuf ext_header = STRBUF_INIT;
 	struct ustar_header header;
 	unsigned int mode;
-	int err = 0;
 
 	if (sha1)
 		strbuf_append_ext_header(&ext_header, "comment",
@@ -327,7 +326,7 @@ static int write_global_extended_header(struct archiver_args *args)
 	}
 
 	if (!ext_header.len)
-		return 0;
+		return;
 
 	memset(&header, 0, sizeof(header));
 	*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
@@ -337,7 +336,6 @@ static int write_global_extended_header(struct archiver_args *args)
 	write_blocked(&header, sizeof(header));
 	write_blocked(ext_header.buf, ext_header.len);
 	strbuf_release(&ext_header);
-	return err;
 }
 
 static struct archiver **tar_filters;
@@ -413,7 +411,7 @@ static int write_tar_archive(const struct archiver *ar,
 {
 	int err = 0;
 
-	err = write_global_extended_header(args);
+	write_global_extended_header(args);
 	if (!err)
 		err = write_archive_entries(args, write_tar_entry);
 	if (!err)
-- 
2.9.0.217.g096ca68
