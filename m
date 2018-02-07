Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F8E1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbeBGBNe (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:34 -0500
Received: from mail-it0-f74.google.com ([209.85.214.74]:34453 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754281AbeBGBN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:28 -0500
Received: by mail-it0-f74.google.com with SMTP id 128-v6so12597383iti.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=iDPp0qcouvBf1e8/1kXZF0DY8MP3nsbDRgSPvdPwVI8=;
        b=M9JaY29ofyWTMva6ao+ZdaQL3cja2j+nY7DcampqPiIiaQZAIfS5WfWUusiuFMSO5o
         BMijDDaicuR1M0AEXrChGvoyCZhhuBykVkP1JTTl8AX144D7BiJ/xl3+/d9vxyBPxHzY
         th1EsSrd2iiXcl9X5IuF1GIBKdHwD78jUGZhgb5BMmvJfZsvZeubDWJgNwcJJJz/xcQd
         x1hI0E3saCYTMcTHd0c3/Z7sQJ2A4wEAOEPYynx1D7TvhTlJhzd19LHBmHn4c2TwkWjm
         yq4JwmWnFxb2FP5vFKG30EhA+d9NMmQOrdcewqwXOYrMp34yLRIefBOEfMT3lMB9V9Yy
         K2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=iDPp0qcouvBf1e8/1kXZF0DY8MP3nsbDRgSPvdPwVI8=;
        b=adHGsKqt/LOchnWO9s8aMObkDbgC+od1sEQsxP8gFakoVbwrTNI8Gyg1UbqpvvTW9U
         P46ubUZ7I+s2wekQc3CdDA6VtKWvCF2+sGqb5YqTIVUjc/fD3diYUSpuiBy9nz8ILizU
         +l3nBLFV8Eopipke6uubexQaPO5uiT4FYReTRvVyCn4AgBgICKyNPk/VnvPKCw8oVPFQ
         oY9kueoSD9525U6B3bzt5mZqgumi53SubiFStao6W4eTFHnI/iDQT7yVOsWLgQejuYPB
         Koh7wFwZtINokRjQ4NGy6Dk5Dpn5EFXK1QGxe5VIlKlEqllxxdU7q86OtNWtLP1fbETo
         dmgw==
X-Gm-Message-State: APf1xPDkueqBgps0whGscdrpAn0okSpvACpShITgiHbMRsdc0vWkRqmD
        M4cWr9NLbg3YF3bbFO+uTEV/m3oF0fdiu5dp7xrtG7lk+KyY6Zcm3RdVsbLaiIQoD4We+hJ7tqs
        3Z6iJsYU4s+dmaXxYSMjJXMHTTJmV7ZP/sX/HL500JgsioSqMq08geL7Bdw==
X-Google-Smtp-Source: AH8x225Bm+eBB2PufP4ZI+OZumr3E2EaldT0PAMrpCOIk6GynwrJZDYOFGe7sCwRRxjWcVjxYPM69HwLpdg=
MIME-Version: 1.0
X-Received: by 10.36.179.67 with SMTP id z3mr2843537iti.12.1517966008191; Tue,
 06 Feb 2018 17:13:28 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:42 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-6-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 05/35] upload-pack: factor out processing lines
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
 upload-pack.c | 113 ++++++++++++++++++++++++++++++++++++++--------------------
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
2.16.0.rc1.238.g530d649a79-goog

