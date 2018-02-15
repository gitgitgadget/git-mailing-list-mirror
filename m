Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B2D1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 21:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756079AbeBOV42 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 16:56:28 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40147 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755949AbeBOV4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 16:56:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id v10so74437wmh.5
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 13:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rm+dCZ0yoJVmLe85EqNk40zYxl4xlf9NpRYOTw99yas=;
        b=Apph8JtykzAwcJ5Am9udXHxvXNbTqIcxVqpYOas7nwQgEOU2zblgKYjzq+KM8VwHzw
         uZ8hSXRVh9piToRo/ZcSUupABqoqdMEdiqb7mAD2uB0do2fGseYsTr5f/LrEgLA3TpR8
         5/2rt13yKhfgBFDYp3F3pVwlpPNXwoopj4NzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rm+dCZ0yoJVmLe85EqNk40zYxl4xlf9NpRYOTw99yas=;
        b=i+qkIRanaiGh8fFGARNwAtZiOX3KzwNFEinpxprYzGmjH5So54WZ7hSDSJSDMySZwW
         wzKm6ndKlecSDVe2iQJruOBZN4fcJkE5MGhvH3kbzp/Kr6r8WIp22sYcjbnxs51vue8O
         31VaOWASKbuB5KNsnOT+YLcKGuZKIZQ0B2oJtlbGhJLM1oD9hw5nQP62XgsXSXroR9Oi
         y+Hk+ssb4Iz80MhVi9IL6FU2hurpipc62GBygPOHSi+kFhkORGUTNGtnniAQotCLvTs4
         iIEpgaw52L5ukKmGjgO8yBiM4FqgGPdYvB+ZiWbrjUb2cqGYdx6/fJ4lN9IMb89opKB+
         LmYg==
X-Gm-Message-State: APf1xPATK9ybv75vgJOcoqIfHCBLl1b1TJi6HuDb8sQgO9X1dAiqkwjC
        9gwA7YqafAbcTicwGSfgmLyF9kbqW3Q=
X-Google-Smtp-Source: AH8x227M5qoOtVvwduV9PLyQrQQ3HXoVQskG/RjH/lKDBaNDR/j6OZMiZ+atV0j8x/ShhfEeH6TjKw==
X-Received: by 10.80.147.71 with SMTP id n7mr5194521eda.189.1518731783678;
        Thu, 15 Feb 2018 13:56:23 -0800 (PST)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-126-104.cgn.ip.fibianet.dk. [5.186.126.104])
        by smtp.gmail.com with ESMTPSA id d60sm11476124edc.40.2018.02.15.13.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Feb 2018 13:56:23 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 1/3] grep: move grep_source_init outside critical section
Date:   Thu, 15 Feb 2018 22:56:13 +0100
Message-Id: <20180215215615.21208-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

grep_source_init typically does three strdup()s, and in the threaded
case, the call from add_work() happens while holding grep_mutex.

We can thus reduce the time we hold grep_mutex by moving the
grep_source_init() call out of add_work(), and simply have add_work()
copy the initialized structure to the available slot in the todo
array.

This also simplifies the prototype of add_work(), since it no longer
needs to duplicate all the parameters of grep_source_init(). In the
callers of add_work(), we get to reduce the amount of code duplicated in
the threaded and non-threaded cases slightly (avoiding repeating the
"GREP_SOURCE_OID, pathbuf.buf, path, oid" argument list); a subsequent
cleanup patch will make that even more so.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/grep.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d..4a4f15172 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -92,8 +92,7 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
-static void add_work(struct grep_opt *opt, enum grep_source_type type,
-		     const char *name, const char *path, const void *id)
+static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 {
 	grep_lock();
 
@@ -101,7 +100,7 @@ static void add_work(struct grep_opt *opt, enum grep_source_type type,
 		pthread_cond_wait(&cond_write, &grep_mutex);
 	}
 
-	grep_source_init(&todo[todo_end].source, type, name, path, id);
+	todo[todo_end].source = *gs;
 	if (opt->binary != GREP_BINARY_TEXT)
 		grep_source_load_driver(&todo[todo_end].source);
 	todo[todo_end].done = 0;
@@ -317,6 +316,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 		     const char *path)
 {
 	struct strbuf pathbuf = STRBUF_INIT;
+	struct grep_source gs;
 
 	if (opt->relative && opt->prefix_length) {
 		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
@@ -325,18 +325,18 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 		strbuf_addstr(&pathbuf, filename);
 	}
 
+	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
+
 #ifndef NO_PTHREADS
 	if (num_threads) {
-		add_work(opt, GREP_SOURCE_OID, pathbuf.buf, path, oid);
+		add_work(opt, &gs);
 		strbuf_release(&pathbuf);
 		return 0;
 	} else
 #endif
 	{
-		struct grep_source gs;
 		int hit;
 
-		grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
 		strbuf_release(&pathbuf);
 		hit = grep_source(opt, &gs);
 
@@ -348,24 +348,25 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 static int grep_file(struct grep_opt *opt, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct grep_source gs;
 
 	if (opt->relative && opt->prefix_length)
 		quote_path_relative(filename, opt->prefix, &buf);
 	else
 		strbuf_addstr(&buf, filename);
 
+	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
+
 #ifndef NO_PTHREADS
 	if (num_threads) {
-		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename, filename);
+		add_work(opt, &gs);
 		strbuf_release(&buf);
 		return 0;
 	} else
 #endif
 	{
-		struct grep_source gs;
 		int hit;
 
-		grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
 		strbuf_release(&buf);
 		hit = grep_source(opt, &gs);
 
-- 
2.15.1

