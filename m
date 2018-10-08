Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 599E81F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJIFLD (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbeJIFLC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BEAD260785;
        Mon,  8 Oct 2018 21:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035833;
        bh=OLPMeu30RZzzRGj1yGvZ4CfO397lXKD+lFWsLUy79Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=p/C3csPNHySYvtOjctJ8/kRV4sg6uHdLPO+4aM8kh3XYufbquoWljivMxtuzt/pWO
         QdBP29d/Qu7R5FgA80isfr6XUgL7cU9n9gLOtyJ6bRtc1pJM0EqfiOlr001VP84eCl
         uEvl135Tr5aSntL7g90f7id2oEHk3G4SLd5DJJ5KdQVYMM2Oc+/MaauzXeKbSxp70E
         lK1t+9P/msmcuQMf0wUxW3O+tY/70I3PuU7Qz+FN9v4UdHwHUtwPbkzLqYz9hsHSMY
         d9MjZnOTSw0FChCJF6ZdQee3kl/438GDVB9qQa8T8dS4JvwOobUFeVUUbStWimyAY6
         ZsnrEpKxQezRrxtHneJ9YHcw9F+ar/6WolZ7d0mfoK94LB4dMgrsYHjTJ4ij6IAN5T
         E7eSi7xZBf9nzNAw978fltESU2PfBKs6kO0YF9o/UzqhSvmbNlJljIx22FjDY+rlHz
         YdMS8v762Mykvn0tycNV4uZsi2ScnteE2DAoe9tnVF8WqobNHU0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/14] packfile: express constants in terms of the_hash_algo
Date:   Mon,  8 Oct 2018 21:56:53 +0000
Message-Id: <20181008215701.779099-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace uses of GIT_SHA1_RAWSZ with references to the_hash_algo to avoid
dependence on a particular hash length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 packfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 841b36182f..17f993b5bf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1121,13 +1121,14 @@ int unpack_object_header(struct packed_git *p,
 void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1)
 {
 	unsigned i;
+	const unsigned hashsz = the_hash_algo->rawsz;
 	for (i = 0; i < p->num_bad_objects; i++)
-		if (hasheq(sha1, p->bad_object_sha1 + GIT_SHA1_RAWSZ * i))
+		if (hasheq(sha1, p->bad_object_sha1 + hashsz * i))
 			return;
 	p->bad_object_sha1 = xrealloc(p->bad_object_sha1,
 				      st_mult(GIT_MAX_RAWSZ,
 					      st_add(p->num_bad_objects, 1)));
-	hashcpy(p->bad_object_sha1 + GIT_SHA1_RAWSZ * p->num_bad_objects, sha1);
+	hashcpy(p->bad_object_sha1 + hashsz * p->num_bad_objects, sha1);
 	p->num_bad_objects++;
 }
 
