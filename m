From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] index-pack: Use the new worker pool
Date: Wed, 26 Aug 2015 17:52:45 -0700
Message-ID: <1440636766-12738-5-git-send-email-sbeller@google.com>
References: <1440636766-12738-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 02:53:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUlRN-0000YW-CI
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 02:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbbH0AxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 20:53:10 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35408 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbbH0Aw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 20:52:57 -0400
Received: by pacdd16 with SMTP id dd16so5113263pac.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 17:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YpS0jd9/MCYNP+PVNyFkaVbpPieqpgFwIdvriF6KHqo=;
        b=FzhCYkiTKmW/8Vtra1xKfN90c/M8+xQcEmvRFS6bzC1IsCmOV5sZjAubR7i3ysDnTs
         D+aJaAHPxTQqDFeTdPRfCunN9cpSfgyRKvKVIkMJprcW7BSN1n+ldGvKYc2aJUKKnior
         1WdZxpKhGAN2BWIEjvry1+oWKLeUsodQfMAVyuNxiGfNY88+dreVSyi7/vFF74nA1lcT
         L8WOrt5L89TH1w/opbpdcJuFnbhEmubcfh/HNkeTVs6n8ybbOJHsGwZPzaaomseJ1SAB
         SeSyvzKlLcu/7aJ66rKhUyEym6vmOSJ22oj6K27BnyVAZLcht5avlWSeZxlWc99vVE+U
         D4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YpS0jd9/MCYNP+PVNyFkaVbpPieqpgFwIdvriF6KHqo=;
        b=bDscvE2aC/2Rt6F2oyrMQIv5Ft9fMBGh5OYITCFnNqjKA4tc3qJQcnAFxY2yCtoezu
         fjht0nYt1vNKSP7STdq8T+V42lynNXfG6NfTWxuweyVQ5Yj+3hXE7HMl86OFe8bAzFQ0
         hBLRbrqbGDED6HHquplVKPPNWKKhjbA5YcWAyxUnA0U75Py8HdWRCkw71jirtqu4cqEn
         NjmB3HpNatWKTgxj5VI8p6HqxEB5vMyf3Cj/805dpHJ0apUrm+gpJDiPFROlUCFmNJAA
         enCKKUiSDq33M903PjRWPoyQcK2QW6RCtAJ3pzYItXimeG4NKotJTHsKLmdKO2TWE84C
         Ow0w==
X-Gm-Message-State: ALoCoQkxrwx57al2UovCHhX9v50rPNKowpjnEUvTtaVwrI2ihRVqJo6VGtl8AdLa5Cf127iuSRZx
X-Received: by 10.68.57.170 with SMTP id j10mr2352480pbq.56.1440636777213;
        Wed, 26 Aug 2015 17:52:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:806a:7c76:ca55:3bf1])
        by smtp.gmail.com with ESMTPSA id kn8sm281913pab.38.2015.08.26.17.52.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Aug 2015 17:52:56 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g784836d
In-Reply-To: <1440636766-12738-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276655>

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
2.5.0.264.g784836d
