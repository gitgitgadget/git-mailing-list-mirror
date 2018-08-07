Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C194E208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 09:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeHGLsg (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 07:48:36 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:39998 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeHGLsg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 07:48:36 -0400
Received: from lindisfarne.localdomain ([92.22.26.195])
        by smtp.talktalk.net with SMTP
        id myOIfyQGYbZX5myOPf3so5; Tue, 07 Aug 2018 10:35:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533634506;
        bh=sDB9gnhDFvLJUPW4ZGheNCxegl06gMfyrm7FM73KSL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=WU1mlCf5LY3SW1itQRdaGpuHgYQfHK2LUuj3Qf0S2/jHr+tsJWo9Iszokxf0171+w
         4N5x+FAy6w419kHoGa+xlZ+piv+woOt5AlvaJjfRMBGBQtAvuCCrWCEavCEwLXiAJ3
         v7k8D8Jw3GHVHz4WSiAFoCB8zsE+grt6DSd8DGqs=
X-Originating-IP: [92.22.26.195]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=8bf3kEuDtVJeVZALKX4IsA==:117
 a=8bf3kEuDtVJeVZALKX4IsA==:17 a=evINK-nbAAAA:8 a=BCjA09oAAAAA:8
 a=LJ9Rvin4MAgj4d4Y3hQA:9 a=_KC-vHavC9zWheXl:21 a=dwd6ePpVhiWvQS5y:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=jYKBPJSq9nmHKCndOPe9:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 1/2] sequencer: handle errors from read_author_ident()
Date:   Tue,  7 Aug 2018 10:34:51 +0100
Message-Id: <20180807093452.22524-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807093452.22524-1-phillip.wood@talktalk.net>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180807093452.22524-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBqTbLJnzWaZzlHB1lGSY7nBdJpUbr0Tl1DL2Bfw5Z0BH1NEDUvK3ihA9jou9KJgEWvmF35wa0mpSgECktJjDM9ZqxhIhZI9a7N2YdKpgwBI4/UBRisb
 QN8YgY9CJhygn+nT7seYkPpcFmcZTHpdORwBFNmAlliLEuoOj+49AMB33utWV6Zx7quQKDZQCbkR+aEMovrzlfzlwj66nz4hMxcEqVJj6zfwZTz55p9bHGoO
 4xREflmS5eqNlljiuvcoaxmN8doEdNrxKNmvpZkLEDEpkyJ4G0kLKY0HXTmMuikNVKdPoJo8HL8Ja/RIqvSoHFCGTRjsPZRiA6rx5qjtbUs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check for a NULL return value from read_author_ident() that indicates
an error. Previously the NULL author was passed to commit_tree() which
would then fallback to using the default author when creating the new
commit. This changed the date and potentially the author of the commit
which corrupted the author data compared to its expected value.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v3:
    
     - Implemented the simpler scheme suggested by Eric

 sequencer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 944dea6997..c4e4418559 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -795,11 +795,18 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
 	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
 		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
-		const char *author = is_rebase_i(opts) ?
-			read_author_ident(&script) : NULL;
+		const char *author = NULL;
 		struct object_id root_commit, *cache_tree_oid;
 		int res = 0;
 
+		if (is_rebase_i(opts)) {
+			author = read_author_ident(&script);
+			if (!author) {
+				strbuf_release(&script);
+				return -1;
+			}
+		}
+
 		if (!defmsg)
 			BUG("root commit without message");
 
-- 
2.18.0

