Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6441D1F744
	for <e@80x24.org>; Thu, 30 Jun 2016 09:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbcF3JKa (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:10:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:38269 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751547AbcF3JK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:10:28 -0400
Received: (qmail 31642 invoked by uid 102); 30 Jun 2016 09:09:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:09:31 -0400
Received: (qmail 6669 invoked by uid 107); 30 Jun 2016 09:09:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:09:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 05:09:26 -0400
Date:	Thu, 30 Jun 2016 05:09:26 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 5/5] archive-tar: drop return value
Message-ID: <20160630090926.GE17463@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160630090614.GA16725@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We never do any error checks, and so never return anything
but "0". Let's just drop this to simplify the code.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index d671bc3..7ea4e90 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -319,13 +319,12 @@ static int write_tar_entry(struct archiver_args *args,
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
@@ -337,7 +336,7 @@ static int write_global_extended_header(struct archiver_args *args)
 	}
 
 	if (!ext_header.len)
-		return 0;
+		return;
 
 	memset(&header, 0, sizeof(header));
 	*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
@@ -347,7 +346,6 @@ static int write_global_extended_header(struct archiver_args *args)
 	write_blocked(&header, sizeof(header));
 	write_blocked(ext_header.buf, ext_header.len);
 	strbuf_release(&ext_header);
-	return err;
 }
 
 static struct archiver **tar_filters;
@@ -423,9 +421,8 @@ static int write_tar_archive(const struct archiver *ar,
 {
 	int err = 0;
 
-	err = write_global_extended_header(args);
-	if (!err)
-		err = write_archive_entries(args, write_tar_entry);
+	write_global_extended_header(args);
+	err = write_archive_entries(args, write_tar_entry);
 	if (!err)
 		write_trailer();
 	return err;
-- 
2.9.0.317.g65b4e7c
