Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C301F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeB0LEh (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:04:37 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:48503 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbeB0LE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:04:29 -0500
Received: from lindisfarne.localdomain ([89.242.176.20])
        by smtp.talktalk.net with SMTP
        id qd3QeQ4WdoNnDqd3ceXd1F; Tue, 27 Feb 2018 11:04:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519729468;
        bh=BbB5Iwmjucr5OD0+0d6qpeboUjDL1yHtD3kgVhn7cao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=TLdKj8GK0xOgeBeL8aN63cplzCuRS6YMu/fQN2/9sasflb+gtDdhFqbUQ5E5vpoUl
         uww6HLeYZmWkOZsliCC16I9gwaRc5PpKyBJ45i7f5AHsjWv4cDJ/X7v2o2ZVhUQM/G
         LW2hkPtOD2lWsAx47R8eKXe3ApbjpQ8LhpYuoxFc=
X-Originating-IP: [89.242.176.20]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=BZXIa/HMvEOrkAULb1ciZg==:117
 a=BZXIa/HMvEOrkAULb1ciZg==:17 a=evINK-nbAAAA:8 a=btPmDDSnAHUVDtEEeN8A:9
 a=z2bXthiuOIam2nBN:21 a=hEE-zIYjV4AsxFf3:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 9/9] add -p: don't rely on apply's '--recount' option
Date:   Tue, 27 Feb 2018 11:04:04 +0000
Message-Id: <20180227110404.16816-10-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180227110404.16816-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180227110404.16816-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfO8HvJeCRbP7IsoBzLkiVt2gMzTaj/3KOoXVaCr/EuDu00KbIV8upnffm00N6fg3rZKcZPnLtZ+kLMFQrNZRjAkzjsWe5kv/cF2SdMT7ubPKYHEuo+8t
 DD8nsaZaqk3GEFpjg3Q0heJrSwrNLc3dWNkDzaMjC0Y1Z+g/OgPn5G3Kp+HZd9KeNfu7p+K2Kkhpt2llMQV4ij+KiJg5L73gsAkZy7yWgK4T1kQlFTWlKs0O
 95qNFwB6XhVZQfSaI+DPqZOb1GbQnizW4T1uKUoGPpk9/6Ugrts6aevSzL46FtgmKYaDJqfMdrfX1N46vElxF3PoMxHBXM9wf5gquVs98/s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that add -p counts patches properly it should be possible to turn
off the '--recount' option when invoking 'git apply'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    I can't think of a reason why this shouldn't be OK but I can't help
    feeling slightly nervous about it. I've made it a separate patch so it
    can be easily dropped or reverted if I've missed something.

 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3226c2c4f0..a64c0db57d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -677,7 +677,7 @@ sub add_untracked_cmd {
 sub run_git_apply {
 	my $cmd = shift;
 	my $fh;
-	open $fh, '| git ' . $cmd . " --recount --allow-overlap";
+	open $fh, '| git ' . $cmd . " --allow-overlap";
 	print $fh @_;
 	return close $fh;
 }
-- 
2.16.1

