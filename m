Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A413C35241
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 05:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334E02075E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 05:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgAYFhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 00:37:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:44390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725781AbgAYFhY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 00:37:24 -0500
Received: (qmail 10929 invoked by uid 109); 25 Jan 2020 05:37:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 05:37:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13808 invoked by uid 111); 25 Jan 2020 05:44:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jan 2020 00:44:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Jan 2020 00:37:23 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/4] merge-recursive: silence -Wxor-used-as-pow warning
Message-ID: <20200125053723.GA744673@coredump.intra.peff.net>
References: <20200125053542.GA744596@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125053542.GA744596@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge-recursive code uses stage number constants like this:

  add = &ci->ren1->dst_entry->stages[2 ^ 1];
  ...
  add = &ci->ren2->dst_entry->stages[3 ^ 1];

The xor has the effect of flipping the "1" bit, so that "2 ^ 1" becomes
"3" and "3 ^ 1" becomes "2", which correspond to the "ours" and "theirs"
stages respectively.

Unfortunately, clang-10 and up issue a warning for this code:

  merge-recursive.c:1759:40: error: result of '2 ^ 1' is 3; did you mean '1 << 1' (2)? [-Werror,-Wxor-used-as-pow]
                  add = &ci->ren1->dst_entry->stages[2 ^ 1];
                                                     ~~^~~
                                                     1 << 1
  merge-recursive.c:1759:40: note: replace expression with '0x2 ^ 1' to silence this warning

We could silence it by using 0x2, as the compiler mentions. Or by just
using the constants "2" and "3" directly. But after digging into it, I
do think this bit-flip is telling us something. If we just wrote:

  add = &ci->ren2->dst_entry->stages[2];

for the second one, you might think that "ren2" and "2" correspond. But
they don't. The logic is: ren2 is theirs, which is stage 3, but we
are interested in the opposite side's stage, so flip it to 2.

So let's keep the bit-flipping, but let's also put it behind a named
function, which will make its purpose a bit clearer. This also has the
side effect of suppressing the warning (and an optimizing compiler
should be able to easily turn it into a constant as before).

Signed-off-by: Jeff King <peff@peff.net>
---
It might be more readable still to #define STAGE_OURS and STAGE_THEIRS,
but the use of bare 2/3 is pervasive throughout the file. We'd probably
want to change it consistently, and perhaps call "ren1" "ren_ours" or
something like that. I'm not overly familiar with this code, so I tried
to keep it to what I found an obvious improvement. But I'm also happy to
go the "0x2 ^ 1" route if merge-recursive experts prefer that.

 merge-recursive.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 10dca5644b..e6aedd3cab 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1712,6 +1712,15 @@ static char *find_path_for_conflict(struct merge_options *opt,
 	return new_path;
 }
 
+/*
+ * Toggle the stage number between "ours" and "theirs" (2 and 3) by flipping
+ * the 1-bit.
+ */
+static inline int flip_stage(int stage)
+{
+	return stage ^ 1;
+}
+
 static int handle_rename_rename_1to2(struct merge_options *opt,
 				     struct rename_conflict_info *ci)
 {
@@ -1756,14 +1765,14 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		 * such cases, we should keep the added file around,
 		 * resolving the conflict at that path in its favor.
 		 */
-		add = &ci->ren1->dst_entry->stages[2 ^ 1];
+		add = &ci->ren1->dst_entry->stages[flip_stage(2)];
 		if (is_valid(add)) {
 			if (update_file(opt, 0, add, a->path))
 				return -1;
 		}
 		else
 			remove_file_from_index(opt->repo->index, a->path);
-		add = &ci->ren2->dst_entry->stages[3 ^ 1];
+		add = &ci->ren2->dst_entry->stages[flip_stage(3)];
 		if (is_valid(add)) {
 			if (update_file(opt, 0, add, b->path))
 				return -1;
@@ -1776,7 +1785,7 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		 * rename/add collision.  If not, we can write the file out
 		 * to the specified location.
 		 */
-		add = &ci->ren1->dst_entry->stages[2 ^ 1];
+		add = &ci->ren1->dst_entry->stages[flip_stage(2)];
 		if (is_valid(add)) {
 			add->path = mfi.blob.path = a->path;
 			if (handle_file_collision(opt, a->path,
@@ -1797,7 +1806,7 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 				return -1;
 		}
 
-		add = &ci->ren2->dst_entry->stages[3 ^ 1];
+		add = &ci->ren2->dst_entry->stages[flip_stage(3)];
 		if (is_valid(add)) {
 			add->path = mfi.blob.path = b->path;
 			if (handle_file_collision(opt, b->path,
@@ -1846,7 +1855,7 @@ static int handle_rename_rename_2to1(struct merge_options *opt,
 	path_side_1_desc = xstrfmt("version of %s from %s", path, a->path);
 	path_side_2_desc = xstrfmt("version of %s from %s", path, b->path);
 	ostage1 = ci->ren1->branch == opt->branch1 ? 3 : 2;
-	ostage2 = ostage1 ^ 1;
+	ostage2 = flip_stage(ostage1);
 	ci->ren1->src_entry->stages[ostage1].path = a->path;
 	ci->ren2->src_entry->stages[ostage2].path = b->path;
 	if (merge_mode_and_contents(opt, a, c1,
-- 
2.25.0.421.gb74d19af79

