Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2621F829
	for <e@80x24.org>; Mon,  1 May 2017 02:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642404AbdEACc5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:57 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36058 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999559AbdEACbb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 59DCE280DB;
        Mon,  1 May 2017 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605815;
        bh=4Aah0QPZnN3sMvpWAVWvYLoUrYEdAmoP/LF2fg9FgwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xYIFlxFeSGL8WtN0GpRmFgAAURAEwj1S0Zn7v+uFoBYQ8Dv3KirNy2V2Dt+Yo4TN2
         +mVVVk36W/j7PWh5Q9x/ilQq05ac5Z4LCQdQuo3jXN4rzcy6Uwj5in8AuZeLD6Ntw5
         ggv3AuIXPr64Au61xJX4uvQ+srOrdfjtYYg3b00JeEnZFGa+XwAKxsYF6eyrNkn140
         d0BjZ0Lo2NyrMWDcVQ6Kticj3vtHGV0b7w+QZDIdcJD3dVezBWhJp8uyh9F8OPmb8g
         xqJQSuWMxeiAFxUXj25JaguDEbnqFnIXpRxVovxB4s8AgWAo3iyBGFj90nNo1NsRPg
         2DHMIN1+roHalEh7w1D0yUyL8oNy1rrvFYzv1zAMuSF6VCi/4nDPwu90HfqkXciAn1
         GEZHNLJdWpCK1dkezWnnKo/YYdukUjahk38yBi1VwdRF8CHgBkJlqXM2RG90oaJxNh
         wwsAkzHxFd/A/SXkZdJ6s8EltQlS2fh0CgQVZ5GJgGJCtnieqrL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 44/53] sha1_name: convert internals of peel_onion to object_id
Date:   Mon,  1 May 2017 02:29:37 +0000
Message-Id: <20170501022946.258735-45-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_name.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index b7e09ac13..72e72ab9a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -798,7 +798,7 @@ struct object *peel_to_type(const char *name, int namelen,
 static int peel_onion(const char *name, int len, unsigned char *sha1,
 		      unsigned lookup_flags)
 {
-	unsigned char outer[20];
+	struct object_id outer;
 	const char *sp;
 	unsigned int expected_type = 0;
 	struct object *o;
@@ -846,10 +846,10 @@ static int peel_onion(const char *name, int len, unsigned char *sha1,
 	else if (expected_type == OBJ_TREE)
 		lookup_flags |= GET_SHA1_TREEISH;
 
-	if (get_sha1_1(name, sp - name - 2, outer, lookup_flags))
+	if (get_sha1_1(name, sp - name - 2, outer.hash, lookup_flags))
 		return -1;
 
-	o = parse_object(outer);
+	o = parse_object(outer.hash);
 	if (!o)
 		return -1;
 	if (!expected_type) {
