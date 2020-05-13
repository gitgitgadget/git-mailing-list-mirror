Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4624FC2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293D520753
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="V/HYMPhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbgEMAym (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38104 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731638AbgEMAyl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8D742609D3;
        Wed, 13 May 2020 00:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331280;
        bh=LYaNLLLOZ0jl34fl6MqE/r8TKb7ZelEL1oJtQOx/hqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=V/HYMPhDiN14FEEXsjM0HRszfAkv1WWlvaymCgJp6xXbNSHSSpe776jjCG0Uy91cN
         /jP6vpPkHpIFxiONiIfW+dLRTyyN5FxT0ogzc50E9k/6CjmG57rSwn+TCnT3mEYAJx
         RyzrRERVGidW85VS1MPMW8XFaQAxRVKp7B+jLEU2EPMIMbNamNEbyvRHne0Du6ZjYQ
         Itz/SsO4NxkfjhH5Nwz8MB3H0jhcjC0LKvy2D2UsLiXXRQXHEtqd5iinznrTM+Ixuj
         ATRLLDWeBdeLThU2VOHriLGyCI9OoaW3HhGmOSEgUCXacwklMm0bZPa0mDxkYwkYLP
         C/YtJCfvuogJkIREl2NFKP0gbYA9DJi/HAgBxySC2SrXf6UbLhBg3BgJoqsbSLboxH
         KdmKztuevZZZSMdIPEn6YBe+iOXo8Mxa3Gty4G9/ujZUj/zna1JKADcf0YWk3y0QOM
         Q744hXUo45DPG7c6N2wDv6nrS1GY+iRI+3RmnXUHtHFGWmLl1Bx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 07/44] connect: add function to fetch value of a v2 server capability
Date:   Wed, 13 May 2020 00:53:47 +0000
Message-Id: <20200513005424.81369-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
index 4027fd4677..4df9e77206 100644
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
index 5f2382e018..4d76a6017d 100644
--- a/connect.h
+++ b/connect.h
@@ -19,6 +19,7 @@ struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
 
 int server_supports_v2(const char *c, int die_on_error);
+int server_feature_v2(const char *c, const char **v);
 int server_supports_feature(const char *c, const char *feature,
 			    int die_on_error);
 
