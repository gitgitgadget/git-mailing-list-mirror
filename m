Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBEAC433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 02:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKXCBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 21:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXCBI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 21:01:08 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2ED25C6A
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 18:01:06 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1669255264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aUX0zC6+aOSqM7R9SHzFf+hya57slYl7zK0tmbhU218=;
        b=QCe4iJa3ySP+BwinBditA473jNwzhVIdXRRRTKkKMa0jFS+SbKSy6wTAxW5vrS8ctxrpfG
        tvsnWVabI/QA6RhjhFvXDrfQNSdx8mRXC2S6qn8b0ieMPXU4FGsm/blSo+HfkbnIgSbEcP
        tPPeHXt3AKCE6M2VhkDhHziAC9sMwZAVZQcSeRN8uDjnsqOlUiiBpvWN0B7bPX+poSom8F
        lgej6te5kIN4OxS5nj37N4Ri7RXBVxeBVTUl679DhGd9T5gG2As2YLLGb2aFjiZ+xvG0Ki
        303m1qbq1PUcZvLzDaXQAshef7617q4CGV/gZkZtk3ty6baa/YP1cxblpbdZeg==
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Subject: [PATCH] send-email: disable option auto-abbreviation
Date:   Wed, 23 Nov 2022 21:00:56 -0500
Message-Id: <20221124020056.242185-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

send-email supports specifying format-patch options.  However, some
valid format-patch short options trigger an error because Getopt's
default auto-abbreviation is enabled.  For example, with

  git send-email -v 3 @{u}

the -v is consumed as send-email's --validate, and 3 is passed on to
the format-patch call, leading to

  fatal: ambiguous argument '3': unknown revision or path not in the
  working tree.  [...]

Disable Getopt's auto-abbreviation feature so that such options are
properly relayed to format-patch.  With this change, there is some
risk of breaking external scripts that rely on the abbreviation, but
that is hopefully unlikely given that Git does not advertise support
for auto-abbreviation and most subcommands do not support it.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 git-send-email.perl   | 2 +-
 t/t9001-send-email.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..1e6d5d7677 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -24,7 +24,7 @@
 use Git;
 use Git::I18N;
 
-Getopt::Long::Configure qw/ pass_through /;
+Getopt::Long::Configure qw/ pass_through no_auto_abbrev /;
 
 package FakeTerm;
 sub new {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 01c74b8b07..c2ebf19ec6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2334,6 +2334,12 @@ test_expect_success $PREREQ 'test that send-email works outside a repo' '
 		"$(pwd)/0001-add-main.patch"
 '
 
+test_expect_success $PREREQ 'send-email relays -v 4' '
+	test_when_finished "rm -f out" &&
+	git send-email --dry-run -v 4 -1 >out &&
+	grep "PATCH v4" out
+'
+
 test_expect_success $PREREQ 'test that sendmail config is rejected' '
 	test_config sendmail.program sendmail &&
 	test_must_fail git send-email \

base-commit: e7e5c6f715b2de7bea0d39c7d2ba887335b40aa0
-- 
2.38.1

