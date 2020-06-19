Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0B0C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43ACD20B80
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="W1coQgEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403903AbgFSR4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391253AbgFSR4V (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 27C5460A67;
        Fri, 19 Jun 2020 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589378;
        bh=ORMmguZtrHvCLzay+DZGDcwD5Tww9WG4e4A+bbiby4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=W1coQgEzoJjFNYESwXYZCo+eBCt7h4bvNXHNg5bX7kimrDd+EaCa7+1Y0chz9GaP3
         8eDfsi5lDL2E3vS91e+pTLn/GoD1HjDD7QPiITiFUTMZ9Yf/vs6jESsK2ZHfQ7o2I3
         mB0M+m/9CgTj+L05V642WJLQqQoX3rDP+MtUvTEvHA+VDoma8zcjHdAkPUHkvInDwg
         RXC/qsuIT2U5RuIxKNMpiNgB656AtXLSNfaC7opbzxBJN+4L51LoSfGcjEHCUSEzYe
         iPND/MuwA9oxg5/UwkwrZ52ZLs3yRmVSs9QpJVU3hu0+UotU8vglT+adPauWCoyTLa
         gmJNFNJlnnsKKJGZsjryBrojoK1RU/yRIb0WUTO2SUMP5yvv7ZzQKGDHKGaJJWmJGK
         R8hIClf/ceNxoPRvdASp7tyGzt64z+a6hubrmRd8Ja8kQcg3nG0wMwZS1ISqqeJHSK
         RyWy+LT++UQmy7+0QUm95EvgOf9TP54LndgfoMfrhGhGkDn2IHB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 10/44] connect: add function to detect supported v1 hash functions
Date:   Fri, 19 Jun 2020 17:55:27 +0000
Message-Id: <20200619175601.569856-11-sandals@crustytoothpaste.net>
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

Add a function, server_supports_hash, to see if the remote server
supports a particular hash algorithm when speaking protocol v1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 22 ++++++++++++++++++++++
 connect.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/connect.c b/connect.c
index 2cded78b0a..a52b038865 100644
--- a/connect.c
+++ b/connect.c
@@ -527,6 +527,28 @@ static const char *parse_feature_value(const char *feature_list, const char *fea
 	return NULL;
 }
 
+int server_supports_hash(const char *desired, int *feature_supported)
+{
+	int offset = 0;
+	int len;
+	const char *hash;
+
+	hash = next_server_feature_value("object-format", &len, &offset);
+	if (feature_supported)
+		*feature_supported = !!hash;
+	if (!hash) {
+		hash = hash_algos[GIT_HASH_SHA1].name;
+		len = strlen(hash);
+	}
+	while (hash) {
+		if (!xstrncmpz(desired, hash, len))
+			return 1;
+
+		hash = next_server_feature_value("object-format", &len, &offset);
+	}
+	return 0;
+}
+
 int parse_feature_request(const char *feature_list, const char *feature)
 {
 	return !!parse_feature_value(feature_list, feature, NULL, NULL);
diff --git a/connect.h b/connect.h
index 88702fdd17..c53976f7ec 100644
--- a/connect.h
+++ b/connect.h
@@ -18,6 +18,7 @@ int url_is_local_not_ssh(const char *url);
 struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
 
+int server_supports_hash(const char *desired, int *feature_supported);
 int server_supports_v2(const char *c, int die_on_error);
 int server_feature_v2(const char *c, const char **v);
 int server_supports_feature(const char *c, const char *feature,
