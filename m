Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194A220899
	for <e@80x24.org>; Tue,  1 Aug 2017 09:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdHAJDp (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 05:03:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34363 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbdHAJDk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 05:03:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id o33so832988wrb.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BH6cq6CJWAlinVn050ZcjxKAUfmp43w4RS6QVxmLHB8=;
        b=P/iTS8ovKQz1RQSgiJJ3ahL/U0Vzf57/PmZEiaLYcdEgcXFdhej+bdMjiPYMFVFCuF
         sIZbpcdOJT/VErsyBmFpC3hgcscJS2sK4p/JCHmeo5y17yoEpQ9ZFFHgcBqiguW2zwnA
         u3cLFzmOByAeWpVr/U3IG3/P+10t7VQ+u29kxl9dQ48lOR86sqBWxWXZSnBOologIn5T
         YPthHlZuLOqh6CUJQoBNIq1NdHpsnfHJZAR1LNalLov0emrhThQM0V75kENafqxfzvoS
         ldx89xD14OHjh/xlxuPWboMBxSWVAIOPxCufs0Op7c3WUU3qqO3Ryr+u2/PxPw0yYoyy
         GHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=BH6cq6CJWAlinVn050ZcjxKAUfmp43w4RS6QVxmLHB8=;
        b=IHEGX2+3UUcm/8usQkEyiIQROcj2JGuLOOxUii0P9ugidHZ7c511dyJyZ3fLA9nB4r
         ao49tWIfq6MwJkTXRH/23bQVHSA3eiHpWopXVh4anrlkJzlIyDl7HQQd6GxB6j3WkdD+
         fT2nG1MQjnJgVo+Q6yHsMq30jP9zCxcNlekq8j4w8z30iGmLb5NuBWEl1X/uNfi/yTNB
         ur1HNcrJ/0Q+sgluCS3j1FmL1Q5m2AT86+3+sQ0phnxQRzzW0wxmFGVTUPpJHcZp6pYL
         +0gyMYAW4tjrbLya5cWTxFNxAmmkoWTV8PwQlML39U7JVbffhbI9ebtsai/4WKgfnvgY
         3uXA==
X-Gm-Message-State: AIVw111lyUtIuuIrH5Bs3PNpFL49U24Lj7TPexDus4Y0XS2oaI+IaDE4
        aWwoqfnAEYrO4PcLulA=
X-Received: by 10.223.136.155 with SMTP id f27mr14295925wrf.291.1501578218993;
        Tue, 01 Aug 2017 02:03:38 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-192-75.adsl-ull.clienti.tiscali.it. [94.39.192.75])
        by smtp.gmail.com with ESMTPSA id 91sm29947237wrg.83.2017.08.01.02.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Aug 2017 02:03:38 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 2/4] trailers: introduce struct new_trailer_item
Date:   Tue,  1 Aug 2017 11:03:31 +0200
Message-Id: <20170801090333.32642-3-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170801090333.32642-1-bonzini@gnu.org>
References: <20170801090333.32642-1-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

This will provide a place to store the current state of the
--where, --if-exists and --if-missing options.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 builtin/interpret-trailers.c | 41 +++++++++++++++++++++++++++++++++++++----
 trailer.c                    | 19 +++++++++++--------
 trailer.h                    | 14 +++++++++++++-
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 175f14797..8f38fa318 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -16,17 +16,50 @@ static const char * const git_interpret_trailers_usage[] = {
 	NULL
 };
 
+static void new_trailers_clear(struct list_head *trailers)
+{
+	struct list_head *pos, *tmp;
+	struct new_trailer_item *item;
+
+	list_for_each_safe(pos, tmp, trailers) {
+		item = list_entry(pos, struct new_trailer_item, list);
+		list_del(pos);
+		free(item);
+	}
+}
+
+static int option_parse_trailer(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct list_head *trailers = opt->value;
+	struct new_trailer_item *item;
+
+	if (unset) {
+		new_trailers_clear(trailers);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	item = xmalloc(sizeof *item);
+	item->text = arg;
+	list_add_tail(&item->list, trailers);
+	return 0;
+}
+
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	int in_place = 0;
 	int trim_empty = 0;
-	struct string_list trailers = STRING_LIST_INIT_NODUP;
+	LIST_HEAD(trailers);
 
 	struct option options[] = {
 		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
-		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
-				N_("trailer(s) to add")),
+
+		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
+				N_("trailer(s) to add"), option_parse_trailer),
 		OPT_END()
 	};
 
@@ -43,7 +76,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		process_trailers(NULL, in_place, trim_empty, &trailers);
 	}
 
-	string_list_clear(&trailers, 0);
+	new_trailers_clear(&trailers);
 
 	return 0;
 }
diff --git a/trailer.c b/trailer.c
index f02895373..6941da799 100644
--- a/trailer.c
+++ b/trailer.c
@@ -669,9 +669,8 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 }
 
 static void process_command_line_args(struct list_head *arg_head,
-				      struct string_list *trailers)
+				      struct list_head *new_trailer_head)
 {
-	struct string_list_item *tr;
 	struct arg_item *item;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
@@ -695,17 +694,20 @@ static void process_command_line_args(struct list_head *arg_head,
 	}
 
 	/* Add an arg item for each trailer on the command line */
-	for_each_string_list_item(tr, trailers) {
-		int separator_pos = find_separator(tr->string, cl_separators);
+	list_for_each(pos, new_trailer_head) {
+		struct new_trailer_item *tr =
+			list_entry(pos, struct new_trailer_item, list);
+		int separator_pos = find_separator(tr->text, cl_separators);
+
 		if (separator_pos == 0) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_addstr(&sb, tr->string);
+			strbuf_addstr(&sb, tr->text);
 			strbuf_trim(&sb);
 			error(_("empty trailer token in trailer '%.*s'"),
 			      (int) sb.len, sb.buf);
 			strbuf_release(&sb);
 		} else {
-			parse_trailer(&tok, &val, &conf, tr->string,
+			parse_trailer(&tok, &val, &conf, tr->text,
 				      separator_pos);
 			add_arg_item(arg_head,
 				     strbuf_detach(&tok, NULL),
@@ -969,7 +971,8 @@ static FILE *create_in_place_tempfile(const char *file)
 	return outfile;
 }
 
-void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
+void process_trailers(const char *file, int in_place, int trim_empty,
+		      struct list_head *new_trailer_head)
 {
 	LIST_HEAD(head);
 	LIST_HEAD(arg_head);
@@ -987,7 +990,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 	/* Print the lines before the trailers */
 	trailer_end = process_input_file(outfile, sb.buf, &head);
 
-	process_command_line_args(&arg_head, trailers);
+	process_command_line_args(&arg_head, new_trailer_head);
 
 	process_trailers_lists(&head, &arg_head);
 
diff --git a/trailer.h b/trailer.h
index 2b39a1bee..b83b249b6 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,6 +1,8 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
+#include "list.h"
+
 enum trailer_where {
 	WHERE_END,
 	WHERE_AFTER,
@@ -44,8 +46,18 @@ struct trailer_info {
 	size_t trailer_nr;
 };
 
+/*
+ * A list that represents newly-added trailers, such as those provided
+ * with the --trailer command line option of git-interpret-trailers.
+ */
+struct new_trailer_item {
+	struct list_head list;
+
+	const char *text;
+};
+
 void process_trailers(const char *file, int in_place, int trim_empty,
-		      struct string_list *trailers);
+		      struct list_head *new_trailer_head);
 
 void trailer_info_get(struct trailer_info *info, const char *str);
 
-- 
2.13.3


