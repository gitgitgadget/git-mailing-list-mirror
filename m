Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE6DC2D0FB
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC62B20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XUjmdqnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbgEMAzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38104 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731837AbgEMAyr (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4E66F60D07;
        Wed, 13 May 2020 00:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331285;
        bh=5OqbgbgT9Ub0EVedjs2/QCeU8Qm807ZRLrM0Pa/VUQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XUjmdqnj+eXCYwXOxxtAk5gcYVOaxdr/0lo3Bi63PpIUtKwV8JBHcfZkOASGj8ZUj
         3NBy6WkfXjDWGO3XOyozmLPlv/UGpY7Xw900C0cp5N39kTR8NFoKFJRL4ZLOjzDUBf
         5l+Jfp6R3Kc8kr7nTKSyn33FF38CGRfvqPN1thLhZQdQnFT1TlmurFowvEn/MzY96b
         iP5ztLFyFUABrpos6u2/mRnlxyANELvlQuZjxUeE2oD+Z//EMw0V4mclHjYWLpDIuG
         V0HCaYTYUl3u/2WdEjIfjEpvDBvKETyP4otqRh8t2yHgU6SHZLZzqcFxmradZ398Li
         1hs/vyAzX/bEA1/YcBw6pTiEjRqFj0gZLs3ZFrpCK0Y+I4nzQbo/Z+aGUr6dNYEkjI
         1OQOGUw9JCR4GbYyaWRj8l1wkVpcwJzhHAggpYBqUpxiDG7vIa2Qy8BBgm9m9ebvLJ
         Sfn2pC6Yd7+u19pIgqogK11UV0x/e4Ced1KUplTjMfo77Yby+Bi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 18/44] remote-curl: implement object-format extensions
Date:   Wed, 13 May 2020 00:53:58 +0000
Message-Id: <20200513005424.81369-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
