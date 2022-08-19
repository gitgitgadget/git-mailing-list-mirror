Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66469C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348244AbiHSKIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348275AbiHSKIb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:08:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2343A2655D
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:28 -0700 (PDT)
Received: (qmail 17657 invoked by uid 109); 19 Aug 2022 10:08:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 916 invoked by uid 111); 19 Aug 2022 10:08:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/11] git-compat-util: add UNUSED macro
Message-ID: <Yv9hG/12/yvqZOnf@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for compiling with -Wunused-parameter, we'd like to be
able to annotate some function parameters as false positives (e.g.,
parameters which must exist to conform to a callback interface).

Ideally our annotation will:

  - be portable, turning into nothing on platforms which don't support
    it

  - be easy to read, without looking too syntactically odd or taking
    attention away from the rest of the parameters

  - help us notice when a parameter marked as unused is actually used,
    which keeps our annotations accurate. In theory a compiler could
    tell us this easily, but gcc has no such warning. Clang has
    -Wused-but-marked-unused, but it triggers false positives with our
    MAYBE_UNUSED annotation (e.g., for commit-slab functions)

This patch introduces an UNUSED() macro which takes the parameter name
as an argument. That lets us tweak the name in such a way that we'll
notice if somebody tries to use it. It looks like this in use:

  int some_ref_cb(const char *refname,
                  const struct object_id *UNUSED(oid),
                  int UNUSED(flags),
                  void *UNUSED(data))
  {
        printf("got refname %s", refname);
        return 0;
  }

Because the unused parameter names are rewritten behind the scenes to
UNUSED_oid, etc, adding code like:

  printf("oid is %s", oid_to_hex(oid));

will fail compilation with "oid undeclared". Sadly, the "did you mean"
feature of modern compilers is not generally smart enough to suggest the
"unused" name. If we used a very short prefix like U_oid, that does
convince gcc to say "did you mean", but since the "U_" in the suggestion
isn't much of a hint, it doesn't really help. In practice, a look at the
function definition usually makes the problem pretty obvious.

Note that we have to put the definition of UNUSED early in
git-compat-util.h, because it will eventually be used for some compat
functions themselves (both directly here and in mingw.h).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 36a25ae252..c6669db07d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -189,6 +189,12 @@ struct strbuf;
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
+#if defined(__GNUC__)
+#define UNUSED(var) UNUSED_##var __attribute__((unused))
+#else
+#define UNUSED(var) UNUSED_##var
+#endif
+
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
 # if !defined(_WIN32_WINNT)
 #  define _WIN32_WINNT 0x0600
-- 
2.37.2.928.g0821088f4a

