Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7165EC2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5441E20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TTITDEpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbgEMAym (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38112 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729215AbgEMAyl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 25EC7609D4;
        Wed, 13 May 2020 00:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331280;
        bh=TXV9vw3iyjpcOd1Px6pnQlIK7bO3DW+gVm2gat27M3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TTITDEpF5g8344D3WWnCJLf2ggbleNmGHx6Bi+BmYKrCW3s03mcObDZTrB5zu7Xmn
         hBa/3EEtzfnRuc6akuiRrGMP276YofU3smUmbHEzOpL/abrN2+Hys+0HLe31HyOw37
         dd7qQ67aOM5K12ITq6nCkq0jmw5lYOUP/o9hxLOlToNQRfzaZcNGiu0asWD3Rex3Wg
         zwAaPgmAEjg6Hs4iTqDwW/jEvPogiLi4HABwWHKGVY9xi7EsLfIPfhlCSyCy2epQfP
         odWEkwOGcOIcBj2aYnrHrOwCwQO/8Q/SZcIjlwfTdbjGaaS7WZcrcOTtZjDxpbjTdX
         87IGv1CZNA1eMAZgCU287U8WE6LtPbZZEDGXfz3QQkJ6Rlu9e1PH2WDmFu05zC7Ph+
         k0fDC3fpv+OoseZwYn4BQPkNTx5pQ+/FtPSEy8Fsh6un+VeuuWAd/5EmYyOXGa2xLI
         xKXjmY6ZsDDvza0KRAciu4p3LEC9eGQIYV/xgKEjHr3+VUFnfdb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 06/44] connect: add function to parse multiple v1 capability values
Date:   Wed, 13 May 2020 00:53:46 +0000
Message-Id: <20200513005424.81369-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a capability response, we can have multiple symref entries.  In the
future, we will also allow for multiple hash algorithms to be specified.
To avoid duplication, expand the parse_feature_value function to take an
optional offset where the parsing should begin next time.  Add a wrapper
function that allows us to query the next server feature value, and use
it in the existing symref parsing code.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 641388a766..4027fd4677 100644
--- a/connect.c
+++ b/connect.c
@@ -18,7 +18,8 @@
 
 static char *server_capabilities_v1;
 static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;
-static const char *parse_feature_value(const char *, const char *, int *);
+static const char *parse_feature_value(const char *, const char *, int *, int *);
+static const char *next_server_feature_value(const char *feature, int *len, int *offset);
 
 static int check_ref(const char *name, unsigned int flags)
 {
@@ -180,17 +181,16 @@ static void parse_one_symref_info(struct string_list *symref, const char *val, i
 static void annotate_refs_with_symref_info(struct ref *ref)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
-	const char *feature_list = server_capabilities_v1;
+	int offset = 0;
 
-	while (feature_list) {
+	while (1) {
 		int len;
 		const char *val;
 
-		val = parse_feature_value(feature_list, "symref", &len);
+		val = next_server_feature_value("symref", &len, &offset);
 		if (!val)
 			break;
 		parse_one_symref_info(&symref, val, len);
-		feature_list = val + 1;
 	}
 	string_list_sort(&symref);
 
@@ -452,7 +452,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	return list;
 }
 
-static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
+static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
 {
 	int len;
 
@@ -460,6 +460,8 @@ static const char *parse_feature_value(const char *feature_list, const char *fea
 		return NULL;
 
 	len = strlen(feature);
+	if (offset)
+		feature_list += *offset;
 	while (*feature_list) {
 		const char *found = strstr(feature_list, feature);
 		if (!found)
@@ -474,9 +476,14 @@ static const char *parse_feature_value(const char *feature_list, const char *fea
 			}
 			/* feature with a value (e.g., "agent=git/1.2.3") */
 			else if (*value == '=') {
+				int end;
+
 				value++;
+				end = strcspn(value, " \t\n");
 				if (lenp)
-					*lenp = strcspn(value, " \t\n");
+					*lenp = end;
+				if (offset)
+					*offset = value + end - feature_list;
 				return value;
 			}
 			/*
@@ -491,12 +498,17 @@ static const char *parse_feature_value(const char *feature_list, const char *fea
 
 int parse_feature_request(const char *feature_list, const char *feature)
 {
-	return !!parse_feature_value(feature_list, feature, NULL);
+	return !!parse_feature_value(feature_list, feature, NULL, NULL);
+}
+
+static const char *next_server_feature_value(const char *feature, int *len, int *offset)
+{
+	return parse_feature_value(server_capabilities_v1, feature, len, offset);
 }
 
 const char *server_feature_value(const char *feature, int *len)
 {
-	return parse_feature_value(server_capabilities_v1, feature, len);
+	return parse_feature_value(server_capabilities_v1, feature, len, NULL);
 }
 
 int server_supports(const char *feature)
