Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93413207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbdEFWLv (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:11:51 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37758 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754211AbdEFWLO (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C130F280BD;
        Sat,  6 May 2017 22:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108669;
        bh=4bL2u7h1sHWuy158gFBw/8/Ug870OwpdQz4sX1gWclQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAat10kHSuokwQrno1nr7YLJKqz/omc5CcHft+cmAIoMaJO+iw65OTQw2FVLmPE4i
         QAKN0JEVKAdcDarKUIExRttivZuA87AJaC2+mo+eBC0D9cdVfjAUkWb55oZrDcXtoX
         JL0Ytqvh6pUeUoPC6aY1EDyUV9TeIKsvNYxnxqzJc7+M719jnz5BWg3MD1sOtZEJ1X
         XOeqh0dpdLoYcCghG+YrrGfVpV69O8SgBonlSdv82spa1BW8Ro2KmJhVIJ+zXZh/Fs
         3gVrPE4i6WoaXi+GJaptzsKS6EyL0RMH+5ldADoVb8ZFfi6tIwECJsTy1LvKGDgmyl
         UA4U8yK8NdcQlh1tCcnzMi/QysNnv7bonspa5dSgaBHZwUWdTq8RO347JhBaZg2C53
         54K28aPphPt1d01fqnd8RPVYKDciwyyua1VzZhBWV9+t7gvK0TVdOPkQiOAKRaA0Yi
         6eWLmtNeUnJb0qiaLsMbQL6Qo/7oKIb2ph/LC4musDEmvRqb304
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 16/53] builtin/verify-commit: convert to struct object_id
Date:   Sat,  6 May 2017 22:10:01 +0000
Message-Id: <20170506221038.296722-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
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
