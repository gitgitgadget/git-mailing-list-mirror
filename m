Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881EE1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964977AbeB1XXf (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:23:35 -0500
Received: from mail-qk0-f201.google.com ([209.85.220.201]:54116 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964944AbeB1XXa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:30 -0500
Received: by mail-qk0-f201.google.com with SMTP id n189so3149995qkc.20
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=X9ADGDzFFbRhAC+ORIUhQNZ0jJiw4QU1qJ8xIzEiuww=;
        b=vEeJy6OV3UbHxWsLS7F2pEW25cD8febcckJgu46JtkprIrlNpktR+yOdMtMJurbUPk
         16VvqNkPxx/HB/G6nM3Jwvv8HzgF4FWTcBaDtkjwBdYI8yx7TMYGQLqSRhuniAGTZVkA
         FaoIMDn+sixXq2O+qOdvnIlXGR9acv1TuMUfhZvyfmh3PbHIsyoyxDbyDp42bwIgOw+X
         I/zSZcpIkrLq+UphcIJMu1uejAa/RNEL5vjmKdUngizrw841LrXyAVjYPdGCRYFpPFco
         w4vvbEtz/C6tGbi4otrhUzkyDHzdauRGKsaRrW2G+qUChNagB3vrnhvZYDV0xg+nosBh
         E9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=X9ADGDzFFbRhAC+ORIUhQNZ0jJiw4QU1qJ8xIzEiuww=;
        b=GPtzTRU9blx6zr/n05qh/us+5zgYzXfMS9aDUYnHvVxgekWQehuNFZ3ot06Y54FMWg
         nJKR18Orp5pUrxKdLw0arBBmzIS0b1oQxZC0gZ6jZwSAOlceOzIIn7px66LPBZ+FXT+E
         TpTTYV4TQx2QtPNu033t6EexV3YDdI2bMSXYL6hYFCHlDlaDjqAoCq/+4+dWKKFfiaBb
         x9w5G2vIzWi2xQEjhCdCRjV/ifGH2aZMw7D1UDWRm3bDHKUKg3yQIse5+YpREqSn0A2W
         l4La7efjXafgepwmo3hCm7Oj5Xb8vOedgRZ/7SZBUqzEVX6H8WIeQzM+JTiUJU9D4PwM
         ltWg==
X-Gm-Message-State: APf1xPB4flkKAPFE63E5yfNMEAoPffCiqHS9VsR45OpBRw44DB5mfZg5
        ouW2NCDdiqUo+7180o4xy/HIB7pbGzb84hKtgkE3lWNgpFZ84pucFohGYBaM3qroS/XgknCbdzW
        YatZcQwRzfMy/h+jbRGofqxVPkwWEfrsn1W0DSrSg0aODArDkLkUDnTt+Zg==
X-Google-Smtp-Source: AG47ELt+/ICzPU+gft3yv2079dgOEpHpjLL2dswxMCyzbhVRjQNTNyt7rnpzjRRV46VsSiv+xDJ3a90ysL4=
MIME-Version: 1.0
X-Received: by 10.55.81.2 with SMTP id f2mr14544565qkb.10.1519860209154; Wed,
 28 Feb 2018 15:23:29 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:22 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-6-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 05/35] upload-pack: factor out processing lines
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic for processing shallow, deepen, deepen_since, and
deepen_not lines into their own functions to simplify the
'receive_needs()' function in addition to making it easier to reuse some
of this logic when implementing protocol_v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 upload-pack.c | 113 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 39 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2ad73a98b..1e8a9e1ca 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -724,6 +724,75 @@ static void deepen_by_rev_list(int ac, const char **av,
 	packet_flush(1);
 }
 
+static int process_shallow(const char *line, struct object_array *shallows)
+{
+	const char *arg;
+	if (skip_prefix(line, "shallow ", &arg)) {
+		struct object_id oid;
+		struct object *object;
+		if (get_oid_hex(arg, &oid))
+			die("invalid shallow line: %s", line);
+		object = parse_object(&oid);
+		if (!object)
+			return 1;
+		if (object->type != OBJ_COMMIT)
+			die("invalid shallow object %s", oid_to_hex(&oid));
+		if (!(object->flags & CLIENT_SHALLOW)) {
+			object->flags |= CLIENT_SHALLOW;
+			add_object_array(object, NULL, shallows);
+		}
+		return 1;
+	}
+
+	return 0;
+}
+
+static int process_deepen(const char *line, int *depth)
+{
+	const char *arg;
+	if (skip_prefix(line, "deepen ", &arg)) {
+		char *end = NULL;
+		*depth = (int)strtol(arg, &end, 0);
+		if (!end || *end || *depth <= 0)
+			die("Invalid deepen: %s", line);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int process_deepen_since(const char *line, timestamp_t *deepen_since, int *deepen_rev_list)
+{
+	const char *arg;
+	if (skip_prefix(line, "deepen-since ", &arg)) {
+		char *end = NULL;
+		*deepen_since = parse_timestamp(arg, &end, 0);
+		if (!end || *end || !deepen_since ||
+		    /* revisions.c's max_age -1 is special */
+		    *deepen_since == -1)
+			die("Invalid deepen-since: %s", line);
+		*deepen_rev_list = 1;
+		return 1;
+	}
+	return 0;
+}
+
+static int process_deepen_not(const char *line, struct string_list *deepen_not, int *deepen_rev_list)
+{
+	const char *arg;
+	if (skip_prefix(line, "deepen-not ", &arg)) {
+		char *ref = NULL;
+		struct object_id oid;
+		if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
+			die("git upload-pack: ambiguous deepen-not: %s", line);
+		string_list_append(deepen_not, ref);
+		free(ref);
+		*deepen_rev_list = 1;
+		return 1;
+	}
+	return 0;
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows = OBJECT_ARRAY_INIT;
@@ -745,49 +814,15 @@ static void receive_needs(void)
 		if (!line)
 			break;
 
-		if (skip_prefix(line, "shallow ", &arg)) {
-			struct object_id oid;
-			struct object *object;
-			if (get_oid_hex(arg, &oid))
-				die("invalid shallow line: %s", line);
-			object = parse_object(&oid);
-			if (!object)
-				continue;
-			if (object->type != OBJ_COMMIT)
-				die("invalid shallow object %s", oid_to_hex(&oid));
-			if (!(object->flags & CLIENT_SHALLOW)) {
-				object->flags |= CLIENT_SHALLOW;
-				add_object_array(object, NULL, &shallows);
-			}
+		if (process_shallow(line, &shallows))
 			continue;
-		}
-		if (skip_prefix(line, "deepen ", &arg)) {
-			char *end = NULL;
-			depth = strtol(arg, &end, 0);
-			if (!end || *end || depth <= 0)
-				die("Invalid deepen: %s", line);
+		if (process_deepen(line, &depth))
 			continue;
-		}
-		if (skip_prefix(line, "deepen-since ", &arg)) {
-			char *end = NULL;
-			deepen_since = parse_timestamp(arg, &end, 0);
-			if (!end || *end || !deepen_since ||
-			    /* revisions.c's max_age -1 is special */
-			    deepen_since == -1)
-				die("Invalid deepen-since: %s", line);
-			deepen_rev_list = 1;
+		if (process_deepen_since(line, &deepen_since, &deepen_rev_list))
 			continue;
-		}
-		if (skip_prefix(line, "deepen-not ", &arg)) {
-			char *ref = NULL;
-			struct object_id oid;
-			if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
-				die("git upload-pack: ambiguous deepen-not: %s", line);
-			string_list_append(&deepen_not, ref);
-			free(ref);
-			deepen_rev_list = 1;
+		if (process_deepen_not(line, &deepen_not, &deepen_rev_list))
 			continue;
-		}
+
 		if (!skip_prefix(line, "want ", &arg) ||
 		    get_oid_hex(arg, &oid_buf))
 			die("git upload-pack: protocol error, "
-- 
2.16.2.395.g2e18187dfd-goog

