Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE9D20A2A
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbdI2UMX (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:23 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:49137 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbdI2UMP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:15 -0400
Received: by mail-pg0-f41.google.com with SMTP id v23so351100pgc.5
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sQzbfBe1epG1IuDBfxyBFJt3naN9qSJBdY34RY3lk54=;
        b=fvkT0xfIqEVYJj6l0/BXW9Apuj54yafXuB1pqpq0/7qXPlSN57XesO86W41TmOQLqA
         4cb2vS/IDNr4qOMe1N4sIr2n7TAsdn4TsUIIE7joYXlUnnWT7zX+Oq61fe2Krmadk3//
         OgicaLm1HVG5PINRhzvQzc5Sw347DMYc9Wi8PN19mL0HR/M28k036Vy3ckinWOKXo1A/
         1uUFahTOq9HTlPWTMbO8tbUx1DwoQP2CSJDOcv0qC0ctD4y1JvBxilLw+PxshUh4GPMj
         ONzLpUGBKJwJZTQDKy/0agGpwrfixAlaEonapJXI5kZDAPmXW9VUrLQsP37B/2rm+eeA
         FHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sQzbfBe1epG1IuDBfxyBFJt3naN9qSJBdY34RY3lk54=;
        b=oDeHdMm9Jtm7mj241czvG7hVYrGWPJBUzKFbd4Wknu1uYFfCZvdqgyxQySfLatY+VH
         T07q0sYA1a7/ALFlgTBIat6qK6/saa9pLc2CIi753NxJg3ELfezJ/QcfQVAjEoBPNc0i
         bDjeaTM0m6jXguO5/DkilKAKIjG7rA1iFQPSDYVWBQqz6HNsv7hiOkHg4MnkJD9H9Wjm
         s6ZHH07rJFeREz3/EmyiuZpWo2Nk3oP+85UKqdO59NmX34+y80qsla1dUAQKpRgdIxOi
         JGfF9R2xCSp28dcPuGXVaM1hnt+E/ZK+zHyMZHwvE+h6bGklLGbwNEQ7vkbHXLqcdT1F
         tw/g==
X-Gm-Message-State: AHPjjUgAzRuM0yzJqpogrS3X5WgfgeAS8Ft1Bc6dRuTQ4c3fOEdwDVc4
        1dhK9158HpN1NhDNdO3Mmnv1QBAsY44=
X-Google-Smtp-Source: AOwi7QCPy6H0xeZ+/dbLrQVcoAhdowQxg3iZxDjMfu+DPLLPEQcBwifHLa+1yHqQVSMaUts4TgTK+Q==
X-Received: by 10.98.86.28 with SMTP id k28mr8826010pfb.89.1506715934033;
        Fri, 29 Sep 2017 13:12:14 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:13 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 05/18] index-pack: refactor writing of .keep files
Date:   Fri, 29 Sep 2017 13:11:41 -0700
Message-Id: <eb0b57bc917db45ae517e9cea05d94b4977b4952.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, index-pack will be taught to write ".promisor"
files which are similar to the ".keep" files it knows how to write.
Refactor the writing of ".keep" files, so that the implementation of
writing ".promisor" files becomes easier.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 99 ++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f2be145e1..7ad170590 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1389,15 +1389,58 @@ static void fix_unresolved_deltas(struct sha1file *f)
 	free(sorted_by_pos);
 }
 
