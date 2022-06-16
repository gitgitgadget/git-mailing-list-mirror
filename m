Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C30C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiFPUEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiFPUE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:04:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B404E3B9
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:04:26 -0700 (PDT)
Received: (qmail 15275 invoked by uid 109); 16 Jun 2022 20:04:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jun 2022 20:04:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 16 Jun 2022 16:04:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] bug_fl(): correctly initialize trace2 va_list
Message-ID: <YquMyakxYnU6mI5a@coredump.intra.peff.net>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
 <d674aefa78bdb6d255e40af2f308abf8a87a593a.1655336146.git.gitgitgadget@gmail.com>
 <Yqq3O5hykBecoVKQ@coredump.intra.peff.net>
 <xmqq8rpxw6ch.fsf@gitster.g>
 <220616.86o7yswyek.gmgdl@evledraar.gmail.com>
 <xmqqk09gtriq.fsf@gitster.g>
 <YquCaE+Vw9P/fybU@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YquCaE+Vw9P/fybU@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 03:20:08PM -0400, Jeff King wrote:

> > > The fix Peff's got here LGTM. I can (re)submit it with
> > > format-patch+send-email after giving it a commit message describing the
> > > issue if you'd like, but the change would be the same.
> > 
> > Yup, I think the code change there looks the most sensible.
> 
> I'll wrap it up with a commit message and modify the test to be more
> thorough.

Here it is. This can replace Johannes's patch 11.

-- >8 --
Subject: bug_fl(): correctly initialize trace2 va_list

The code added 0cc05b044f (usage.c: add a non-fatal bug() function to go
with BUG(), 2022-06-02) sets up two va_list variables: one to output to
stderr, and one to trace2. But the order of initialization is wrong:

  va_list ap, cp;
  va_copy(cp, ap);
  va_start(ap, fmt);

We copy the contents of "ap" into "cp" before it is initialized, meaning
it is full of garbage. The two should be swapped.

However, there's another bug, noticed by Johannes Schindelin: we forget
to call va_end() for the copy. So instead of just fixing the copy's
initialization, let's do two separate start/end pairs. This is allowed
by the standard, and we don't need to use copy here since we have access
to the original varargs. Matching the pairs with the calls makes it more
obvious that everything is being done correctly.

Note that we do call bug_fl() in the tests, but it didn't trigger this
problem because our format string doesn't have any placeholders. So even
though we were passing a garbage va_list through the stack, nobody ever
needed to look at it. We can easily adjust one of the trace2 tests to
trigger this, both for bug() and for BUG(). The latter isn't broken, but
it's nice to exercise both a bit more. Without the fix in this patch
(but with the test change), the bug() case causes a segfault.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-trace2.c | 4 ++--
 usage.c                | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 180c7f53f3..a714130ece 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -224,8 +224,8 @@ static int ut_009bug_BUG(int argc, const char **argv)
 
 static int ut_010bug_BUG(int argc, const char **argv)
 {
-	bug("a bug message");
-	BUG("a BUG message");
+	bug("a %s message", "bug");
+	BUG("a %s message", "BUG");
 }
 
 /*
diff --git a/usage.c b/usage.c
index 79900d0287..56e29d6cd6 100644
--- a/usage.c
+++ b/usage.c
@@ -334,15 +334,17 @@ NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
 int bug_called_must_BUG;
 void bug_fl(const char *file, int line, const char *fmt, ...)
 {
-	va_list ap, cp;
+	va_list ap;
 
 	bug_called_must_BUG = 1;
 
-	va_copy(cp, ap);
 	va_start(ap, fmt);
 	BUG_vfl_common(file, line, fmt, ap);
 	va_end(ap);
-	trace2_cmd_error_va(fmt, cp);
+
+	va_start(ap, fmt);
+	trace2_cmd_error_va(fmt, ap);
+	va_end(ap);
 }
 
 #ifdef SUPPRESS_ANNOTATED_LEAKS
-- 
2.37.0.rc0.352.g10876ef154

