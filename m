Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58013C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3110320776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fr9+qBaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404736AbgFSR4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393893AbgFSR4g (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8FF6A60A78;
        Fri, 19 Jun 2020 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589388;
        bh=VEFsq6X+8mMwNvzoUhrFq5r46eaowPx57ncl9Z6sta8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fr9+qBaahR9AgquiHWYyWorOzxaKKZb6QRLjt1MdMqpDUKIhf8G+8fTvvii0JgkPF
         /X5QmrrAGZyGVDdkyefU5E3m4oz22HLmgwsXnSQ43vsYu6uAEhL7CxQotBwRYoVJ1S
         PttPklZrXgX3E695IIK26CWivE5bvkqrmfdaf5QM+waNrrLR+TCwvlhLp3XCvEqFce
         sf133cYxVzY8mrQNkTSqzJhcCE3OzxkrQbHVp9NwyzYV2PGWoA7HLZXmckQwQcSlx8
         QW62tXiS9iDoXlFzEes2KXOfygDnn3j1i3erhKCHzlfxzEbzQTxALZGwaVKR8LCLTW
         aVAKO5+o2Xy2jlsi5wRH8HzqP5yRYkVqUbOM5rYk/fBe66uOfGdwmrdYlKDrDfGGm3
         iadqacM/iod3c9fT44NOMs0GJ/xUGXol5QXhbQt7b3two6gOBUo6k7oSpae4OrHCoP
         StzpR/SxeQSQVtmS4L2O/MmhFs+S+Y+oNsqeADlPjn6geJClEqP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 30/44] connect: parse v2 refs with correct hash algorithm
Date:   Fri, 19 Jun 2020 17:55:47 +0000
Message-Id: <20200619175601.569856-31-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
index 320cc2016d..e6cf2f8dc4 100644
--- a/connect.c
+++ b/connect.c
@@ -284,7 +284,7 @@ static int process_ref(const struct packet_reader *reader, int len,
 		die(_("protocol error: unexpected capabilities^{}"));
 	} else if (check_ref(name, flags)) {
 		struct ref *ref = alloc_ref(name);
-		memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
+		oidcpy(&ref->old_oid, &old_oid);
 		**list = ref;
 		*list = &ref->next;
 	}
@@ -397,7 +397,7 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 		goto out;
 	}
 
-	if (parse_oid_hex(line_sections.items[i++].string, &old_oid, &end) ||
+	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
 	    *end) {
 		ret = 0;
 		goto out;
@@ -405,7 +405,7 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 
 	ref = alloc_ref(line_sections.items[i++].string);
 
-	oidcpy(&ref->old_oid, &old_oid);
+	memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
 	**list = ref;
 	*list = &ref->next;
 
@@ -418,7 +418,8 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 			struct object_id peeled_oid;
 			char *peeled_name;
 			struct ref *peeled;
-			if (parse_oid_hex(arg, &peeled_oid, &end) || *end) {
+			if (parse_oid_hex_algop(arg, &peeled_oid, &end,
+						reader->hash_algo) || *end) {
 				ret = 0;
 				goto out;
 			}
@@ -426,7 +427,8 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 			peeled_name = xstrfmt("%s^{}", ref->name);
 			peeled = alloc_ref(peeled_name);
 
-			oidcpy(&peeled->old_oid, &peeled_oid);
+			memcpy(peeled->old_oid.hash, peeled_oid.hash,
+			       reader->hash_algo->rawsz);
 			**list = peeled;
 			*list = &peeled->next;
 
@@ -456,6 +458,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     int stateless_rpc)
 {
 	int i;
+	const char *hash_name;
 	*list = NULL;
 
 	if (server_supports_v2("ls-refs", 1))
@@ -464,6 +467,14 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
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
