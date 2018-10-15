Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71821F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeJOHpE (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:45:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50574 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbeJOHpD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:45:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CE79F61B81;
        Mon, 15 Oct 2018 00:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561739;
        bh=RlUXsatHq7KX+yJvyOwV+bf7cgYLyKyVsXAd+M4fSBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VYhZo9nrfzqAZO1NDBI3kBpBbDYLxhvBsQvCxyAi5JLU4etSBqZWKukxk52W/tN9O
         RkciD2os/wjrsS3ML+b7gXTIHg42fRZsEle6gZNGkvekzBxN4hyzonGIwGTo2u5wX9
         KkHXcLlB4QwBHp4xh2BoD+tdycOSo7K2NhvG5dKqVDOVggXTQuLivaFiFEBE+cQnLM
         8ZWEmfLyJ3yJacMpCuEl2Iym48Rx2vbNcKCE4g9RmNmNh36aMoVBpR0TBwraOqKu12
         Rk/7KLrrZLgxLVfoGBxTqSytFQQcu0ME3d2tYVPjTFIFQaXAVcBPvlT1sYbeHOTwmD
         UlBY62q9fygILOVTunkqXxKnXbh0FMxS5YmAkz4fnrapeCLtuwO1gsdk1WW5YKl+AE
         +vW6U0VsKdbmpLkEJ3sJ101gEPuiGZeW4NrDTCF9xsxzZPADyHY84P+sWNNjF5ZShQ
         yS6IgccTDJQ6zVcCF9b6JeWRfTGwapX6aLcGg54IdHl4GAY6UCI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 07/15] packfile: express constants in terms of the_hash_algo
Date:   Mon, 15 Oct 2018 00:01:54 +0000
Message-Id: <20181015000202.951965-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace uses of GIT_SHA1_RAWSZ with references to the_hash_algo to avoid
dependence on a particular hash length.

It's likely that in the future, we'll update the pack format to indicate
what hash algorithm it uses, and then this code will change.  However,
at least on an interim basis, make it easier to develop on a pure
SHA-256 Git by using the_hash_algo here.

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
 
