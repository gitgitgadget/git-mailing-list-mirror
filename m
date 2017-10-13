Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEEFB20437
	for <e@80x24.org>; Fri, 13 Oct 2017 16:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbdJMQ4m (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 12:56:42 -0400
Received: from 28dayslater.mr.itd.umich.edu ([141.211.125.104]:45934 "EHLO
        28dayslater.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752134AbdJMQ4k (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Oct 2017 12:56:40 -0400
X-Greylist: delayed 723 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Oct 2017 12:56:40 EDT
Received: FROM tombraider.mr.itd.umich.edu (smtp.mail.umich.edu [141.211.12.86])
        By 28dayslater.mr.itd.umich.edu ID 59E0ED74.D5B17.13238;
        Fri, 13 Oct 2017 12:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2016-05-12; t=1507913075;
        bh=mC6/FAqRMcjyjry7ZQXVJlBy/DUUeTnelvPoqfDpi4k=;
        h=From:To:Cc:Subject:Date;
        b=QQwwqbAduFpudGw5BepN6AiFUnXx396VCqCFVMqL85LHmTnjN+3kX9yH522Urr9oh
         u8L/SvSxwgrjBtsp7kxRfb2s7XEGh2lu68qr280OlkDmBqvKeAbMOkykSzZDY9tk86
         u02jKfE+FnnJRERomw360/4QdzsIszYVoHY67khoJT5+hUXVI9JkOZAOniCrOrw05z
         /9VS5Vyq5Z0rTHaOq6TcNjFL3bIq8od4sWDEUtNCeswfcHHjoPK2evat88W3btbqnI
         hk2PzHIqlS1IfeITRBMvx/FB0+VTrZKH6+HLK740V+HE9u+aKKEivQHP/XD7dOAiiq
         9j999k+4y3Z9A==
Authentication-Results: tombraider.mr.itd.umich.edu;
        iprev=permerror policy.iprev=4.14.106.2 (unknown);
        auth=pass smtp.auth=asottile
Received: FROM asottile-VirtualBox.lyft-corp.net (unknown [4.14.106.2])
        By tombraider.mr.itd.umich.edu ID 59E0ED72.B3C09.24367;
        Authuser asottile;
        Fri, 13 Oct 2017 12:44:34 -0400
From:   Anthony Sottile <asottile@umich.edu>
To:     git@vger.kernel.org
Cc:     Anthony Sottile <asottile@umich.edu>
Subject: [PATCH] diff: alias -q to --quiet
Date:   Fri, 13 Oct 2017 09:44:15 -0700
Message-Id: <20171013164415.6632-1-asottile@umich.edu>
X-Mailer: git-send-email 2.15.0.rc1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, `-q` was silently ignored:

Before:

$ git diff -q -- Documentation/; echo $?
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index a88c767..aa6e724 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -587,6 +587,7 @@ ifndef::git-log[]
        That is, it exits with 1 if there were differences and
        0 means no differences.

+-q::
 --quiet::
        Disable all output of the program. Implies `--exit-code`.
 endif::git-log[]
0
$

After:
$ ./git diff -q -- Documentation/; echo $?
1
$

Signed-off-by: Anthony Sottile <asottile@umich.edu>
---
 Documentation/diff-options.txt | 1 +
 diff.c                         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index a88c767..aa6e724 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -587,6 +587,7 @@ ifndef::git-log[]
 	That is, it exits with 1 if there were differences and
 	0 means no differences.
 
+-q::
 --quiet::
 	Disable all output of the program. Implies `--exit-code`.
 endif::git-log[]
diff --git a/diff.c b/diff.c
index 69f0357..13dfc3e 100644
--- a/diff.c
+++ b/diff.c
@@ -4751,7 +4751,7 @@ int diff_opt_parse(struct diff_options *options,
 	}
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
-	else if (!strcmp(arg, "--quiet"))
+	else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
 		DIFF_OPT_SET(options, QUICK);
 	else if (!strcmp(arg, "--ext-diff"))
 		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
-- 
2.7.4

