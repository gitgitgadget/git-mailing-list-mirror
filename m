Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436E0ECDFA1
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 23:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiJYX3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiJYX3k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 19:29:40 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64C2AD6
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:29:39 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j21-20020a17090a7e9500b00212b3905d87so5052353pjl.9
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g1mC+p8bxnj+EIcdRtC5k4EbdELX1MHPqO62MqZDbUE=;
        b=J6aUgZ2DLHmhjjHWaNKPVm4DXV7zDhGOa7yW9IaxCt1oObZbU4pReYY7Q8zSVzKTop
         NfedRSiWH75YblLgAsdbEuMAETLHpFMyXUoU4TITI1sdeAXXgZxBfKDTpS+PjEdFzNER
         RpCZYsRTrjWEjN4iBre9UFpbuTSEziAo5f+e3TF0B5nB9kE7kADLeG1jss81ylA0ev4m
         Flgfb9+mYaPI3e/epHAFX8fgRv8fdxP8caWlbvFVvYpQ/H2lOMS6cd/eJNCdENIda1Q0
         l6l+WTWOg0uggX98jptxbVXBF1UEt83bY4FULTVS7fyhfaSdWmytFYU/DQY4V1CjaIbB
         DVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1mC+p8bxnj+EIcdRtC5k4EbdELX1MHPqO62MqZDbUE=;
        b=XxBa3P2Vfy8A+9F4pfYAU0XgCzqu+DXGLOEcoWq7dBRYCwtJOfptn4J0saJ0zTaIcQ
         YcmPMuOB/UEhfp3Qw62eLv3HMdQFWYqYv7HcillaF/uJ9ECMQUHm53ZtDrn7Cdcvwiif
         WV1G2TXYcZYLAsPaG4aNe/i0dE51A8iIp/mv/vzDYN9eVXPpbZW+faubYzjC6zi78kjR
         hEcDSNSXv76fIwtUUDk1OysV1TB1JrfeP6U06F0pzgESXbnHQZ7CtOy/u8NlC50pwFnC
         pmVYoR64g68wXMCdT8XdVCbx+ozgkUpjlAbMdqzST0WlrwGExKdrZ4CY10GCslTR8NNI
         CmUg==
X-Gm-Message-State: ACrzQf06bgwiqQEQWOjxa/ctjBHKwAD7zlNak0JxSz8XF4++UqigEDdY
        dUg50Z/Ny8qSxvLbxYFq/LRC16/KAoBHLQUqYu9+IG7cLMtE5viOlJhpBvAEe37GxWAMZ3ujzov
        UlrMnK1ImZKsCC5g6DQG1xfzP7rvMZLMlcNAIfv0wGa4Bg+Dz9s26kzJUcrq+eckxpd0vJbKb9t
        Qa
X-Google-Smtp-Source: AMsMyM75vS3hgNRK/Kgj/ah/lEwiI81463yLlOA4KeYU2ZQdecTQ3qDxaOitSsAn3cTwU0XzphYWuzarjmOYO0VRAw2M
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:e90:b0:213:2708:8dc3 with
 SMTP id fv16-20020a17090b0e9000b0021327088dc3mr781746pjb.2.1666740578343;
 Tue, 25 Oct 2022 16:29:38 -0700 (PDT)
Date:   Tue, 25 Oct 2022 16:29:34 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025232934.1504445-1-jonathantanmy@google.com>
Subject: [PATCH] negotiator/skipping: avoid stack overflow
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mark_common() in negotiator/skipping.c may overflow the stack due to
recursive function calls. Avoid this by instead recursing using a
heap-allocated data structure.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This was observed at $DAYJOB.

To reviewers, you can check the diff with:
  git show --color-moved-ws=allow-indentation-change --color-moved
to more clearly show which lines are new and which lines have only
changed indentation.
---
 negotiator/skipping.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index c4398f5ae1..0f5ac48e87 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -86,21 +86,26 @@ static int clear_marks(const char *refname, const struct object_id *oid,
 /*
  * Mark this SEEN commit and all its SEEN ancestors as COMMON.
  */
-static void mark_common(struct data *data, struct commit *c)
+static void mark_common(struct data *data, struct commit *seen_commit)
 {
-	struct commit_list *p;
+	struct prio_queue queue = { NULL };
+	struct commit *c;
 
-	if (c->object.flags & COMMON)
-		return;
-	c->object.flags |= COMMON;
-	if (!(c->object.flags & POPPED))
-		data->non_common_revs--;
+	prio_queue_put(&queue, seen_commit);
+	while ((c = prio_queue_get(&queue))) {
+		struct commit_list *p;
+		if (c->object.flags & COMMON)
+			return;
+		c->object.flags |= COMMON;
+		if (!(c->object.flags & POPPED))
+			data->non_common_revs--;
 
-	if (!c->object.parsed)
-		return;
-	for (p = c->parents; p; p = p->next) {
-		if (p->item->object.flags & SEEN)
-			mark_common(data, p->item);
+		if (!c->object.parsed)
+			return;
+		for (p = c->parents; p; p = p->next) {
+			if (p->item->object.flags & SEEN)
+				prio_queue_put(&queue, p->item);
+		}
 	}
 }
 
-- 
2.38.0.135.g90850a2211-goog

