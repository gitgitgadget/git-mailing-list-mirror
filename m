Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40937C2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2192D20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tL/0oXLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgEMAzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38118 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731908AbgEMAyw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:52 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0DCA660D0F;
        Wed, 13 May 2020 00:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331291;
        bh=JSgB3nukR2NV7duJV991p0Ltx9V/rSGJxeO51RyxAVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tL/0oXLPk/J5f/m8sroDrv+YddXjo8WDpN6Jc8yVcMuCGHOzuazrj+q/N7Eq9/CUp
         JeJsZV3x6W0A4+afOc7E8LH0yw0Cx6b+pCpzW0xdX9v0DJRyjZPLq5KvHlwW7DVISC
         jdmhFfHC43sRlXeosdYWyS+KuAd86KA8GWuJV1FjVt9c+hPcuDcch9pysMT1RDbIS4
         lxEdq4GDqjJjyOyNG/VgFkTqxye25ru8pV/B7oujwFrB6EiuAlS+gvHFb7h8EoyOTj
         w+0eCCpiioyUx+R4U8f8cktd0BhRP/uhFthVZtBMkJ9LlNGeumGHt44kcq457tYJ8i
         Yerd1z1dBjsfQeRpiV7e2pQSF+ZAlSKF1cSndP+vMk4GJwlMMGSLBk5Edob2nhJQmW
         RIu7sQEyvrazv9CHhXSk0ZG20AkN5kPpg6U5AlowXhgJBtsGpU9diOIJoCqoubKK/W
         WHGYYSvYQPgVhsV7YJsx/xj9yeHkdTlyefYLldC3U69LW2rxH8X
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 31/44] connect: parse v2 refs with correct hash algorithm
Date:   Wed, 13 May 2020 00:54:11 +0000
Message-Id: <20200513005424.81369-32-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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

Note that we use memcpy instead of oidcpy for copying values, since
oidcpy is intentionally limited to the current hash algorithm length,
and the copy will be too short if the server side uses SHA-256 but the
client side has not had a repository set up (and therefore defaults to
SHA-1).

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index bb4bc4ab7f..4e6462e52f 100644
--- a/connect.c
+++ b/connect.c
@@ -394,7 +394,7 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 		goto out;
 	}
 
-	if (parse_oid_hex(line_sections.items[i++].string, &old_oid, &end) ||
+	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
 	    *end) {
 		ret = 0;
 		goto out;
@@ -402,7 +402,7 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 
 	ref = alloc_ref(line_sections.items[i++].string);
 
-	oidcpy(&ref->old_oid, &old_oid);
+	memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
 	**list = ref;
 	*list = &ref->next;
 
@@ -415,7 +415,8 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 			struct object_id peeled_oid;
 			char *peeled_name;
 			struct ref *peeled;
-			if (parse_oid_hex(arg, &peeled_oid, &end) || *end) {
+			if (parse_oid_hex_algop(arg, &peeled_oid, &end,
+						reader->hash_algo) || *end) {
 				ret = 0;
 				goto out;
 			}
@@ -423,7 +424,8 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 			peeled_name = xstrfmt("%s^{}", ref->name);
 			peeled = alloc_ref(peeled_name);
 
-			oidcpy(&peeled->old_oid, &peeled_oid);
+			memcpy(peeled->old_oid.hash, peeled_oid.hash,
+			       reader->hash_algo->rawsz);
 			**list = peeled;
 			*list = &peeled->next;
 
@@ -442,6 +444,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     const struct string_list *server_options)
 {
 	int i;
+	const char *hash_name;
 	*list = NULL;
 
 	if (server_supports_v2("ls-refs", 1))
@@ -450,6 +453,14 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
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
