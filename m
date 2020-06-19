Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745C7C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8E220776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="joBQjlY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404229AbgFSR41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39446 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393707AbgFSR40 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A03C160A68;
        Fri, 19 Jun 2020 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589378;
        bh=edUdmuqwqgrI4d7hU9gk2tehK/HwKep/ouFUbgKC4Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=joBQjlY5agjFH8lEmQiaCo9BWLEGrMz90vxDI3kGsFfqCNeU/i+5p9k+Usdb5Z5jt
         tpxWPqSS3sAG10QA7xPkwfzQLxcN6VU3jWdo7Rmq7yeBOqPU8XuOp2M45WRbIvGjr8
         G0WWc6kRhuTj1k3Yc8L7lihvsaZwUhGiPDiM1Y2GCNn5GhpjUBS1vBz0lJF0amK0ft
         0+juaw/xM5oEY825l0uuHFT0Pepd3Bc4yzElyLut59bsfxR09nwqeqWnRkYDXKFLvm
         NSRlPPKN7N7bEU7+3g27LxSBHRr0ShCKyL+K8sSshVO7vRsyT38YwKOYRFLAuO+2zt
         PhRuze3lIQoEsvlTP/1VzRAXJ7myZXYJRzbsT7o8iOK6wszXCo+PdZdSpqYmh7e6hu
         /u360ij7smoC9s2NJ3Dp00LgWBh8LPRzfSZWedjUZNy2dPVDBjLiESfSNN/OCzAmgO
         wwG6GcYUAu3AvPoHAx9gmpaqKwCHEDj2OrOBdt+N2FgE5SSHtOO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 11/44] send-pack: detect when the server doesn't support our hash
Date:   Fri, 19 Jun 2020 17:55:28 +0000
Message-Id: <20200619175601.569856-12-sandals@crustytoothpaste.net>
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
 
