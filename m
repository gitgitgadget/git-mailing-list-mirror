Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703B41F404
	for <e@80x24.org>; Fri, 23 Feb 2018 14:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbeBWOsG (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 09:48:06 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32962 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWOsE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 09:48:04 -0500
Received: by mail-lf0-f66.google.com with SMTP id o145so9482358lff.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rr3eUkO+UKIwIozR7YJddBT+aW9TCy3OLR3EgDuXXnw=;
        b=cA9vlR7kRq1cNaPgjCz69Gt7v0iDw2n4ObHD22DkF4Sw/msWxFJkZzq8MFg+GOz76x
         OABMoLLN+AZhLOix4kWKDJWKlZBDkJJ12v8zVjB8Z7VbFSPo4y7GptaEATQxbN9vw4rA
         fYXJi2rkXcjHiNVk+oKCiwU6DaeUyi9DOa+Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rr3eUkO+UKIwIozR7YJddBT+aW9TCy3OLR3EgDuXXnw=;
        b=W+2f9otC6oHmCZq9VpUquXCJB/JojkWGQS7rJIalIC9RB7NyXa5v0H3XPrISZGcqUk
         0vzF19BHswp0XnPepcPndAhRXu0339weKbycXkVvLoHtvqNSa7aegovormuDT5uEojhd
         bg14sDUeq8wroHsUoo/9zg6w4nX3jlOu7WnFLnYz7GBZ69Ye6Vz8ZMgozquAmzxqlycB
         Jq9pf9BwPsQCja/hYx8Ol7Ja1QxZ9k1r8xcSynv9wd0BVsCJIKnall4tIK2YX5iXHLnk
         ShpCcP3Iw8fgBD0bQLPPJOV58eLxvbiYh0egggThG2KV9VS3cgwl4lQVC83vSow8jwTf
         w8LQ==
X-Gm-Message-State: APf1xPA0D8aRL04+DhpiOlTppUFLIDN4chXs3VrtwSPqWoQHJuTwfADv
        W8aSsWnhokBXcUE8zjCXyDGQj6dSn4Y=
X-Google-Smtp-Source: AG47ELulJLDTG2u0nrzFWKJkkKxq2lKsF4KL9B/MHsO+tCLyhAMP4HsmugMmzNSruX234dUh9oOoTg==
X-Received: by 10.46.74.2 with SMTP id x2mr1596990lja.99.1519397282656;
        Fri, 23 Feb 2018 06:48:02 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t21sm497958ljd.55.2018.02.23.06.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 06:48:02 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 1/2] grep: move grep_source_init outside critical section
Date:   Fri, 23 Feb 2018 15:47:56 +0100
Message-Id: <20180223144757.31875-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180223144757.31875-1-rv@rasmusvillemoes.dk>
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
 <20180223144757.31875-1-rv@rasmusvillemoes.dk>
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
long "GREP_SOURCE_OID, pathbuf.buf, path, oid" argument list); a
subsequent cleanup patch will make that even more so.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/grep.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d..aad422bb6 100644
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
@@ -325,18 +325,22 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 		strbuf_addstr(&pathbuf, filename);
 	}
 
+	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
+
 #ifndef NO_PTHREADS
 	if (num_threads) {
-		add_work(opt, GREP_SOURCE_OID, pathbuf.buf, path, oid);
+		/*
+		 * add_work() copies gs and thus assumes ownership of
+		 * its fields, so do not call grep_source_clear()
+		 */
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
 
@@ -348,24 +352,29 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
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
+		/*
+		 * add_work() copies gs and thus assumes ownership of
+		 * its fields, so do not call grep_source_clear()
+		 */
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

