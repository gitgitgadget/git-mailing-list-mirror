Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7959A1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfBLW1J (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:27:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46356 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfBLW1H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:27:07 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so220792edy.13
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5gylcfuDa0p7UhjHRVil7Fph9lV2JyHGLEhPqvNZpk=;
        b=cK4pa25tt8BB7UTxltfozCVb8ior3AIOZIEXXHtfD/NiKQwYM72E4zUP2ukCdaqRH6
         QsZu8XbaxyIYcFW0yVIjCaM20/xtua4mBaCx7hsBVQlglDONuJQ6cLzfOa54ADWkSL+c
         gQO60TPhCcHPwynxonKH7P0JE16upQ0hHKWEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5gylcfuDa0p7UhjHRVil7Fph9lV2JyHGLEhPqvNZpk=;
        b=lph0miC3IpiFtBU/k2gmvSz7LHz79qmdifRNAciwK7ON6xP+7xqOMOpnD4ctHKb9xD
         rpHLy7VWF06aVKHvD6onkO42lPaSWQPc3AmQ7noFqZoZgNIhMi7hDYD28oZawuoL3XwS
         wAmFwZpn+fKOK9Z2VLYCtAdBkODR3a067iSdXIek3FyknELe7TUSCCxcI6T+PtsbjBg8
         P+VB0bkTaM6vBZmwPeXsrheyq/9FxLt9hvpFaWaXG/1gkJ0VmKWhrOoswMPBiCCAyMvv
         yGDit74vVl9XlB76AheR/dKA/+anDJ2T/GyCAUrF5tfTtJHgIUqjrw3yq/JnsS283L3D
         96rA==
X-Gm-Message-State: AHQUAubnStaPPP18soTsqNOOP0yrdHjntCtYBqK3vqA2eMC+eg4SkE5L
        MFcYPsdBEIuOZeKr+upDcIKZKUZpMEFVx41E
X-Google-Smtp-Source: AHgI3IZNwy4iql+o3o9N+xmtL1YetEmAg08sSSVmdsD4OLrPB+UgOCTk9uOrVXKkYdueokEJM1WIqg==
X-Received: by 2002:a50:cc84:: with SMTP id q4mr5007348edi.12.1550010425461;
        Tue, 12 Feb 2019 14:27:05 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id ay20sm3349582ejb.32.2019.02.12.14.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 14:27:04 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC PATCH 5/5] builtin/grep.c: fix fence-post error in add_work()
Date:   Tue, 12 Feb 2019 23:26:54 +0100
Message-Id: <20190212222654.7432-6-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
References: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're only using 127 of the slots in todo[], which can easily be seen
by adding this hack

--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -93,6 +93,8 @@ static int skip_first_line;

 static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 {
+	static int count;
+
 	grep_lock();

 	while ((todo_end+1) % ARRAY_SIZE(todo) == todo_done) {
@@ -108,6 +110,7 @@ static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);

 	pthread_cond_signal(&cond_add);
+	fprintf(stderr, "added work item %3d\n", ++count);
 	grep_unlock();
 }

@@ -173,6 +176,7 @@ static void *run(void *arg)
 	int hit = 0;
 	struct grep_opt *opt = arg;

+	sleep(2);
 	while (1) {
 		struct work_item *w = get_work();
 		if (!w)

Of course, just removing the +1 after todo_end would be instant
deadlock, since nothing would ever change todo_end or todo_done from
0.

The problem boils down to the fact that arithmetic mod 128 cannot
capture the 129 possible values of end-done (which
is (end-start)+(start-done), i.e. the total number of items waiting to
be picked up or that have been picked up by a worker).

To fix this, don't keep the todo_* variables reduced mod 128, and only
do that when using them as indices into todo[]. Then we can rewrite
the condition in add_work() to the proper one: Wait until todo_end is
not a full round ahead of todo_done.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/grep.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 35ed79b0dd..ce158cabbb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -102,7 +102,7 @@ static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 
 	grep_lock();
 
-	while ((todo_end+1) % ARRAY_SIZE(todo) == todo_done) {
+	while (todo_end - todo_done == ARRAY_SIZE(todo)) {
 		pthread_cond_wait(&cond_write, &grep_mutex);
 	}
 
@@ -112,7 +112,7 @@ static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 		grep_source_load_driver(&w->source, opt->repo->index);
 	w->done = 0;
 	strbuf_reset(&w->out);
-	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
+	todo_end += 1;
 
 	pthread_cond_signal(&cond_add);
 	grep_unlock();
@@ -131,7 +131,7 @@ static struct work_item *get_work(void)
 		ret = NULL;
 	} else {
 		ret = todo_item(todo_start);
-		todo_start = (todo_start + 1) % ARRAY_SIZE(todo);
+		todo_start += 1;
 	}
 	grep_unlock();
 	return ret;
@@ -144,8 +144,7 @@ static void work_done(struct work_item *w)
 	grep_lock();
 	w->done = 1;
 	old_done = todo_done;
-	for(; todo_done != todo_start;
-	    todo_done = (todo_done+1) % ARRAY_SIZE(todo)) {
+	for(; todo_done != todo_start; todo_done += 1) {
 		w = todo_item(todo_done);
 		if (!w->done)
 			break;
-- 
2.20.1

