Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8269020209
	for <e@80x24.org>; Fri, 30 Jun 2017 09:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdF3Jtn (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 05:49:43 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:11503 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbdF3Jtk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 05:49:40 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id QsYKdOu0hQ527QsYVdIMsu; Fri, 30 Jun 2017 10:49:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498816179; bh=wiWkcBs3Mx+m63GuHmCl096ikGm/Wh3ig/d/J0IJVzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=slvuQHx+XON1TTKJBfrCH50ltpSueexaL1kGfIwu6OSN4kKYotMCD8k4GmCXVPnFo
         U5tSJenVrc+UeYGD5M/o1LwbrHb99VxO3s1CBLlfInz0B9K6C1T228osATY9fA/o1w
         IgzdwnATWeSJIBsAs10NIxps+IBudZ0AvfAMqBBk=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=cYJeAYfeg3XIO7qQxPMA:9
 a=yPvfxbJaGk3wAi3Y:21 a=8Zxs_WvQP2foteCg:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 4/4] Add tests for Git::unquote_path()
Date:   Fri, 30 Jun 2017 10:49:12 +0100
Message-Id: <20170630094912.8653-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170630094912.8653-1-phillip.wood@talktalk.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
 <20170630094912.8653-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfAYMroW4qle9gm7MsA6l2HRO2wuqJao0k0PRNLh/sivn3cSa7GuZlGPvqo4wldNHDheRr0/0xBUP9fOs3CjgHqLMRD2DqHCmJFmabs0pzqqPweZc9hCI
 alnFLr5/+JGrXiPCfkIW5Yha6g6jpY/pjapbirRHy7yoeRffAaMhzRCsnVc8dYftidBww1dqc62Q1Zda114eaJAwJkcPXw3thVb1JlV/yaoN/ejOxZVpv7jB
 YhNCjlYuGavaj7Rk1jRxj4SnLUZoR7xrDKnvlKfXtDw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check that unquote_path() handles spaces and escape sequences properly

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t9700/test.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 1b75c919651a8126e2a327f3d9645d4377823726..34cd01366f92164ffcd712cb86dac4eb1cffa3f5 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -133,6 +133,13 @@ close TEMPFILE3;
 unlink $tmpfile3;
 chdir($abs_repo_dir);
 
+# unquoting paths
+is(Git::unquote_path('abc'), 'abc', 'unquote unquoted path');
+is(Git::unquote_path('"abc def"'), 'abc def', 'unquote simple quoted path');
+is(Git::unquote_path('"abc\"\\\\ \a\b\t\n\v\f\r\001\040"'),
+		     "abc\"\\ \x07\x08\x09\x0a\x0b\x0c\x0d\x01 ",
+		     'unquote escape sequences');
+
 printf "1..%d\n", Test::More->builder->current_test;
 
 my $is_passing = eval { Test::More->is_passing };
-- 
2.13.1