+static const char *derive_filename(const char *pack_name, const char *suffix,
+				   struct strbuf *buf)
+{
+	size_t len;
+	if (!strip_suffix(pack_name, ".pack", &len))
+		die(_("packfile name '%s' does not end with '.pack'"),
+		    pack_name);
+	strbuf_add(buf, pack_name, len);
+	strbuf_addch(buf, '.');
+	strbuf_addstr(buf, suffix);
+	return buf->buf;
+}
+
+static void write_special_file(const char *suffix, const char *msg,
+			       const char *pack_name, const unsigned char *sha1,
+			       const char **report)
+{
+	struct strbuf name_buf = STRBUF_INIT;
+	const char *filename;
+	int fd;
+	int msg_len = strlen(msg);
+
+	if (pack_name)
+		filename = derive_filename(pack_name, suffix, &name_buf);
+	else
+		filename = odb_pack_name(&name_buf, sha1, suffix);
+
+	fd = odb_pack_keep(filename);
+	if (fd < 0) {
+		if (errno != EEXIST)
+			die_errno(_("cannot write %s file '%s'"),
+				  suffix, filename);
+	} else {
+		if (msg_len > 0) {
+			write_or_die(fd, msg, msg_len);
+			write_or_die(fd, "\n", 1);
+		}
+		if (close(fd) != 0)
+			die_errno(_("cannot close written %s file '%s'"),
+				  suffix, filename);
+		*report = suffix;
+	}
+	strbuf_release(&name_buf);
+}
+
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
-		  const char *keep_name, const char *keep_msg,
-		  unsigned char *sha1)
+		  const char *keep_msg, unsigned char *sha1)
 {
 	const char *report = "pack";
 	struct strbuf pack_name = STRBUF_INIT;
 	struct strbuf index_name = STRBUF_INIT;
-	struct strbuf keep_name_buf = STRBUF_INIT;
 	int err;
 
 	if (!from_stdin) {
@@ -1409,28 +1452,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			die_errno(_("error while closing pack file"));
 	}
 
-	if (keep_msg) {
-		int keep_fd, keep_msg_len = strlen(keep_msg);
-
-		if (!keep_name)
-			keep_name = odb_pack_name(&keep_name_buf, sha1, "keep");
-
-		keep_fd = odb_pack_keep(keep_name);
-		if (keep_fd < 0) {
-			if (errno != EEXIST)
-				die_errno(_("cannot write keep file '%s'"),
-					  keep_name);
-		} else {
-			if (keep_msg_len > 0) {
-				write_or_die(keep_fd, keep_msg, keep_msg_len);
-				write_or_die(keep_fd, "\n", 1);
-			}
-			if (close(keep_fd) != 0)
-				die_errno(_("cannot close written keep file '%s'"),
-					  keep_name);
-			report = "keep";
-		}
-	}
+	if (keep_msg)
+		write_special_file("keep", keep_msg, final_pack_name, sha1,
+				   &report);
 
 	if (final_pack_name != curr_pack_name) {
 		if (!final_pack_name)
@@ -1472,7 +1496,6 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	strbuf_release(&index_name);
 	strbuf_release(&pack_name);
-	strbuf_release(&keep_name_buf);
 }
 
 static int git_index_pack_config(const char *k, const char *v, void *cb)
@@ -1615,26 +1638,13 @@ static void show_pack_info(int stat_only)
 	}
 }
 
-static const char *derive_filename(const char *pack_name, const char *suffix,
-				   struct strbuf *buf)
-{
-	size_t len;
-	if (!strip_suffix(pack_name, ".pack", &len))
-		die(_("packfile name '%s' does not end with '.pack'"),
-		    pack_name);
-	strbuf_add(buf, pack_name, len);
-	strbuf_addstr(buf, suffix);
-	return buf->buf;
-}
-
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
 	const char *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
-	const char *keep_name = NULL, *keep_msg = NULL;
-	struct strbuf index_name_buf = STRBUF_INIT,
-		      keep_name_buf = STRBUF_INIT;
+	const char *keep_msg = NULL;
+	struct strbuf index_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
 	unsigned char pack_sha1[20];
@@ -1745,9 +1755,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (!index_name && pack_name)
-		index_name = derive_filename(pack_name, ".idx", &index_name_buf);
-	if (keep_msg && !keep_name && pack_name)
-		keep_name = derive_filename(pack_name, ".keep", &keep_name_buf);
+		index_name = derive_filename(pack_name, "idx", &index_name_buf);
 
 	if (verify) {
 		if (!index_name)
@@ -1795,13 +1803,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
-		      keep_name, keep_msg,
+		      keep_msg,
 		      pack_sha1);
 	else
 		close(input_fd);
 	free(objects);
 	strbuf_release(&index_name_buf);
-	strbuf_release(&keep_name_buf);
 	if (pack_name == NULL)
 		free((void *) curr_pack);
 	if (index_name == NULL)
-- 
2.14.2.822.g60be5d43e6-goog

