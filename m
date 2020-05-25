Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852A1C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64ACF2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kO1P/QSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390690AbgEYUAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390414AbgEYT7y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9E9FF60D06;
        Mon, 25 May 2020 19:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436790;
        bh=5OqbgbgT9Ub0EVedjs2/QCeU8Qm807ZRLrM0Pa/VUQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kO1P/QSOO48Ovh6+FLiE4yJNsHjLE7SiX8GYkkrqYi9qvatGLPDsEelVvEiFQMkzK
         t1Gu5i+/+5koBHrow11ynL98l8xAsCrEonHF0m+bCRudYLJWc4WTkMSzjc2C/Noopv
         l1wyCRrssDsopuK8TN7S1sjeMYWbzJjrgy/bsAbEXk/1gXzO4A21F3QyZayotBwNwJ
         TuJ2NirmaXL3xD2DDJLD0SrmSVaPAwVl9sgOZXmpWvvZdGC7A48oCfAkAWVZkTSJYz
         i4u228/8x39/C9rdDlbTKui7h/5rLPgROzRa45cfLHHMgNCkgZc5zdevEaE5XcwbWj
         4delEfT0DAdyokM0sFJvcnnWkGV3w15PJVUzqAuJR7nl8ojo7tpYy5vy8tMhrRnYx5
         njnwPdriTRaJ1xsA6s8D94jxiJAOurXQDaXSnMRJJ64Gcm4wUQnOleNihaol1NlCqx
         R+0guUPasURLxUS4nyVjv3SG++7pjpFfFt44mxJNGbqP1dOYEEP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 18/44] remote-curl: implement object-format extensions
Date:   Mon, 25 May 2020 19:59:04 +0000
Message-Id: <20200525195930.309665-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement the object-format extensions that let us determine the hash
algorithm in use when pushing, pulling, and fetching.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1c9aa3d0ab..3ed0dfec1b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -41,7 +41,9 @@ struct options {
 		deepen_relative : 1,
 		from_promisor : 1,
 		no_dependents : 1,
-		atomic : 1;
+		atomic : 1,
+		object_format : 1;
+	const struct git_hash_algo *hash_algo;
 };
 static struct options options;
 static struct string_list cas_options = STRING_LIST_INIT_DUP;
@@ -190,6 +192,16 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "filter")) {
 		options.filter = xstrdup(value);
 		return 0;
+	} else if (!strcmp(name, "object-format")) {
+		int algo;
+		options.object_format = 1;
+		if (strcmp(value, "true")) {
+			algo = hash_algo_by_name(value);
+			if (algo == GIT_HASH_UNKNOWN)
+				die("unknown object format '%s'", value);
+			options.hash_algo = &hash_algos[algo];
+		}
+		return 0;
 	} else {
 		return 1 /* unsupported */;
 	}
@@ -231,6 +243,7 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 	case protocol_v0:
 		get_remote_heads(&reader, &list, for_push ? REF_NORMAL : 0,
 				 NULL, &heads->shallow);
+		options.hash_algo = reader.hash_algo;
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
@@ -509,6 +522,9 @@ static struct ref *get_refs(int for_push)
 static void output_refs(struct ref *refs)
 {
 	struct ref *posn;
+	if (options.object_format && options.hash_algo) {
+		printf(":object-format %s\n", options.hash_algo->name);
+	}
 	for (posn = refs; posn; posn = posn->next) {
 		if (posn->symref)
 			printf("@%s %s\n", posn->symref, posn->name);
@@ -1439,6 +1455,7 @@ int cmd_main(int argc, const char **argv)
 			printf("option\n");
 			printf("push\n");
 			printf("check-connectivity\n");
+			printf("object-format\n");
 			printf("\n");
 			fflush(stdout);
 		} else if (skip_prefix(buf.buf, "stateless-connect ", &arg)) {
