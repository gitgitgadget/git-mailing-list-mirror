Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C1E1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 10:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJ3TcV (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 15:32:21 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:15529 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbeJ3TcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 15:32:21 -0400
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id HRQbg5GIzdJAeHRQigS6Mk; Tue, 30 Oct 2018 10:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540895964;
        bh=yiV+rGxaQqQbbgXMjd/he6CGkjrVB2KKXu+hBZOTu2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=RjjKPmFosJkMo9hOOfprqL9z1yCnE9ILhH+rhmEi9v0R5fj8A93i21oaTLHSm42jp
         UYAD3xZJBdylu+k62GZDd3NCS7ESv4FJW5PwgPovEvIhG5nXqbQZRx1L8lzwKlrG2+
         MKec7eFGKLGQ8ujR2OkYWuuII/5DHfJ96B/hvwCI=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=BCjA09oAAAAA:8
 a=1ulBX1ryXkBVU36sZhAA:9 a=Z5tHxQ38kdD2Mam8:21 a=iSUq80Ko9vD66vLc:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=jYKBPJSq9nmHKCndOPe9:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/5] am: don't die in read_author_script()
Date:   Tue, 30 Oct 2018 10:39:12 +0000
Message-Id: <20181030103916.6241-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181030103916.6241-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181030103916.6241-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD1SEs9fZRSNd3MMjvb4kHEOB80kfXmcb5XgEPx0rAwdbdniLTHdJd6EpUwLqmHPbX7svp+4NBmdu6JZtaQAyrA1lsWMRqD3DjtrFxL8U6cAao5190wY
 CW739GCRfB7lh37SWzwNbx6owiG8H2/7YcgRcrYHMiJxYx3j8eqzVtwWulF5NfDteyIjFuITx7JLqeFey1Q//vTEvaMDv6z85N7dyutBGT9u2HdYMUgBOlQ7
 n64sIufT001iL+nEeP60mTJlCSYCXKLl6WTx1pTRx/xk3jDr38BCtzZ/gPv8DHAq3vXREyp82n5MqzE5e7WyMHafp1u5BBwlaavJhD7ik40=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The caller is already prepared to handle errors returned from this
function so there is no need for it to die if it cannot read the file.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/am.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5e866d17c7..b68578bc3f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -318,7 +318,8 @@ static int read_author_script(struct am_state *state)
 	if (fd < 0) {
 		if (errno == ENOENT)
 			return 0;
-		die_errno(_("could not open '%s' for reading"), filename);
+		return error_errno(_("could not open '%s' for reading"),
+				   filename);
 	}
 	strbuf_read(&buf, fd, 0);
 	close(fd);
-- 
2.19.1

