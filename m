Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461B4C83F11
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 12:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjH1M5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjH1M5f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 08:57:35 -0400
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 05:57:31 PDT
Received: from out-247.mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFE2C3
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 05:57:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1693227102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=STuyrror4xcLQO9JkZp+pWlccgFQSbsQ7tYtCf0d6/8=;
        b=I6jXCT4bV/ZATX2uVJawDElHgpz25vgh22KKg/cd2NQCjrGNIdJ0LYrn/lI/LVSouAPpxc
        LCy1MJV3gMehxrnQoyB0ElX7Vv1I0UTwxyQTBVvNQzQqzXvEyFDvwR/z0XZuIfWVkLSSGE
        rGz0IG9hhHcL4eVGTs4WfQFhf9mxC18dYPCBq8Bjsy8jlPbqKiiGsay7W9zd2eUHAY36a3
        ZRL7XAC/EhdzWXmyn10C/Dqh31IILVH1D+VjRxSBwm1vyM8L10dk8MMafw2P3fJ/ZlLwXO
        /wcP9BysyDR9N1BrVg/v16wiLcSDEGOQrrSGDKKHt356gNH0IGXjaf93XI4oOg==
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH] builtin/log.c: prepend "RFC" on --rfc
Date:   Mon, 28 Aug 2023 14:50:34 +0200
Message-ID: <20230828125132.25144-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than replacing the configured subject prefix (either through the
git config or command line) entirely with "RFC PATCH", this change
prepends RFC to whatever subject prefix was already in use.

This is useful, for example, when a user is working on a repository that
has a subject prefix considered to disambiguate patches:

	git config format.subjectPrefix 'PATCH my-project'

Prior to this change, formatting patches with --rfc would lose the
'my-project' information.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
Implementation note: this introduces a small memory leak, but freeing it
requires a non-trivial amount of refactoring and some dubious choices
that I was not sure of for a small patch; and it seems like memory leaks
in this context are tolerated anyway from a perusal of the existing
code.

 Documentation/git-format-patch.txt |  6 +++---
 builtin/log.c                      | 15 ++++++++++++++-
 t/t4014-format-patch.sh            |  9 +++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 373b46fc0d..fdc52cf826 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -229,9 +229,9 @@ populated with placeholder text.
 	variable, or 64 if unconfigured.
 
 --rfc::
-	Alias for `--subject-prefix="RFC PATCH"`. RFC means "Request For
-	Comments"; use this when sending an experimental patch for
-	discussion rather than application.
+	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
+	default). RFC means "Request For Comments"; use this when sending
+	an experimental patch for discussion rather than application.
 
 -v <n>::
 --reroll-count=<n>::
diff --git a/builtin/log.c b/builtin/log.c
index db3a88bfe9..d986faebed 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1476,9 +1476,22 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
 
 static int rfc_callback(const struct option *opt, const char *arg, int unset)
 {
+	int n;
+	char *prefix;
+	const char *prev;
+
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	return subject_prefix_callback(opt, "RFC PATCH", unset);
+
+	prev = ((struct rev_info *)opt->value)->subject_prefix;
+	assert(prev != NULL);
+	n = snprintf(NULL, 0, "RFC %s", prev);
+	assert(n > 0);
+	prefix = xmalloc(n + 1);
+	n = snprintf(prefix, n + 1, "RFC %s", prev);
+	assert(n > 0);
+
+	return subject_prefix_callback(opt, prefix, unset);
 }
 
 static int numbered_cmdline_opt = 0;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3cf2b7a7fb..a7fe839683 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1377,6 +1377,15 @@ test_expect_success '--rfc' '
 	test_cmp expect actual
 '
 
+test_expect_success '--rfc does not overwrite prefix' '
+	cat >expect <<-\EOF &&
+	Subject: [RFC PATCH foobar 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --subject-prefix "PATCH foobar" --rfc >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--from=ident notices bogus ident' '
 	test_must_fail git format-patch -1 --stdout --from=foo >patch
 '
-- 
2.42.0

