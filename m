Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41BBC25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 08:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347663AbiHSIzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347888AbiHSIzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 04:55:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B85D2B2C
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 01:54:57 -0700 (PDT)
Received: (qmail 17553 invoked by uid 109); 19 Aug 2022 08:54:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 08:54:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 427 invoked by uid 111); 19 Aug 2022 08:54:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 04:54:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 04:54:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 5/6] reftable: drop unused parameter from reader_seek_linear()
Message-ID: <Yv9P4O3WCrR9f9o2@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reader code passes around a "struct reftable_reader" context
variable. But the seek function doesn't need it; the table iterator we
already get is sufficient.

Signed-off-by: Jeff King <peff@peff.net>
---
One could argue that this is a method of a reftable_reader following the
usual C object-oriented naming conventions, and thus should retain its
first parameter, even if it isn't directly used.

In that case, we can annotate this as unused (once we have the ability
to do so, which will be a separate series). I have a mild preference for
removing it (hence this patch), since I think that makes the code more
clear. I suppose one could also argue that it should be a method of the
table_iter: table_iter_seek_linear() or something. I don't think it
matters much, and my ulterior motive is appeasing -Wunused-parameters.

 reftable/reader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 54b4025105..b4db23ce18 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -443,7 +443,7 @@ static int reader_start(struct reftable_reader *r, struct table_iter *ti,
 	return reader_table_iter_at(r, ti, off, typ);
 }
 
-static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
+static int reader_seek_linear(struct table_iter *ti,
 			      struct reftable_record *want)
 {
 	struct reftable_record rec =
@@ -510,7 +510,7 @@ static int reader_seek_indexed(struct reftable_reader *r,
 	if (err < 0)
 		goto done;
 
-	err = reader_seek_linear(r, &index_iter, &want_index);
+	err = reader_seek_linear(&index_iter, &want_index);
 	while (1) {
 		err = table_iter_next(&index_iter, &index_result);
 		table_iter_block_done(&index_iter);
@@ -570,7 +570,7 @@ static int reader_seek_internal(struct reftable_reader *r,
 	err = reader_start(r, &ti, reftable_record_type(rec), 0);
 	if (err < 0)
 		return err;
-	err = reader_seek_linear(r, &ti, rec);
+	err = reader_seek_linear(&ti, rec);
 	if (err < 0)
 		return err;
 	else {
-- 
2.37.2.928.g0821088f4a

