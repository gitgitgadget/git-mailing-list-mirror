Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD601F516
	for <e@80x24.org>; Thu, 21 Jun 2018 11:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933140AbeFULpn (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 07:45:43 -0400
Received: from mail.javad.com ([54.86.164.124]:53137 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933014AbeFULpm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 07:45:42 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id D68A93E978;
        Thu, 21 Jun 2018 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1529581542;
        bh=tQWPnRNArpdohh+VHuc6/Oj82uprWdh2IskPiDZLxHY=; l=1350;
        h=Received:From:To:Subject;
        b=Kt940SaJj/d/pOifbnG5JjztTDmoxSzKlQWLAC4zljq/fuIFRNbxXTUr9oF02ly9F
         LpwtAvIPskvCzNdBW4D6j/ZpzoZ+r5INiNqXSJ0L0dKiccpF7jiPgNmzsEfaSk77yU
         IB/11+LSHznIazavLQZltBudX0SZAHXP/2NxM4VY=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1fVy20-0005RA-5U; Thu, 21 Jun 2018 14:45:40 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is
 specified
Date:   Fri, 25 May 2018 15:42:03 +0300
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Message-ID: <87efh0pdln.fsf@javad.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cherry-picking multiple commits, it's impossible to have both
merge- and non-merge commits on the same command-line. Not specifying
'-m 1' results in cherry-pick refusing to handle merge commits, while
specifying '-m 1' fails on non-merge commits.

This patch allows '-m 1' for non-merge commits. Besides, as mainline is
always the only parent for a non-merge commit, it made little sense to
disable it in the first place.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 sequencer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1ce6326..2393bdf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1543,9 +1543,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			return error(_("commit %s does not have parent %d"),
 				oid_to_hex(&commit->object.oid), opts->mainline);
 		parent = p->item;
-	} else if (0 < opts->mainline)
-		return error(_("mainline was specified but commit %s is not a merge."),
-			oid_to_hex(&commit->object.oid));
+	} else if (1 < opts->mainline)
+		/* Non-first parent explicitly specified as mainline for
+		 * non-merge commit */
+		return error(_("commit %s does not have parent %d"),
+			     oid_to_hex(&commit->object.oid), opts->mainline);
 	else
 		parent = commit->parents->item;
 
-- 
2.10.0.1.g57b01a3

