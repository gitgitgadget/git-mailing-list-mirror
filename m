Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD1C2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E6020675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cP8edmyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbgEMAyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38104 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731760AbgEMAyn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4240D609D3;
        Wed, 13 May 2020 00:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331282;
        bh=vC3yULAhTXszSyPeUhFmr4d2WyU9ajPycevd18cAwS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cP8edmyU4SnO4mbI6AAFB7Qcqz/I3lMlEUqfLhu1+qlbQ15e+vUbtzsTS3QxcgzFU
         yIBwyDXxf1FZcVCkw9WFqysknhi7lULiIGailvUcdEI7DXmPHPad/adCGY9qodgMdF
         PfOOpZuo0+7vvWlS/F4O4dwdKWYi1U270YbQTHAgDMqHSFZC6/qAVVBACl7ZauOJhe
         0i29MaGmrKC+bc1qAS7H76spzmuI0qlbKQmEIiq0NE4+M3oExOWoPHOshFT82CJxiD
         /NTwGlyp4TXY+nv9o5rblzzs+2kT69rwP9tZH86xZ5/KhmV9Z746s9B434z4kxisMP
         lXKJKE9RB+spqMxGlBTH72PHK+jPebcx3sh8iWVsom4DIg0SdTIb65T+vUcuaVNWqM
         9azQFo3ZRonherxpnhJFIQdWm7z40erExasdMqQORQl0OJ87Zk3pWKDcDeGEydk3Fv
         WFrWQZQalA7PZF0001VJ5CjQtNRWXFYGlqXKvdpJwSUmB/eVTAZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 11/44] send-pack: detect when the server doesn't support our hash
Date:   Wed, 13 May 2020 00:53:51 +0000
Message-Id: <20200513005424.81369-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Detect when the server doesn't support our hash algorithm and abort.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 send-pack.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index d1b7edc995..fb037568a9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -362,6 +362,7 @@ int send_pack(struct send_pack_args *args,
 	int atomic_supported = 0;
 	int use_push_options = 0;
 	int push_options_supported = 0;
+	int object_format_supported = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -388,6 +389,9 @@ int send_pack(struct send_pack_args *args,
 	if (server_supports("push-options"))
 		push_options_supported = 1;
 
+	if (!server_supports_hash(the_hash_algo->name, &object_format_supported))
+		die(_("the receiving end does not support this repository's hash algorithm"));
+
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
 		int len;
 		push_cert_nonce = server_feature_value("push-cert", &len);
@@ -428,6 +432,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addstr(&cap_buf, " atomic");
 	if (use_push_options)
 		strbuf_addstr(&cap_buf, " push-options");
+	if (object_format_supported)
+		strbuf_addf(&cap_buf, " object-format=%s", the_hash_algo->name);
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
 
