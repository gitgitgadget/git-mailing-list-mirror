Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851A6C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673D4613C9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFJNIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:08:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:51228 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhFJNIk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:08:40 -0400
Received: (qmail 7643 invoked by uid 109); 10 Jun 2021 13:06:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 13:06:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29815 invoked by uid 111); 10 Jun 2021 13:06:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 09:06:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 09:06:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] add_pending_object_with_path(): work around "gcc -O3"
 complaint
Message-ID: <YMIOY6Hp6//yGrFm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When compiling with -O3, some gcc versions (10.2.1 here) complain about
an out-of-bounds subscript:

  revision.c: In function ‘do_add_index_objects_to_pending’:
  revision.c:321:22: error: array subscript [1, 2147483647] is outside array bounds of ‘char[1]’ [-Werror=array-bounds]
    321 |   if (0 < len && name[len] && buf.len)
        |                  ~~~~^~~~~

The "len" parameter here comes from calling interpret_branch_name(),
which intends to return the number of characters of "name" it parsed.

But the compiler doesn't realize this. It knows the size of the empty
string "name" passed in from do_add_index_objects_to_pending(), but it
has no clue that the "len" we get back will be constrained to "0" in
that case.

And I don't think the warning is telling us about some subtle or clever
bug. The implementation of interpret_branch_name() is in another file
entirely, and the compiler can't see it (you can even verify there is no
clever LTO going on by replacing it with "return 0" and still getting
the warning).

We can work around this by replacing our "did we hit the trailing NUL"
subscript dereference with a length check. We do not even have to pay
the cost for an extra strlen(), as we can pass our new length into
interpret_branch_name(), which was converting our "0" into a call to
strlen() anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
Together with ab/trace2-squelch-gcc-warning and the ll-merge fix I
posted in [0], this makes the whole project compile cleanly with "-O3"
for me.

I suspect after this patch we could drop the "if len is 0, call strlen()
as a courtesy" code from interpret_branch_name() entirely. But the call
stack gets pretty hairy (some of these len values come directly from
the get_oid functions directly!) so I wasn't brave enough to follow
through on that.

It's even possible the current code in interpret_branch_name() could be
buggy here, if some caller is using a non-NUL-terminated buffer or a
portion of a string, and we mistake a true "0" size for a request to
call strlen(). That might be worth poking at, but I didn't want to spend
time on it just now.

[0] https://lore.kernel.org/git/YMIKwsEFnkqz6PWa@coredump.intra.peff.net/

 revision.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 8140561b6c..cddd0542a6 100644
--- a/revision.c
+++ b/revision.c
@@ -316,9 +316,10 @@ static void add_pending_object_with_path(struct rev_info *revs,
 		revs->no_walk = 0;
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
 		struct strbuf buf = STRBUF_INIT;
-		int len = interpret_branch_name(name, 0, &buf, &options);
+		size_t namelen = strlen(name);
+		int len = interpret_branch_name(name, namelen, &buf, &options);
 
-		if (0 < len && name[len] && buf.len)
+		if (0 < len && len < namelen && buf.len)
 			strbuf_addstr(&buf, name + len);
 		add_reflog_for_walk(revs->reflog_info,
 				    (struct commit *)obj,
-- 
2.32.0.529.g079a794268
