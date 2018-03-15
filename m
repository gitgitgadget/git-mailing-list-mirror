Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F9A1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeCORfI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:35:08 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:33754 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCORb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:31:59 -0400
Received: by mail-yw0-f202.google.com with SMTP id d10so7696546ywe.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=NFSIICGVr+1bS9hUnKD3wXVt5JiOfv0jsJj7nlb3wS4=;
        b=DCFFVz6rQFfo0jWVuAIhDg+8yKXWaVq/AV3EvEJBaDy+IZ+UQjVCuoGb8PU4upao/J
         kJ2abjMfv/UikJnxeZKGYLLHWQE62bnt5tnoWK/LyJ2fqGS+Mlm6Rlwp8Ek0Um6c6Jbr
         +gCNm20usUfvIM8ecBYLHUI+XNR2RexS1OtTpirSrzrJrBZFyZCR25k/eG0X2JAwF2BE
         BuPB6ckOt8yOnRn8ISWTdEYOVINhyKaV0OPd81o/77Fq64+Zr0gq1YMPsbat84XDH3js
         W/Ejj+4GNPs4YTrCuRXCEtWIQbuIOpkvtn1phAmBlgNl299rtocuK9NO9GH41Avb+M+a
         yfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=NFSIICGVr+1bS9hUnKD3wXVt5JiOfv0jsJj7nlb3wS4=;
        b=WKWXXirKVviD0M3kePjf+zVydwH+EeVNlKA80ms9/lhoLS20fQ+sN21L/ez6AC9c3P
         38D6+Sph7gqKFpRQnjy8vFqU0ZaNXJagmZTz3FqE4KOmyuywovrbThektB3KmeoxvuCM
         p37z+CJsUV4PJjwo+5E+Fxr/T0hi03UKgO8YtwCySWc4PVhXbm6N1LuuV0iXqSVqUKAY
         g8PpUB3eL9eLL09z8Sg/QXEr04uSiCJnXVuO6HOzXG2ziXvm1/e/5C+KoPHcTWmfOcGz
         T5kj9gudWVpYFammI4jDtJlNn6WtF3JQkes/q7m4FP8zFY8UVeerN/PXGy2Yvy3Q+/uR
         AefQ==
X-Gm-Message-State: AElRT7E6WQBwuA+TRu5G9mCCKz1IJxE3kcJyDy6E3DBCJ6kN6maaqN0i
        TyG92wREBF2gIj55CCIDlC00AD0Bp8pvjsHgJc20JDXlJ349irTEUmnyJi+Yk0H/UGsoiyfuKeF
        sVLalVpVcqV7VAhDQMfC7IgejTiECXjFOvV3Wcqi4U2Z4YddYlDUeqaC6nA==
X-Google-Smtp-Source: AG47ELvBKZF8hdPAFUQVSgaHCIg7Pp8XSQQOJAoE+u0a0howUVBbwP7yzozgZb6wROCSBMr+TzfF6KAYuCk=
MIME-Version: 1.0
X-Received: by 10.129.41.9 with SMTP id p9mr3807791ywp.25.1521135118943; Thu,
 15 Mar 2018 10:31:58 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:12 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-6-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 05/35] upload-pack: factor out processing lines
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
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
index 2ad73a98b1..1e8a9e1caf 100644
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
2.16.2.804.g6dcf76e118-goog

