Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15EDA20899
	for <e@80x24.org>; Fri, 18 Aug 2017 01:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbdHRBjJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 21:39:09 -0400
Received: from smtp.mail.umich.edu ([141.211.125.12]:45367 "EHLO
        maleficent.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753822AbdHRBjI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Aug 2017 21:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2016-05-12; t=1503020346;
        bh=zPkYPEY2HnIDh+sQC0zMZ1w35NYZxZvgW86Bb7ce84U=;
        h=From:To:Cc:Subject:Date;
        b=HrwlIOGCD5TG2XORnjDX+6DF71CXx2jiVQQVj4CD+uZnEPgZZxWpgMAhtfbHF4gdd
         bQ/5rYf91TwFQnMVHIIR6esBRhvpklhOLFJuD8kHBNMp+aLKShe7/6FGwQ9+H6j3Oy
         bW98CGlv1VlWLEVG2FXLubXBmx/01KSXLxnBTzN0zE49A+Hy4ukqvjb7MGRP/cB/b8
         bOHqqMA8hCUed+Az5gVdb4UxTCLitJQowoQf5Mr05fQDVgowdS7PQNAhK4GBfyV9El
         7dB33Pwx74RmwiUu1+rG7noPziZ3145B74BjC2lOsdLUqAVxaHmja+FSRT9d2ciF0r
         biS3thaBP8TIA==
Authentication-Results: maleficent.mr.itd.umich.edu;
        iprev=pass policy.iprev=67.180.238.167 (c-67-180-238-167.hsd1.ca.comcast.net);
        auth=pass smtp.auth=asottile
Received: FROM localhost.localdomain (c-67-180-238-167.hsd1.ca.comcast.net [67.180.238.167])
        By maleficent.mr.itd.umich.edu ID 5996453A.46739.30381;
        Authuser asottile;
        Thu, 17 Aug 2017 21:39:06 -0400
From:   Anthony Sottile <asottile@umich.edu>
To:     git@vger.kernel.org
Cc:     Anthony Sottile <asottile@umich.edu>
Subject: [PATCH/RFC] git-grep: correct exit code with --quiet and -L
Date:   Thu, 17 Aug 2017 18:38:51 -0700
Message-Id: <20170818013851.16753-1-asottile@umich.edu>
X-Mailer: git-send-email 2.14.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The handling of `status_only` no longer interferes with the handling of
`unmatch_name_only`.  `--quiet` no longer affects the exit code when using
`-L`/`--files-without-match`.

Signed-off-by: Anthony Sottile <asottile@umich.edu>
---
 grep.c          | 2 +-
 t/t7810-grep.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 2efec0e..c9e7cc7 100644
--- a/grep.c
+++ b/grep.c
@@ -1821,7 +1821,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		return 0;
 
 	if (opt->status_only)
-		return 0;
+		return opt->unmatch_name_only;
 	if (opt->unmatch_name_only) {
 		/* We did not see any hit, so we want to show this */
 		show_name(opt, gs->name);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f106387..2a6679c 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -374,6 +374,11 @@ test_expect_success 'grep -L -C' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep --files-without-match --quiet' '
+	git grep --files-without-match --quiet nonexistent_string >actual &&
+	test_cmp /dev/null actual
+'
+
 cat >expected <<EOF
 file:foo mmap bar_mmap
 EOF
-- 
2.7.4

