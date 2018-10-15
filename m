Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07FF1F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeJOHo4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:44:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50512 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbeJOHo4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:44:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4BE8D61B74;
        Mon, 15 Oct 2018 00:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561729;
        bh=G7YCiFx3CVzUn72qzeM+hbuk4BfEMhWEmAXqLhoCw5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=g7ohlF6ZFCumgpZnxolurKjtOd4BcksguFzQ/DaNhfHR2kP4qRfEJ275Wk8nzZpdk
         GKtaaxPTjFanXdGDWucF4CJcqOM7i3Zs2AcFiZn1XGxkSgbOfl64h9HkPIsNkP5rgp
         bWw+MgvVN/w+P57UA8zk3JwYqIx1CJLVOULxr6RSN+rCiZKz7Fk70scQkFMSF2+YFs
         HLBrmkClHcbWS6XeYDYssflaqeAwrziJqNn/l5XRrBXKw6iFTFB0Idx01vnDpFlqHF
         PmAqp4GWYzbimJt238ct6dQkYPCngafW/fUPVLGn5kN3TjupbZZNQhJaE3yxF6vSd7
         0VEHGEiTXd7VeFLG/KLMMWLvReYUwyENcnc1vxq+Ol/GxAHfM1sBBeIZsCQ+i493TD
         SjTLDBnyAcKioZIGp3sF+dB5TrliwdKsn3wYnh2bzJO7hXSgUaaRokhxWRXstUqxHX
         D7pZPKI58KL1W6CzMpIGLPfLd3iLxVvsoGJI7sQ7UJ+hxFJjjza
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 01/15] object_id.cocci: match only expressions of type 'struct object_id'
Date:   Mon, 15 Oct 2018 00:01:48 +0000
Message-Id: <20181015000202.951965-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

Most of our semantic patches in 'contrib/coccinelle/object_id.cocci'
turn calls of SHA1-specific functions into calls of their
corresponding object_id counterparts, e.g. sha1_to_hex() to
oid_to_hex().  These semantic patches look something like this:

  @@
  expression E1;
  @@
  - sha1_to_hex(E1.hash)
  + oid_to_hex(&E1)

and match the access to the 'hash' field in any data type, not only in
'struct object_id', and, consquently, can produce wrong
transformations.

Case in point is the recent hash function transition patch "rerere:
convert to use the_hash_algo" [1], which, among other things, renamed
'struct rerere_dir's 'sha1' field to 'hash', and then 'make
coccicheck' started to suggest the following wrong transformations for
'rerere.c' [2]:

  -    return sha1_to_hex(id->collection->hash);
  +    return oid_to_hex(id->collection);

and

  -    DIR *dir = opendir(git_path("rr-cache/%s", sha1_to_hex(rr_dir->hash)));
  +    DIR *dir = opendir(git_path("rr-cache/%s", oid_to_hex(rr_dir)));

Avoid such wrong transformations by tightening semantic patches in
'object_id.cocci' to match only type of or pointers to 'struct
object_id'.

[1] https://public-inbox.org/git/20181008215701.779099-15-sandals@crustytoothpaste.net/
[2] https://travis-ci.org/git/git/jobs/440463476#L580

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 contrib/coccinelle/object_id.cocci | 117 ++++++++++++++++-------------
 1 file changed, 63 insertions(+), 54 deletions(-)

diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index d8bdb48712..6a7cf3e02d 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -1,119 +1,127 @@
 @@
-expression E1;
+struct object_id OID;
 @@
-- is_null_sha1(E1.hash)
-+ is_null_oid(&E1)
+- is_null_sha1(OID.hash)
++ is_null_oid(&OID)
 
 @@
-expression E1;
+struct object_id *OIDPTR;
 @@
-- is_null_sha1(E1->hash)
-+ is_null_oid(E1)
+- is_null_sha1(OIDPTR->hash)
++ is_null_oid(OIDPTR)
 
 @@
-expression E1;
+struct object_id OID;
 @@
-- sha1_to_hex(E1.hash)
-+ oid_to_hex(&E1)
+- sha1_to_hex(OID.hash)
++ oid_to_hex(&OID)
 
 @@
 identifier f != oid_to_hex;
-expression E1;
+struct object_id *OIDPTR;
 @@
   f(...) {<...
-- sha1_to_hex(E1->hash)
-+ oid_to_hex(E1)
+- sha1_to_hex(OIDPTR->hash)
++ oid_to_hex(OIDPTR)
   ...>}
 
 @@
