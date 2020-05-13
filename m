Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0177C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5DDA20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gYpCqkES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgEMAyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38112 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731692AbgEMAyn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CF8CD60CFE;
        Wed, 13 May 2020 00:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331282;
        bh=GQ7uCyvva2Azpko5tSygkfZCc9f/ScMTtEFfAlmp7gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gYpCqkES7iHAnBbS+KGNHifXhUL2wLXlxoZba7RwmprfVFk8JftV0sYq5WLxYyw3+
         0eOC9OQxLjb7+zM6J2IJLOdMSTRZont/EyI820B4/LWzn7hLKZz4aFqqWdIfowVcvU
         gBGI0TaMFROSloplnmSI/PofnQ8Tf4Ymz16tkFoF2NdEdELG+cdDnQHwcWCqTda5b6
         XlzovFnihmpf+V074ZOP4N7m0E+DpC4wzeudjwblTn6HBfLiPMvOs3tgeou6cQEfS+
         QHN8W5EUzsGiJiqyZgco8/SSjJcaEypfdMD7W+Ad4+jRTnm20zeKmLKuKYmI/cMsIw
         zWqu+zm5NQZbUI/Ex703tOed/ie8OSS07CbhhHTeSZKVMgaj592TyqtPOT0qFka3So
         Rq8J+6qxN9YFrqy8WmcgS4mVFkCDNJA4QD7ZWvxHShGDkZFMD5tLzpjcBJIAc9A1Bl
         j7UiDEKRZGfGUyTRaf6IwXb3s3Ga9b/E1zLcj3c0ltezqMEypAD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 10/44] connect: add function to detect supported v1 hash functions
Date:   Wed, 13 May 2020 00:53:50 +0000
Message-Id: <20200513005424.81369-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
 connect.c | 24 ++++++++++++++++++++++++
 connect.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/connect.c b/connect.c
index 4df9e77206..cb69aafe2c 100644
--- a/connect.c
+++ b/connect.c
@@ -511,6 +511,30 @@ static const char *parse_feature_value(const char *feature_list, const char *fea
 	return NULL;
 }
 
+int server_supports_hash(const char *desired, int *feature_supported)
+{
+	int offset = 0;
+	int len, found = 0;
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
+			found = 1;
+
+		if (found)
+			return 1;
+		hash = next_server_feature_value("object-format", &len, &offset);
+	}
+	return 0;
+}
+
 int parse_feature_request(const char *feature_list, const char *feature)
 {
 	return !!parse_feature_value(feature_list, feature, NULL, NULL);
diff --git a/connect.h b/connect.h
index 4d76a6017d..fc75d6a457 100644
--- a/connect.h
+++ b/connect.h
@@ -18,6 +18,7 @@ int url_is_local_not_ssh(const char *url);
 struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
 
+int server_supports_hash(const char *desired, int *feature_supported);
 int server_supports_v2(const char *c, int die_on_error);
 int server_feature_v2(const char *c, const char **v);
 int server_supports_feature(const char *c, const char *feature,
