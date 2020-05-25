Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE28EC433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FEA2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0m/YnXvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390588AbgEYUA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38818 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390559AbgEYUAS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 189E460D00;
        Mon, 25 May 2020 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436787;
        bh=CNRYudmVcbOwLD3nR9jzlGoBvErmrez6UAMqXK+Jovs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0m/YnXvplG9psvHY/IYffKOFjQ5N14kPaDKEBWUBTTvuC3x0J0HD2OsjwRSgOWJPT
         7XKkgSDSOoxrA38ZTOhG7M/Wk1azP6nvHG1CBh9FFPtVxeqerpulL+rOWHyZYftNsS
         eN3H2b0wFx4eOnh+kO8GHz0LJ5hrlnnxwP5887b8HkcKhVEWqZyG/fuYdTGn+HfoC1
         XIviSl7DoW0ggJBNaX7xhfiLOXqzdGy2YYhO8uMa8x3tB27Zjqbdyy0Slx+ioPYhu9
         6/6Fk1mgUMl1SJ8db8fs5TQBToOcwP3Mq21C4zWMFbVaH+Q9iZ61N1Ob5DXIGTtF40
         Hb4iMLHizdwltU+YZ5J5SsQ7QOK2pfkWhkDTsj/CPpp/DImmBOvZyMHOm5K3SDOHcZ
         Az2vLrY0v2lh83JqjXN+6gubn7LLtc2lgVcTTdiWZdI7OPXw+uE2AOBddD+rFYEUCt
         6kVvf7UxMw2GUtFyjkO75lfwRp+U665Ae3v/KI7GYH0XZcnltjA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 10/44] connect: add function to detect supported v1 hash functions
Date:   Mon, 25 May 2020 19:58:56 +0000
Message-Id: <20200525195930.309665-11-sandals@crustytoothpaste.net>
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

Add a function, server_supports_hash, to see if the remote server
supports a particular hash algorithm when speaking protocol v1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 22 ++++++++++++++++++++++
 connect.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/connect.c b/connect.c
index ad0e4e8e56..eaa13b41bb 100644
--- a/connect.c
+++ b/connect.c
@@ -511,6 +511,28 @@ static const char *parse_feature_value(const char *feature_list, const char *fea
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
