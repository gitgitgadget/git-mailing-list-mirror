Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937A7C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD7A2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WriC5kZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390593AbgEYUA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38802 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390547AbgEYUAS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CAB3960CF9;
        Mon, 25 May 2020 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436786;
        bh=o38jj4d7QtGrS5a2eNNJZkgmpX7AjSI6RHIhy2ooVys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WriC5kZ7GMWHBk+/hUJXlDEnfH5JgYEgd08WzjJaSLnFKl8HKkvROvS5RFIK48X3q
         FLiI+p3cJtxVXfvZp+f/opqbZVqce4/LEvlGXzj9Z6VbxvsPsc1CgMO4nwBU0hJXMW
         7J9hLHBdis4h8S2RRO2/nG5AwTgKXJLCd8jKuffgZh+Rqtz+Cu7H1YsxVdyF6BsFSt
         dobtsqgu/vVzv5chVgO70ZHpR6BgQco8JmNZ66WNalyDaiWgjfHlyWKxTEO5HHK22o
         GXvnB3WW0h4e78yT84OI1/yiyz3Wku68oA5dhXIkJREGG8U8OwNa/23u95hQiXF2en
         3M+8EUJKwfAwAfke2+EwtFPSmdv4IKN4By2jIOuDFAcZRxEs9pOassdTL6C5HLKvjc
         1GgKjUMjtNs8u/wDQFvaBqUpALu7Tn2pdIaJwF4IKEzKAWhw2c+vICv/de4luIEU3e
         YultkEzRL9bGtVBsrXhncj7KgV4aJxU8iUY6n3rEKzB9SwOerjO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 07/44] connect: add function to fetch value of a v2 server capability
Date:   Mon, 25 May 2020 19:58:53 +0000
Message-Id: <20200525195930.309665-8-sandals@crustytoothpaste.net>
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
index 2b55a32d4d..ad0e4e8e56 100644
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
 
