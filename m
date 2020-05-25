Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB952C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA9C2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HtJ5p1Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390621AbgEYUAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38796 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390545AbgEYUAR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 62A1C60CF2;
        Mon, 25 May 2020 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436785;
        bh=qQ80ZzeBSLgKo57xBL5U1/mAg+xY3uajsMWjI2OqhAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HtJ5p1OiBnGpzzz9b4o5Ax2Lppf9MoxdTPix4UnLEbwVPeMdd9oA+0CDaDifXEx8x
         lTLf20PPN3Z0w7d/aAOq/KdGsw071n5gQYU+tnfbMrQcQNEoRwxbUHtftRpMxfDR+B
         /DdKydg7UkEaGg5Ya2tFDWaSgJZ+LoZ9LkH5Md5m6D7sHPA9XobNEgW+idEf8oJLXG
         YbdNF1rGwttnJ8YHkWwoS875bLUGegI+ya8bzlD11lARcddbS/UPPghuWbH5vzRVFg
         zodCJaNttGMqm5KNFnQJWqBzdF+yZ4dF9pU2VhARtNLWgfT5WLI56p7S3DBlmDpD1S
         PlBhlkRMT16kJ8eRCwrIrPueNt+FQqbZBNvJouziuLx2VsqOaz/kK69bSDuNJPid8N
         8TTveejBhb5m0OYWW9Kxgpieytwc9g3QgVSDE1kTlk/o3Pgeq7bVDg2gUiYmJWqSrs
         izIx38Yqgit2SIGeH5kuQUNLKxUSe3tOwF3VZ7TMbNMDjBgoCcq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 06/44] connect: add function to parse multiple v1 capability values
Date:   Mon, 25 May 2020 19:58:52 +0000
Message-Id: <20200525195930.309665-7-sandals@crustytoothpaste.net>
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
index ccc5274189..2b55a32d4d 100644
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
