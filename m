Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C571FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999467AbdEACa7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:30:59 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35660 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642336AbdEACaR (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C98E2280BF;
        Mon,  1 May 2017 02:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605806;
        bh=4bL2u7h1sHWuy158gFBw/8/Ug870OwpdQz4sX1gWclQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDxi4DkMEAvQIkFI+cFfNUtVM6GFsmRemLe25n8qnNRBrEIeYwvigbISj3bTj4xwc
         etjAwUVTe3AypYWjDmqipNCuJrtEJh0qoom7HW03xoQ0AtFncXryeaqA8dOeeOwvfh
         3IaWh+fCX4rQvtXv8pIneqBAnOM5bLSgk3151ERrKBIp9bVVhLz+Bz6u8KPuDm9Qy2
         ED9jvG8ovv5nAq3Pu8KrKtlIN65tj+2CzjsgC/aNPAI8ocPXu2NnEs/oJJSCGjHVMd
         RmYyAXwa46l+cZsLPVJWEZjt78JFt2J6z+esLX5LawEVzaWzYW0h4MpnBuXpXuvL69
         d3qPKgSTwnoZ0er96sQMPxFxOv0QtAEohYX5X9ZZO1Y67QI4YjGOBl+rJ7wH68ZYA8
         6YUZLiOQ2WwhhZq3Oef+rXxTqQ8gIkNKB0Z2xRbjyX0v6qM1wrppzrhlBoeu9cCwnp
         frpRLsEWpjtgTlAxn1aVbqrPQwRctNg8lwlqXtA1XyiRGYvsKm9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 16/53] builtin/verify-commit: convert to struct object_id
Date:   Mon,  1 May 2017 02:29:09 +0000
Message-Id: <20170501022946.258735-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a prerequisite to convert to lookup_commit, which we will
convert later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/verify-commit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 38bedf8f9..a5db1c427 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -18,14 +18,14 @@ static const char * const verify_commit_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned long size, unsigned flags)
+static int run_gpg_verify(const struct object_id *oid, const char *buf, unsigned long size, unsigned flags)
 {
 	struct signature_check signature_check;
 	int ret;
 
 	memset(&signature_check, 0, sizeof(signature_check));
 
-	ret = check_commit_signature(lookup_commit(sha1), &signature_check);
+	ret = check_commit_signature(lookup_commit(oid->hash), &signature_check);
 	print_signature_buffer(&signature_check, flags);
 
 	signature_check_clear(&signature_check);
@@ -35,22 +35,22 @@ static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned l
 static int verify_commit(const char *name, unsigned flags)
 {
 	enum object_type type;
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *buf;
 	unsigned long size;
 	int ret;
 
-	if (get_sha1(name, sha1))
+	if (get_oid(name, &oid))
 		return error("commit '%s' not found.", name);
 
-	buf = read_sha1_file(sha1, &type, &size);
+	buf = read_sha1_file(oid.hash, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.", name);
 	if (type != OBJ_COMMIT)
 		return error("%s: cannot verify a non-commit object of type %s.",
 				name, typename(type));
 
-	ret = run_gpg_verify(sha1, buf, size, flags);
+	ret = run_gpg_verify(&oid, buf, size, flags);
 
 	free(buf);
 	return ret;
