Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AEDC433E1
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 03:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229EF2078A
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 03:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgHWDMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 23:12:13 -0400
Received: from mimir.eigenstate.org ([206.124.132.107]:11400 "EHLO
        mimir.eigenstate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgHWDMM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 23:12:12 -0400
Received: from oneeye.my.domain (pool-74-101-2-6.nycmny.fios.verizon.net [74.101.2.6])
        by mimir.eigenstate.org (OpenSMTPD) with ESMTPSA id 116bed60 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sat, 22 Aug 2020 20:12:12 -0700 (PDT)
From:   Ori Bernstein <ori@eigenstate.org>
To:     git@vger.kernel.org
Cc:     Ori Bernstein <ori@eigenstate.org>
Subject: [PATCH] Avoid infinite loop in malformed packfiles
Date:   Sat, 22 Aug 2020 20:11:52 -0700
Message-Id: <20200823031151.10985-1-ori@eigenstate.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200823005236.10386-1-ori@eigenstate.org>
References: <20200823005236.10386-1-ori@eigenstate.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In packfile.c:1680, there's an infinite loop that tries to get
to the base of a packfile. With offset deltas, the offset needs
to be greater than 0, so it's always walking backwards, and the
search is guaranteed to terminate.

With reference deltas, there's no check for a cycle in the
references, so a cyclic reference will cause git to loop
infinitely, growing the delta_stack infinitely, which will
cause it to consume all available memory as as a full CPU
core.

This change puts an arbitrary limit of 10,000 on the number
of iterations we make when chasing down a base commit, to
prevent looping forever, using all available memory growing
the delta stack.

Signed-off-by: Ori Bernstein <ori@eigenstate.org>
---
 packfile.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/packfile.c b/packfile.c
index 6ab5233613..321e002c50 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1633,6 +1633,7 @@ static void write_pack_access_log(struct packed_git *p, off_t obj_offset)
 
 int do_check_packed_object_crc;
 
+#define UNPACK_ENTRY_STACK_LIMIT 10000
 #define UNPACK_ENTRY_STACK_PREALLOC 64
 struct unpack_entry_stack_ent {
 	off_t obj_offset;
@@ -1715,6 +1716,12 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			break;
 		}
 
+		if (delta_stack_nr > UNPACK_ENTRY_STACK_LIMIT) {
+			error("overlong delta chain at offset %jd from %s",
+			      (uintmax_t)curpos, p->pack_name);
+			goto out;
+		}
+
 		/* push object, proceed to base */
 		if (delta_stack_nr >= delta_stack_alloc
 		    && delta_stack == small_delta_stack) {
-- 
2.27.0

