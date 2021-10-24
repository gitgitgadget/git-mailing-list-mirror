Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1EBC433FE
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 01:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6C860F5D
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 01:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhJXBxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 21:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhJXBx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 21:53:29 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D156C061348
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 18:51:07 -0700 (PDT)
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635039789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zvUx/pvXDtGvEIPj1TmAF7TBkvn8/o9R7wNj40BXPI=;
        b=xTp+ZdEh60jZLvBqD8UIvGn4L58MWQA688HCiYtuOUGMqWgD67DDSBbKStFf5DHGRi6nU+
        m/P6z5zn3XSqGv3aH8VIe5kY65Rbhxi6J+G6PYgQVj41svk7Pbm7qm3+Cgc3NT1wbC/Qic
        4GVf6gGsVlcJoGRt0N9XUsXtecoPglmD6PP3wYGDmDORenL1SZsqBU/kiKL1op9Dr09yy9
        xxM3Pu0z+YckDQ78Wt/IkI5OOh07W3S0so1UzQiCdIv+a9Ogy1MWBgSaTg9tpo3mNc96RA
        ZqX/AMOj5pFKzMSappCm1HWMk/ykHNyWa4H+iyTJfxKgpeQ0XMCP0SEH/dG6ykuHkvrWcr
        OiP87Qo6+SN8aV8QyOYrrFYPOjEAEBYVI4FO05+YqPhQywnpiDKgS9srPwlAoUSFerFo/r
        wiAm+JA7nvc0L46/0/UFYuRK/qb01xF5o4MH+K6Ck7MlymxI5UryVSimXKdanmg23byJrg
        /VoYoCrNbTlDnxbTziWh7Yi18QfaENz8V7VFPZMgEj3ah4nSBemRtqUxR+AqSywdye9oGj
        7I8xqDd/g+gMETYW/jZ2SNeSR621vl0F8Ahazz4pqmww5NHaazWgS4prV3cfteQJVAOWga
        ZeHRIcQdxDUlxeGQCMF3HBHNaSaBiPQWCVBFabbp/m7ELcbHaUEl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635039789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zvUx/pvXDtGvEIPj1TmAF7TBkvn8/o9R7wNj40BXPI=;
        b=GObaaHA/y06d599kMlqN5hEg5vS0tLk+fJ9Jg6CbaO7181qr0ZNMbhL3QhH6b6dWJXGsKz
        sjYzU+cg3JLQTZBg==
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 3/3] pretty: add abbrev option to %(describe)
Date:   Sat, 23 Oct 2021 21:42:56 -0400
Message-Id: <20211024014256.3569322-4-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211024014256.3569322-1-eschwartz@archlinux.org>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The %(describe) placeholder by default, like `git describe`, uses a
seven-character abbreviated commit hash. This may not be sufficient to
fully describe all git repos, resulting in a placeholder replacement
changing its length because the repository grew in size. This could
cause the output of git-archive to change.

Add the --abbrev option to `git describe` to the placeholder interface
in order to provide tools to the user for fine-tuning project defaults
and ensure reproducible archives.

One alternative would be to just always specify --abbrev=40 but this may
be a bit too biased...

Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
---
 Documentation/pretty-formats.txt | 4 ++++
 pretty.c                         | 2 +-
 t/t4205-log-pretty-formats.sh    | 8 ++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 14107ac191..317c1382b5 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -221,6 +221,10 @@ The placeholders are:
 			  the same time.
 +
 ** 'tags[=<BOOL>]': Also consider lightweight tags.
+** 'abbrev=<N>': Instead of using the default number of hexadecimal digits
+   (which will vary according to the number of objects in the repository with a
+   default of 7) of the abbreviated object name, use <n> digits, or as many digits
+   as needed to form a unique object name.
 ** 'match=<pattern>': Only consider tags matching the given
    `glob(7)` pattern, excluding the "refs/tags/" prefix.
 ** 'exclude=<pattern>': Do not consider tags matching the given
diff --git a/pretty.c b/pretty.c
index 3a41bedf1a..a092457274 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1217,7 +1217,7 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 static size_t parse_describe_args(const char *start, struct strvec *args)
 {
 	const char *options[] = { "tags" };
-	const char *option_arguments[] = { "match", "exclude" };
+	const char *option_arguments[] = { "match", "exclude", "abbrev" };
 	const char *arg = start;
 
 	for (;;) {
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index d4acf8882f..35eef4c865 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1010,4 +1010,12 @@ test_expect_success '%(describe:tags) vs git describe --tags' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(describe:abbrev=...) vs git describe --abbrev=...' '
+	test_when_finished "git tag -d tagname" &&
+	git tag -a -m tagged tagname &&
+	git describe --abbrev=15 >expect &&
+	git log -1 --format="%(describe:abbrev=15)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.1

