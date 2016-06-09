From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule--helper: initial clone learns retry logic
Date: Thu,  9 Jun 2016 12:06:36 -0700
Message-ID: <20160609190637.21177-2-sbeller@google.com>
References: <20160609190637.21177-1-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 09 21:07:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB5IT-0000jT-L4
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 21:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbcFITHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 15:07:04 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34596 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbcFITHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 15:07:01 -0400
Received: by mail-pa0-f47.google.com with SMTP id bz2so15802315pad.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 12:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IXVuwIchPmkXomilRPOzggXSai1nP28k7UmY95TM4Cw=;
        b=adO6M+kIbzWWs4pNSefOI21iukKGbPh2n1/s9lo7vrsIOxJ3EPRvaaCWaBpuqPS73z
         JSGpMf/5sd4P5SmIeD+9+18Px0Af68r/jNKOkdK/UK+BMaXfqWqQKH8k+lajmAIqECL8
         BxWqQ/gDPK1+H4LR/Qp/jZcQ9AgxKgERTalznfFdK3f0GEtUMv7YKo/pxd4YhEiCbIcv
         ihqferxgBefK7piNZdFQ+0V06Wz3Igk04CI4HEwUEiOj+cdQWPWuWcWpxbJE7/Jat3BA
         QMYXRN0kEduEpOJnOMQ8Rg8ZVwJAsdGMA58F7VKBaz2/OQpxC38ub4bME2DtesenIyWQ
         bT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IXVuwIchPmkXomilRPOzggXSai1nP28k7UmY95TM4Cw=;
        b=losx1bUPiccAhUisZmKsLtPfEiJOArNIPQ3LpX9yzPUkrCIP9GuCqqdmmvh+vPvqCx
         JVc0HLjJT/u/ID6foYMguuB6gT6fEYbaa7pP1sCtABtvRvuEV2dAuRNMy2XotXNoAIKu
         2kscvHeWWap/e04bgNyquEyEFu5HZqDozSI4GYvP6OI1UMLC55IOxytWhTfP/8CmUiBW
         bsE7Eta8ylxbo7c1qU8asavYUAKplroZZqGxLjSSon26SjbZ07qcxiAikq20v/jwwD5z
         6CuF4zjngsAYTB/jTc1bZ07k1YIuzBCWJrODXBmQDXQ9A1DHJeUmxpBgeZILFqtDU47A
         WknQ==
X-Gm-Message-State: ALyK8tIfU4cO/BAl/t3x+CI9az0ry/KDucCFhPChk3aCLsDJsr3poWA23Tb7SfOmWNGm/EIg
X-Received: by 10.66.231.35 with SMTP id td3mr14082462pac.56.1465499220067;
        Thu, 09 Jun 2016 12:07:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f5a6:3f4d:c2c2:71e])
        by smtp.gmail.com with ESMTPSA id u65sm11918367pfa.9.2016.06.09.12.06.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Jun 2016 12:06:59 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc2.368.gdadd65c
In-Reply-To: <20160609190637.21177-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296915>

Each submodule that is attempted to be cloned, will be retried once in
case of failure after all other submodules were cloned. This helps to
mitigate ephemeral server failures and increases chances of a reliable
clone of a repo with hundreds of submodules immensely.

The choice of the priority queue is a bit miss-leading as we use it as a
standard queue, but the priority queue offers the best API to use.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c7deb55..efb6759 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -12,6 +12,7 @@
 #include "remote.h"
 #include "refs.h"
 #include "connect.h"
+#include "prio-queue.h"
 
 static char *get_default_remote(void)
 {
@@ -568,6 +569,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int compare_ce(const void *one, const void *two, void *cb_data)
+{
+	const struct cache_entry *ce_one = one, *ce_two = two;
+	return ce_two - ce_one;
+}
+
 struct submodule_update_clone {
 	/* index into 'list', the list of submodules to look into for cloning */
 	int current;
@@ -590,10 +597,13 @@ struct submodule_update_clone {
 
 	/* If we want to stop as fast as possible and return an error */
 	unsigned quickstop : 1;
+
+	/* Queue of failed clones, containing the cache_entry */
+	struct prio_queue failed_queue;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
-	STRING_LIST_INIT_DUP, 0}
+	STRING_LIST_INIT_DUP, 0, { compare_ce }}
 
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
@@ -718,23 +728,36 @@ cleanup:
 static int update_clone_get_next_task(struct child_process *child,
 				      struct strbuf *err,
 				      void *suc_cb,
-				      void **void_task_cb)
+				      void **ce_task_cb)
 {
 	struct submodule_update_clone *suc = suc_cb;
+	const struct cache_entry *ce;
 
 	for (; suc->current < suc->list.nr; suc->current++) {
-		const struct cache_entry *ce = suc->list.entries[suc->current];
+		ce = suc->list.entries[suc->current];
 		if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
+			*ce_task_cb = (struct cache_entry *) ce;
 			suc->current++;
 			return 1;
 		}
 	}
+	/*
+	 * The loop above tried cloning each submodule once,
+	 * now try the stragglers again.
+	 */
+	ce = (struct cache_entry *) prio_queue_get(&suc->failed_queue);
+	if (ce) {
+		if (!prepare_to_clone_next_submodule(ce, child, suc, err))
+			die("BUG: ce was a submodule before?");
+		return 1;
+	}
+
 	return 0;
 }
 
 static int update_clone_start_failure(struct strbuf *err,
 				      void *suc_cb,
-				      void *void_task_cb)
+				      void *ce_task_cb)
 {
 	struct submodule_update_clone *suc = suc_cb;
 	suc->quickstop = 1;
@@ -744,15 +767,18 @@ static int update_clone_start_failure(struct strbuf *err,
 static int update_clone_task_finished(int result,
 				      struct strbuf *err,
 				      void *suc_cb,
-				      void *void_task_cb)
+				      void *ce_task_cb)
 {
 	struct submodule_update_clone *suc = suc_cb;
+	struct cache_entry *ce = ce_task_cb;
 
 	if (!result)
 		return 0;
 
-	suc->quickstop = 1;
-	return 1;
+	strbuf_addf(err, _("Failed to clone '%s'. Scheduled for retry"),
+			   ce->name);
+	prio_queue_put(&suc->failed_queue, ce);
+	return 0;
 }
 
 static int update_clone(int argc, const char **argv, const char *prefix)
-- 
2.9.0.rc2.368.gdadd65c
