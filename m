Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA25207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755098AbdEFWNN (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:13:13 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37652 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754618AbdEFWLs (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2D913280D7;
        Sat,  6 May 2017 22:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108678;
        bh=4Aah0QPZnN3sMvpWAVWvYLoUrYEdAmoP/LF2fg9FgwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JR8ptHAQzyZtbQjBrlTbsJ3xflud3wg1FqdNYfXKSNzK1zmJHI6VQFQrA3S77wdAK
         mjBfnte7frwK0ei1K1T7vQrP21GhibB44fnygrg6rChnYoFsv7So14E+xwH/rjbIMl
         lHodU/8N+jBgFvBD1pgv/sYNEIaQeQyoznuZuOi7Z3gXSbSPrI2OqluUhqy28HYzPL
         ylEf9VUZxzlMwiJWM7scROlXsm40zuFKin6Nna0G96IrgY23W8IpC5zyLIvrGX+JFI
         kPR41QUHSiaRPM8Yaif2sK1G48ykhYHE18NVIjVxOg5dI15fbi9o/CKq4agGYjhTGW
         wBZ63nrAGc1wNNwlYZImrAynZjPF4E1IPlelsDQmMVRNw0bMxmzVhCNrLLHTo2LPHS
         1FIz22mm+yLKZc3Kmm9caKmNZWG2WOKMXHkCG1H0KmfybB4RoYwXeb4qv3CanpJbBS
         0bNRfgkX/eUY46J73639BEqdGO9rxTP64jcN+kWazRJYU6FQXsw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 44/53] sha1_name: convert internals of peel_onion to object_id
Date:   Sat,  6 May 2017 22:10:29 +0000
Message-Id: <20170506221038.296722-45-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
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
