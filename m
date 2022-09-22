Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71A6C6FA8B
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 05:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiIVFcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 01:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIVFcH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 01:32:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A910EB0887
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 22:32:06 -0700 (PDT)
Received: (qmail 4689 invoked by uid 109); 22 Sep 2022 05:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 05:32:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30423 invoked by uid 111); 22 Sep 2022 05:32:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 01:32:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 01:32:05 -0400
From:   Jeff King <peff@peff.net>
To:     "John A. Leuenhagen" <john@zlima12.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 1/2] clone: allow "--bare" with "-o"
Message-ID: <YyvzVdfQVdysvMp2@coredump.intra.peff.net>
References: <YyvzIQL9H9aTYNch@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyvzIQL9H9aTYNch@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We explicitly forbid the combination of "--bare" with "-o", but there
doesn't seem to be any good reason to do so. The original logic came as
part of e6489a1bdf (clone: do not accept more than one -o option.,
2006-01-22), but that commit does not give any reason.

Furthermore, the equivalent combination via config is allowed:

  git -c clone.defaultRemoteName=foo clone ...

and works as expected. It may be that this combination was considered
useless, because a bare clone does not set remote.origin.fetch (and
hence there is no refs/remotes/origin hierarchy). But it does set
remote.origin.url, and that name is visible to the user via "git fetch
origin", etc.

Let's allow the options to be used together, and switch the "forbid"
test in t5606 to check that we use the requested name. That test came
much later in 349cff76de (clone: add tests for --template and some
disallowed option pairs, 2020-09-29), and does not offer any logic
beyond "let's test what the code currently does".

Reported-by: John A. Leuenhagen <john@zlima12.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c          | 3 ---
 t/t5606-clone-options.sh | 9 +++++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d269d6fec6..ed8d44bb6a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -929,9 +929,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_bare = 1;
 
 	if (option_bare) {
-		if (option_origin)
-			die(_("options '%s' and '%s %s' cannot be used together"),
-			    "--bare", "--origin", option_origin);
 		if (real_git_dir)
 			die(_("options '%s' and '%s' cannot be used together"), "--bare", "--separate-git-dir");
 		option_no_checkout = 1;
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index f6bb02ab94..cf221e92c4 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -42,11 +42,12 @@ test_expect_success 'rejects invalid -o/--origin' '
 
 '
 
-test_expect_success 'disallows --bare with --origin' '
+test_expect_success 'clone --bare -o' '
 
-	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
-	test_debug "cat err" &&
-	test_i18ngrep -e "options .--bare. and .--origin foo. cannot be used together" err
+	git clone -o foo --bare parent clone-bare-o &&
+	(cd parent && pwd) >expect &&
+	git -C clone-bare-o config remote.foo.url >actual &&
+	test_cmp expect actual
 
 '
 
-- 
2.38.0.rc1.580.gfaa349ad1e

