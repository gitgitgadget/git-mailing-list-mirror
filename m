Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C725C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317C720776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="w4UZgVoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405302AbgFSR5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39638 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404770AbgFSR4t (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4DB4860A63;
        Fri, 19 Jun 2020 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589376;
        bh=Vz8VJsqxAFBjylJ4xGpQCBj+IfUz8i1+hfPP9jT/Ca8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=w4UZgVoOOyHaaWW/72SHzXjWTHNpCyhRp0dERfUDtdbgyfUDiKbFyVF6INb/q5oSG
         Mqn4Wlm6qXt9Ha4+4EJEmizAEJEu54fzFKUx7GCITMy6NaGfaEfoKdj32z9vC2wOlo
         ruOWKqGrhzny9sjxmrI8WVUSRqBd+XfqsK4NKyH1361QvfavAWgapkNWlChByHUdeT
         oSQQDeOiLgmS8KfWpbQyBK2h/ITZ6ROLf9KJ/5k2eyVq0xmfQdfImgxA1qXycG5YIy
         SIarb5HUFue3r0kGp0NX+LhKUbLkCnntTzb9swMM5HrravlLN1I/LD3TcPpf38Vm7T
         cVlXrv10rxw60fiycW4AQBnJLU9416zZ2zVcxhpcaiWKKdXRgsyCchOilLW/AjmsRH
         +zZGA60q9YvrBbTKILAi1H/L+LDt+zg1aiXcTQ36AyPWmfVHkoFYLVL1rAw5o3xd5g
         fJVHSpK6DpwpJOey+0VXY65vL07AE/3+TCmt2MyZ8GkHd1DjjZ+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 07/44] connect: add function to fetch value of a v2 server capability
Date:   Fri, 19 Jun 2020 17:55:24 +0000
Message-Id: <20200619175601.569856-8-sandals@crustytoothpaste.net>
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

So far in protocol v2, all of our server capabilities that have values
have not had values that we've been interested in parsing.  For example,
we receive but ignore the agent value.

However, in a future commit, we're going to want to parse out the value
of a server capability.  To make this easy, add a function,
server_feature_v2, that can fetch the value provided as part of the
server capability.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 15 +++++++++++++++
 connect.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/connect.c b/connect.c
index d30c637ab3..2cded78b0a 100644
--- a/connect.c
+++ b/connect.c
@@ -84,6 +84,21 @@ int server_supports_v2(const char *c, int die_on_error)
 	return 0;
 }
 
+int server_feature_v2(const char *c, const char **v)
+{
+	int i;
+
+	for (i = 0; i < server_capabilities_v2.argc; i++) {
+		const char *out;
+		if (skip_prefix(server_capabilities_v2.argv[i], c, &out) &&
+		    (*out == '=')) {
+			*v = out + 1;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 int server_supports_feature(const char *c, const char *feature,
 			    int die_on_error)
 {
diff --git a/connect.h b/connect.h
index 235bc66254..88702fdd17 100644
--- a/connect.h
+++ b/connect.h
@@ -19,6 +19,7 @@ struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
 
 int server_supports_v2(const char *c, int die_on_error);
+int server_feature_v2(const char *c, const char **v);
 int server_supports_feature(const char *c, const char *feature,
 			    int die_on_error);
 
