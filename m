Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5476E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 09:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbeHOMdU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 08:33:20 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:7383 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbeHOMdU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 08:33:20 -0400
Received: from lindisfarne.localdomain ([92.22.33.100])
        by smtp.talktalk.net with SMTP
        id psJGfwZyyoI6LpsJMf4aIs; Wed, 15 Aug 2018 10:41:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1534326113;
        bh=mO7axdoohcrmti9UfBHOIRIeMrhHjZgs0HSsZVpKfa0=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=IgsxuJaYLKhujnsR7PZCLV8cbE2PqB6rJjxxSlalnM7ME2Y4HG0yQvAd74uJtATIv
         yYWfYM1+1UYXD3n84TJuuYZu9JFIDcjPNQfBP2+yMkQAlDoxePXGOdALp7V1J7lq1F
         2YosMb04TaO1XTBPd2Gf8df/OTmfef9qdpdbtqk8=
X-Originating-IP: [92.22.33.100]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=k9WtyX7eyn4O4XzWYcPtUg==:117
 a=k9WtyX7eyn4O4XzWYcPtUg==:17 a=evINK-nbAAAA:8 a=lZ6Z2LaBJZjMTw-ZM3YA:9
 a=sm9mljUkOsizycuz:21 a=pJsNHwhvjzEHR4-A:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] rebase -i: fix numbering in squash message
Date:   Wed, 15 Aug 2018 10:41:25 +0100
Message-Id: <20180815094125.12530-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLtdp/8BCSJlaLWXJBNN7Z5KiVYBp+tMx/vGwnSIck0iZfuo3rvkAwTVb6IBtZK15IUHGhycgZ7mRo+wmxpigy9mSqZFG1XgPf2nVWaJHsTI1uW0ffaV
 zTc1VbMTcf9uZyCOVUBlrOvkzCPOGyHcq87OrAAth/5T47fAFyPhGCOaE7rFM4Z1WQSp5AsM2sAq9Lu9mZPmALQ3o4H1Qt3oJBZGa2R7+C4X6iRH9a6zHlzc
 U5rbKQpew/DXvdH4BHhkkaMibFPJPMhmj9Gl3xKFLZ5TcelsZOIhogUy5OfSiW8n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Commit e12a7ef597 ("rebase -i: Handle "combination of <n> commits" with
GETTEXT_POISON", 2018-04-27) changed the way that individual commit
messages are labelled when squashing commits together. In doing so a
regression was introduced where the numbering of the messages is off by
one. This commit fixes that and adds a test for the numbering.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                | 4 ++--
 t/t3418-rebase-continue.sh | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2eb5ec7227..77d3c2346f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1387,13 +1387,13 @@ static int update_squash_messages(enum todo_command command,
 		unlink(rebase_path_fixup_msg());
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addf(&buf, _("This is the commit message #%d:"),
-			    ++opts->current_fixup_count);
+			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
-			    ++opts->current_fixup_count);
+			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body));
 	} else
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index e9fd029160..ee871dd1bb 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -128,13 +128,15 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 	: The first squash was skipped, therefore: &&
 	git show HEAD >out &&
 	test_i18ngrep "# This is a combination of 2 commits" out &&
+	test_i18ngrep "# This is the commit message #2:" out &&
 
 	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
 	git show HEAD >out &&
 	test_i18ngrep ! "# This is a combination" out &&
 
 	: Final squash failed, but there was still a squash &&
-	test_i18ngrep "# This is a combination of 2 commits" .git/copy.txt
+	test_i18ngrep "# This is a combination of 2 commits" .git/copy.txt &&
+	test_i18ngrep "# This is the commit message #2:" .git/copy.txt
 '
 
 test_expect_success 'setup rerere database' '
-- 
2.18.0

