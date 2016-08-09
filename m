Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B39D1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 21:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbcHIV3Z (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 17:29:25 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35010 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932521AbcHIV3T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 17:29:19 -0400
Received: by mail-pa0-f42.google.com with SMTP id iw10so8751206pac.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 14:29:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3UPfRHAVybeFWWQuEKUrMLw1sn7QQj6FPh1Wk46o+gA=;
        b=HdoLxDMP+gMwST1JP3WKlaFmORTVwQSDLBpI421XALcGHWzGyhtLBxoBHhGVVwEttV
         DJT/9sTO9Oo8DNxVpsqDUFhOxjrGzivStwzmD9mrwcDQPXz+GDEr5mOWzKC+iIeZlh5j
         DhBo6gzu1IVZ49iEis3jB94nWbz1F1jWu4fWIhBIRuBW+qzxyqWTU6UCNhNavFdodush
         v9Pd3VjtKWFBzZs+qr6ueN+J5d2rqi1Et5OLFuLyX5i5x97KXB2ujEXKgdL+Jn4eSNz0
         V92GvqSNmKxlBXv1GYYvdQ7sStUEULscx1cS32aCpJOaaJqUPck+sgLb2UYCAJhxgFYY
         HsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3UPfRHAVybeFWWQuEKUrMLw1sn7QQj6FPh1Wk46o+gA=;
        b=gfU0ORxMJoagX1uRmW3BvVwpYTgFmZwayncYexiGQdF1XYrZz4C/RXua/RigqrRf5h
         3faOpTuFN2f+4OI2h0HwaQAGHmu1vjv+HPdx1F61/Ad+MgZySrtgaOF9DbFPkZ+E7HJD
         JAzkU//CP06ArLsvk5pt4XpErPFRy/VkMPhi+Y1QDfpL6NWLC4OPjLVLZHsp5N9ZT9iL
         kHOUJAmrEgPEHCBkHO7Yj5lEHdHCEdseY07/ts9u2M2RQlWlOWJVzIh7hkpIbKiF51HR
         Juu4lVsuzXbbRui5sT44xjOwfJnN45FKrrty/jH1uFanngAes+AFmv7RK0qbVxJaPuVY
         9Cbw==
X-Gm-Message-State: AEkoouvsdeZIVJuZVtg/mLqLGwhsvZlQVQnoip2IKOpuU4x9N+CULtv1zvH8/lzt3bwM9Oxd
X-Received: by 10.66.16.97 with SMTP id f1mr842734pad.39.1470778157379;
        Tue, 09 Aug 2016 14:29:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3c57:f9ac:c795:8f1b])
        by smtp.gmail.com with ESMTPSA id n13sm58197571pfj.16.2016.08.09.14.29.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Aug 2016 14:29:16 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule--helper: use parallel processor correctly.
Date:	Tue,  9 Aug 2016 14:29:13 -0700
Message-Id: <20160809212913.14365-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When developing another patch series I had a temporary state in which
git-clone would segfault, when the call was prepared in
prepare_to_clone_next_submodule. This lead to the call failing, i.e. in
`update_clone_task_finished` the task was scheduled to be tried again.
The second call to prepare_to_clone_next_submodule would return 0, as the
segfaulted clone did create the .git file already, such that was not
considered to need to be cloned again. I was seeing the "BUG: ce was
a submodule before?\n" message, which was the correct behavior at the
time as my local code was buggy. When trying to debug this failure, I
tried to use printing messages into the strbuf that is passed around,
but these messages were never printed as the die(..) doesn't
flush the `err` strbuf.

When implementing the die() in 665b35ecc (2016-06-09, "submodule--helper:
initial clone learns retry logic"), I considered this condition to be
a severe condition, which should lead to an immediate abort as we do not
trust ourselves any more. However the queued messages in `err` are valuable
so let's not toss them out by immediately dying, but a graceful return.

Another thing to note: The error message itself was misleading. A return
value of 0 doesn't indicate the passed in `ce` is not a submodule any more,
but just that we do not consider cloning it any more.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Here is the last patch of the series as an independant bug fix applicable
 on master.
 
 Thanks,
 Stefan

 builtin/submodule--helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6f6d67a..bd7cce6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -748,8 +748,12 @@ static int update_clone_get_next_task(struct child_process *child,
 	if (index < suc->failed_clones_nr) {
 		int *p;
 		ce = suc->failed_clones[index];
-		if (!prepare_to_clone_next_submodule(ce, child, suc, err))
-			die("BUG: ce was a submodule before?");
+		if (!prepare_to_clone_next_submodule(ce, child, suc, err)) {
+			suc->current ++;
+			strbuf_addf(err, "BUG: submodule considered for cloning,"
+				    "doesn't need cloning any more?\n");
+			return 0;
+		}
 		p = xmalloc(sizeof(*p));
 		*p = suc->current;
 		*idx_task_cb = p;
-- 
2.9.2.583.gd6329be.dirty

