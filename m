Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823A51F667
	for <e@80x24.org>; Tue, 22 Aug 2017 21:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdHVVrQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 17:47:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56139 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752742AbdHVVrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 17:47:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2362190138;
        Tue, 22 Aug 2017 17:47:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=ciFi
        /JCxmmgaLUWIMjBqOVsYMi0=; b=NyJnYWnBAk4vDauIbni7g85RtGQLW3YVVHC+
        8M1EYpa+Oq5K8jqhOU1iMjw7u7DqYc7Eb6woQDszdOEBpL5+V+aMVQqiRDhDSlxp
        HUKNEDwr+ovO0uUqiO+6P26oQbBkuTmg89OioMdHySGAGD/6qpBLJwqqxv3uSGWN
        uSt1JiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=UBQq7v
        QHqpH+K4PeJLlAuz7tgR+ONN+CW4w+wkrnbYLQkO7TW8rShHrzUV0kYlhhfVSDg0
        klyoRX29x9TRolf/J3qjxUOJ5du1ttITVM9XNGTGAiQSo09jhRLPKIp5cJd31KMQ
        ux9R+KtlFLEe4gqwirpxhFIwP6jhVtEZaxsUU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 150C690137;
        Tue, 22 Aug 2017 17:47:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6917590133;
        Tue, 22 Aug 2017 17:47:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 5/6] rerere: represent time duration in timestamp_t internally
Date:   Tue, 22 Aug 2017 14:46:51 -0700
Message-Id: <20170822214652.31626-6-gitster@pobox.com>
X-Mailer: git-send-email 2.14.1-427-g5711bb0564
In-Reply-To: <20170822214652.31626-1-gitster@pobox.com>
References: <20170819203013.3053-1-gitster@pobox.com>
 <20170822214652.31626-1-gitster@pobox.com>
X-Pobox-Relay-ID: 6E9EBAEE-8783-11E7-BB73-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two configuration variables, gc.rerereResolved and
gc.rerereUnresolved, are measured in days and are passed as such
into the prune_one() helper function, which worked in time_t to see
if an entry in the rerere database is past its expiry.

Instead, have the caller turn the number of days into the expiry
timestamp.  Further, use timestamp_t instead of time_t.  This will
make it possible to extend the way the configuration variable is
spelled by using date.c::parse_expiry_date() that gives the expiry
timestamp in timestamp_t.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/rerere.c b/rerere.c
index 70634d456c..f0b4bce881 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1133,14 +1133,14 @@ int rerere_forget(struct pathspec *pathspec)
  * Garbage collection support
  */
 
-static time_t rerere_created_at(struct rerere_id *id)
+static timestamp_t rerere_created_at(struct rerere_id *id)
 {
 	struct stat st;
 
 	return stat(rerere_path(id, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
 
-static time_t rerere_last_used_at(struct rerere_id *id)
+static timestamp_t rerere_last_used_at(struct rerere_id *id)
 {
 	struct stat st;
 
@@ -1157,11 +1157,11 @@ static void unlink_rr_item(struct rerere_id *id)
 	id->collection->status[id->variant] = 0;
 }
 
-static void prune_one(struct rerere_id *id, time_t now,
-		      int cutoff_resolve, int cutoff_noresolve)
+static void prune_one(struct rerere_id *id,
+		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
 {
-	time_t then;
-	int cutoff;
+	timestamp_t then;
+	timestamp_t cutoff;
 
 	then = rerere_last_used_at(id);
 	if (then)
@@ -1172,25 +1172,35 @@ static void prune_one(struct rerere_id *id, time_t now,
 			return;
 		cutoff = cutoff_noresolve;
 	}
-	if (then < now - cutoff * 86400)
+	if (then < cutoff)
 		unlink_rr_item(id);
 }
 
+static void config_get_expiry(const char *key, timestamp_t *cutoff, timestamp_t now)
+{
+	int days;
+
+	if (!git_config_get_int(key, &days)) {
+		const int scale = 86400;
+		*cutoff = now - days * scale;
+	}
+}
+
 void rerere_gc(struct string_list *rr)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
 	DIR *dir;
 	struct dirent *e;
 	int i;
-	time_t now = time(NULL);
-	int cutoff_noresolve = 15;
-	int cutoff_resolve = 60;
+	timestamp_t now = time(NULL);
+	timestamp_t cutoff_noresolve = now - 15 * 86400;
+	timestamp_t cutoff_resolve = now - 60 * 86400;
 
 	if (setup_rerere(rr, 0) < 0)
 		return;
 
-	git_config_get_int("gc.rerereresolved", &cutoff_resolve);
-	git_config_get_int("gc.rerereunresolved", &cutoff_noresolve);
+	config_get_expiry("gc.rerereresolved", &cutoff_resolve, now);
+	config_get_expiry("gc.rerereunresolved", &cutoff_noresolve, now);
 	git_config(git_default_config, NULL);
 	dir = opendir(git_path("rr-cache"));
 	if (!dir)
@@ -1211,7 +1221,7 @@ void rerere_gc(struct string_list *rr)
 		for (id.variant = 0, id.collection = rr_dir;
 		     id.variant < id.collection->status_nr;
 		     id.variant++) {
-			prune_one(&id, now, cutoff_resolve, cutoff_noresolve);
+			prune_one(&id, cutoff_resolve, cutoff_noresolve);
 			if (id.collection->status[id.variant])
 				now_empty = 0;
 		}
-- 
2.14.1-427-g5711bb0564

