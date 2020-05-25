Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E1FC433E2
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6842073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="A6XJCRUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390452AbgEYT76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 15:59:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390393AbgEYT7t (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7EF90609CF;
        Mon, 25 May 2020 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436787;
        bh=edUdmuqwqgrI4d7hU9gk2tehK/HwKep/ouFUbgKC4Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=A6XJCRUTQUKscCWf5X97I6xLbNgW7naieDvuPKDBa73ov++gSVHGGmesN0/nmn9Qg
         WK9WEpHWs7hB0OtYmgcmL7SJEkDQrFmHqzEO72vRo143dsLWQYfYMtNxxSeMt+JifL
         XR7cH+vhUmgsjDNGDOd+4+9At/lzqI9CAIzSRFCI5et7+3WjX9r7kVPz7fyY8lafPq
         9jjKLUnL2CLcla5JOnuY+8ViG+PwqKpPhlrLPA13jT8JBLkFirNOqMJq17kyWnuQJ8
         wWi8YjU4GozmXjkHC2bm6kjnnwabblRrOnNnzoLoz8Gp0vhs4ziieOe0xgQJU6R0/F
         5/3Xc+2On+v77Dvq4GLDnwUAEhTPQK0zX/MUJkmJ9KGTD0M7CRoQUfJEktVwZaJoTH
         oLFsvioikQViBhvSNxRDltmRWXmCLEIDveXe9dLGX65Lpqk9G9MKdqlTf+nPsIhnpn
         3+VjDZ0S0/0e0OOgzfigNJbECeXWm8jAWbHnXajFk/GQmR5lRn7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 11/44] send-pack: detect when the server doesn't support our hash
Date:   Mon, 25 May 2020 19:58:57 +0000
Message-Id: <20200525195930.309665-12-sandals@crustytoothpaste.net>
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

Detect when the server doesn't support our hash algorithm and abort.
If the server does support our hash, advertise it as part of our
capabilities.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 send-pack.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 0abee22283..02aefcb08e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -363,6 +363,7 @@ int send_pack(struct send_pack_args *args,
 	int atomic_supported = 0;
 	int use_push_options = 0;
 	int push_options_supported = 0;
+	int object_format_supported = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -389,6 +390,9 @@ int send_pack(struct send_pack_args *args,
 	if (server_supports("push-options"))
 		push_options_supported = 1;
 
+	if (!server_supports_hash(the_hash_algo->name, &object_format_supported))
+		die(_("the receiving end does not support this repository's hash algorithm"));
+
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
 		int len;
 		push_cert_nonce = server_feature_value("push-cert", &len);
@@ -429,6 +433,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addstr(&cap_buf, " atomic");
 	if (use_push_options)
 		strbuf_addstr(&cap_buf, " push-options");
+	if (object_format_supported)
+		strbuf_addf(&cap_buf, " object-format=%s", the_hash_algo->name);
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
 
