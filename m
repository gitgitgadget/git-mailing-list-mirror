Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582BAC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015912176B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgJGSTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:19:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:52630 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgJGSTY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:19:24 -0400
Received: (qmail 21257 invoked by uid 109); 7 Oct 2020 18:19:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Oct 2020 18:19:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14891 invoked by uid 111); 7 Oct 2020 18:19:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Oct 2020 14:19:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Oct 2020 14:19:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: [PATCH 1/3] index-pack: restore "resolving deltas" progress meter
Message-ID: <20201007181923.GA1976631@coredump.intra.peff.net>
References: <20201007181708.GA222564@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007181708.GA222564@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit f08cbf60fe (index-pack: make quantum of work smaller, 2020-09-08)
refactored the main loop in threaded_second_pass(), but also deleted the
call to display_progress() at the top of the loop. This means that users
typically see no progress at all during the delta resolution phase (and
for large repositories, Git appears to hang).

This looks like an accident that was unrelated to the intended change of
that commit, since we continue to update nr_resolved_deltas in
resolve_delta(). Let's restore the call to get that progress back.

We'll also add a test that confirms we generate the expected progress.
This isn't perfect, as it wouldn't catch a bug where progress was
delayed to the end. That was probably possible to trigger when receiving
a thin pack, because we'd eventually call display_progress() from
fix_unresolved_deltas(), but only once after doing all the work.
However, since our test case generates a complete pack, it reliably
demonstrates this particular bug and its fix. And we can't do better
without making the test racy.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c  | 4 ++++
 t/t5302-pack-index.sh | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8da4031e72..0f05533902 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1028,6 +1028,10 @@ static void *threaded_second_pass(void *data)
 		struct object_entry *child_obj;
 		struct base_data *child;
 
+		counter_lock();
+		display_progress(progress, nr_resolved_deltas);
+		counter_unlock();
+
 		work_lock();
 		if (list_empty(&work_head)) {
 			/*
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index c92e553a2f..7c9d687367 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -277,4 +277,11 @@ test_expect_success 'index-pack --fsck-objects also warns upon missing tagger in
 	grep "^warning:.* expected .tagger. line" err
 '
 
+test_expect_success 'index-pack -v --stdin produces progress for both phases' '
+	pack=$(git pack-objects --all pack </dev/null) &&
+	GIT_PROGRESS_DELAY=0 git index-pack -v --stdin <pack-$pack.pack 2>err &&
+	test_i18ngrep "Receiving objects" err &&
+	test_i18ngrep "Resolving deltas" err
+'
+
 test_done
-- 
2.29.0.rc0.520.gccaf68d5cd

