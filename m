Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620B7C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C762071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vU+/RdQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390563AbgEYUAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38784 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390542AbgEYUAQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EF0DC609D4;
        Mon, 25 May 2020 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436785;
        bh=MiR21CjvndjGJN/0B3f1TGsex3CuTAO2yUZeWjGSHkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vU+/RdQIfPf4uipC9b9M636zCpnXXjlPACJnbWsuiI7CJYCSHdyZmI3o/eCdKlErj
         nyzBvPv9zYC6y3ojqOO5E5Oel9BKXPs9ai+AJbAphH4ZjB67pRd2DYaFPaBuEx5ROS
         Wx/HWRZLFAFpC2Wkt/AQ2kpmTbqA07zkRjegIzuGIGDPA1zMztdT2kR7xGxAJnRUq6
         m4xkENSPLKmpeVLdA4+tkRrdXeDJaHUTd+dgX+gtk7+pNDUKTURI/L8OpRi5GAkCCo
         Tfc2X7vvMwjxr2AzihmcNwa+3unY+i+i4NhpvbRb6zS+AXvwF9dNaWM4ALLPDEVjHS
         Ex4lBzpV0JJM6KJtkBBMuGcR/r6yJbvMjFrjLulmfFzh5sifm+mAxc7LM39H2ByYBZ
         BbuIxXGirrYUWiA6e3ZU7xxNHFLpf7vs5aRiJJe0qkLAITjo9nLqpPkApecYuOW6W1
         SUOleYl6KMBo/Qfrr9yfI+lwKfDcMTAnHp3E/f2lNGsCVQ87s4i
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 05/44] remote: advertise the object-format capability on the server side
Date:   Mon, 25 May 2020 19:58:51 +0000
Message-Id: <20200525195930.309665-6-sandals@crustytoothpaste.net>
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

Advertise the current hash algorithm in use by using the object-format
capability as part of the ref advertisement.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 1 +
 upload-pack.c          | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ea3d0f01af..4ffa501dce 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -249,6 +249,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
 		if (advertise_push_options)
 			strbuf_addstr(&cap, " push-options");
+		strbuf_addf(&cap, " object-format=%s", the_hash_algo->name);
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write_fmt(1, "%s %s%c%s\n",
 			     oid_to_hex(oid), path, 0, cap.buf);
diff --git a/upload-pack.c b/upload-pack.c
index 0478bff3e7..636911fec5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1008,7 +1008,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, cb_data);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
+		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
@@ -1018,6 +1018,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     allow_filter ? " filter" : "",
+			     the_hash_algo->name,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
