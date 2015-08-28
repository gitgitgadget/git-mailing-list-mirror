From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 8/9] index-pack: Use the new worker pool
Date: Thu, 27 Aug 2015 18:14:54 -0700
Message-ID: <1440724495-708-9-git-send-email-sbeller@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 03:15:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV8Gg-00012l-Fx
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 03:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbbH1BPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 21:15:43 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33473 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbbH1BPK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 21:15:10 -0400
Received: by padfo6 with SMTP id fo6so4642615pad.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 18:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uzSI0wetqD3a2fnl6TSTdYCuAB+vZKeZqQs9uqKkHq0=;
        b=ORpzwgGNOYGv3krn/Se2kfzEMH8vjd0L4YZJIh7WkA3SoaX4EVji3MeTMTB/2b+W8t
         +YW9kl4z8nUc6mszJFMYLsj1rKAQ/sm9+EcyfIQAU0qdbCSF5cysc4/IZIt4uM+v2Lrj
         EZMupv/fAwKMD/hAao8Wj4Yj8I2DkKsvwQNZnkXDRNeZ/qYB1Aiqe6oizBL9R0fQC7nr
         eb853wTLpp3TD3WYBtmLhjbkTaVVGWmadsygIU9wSj9m+mEC1o9VuFa7Atcm/mfNaEJQ
         hI/tKXmIJdHIhrsnIw9GxhhKSnrnp8eYwHTekTZjI0NX4tKuLVycZLX9kG+gOAX57IZY
         0ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uzSI0wetqD3a2fnl6TSTdYCuAB+vZKeZqQs9uqKkHq0=;
        b=kfdSPCW7/gFJ7tcQK5xuzZqP0UHG/4WXBuDDDFo8opAxJZxWDSGt1aQIiNi5e1Nu0Z
         m81/ZdDY0/1ot+/qzOzDwFSZI1M5ZUjxBM2okoGEv6/zGcaUivUn0L9rHMfgS8VOs1XW
         KYhxanOIMJqCh9WavRUkuOlJSzSHaXurtMxyNxr5dH8ByxLMtXsWOiwEnIUC8jNFfwuW
         2qlmtKongA4p5bM7PhLsmCnLu3qp5p1GP1s2ezv3r20mfim6i0dBA+BrZFKljTMmXFZs
         NDvpxENkBzfbY3fO6IB8KIjOXQZdHTmMBlGNqSlEtTY2pVe7ZEKni0m4wDTnhHsRcMHi
         xdyA==
X-Gm-Message-State: ALoCoQnjdnbdgkG+9P+dWE2+74i0ClgcDErJj2s1ouiLucTBS2vl8n0MyVZOXViRgTFcQu7D3B6r
X-Received: by 10.69.27.68 with SMTP id je4mr10716556pbd.163.1440724509485;
        Thu, 27 Aug 2015 18:15:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bce4:8b21:c71b:de7e])
        by smtp.gmail.com with ESMTPSA id mv4sm3736902pdb.51.2015.08.27.18.15.08
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 27 Aug 2015 18:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g5e52b0d
In-Reply-To: <1440724495-708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276695>

This demonstrates how the new threading API may be used.
There is no change in the workflow, just using the new
threading API instead of keeping track of the pthreads
ourselves.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/index-pack.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3f10840..187b281 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1075,7 +1075,7 @@ static void resolve_base(struct object_entry *obj)
 }
 
 #ifndef NO_PTHREADS
-static void *threaded_second_pass(void *data)
+static int threaded_second_pass(struct task_queue *tq, void *data)
 {
 	set_thread_data(data);
 	for (;;) {
@@ -1096,7 +1096,7 @@ static void *threaded_second_pass(void *data)
 
 		resolve_base(&objects[i]);
 	}
-	return NULL;
+	return 0;
 }
 #endif
 
@@ -1195,18 +1195,19 @@ static void resolve_deltas(void)
 					  nr_ref_deltas + nr_ofs_deltas);
 
 #ifndef NO_PTHREADS
-	nr_dispatched = 0;
+
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
+		struct task_queue *tq;
+		nr_dispatched = 0;
 		init_thread();
-		for (i = 0; i < nr_threads; i++) {
-			int ret = pthread_create(&thread_data[i].thread, NULL,
-						 threaded_second_pass, thread_data + i);
-			if (ret)
-				die(_("unable to create thread: %s"),
-				    strerror(ret));
-		}
+
+		tq = create_task_queue(nr_threads);
 		for (i = 0; i < nr_threads; i++)
-			pthread_join(thread_data[i].thread, NULL);
+			add_task(tq, threaded_second_pass, thread_data + i);
+
+		if (finish_task_queue(tq, NULL))
+			die("Not all threads have finished");
+
 		cleanup_thread();
 		return;
 	}
-- 
2.5.0.264.g5e52b0d