-expression E1, E2;
+expression E;
+struct object_id OID;
 @@
-- sha1_to_hex_r(E1, E2.hash)
-+ oid_to_hex_r(E1, &E2)
+- sha1_to_hex_r(E, OID.hash)
++ oid_to_hex_r(E, &OID)
 
 @@
 identifier f != oid_to_hex_r;
-expression E1, E2;
+expression E;
+struct object_id *OIDPTR;
 @@
    f(...) {<...
-- sha1_to_hex_r(E1, E2->hash)
-+ oid_to_hex_r(E1, E2)
+- sha1_to_hex_r(E, OIDPTR->hash)
++ oid_to_hex_r(E, OIDPTR)
   ...>}
 
 @@
-expression E1;
+struct object_id OID;
 @@
-- hashclr(E1.hash)
-+ oidclr(&E1)
+- hashclr(OID.hash)
++ oidclr(&OID)
 
 @@
 identifier f != oidclr;
-expression E1;
+struct object_id *OIDPTR;
 @@
   f(...) {<...
-- hashclr(E1->hash)
-+ oidclr(E1)
+- hashclr(OIDPTR->hash)
++ oidclr(OIDPTR)
   ...>}
 
 @@
-expression E1, E2;
+struct object_id OID1, OID2;
 @@
-- hashcmp(E1.hash, E2.hash)
-+ oidcmp(&E1, &E2)
+- hashcmp(OID1.hash, OID2.hash)
++ oidcmp(&OID1, &OID2)
 
 @@
 identifier f != oidcmp;
-expression E1, E2;
+struct object_id *OIDPTR1, OIDPTR2;
 @@
   f(...) {<...
-- hashcmp(E1->hash, E2->hash)
-+ oidcmp(E1, E2)
+- hashcmp(OIDPTR1->hash, OIDPTR2->hash)
++ oidcmp(OIDPTR1, OIDPTR2)
   ...>}
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR;
+struct object_id OID;
 @@
-- hashcmp(E1->hash, E2.hash)
-+ oidcmp(E1, &E2)
+- hashcmp(OIDPTR->hash, OID.hash)
++ oidcmp(OIDPTR, &OID)
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR;
+struct object_id OID;
 @@
-- hashcmp(E1.hash, E2->hash)
-+ oidcmp(&E1, E2)
+- hashcmp(OID.hash, OIDPTR->hash)
++ oidcmp(&OID, OIDPTR)
 
 @@
-expression E1, E2;
+struct object_id OID1, OID2;
 @@
-- hashcpy(E1.hash, E2.hash)
-+ oidcpy(&E1, &E2)
+- hashcpy(OID1.hash, OID2.hash)
++ oidcpy(&OID1, &OID2)
 
 @@
 identifier f != oidcpy;
-expression E1, E2;
+struct object_id *OIDPTR1;
+struct object_id *OIDPTR2;
 @@
   f(...) {<...
-- hashcpy(E1->hash, E2->hash)
-+ oidcpy(E1, E2)
+- hashcpy(OIDPTR1->hash, OIDPTR2->hash)
++ oidcpy(OIDPTR1, OIDPTR2)
   ...>}
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR;
+struct object_id OID;
 @@
-- hashcpy(E1->hash, E2.hash)
-+ oidcpy(E1, &E2)
+- hashcpy(OIDPTR->hash, OID.hash)
++ oidcpy(OIDPTR, &OID)
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR;
+struct object_id OID;
 @@
-- hashcpy(E1.hash, E2->hash)
-+ oidcpy(&E1, E2)
+- hashcpy(OID.hash, OIDPTR->hash)
++ oidcpy(&OID, OIDPTR)
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR1;
+struct object_id *OIDPTR2;
 @@
-- oidcmp(E1, E2) == 0
-+ oideq(E1, E2)
+- oidcmp(OIDPTR1, OIDPTR2) == 0
++ oideq(OIDPTR1, OIDPTR2)
 
 @@
 identifier f != hasheq;
@@ -125,10 +133,11 @@ expression E1, E2;
   ...>}
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR1;
+struct object_id *OIDPTR2;
 @@
-- oidcmp(E1, E2) != 0
-+ !oideq(E1, E2)
+- oidcmp(OIDPTR1, OIDPTR2) != 0
++ !oideq(OIDPTR1, OIDPTR2)
 
 @@
 identifier f != hasheq;
