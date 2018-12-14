Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D16320A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 13:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeLNNF4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 08:05:56 -0500
Received: from mail.javad.com ([54.86.164.124]:53908 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbeLNNF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 08:05:56 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 2B8F73FC90;
        Fri, 14 Dec 2018 12:56:20 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=sorganov@gmail.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <sorganov@gmail.com>)
        id 1gXn0s-0003A7-Lq; Fri, 14 Dec 2018 15:56:18 +0300
Message-Id: <a8b86bc307141963d0ce6b8f8710b38bd802e302.1544764226.git.sorganov@gmail.com>
In-Reply-To: <cover.1544762343.git.sorganov@gmail.com>
References: <cover.1544762343.git.sorganov@gmail.com>
From:   Sergey Organov <sorganov@gmail.com>
Date:   Fri, 14 Dec 2018 07:53:51 +0300
Subject: [PATCH v2 2/4] cherry-pick: do not error on non-merge commits when
 '-m 1' is specified
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cherry-picking multiple commits, it's impossible to have both
merge- and non-merge commits on the same command-line. Not specifying
'-m 1' results in cherry-pick refusing to handle merge commits, while
specifying '-m 1' fails on non-merge commits.

This patch allows '-m 1' for non-merge commits. As mainline is always
the only parent for a non-merge commit, it makes little sense to
disable it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 sequencer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e1a4dd1..d0fd61b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1766,9 +1766,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			return error(_("commit %s does not have parent %d"),
 				oid_to_hex(&commit->object.oid), opts->mainline);
 		parent = p->item;
-	} else if (0 < opts->mainline)
-		return error(_("mainline was specified but commit %s is not a merge."),
-			oid_to_hex(&commit->object.oid));
+	} else if (1 < opts->mainline)
+		/*
+		 *  Non-first parent explicitly specified as mainline for
+		 *  non-merge commit
+		 */
+		return error(_("commit %s does not have parent %d"),
+			     oid_to_hex(&commit->object.oid), opts->mainline);
 	else
 		parent = commit->parents->item;
 
-- 
2.10.0.1.g57b01a3

