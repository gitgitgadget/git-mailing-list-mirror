Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81160C433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622DC2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EEKNgyot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbgEYUAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38722 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390436AbgEYT75 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C263960D12;
        Mon, 25 May 2020 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436796;
        bh=xz69Nj1npcQo0xs5mic9Nu0mlG+XkphPAs5sMsgd0Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=EEKNgyotm5WVLyYfrS6iUmn+6ofpRgMEPBxVZZX46X2R4eCp9a/kSmAp41j+vx+yF
         BImpH72e0c4Ux9zxLxWIvPJukBi8aNTEsFMVnSuvnILMO9CQRzsbgEi6VvR5YH3Xa5
         XMaqoaCR7uM28DHyQA7KZNX45O2HBcaNao5UfTdzQArwa0Wo9Bv0TF2NiNHpA+2WRb
         3WIjz0xWmso6OBwJ4RGUO6WPgw+rBGFGmC1Nb9BvTNTanHSHKk+UoSMlt5Nn10WzPU
         /Fj/Mw0Y9OEeIf8ePxDvnttTvFiWyy+ameaNpRIIyr15D9O48+yCW7jQarGTHSfW4x
         nWWvKQX9TUGoZ5+0ZH9xI+JDGk+KgZGLsTLEzC/yf5Vki220angAT+4DKAp9X6yKSt
         g+8SERFcW40Dw1xvE45DTrQQMJLUobjdO1gWIvuxJqKEOP60uf15ZexjJ2GTjKNub4
         JvfIUsak8m56zu6lxDDmvzS0vzIkI0dNjX7UIyIDpj6AQShUJdf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 30/44] connect: parse v2 refs with correct hash algorithm
Date:   Mon, 25 May 2020 19:59:16 +0000
Message-Id: <20200525195930.309665-31-sandals@crustytoothpaste.net>
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

When using protocol v2, we need to know what hash algorithm is used by
the remote end.  See if the server has sent us an object-format
capability, and if so, use it to determine the hash algorithm in use and
set that value in the packet reader.  Parse the refs using this
algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index 1d05bc56ed..66650ff2d3 100644
--- a/connect.c
+++ b/connect.c
@@ -283,7 +283,7 @@ static int process_ref(const struct packet_reader *reader, int len,
 		die(_("protocol error: unexpected capabilities^{}"));
 	} else if (check_ref(name, flags)) {
 		struct ref *ref = alloc_ref(name);
-		memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
+		oidcpy(&ref->old_oid, &old_oid);
 		**list = ref;
 		*list = &ref->next;
 	}
@@ -395,7 +395,7 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 		goto out;
 	}
 
-	if (parse_oid_hex(line_sections.items[i++].string, &old_oid, &end) ||
+	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
 	    *end) {
 		ret = 0;
 		goto out;
@@ -403,7 +403,7 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 
 	ref = alloc_ref(line_sections.items[i++].string);
 
-	oidcpy(&ref->old_oid, &old_oid);
+	memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
 	**list = ref;
 	*list = &ref->next;
 
@@ -416,7 +416,8 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 			struct object_id peeled_oid;
 			char *peeled_name;
 			struct ref *peeled;
-			if (parse_oid_hex(arg, &peeled_oid, &end) || *end) {
+			if (parse_oid_hex_algop(arg, &peeled_oid, &end,
+						reader->hash_algo) || *end) {
 				ret = 0;
 				goto out;
 			}
@@ -424,7 +425,8 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 			peeled_name = xstrfmt("%s^{}", ref->name);
 			peeled = alloc_ref(peeled_name);
 
-			oidcpy(&peeled->old_oid, &peeled_oid);
+			memcpy(peeled->old_oid.hash, peeled_oid.hash,
+			       reader->hash_algo->rawsz);
 			**list = peeled;
 			*list = &peeled->next;
 
@@ -443,6 +445,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     const struct string_list *server_options)
 {
 	int i;
+	const char *hash_name;
 	*list = NULL;
 
 	if (server_supports_v2("ls-refs", 1))
@@ -451,6 +454,14 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (server_supports_v2("agent", 0))
 		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
 
+	if (server_feature_v2("object-format", &hash_name)) {
+		int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo == GIT_HASH_UNKNOWN)
+			die(_("unknown object format '%s' specified by server"), hash_name);
+		reader->hash_algo = &hash_algos[hash_algo];
+		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
+	}
+
 	if (server_options && server_options->nr &&
 	    server_supports_v2("server-option", 1))
 		for (i = 0; i < server_options->nr; i++)
