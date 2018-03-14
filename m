Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 201211F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeCNScd (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:32:33 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:47036 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbeCNSc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:29 -0400
Received: by mail-vk0-f74.google.com with SMTP id u84so2684799vke.13
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=NFSIICGVr+1bS9hUnKD3wXVt5JiOfv0jsJj7nlb3wS4=;
        b=JHDmq9SjTvnAButcSLk5F5IgkuKpXbnAvuhpyLmfwEV/UewEca5SZqbkylGlGcU/aB
         q1oJvMiORalxo+H9bDnD3by9wK39ozKwV+zfBE0Sk6eSlHEGCiNJXUIv//p4gIf8lIfD
         ch70Gi+BNyOzGjAaAW8fFcswfd3m9+Ukc/DfsFpGN1RfujNwf6V5om3Z+TAH0pBRkkRd
         H/xKPhy0Ewt/Yfy3zk0boEDVriduCI8bA6ilKHBd2qU7bBEERKd1aGsQrM3gGJKXn8tK
         3K/Zboqp2H4aCqHsrLl9nOtRgka/NpEKNB6OpR+8fbBTZ6DmUn7yCY3aBlNXvcXSL8SQ
         BPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=NFSIICGVr+1bS9hUnKD3wXVt5JiOfv0jsJj7nlb3wS4=;
        b=h6QOlyQe/77fX3UgNhg51fbbd4cfQ+Ju3umu1Ak8tBeLZxecl0fKp9PKAjWtnrpvv0
         /Avlv+pRTKz7i+2XZYiy5QpNV7YFfaSRHnsDOI9cNyuUg4pnxOuM9KzKV8UySJomTuBF
         rdNrk6UFgYshsplPFTDwUU5L7BCT0bsfPGlo0Rkwt2nCL1DCBTDZG4m0w4fl4TMVJwh+
         yUhc9iRtrLHbbtvhfWe9GqG45jvPF/RzUhPk9Ph5dMqgW23pheaxQ4iKYusQvyqyimSx
         pkkpIUjMwG6Xl6Nn2+rHAKeZ+sAhPIgP7yyHnjQ5Ne8XITV35czn8G+m1RIvlXwl6iCj
         sCfw==
X-Gm-Message-State: AElRT7GeE3giwGnzB6t1WGP13vuiv42RuPkdu7NG/NuIZKnWmMCZy7bu
        dN1XcN53XhIDATIGJi5NO4U6SRMXhBwS02uckBveFUFSDXR/Z/g/fOPcurOeKLR0yGni7hX3tPu
        lcbGESEFl38PJoP8kCTpMgYLZv/HrLsYK31J05ANt502sm3gSCqWWBONH/g==
X-Google-Smtp-Source: AG47ELsivoCngJeeC744taLI6cNBosZkKk5NFECD9dcJdi1OecREk20i+7sXGd3qNfzmv0YdBixEVfHdOf4=
MIME-Version: 1.0
X-Received: by 10.176.22.51 with SMTP id k48mr2556937uae.80.1521052349013;
 Wed, 14 Mar 2018 11:32:29 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:42 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-6-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 05/35] upload-pack: factor out processing lines
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

