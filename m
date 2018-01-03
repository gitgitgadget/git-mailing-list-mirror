Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3981F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeACASu (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:18:50 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34292 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeACASt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:49 -0500
Received: by mail-it0-f68.google.com with SMTP id m11so12558878iti.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LUTtXzDHRD0T/EJ7hSoQB9I+/z4GjuUmBevlPPQ23Ac=;
        b=p6afDGZA+nst0aJysrhRAdrbnDdXxqKiy0KmRh/L3ljAjy2EAbodZu6D+qgdv1FEig
         mVwzVTgd8wIbQfcdHvYlX8TZ6WeNASiROO8E4cU8pSzkQrobUz+NR+MFcg87c1ly1eB5
         u4pXp4+SuVhJp9wyEh0GHNwo4A3lN9cT59WHcxv3S/SbIPhOhU4l8YW0JbYrQHz9y0Wl
         nyXiJy+MKRtFz7rIytXyHzKFpaZBK8pl/jVzwnSG54JVICLFOM6AGs7WG3Qqf7ERId9S
         D79CA/FzgUFm0RmIYWnY1r0YX7bLyR7vzi6cgG8maZbeHDx3G+kSqPq5W/+zdwV5CqIj
         UwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LUTtXzDHRD0T/EJ7hSoQB9I+/z4GjuUmBevlPPQ23Ac=;
        b=s8diH2XreFnLaEnzMzXo/GhbSBub793Cpjv+KxCvURDlvvYVTuYSLNE8vqyrCAcUby
         pH4Koehbrg3MjeONYC1p/5w2i21aIxJNSge7n87rMJGYJMKFhbaYnjFUodO9VBbzaKxI
         6MCfmVLprpME5FL7k02/6B4AcwjAgAaxvskF4SXhkWP2a/hwjuUxQd0PxauAW2b5dVo6
         JIZDiZPo2nffe68OH0bOTbp5d95d9uV0wP/gF+c29L9JfK6bxiMXz9q1lbnawCpDa0Ek
         xeFVWiuwaem1/LbJRwsEaFumgPj9ZllYIBxqMJzWApbAKCAT1WVZpc/c+obK1qh1d4Pn
         FCOg==
X-Gm-Message-State: AKGB3mK54HmKL1otgsr8AHv9d2Kt/vKUvPaVNzNvuLwEQnYSeKVL11UZ
        9MmaON7J7Bdnv4VWvb+J6gDpbc1Ys18=
X-Google-Smtp-Source: ACJfBovEstv3BxguUWMGQL8jBYxNFZ96iCh4t6mulDWNXuU6zBs/Qa+2MhwuyII7AhT5mYLJq9vitA==
X-Received: by 10.36.73.9 with SMTP id z9mr23589ita.36.1514938727792;
        Tue, 02 Jan 2018 16:18:47 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:47 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 05/26] upload-pack: factor out processing lines
Date:   Tue,  2 Jan 2018 16:18:07 -0800
Message-Id: <20180103001828.205012-6-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
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
 upload-pack.c | 113 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 39 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 20acaa49d..9a507ae53 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -731,6 +731,75 @@ static void deepen_by_rev_list(int ac, const char **av,
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
+		*depth = strtol(arg, &end, 0);
+		if (!end || *end || depth <= 0)
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
@@ -752,49 +821,15 @@ static void receive_needs(void)
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
2.15.1.620.gb9897f4670-goog

