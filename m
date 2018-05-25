Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8211F42D
	for <e@80x24.org>; Fri, 25 May 2018 12:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeEYMrk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 08:47:40 -0400
Received: from mail.javad.com ([54.86.164.124]:45603 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751949AbeEYMrj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 08:47:39 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 May 2018 08:47:39 EDT
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 3E3FD3E8F7;
        Fri, 25 May 2018 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527252126;
        bh=tQWPnRNArpdohh+VHuc6/Oj82uprWdh2IskPiDZLxHY=; l=1350;
        h=Received:From:To:Subject;
        b=JAYyVcTOHIFY4jwc9PULmWC2wlZy6v+1Yh63dxqCWH7Xifsymh8SCg275X5Cvk+ph
         geOD0mt1/VmN+6koGAf4VhYvK91FEeimUpLRwLIBkuylfzKr8hvAg8DLLCaiAprR/i
         4TpqGLjI09F8aNS7nuFJoxd44ILERUzXZHE/LW/0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1527252126;
        bh=tQWPnRNArpdohh+VHuc6/Oj82uprWdh2IskPiDZLxHY=; l=1350;
        h=Received:From:To:Subject;
        b=JAYyVcTOHIFY4jwc9PULmWC2wlZy6v+1Yh63dxqCWH7Xifsymh8SCg275X5Cvk+ph
         geOD0mt1/VmN+6koGAf4VhYvK91FEeimUpLRwLIBkuylfzKr8hvAg8DLLCaiAprR/i
         4TpqGLjI09F8aNS7nuFJoxd44ILERUzXZHE/LW/0=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1fMC2l-0002VN-QF; Fri, 25 May 2018 15:42:03 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is
 specified
Date:   Fri, 25 May 2018 15:42:03 +0300
Message-ID: <87wovrx5yc.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
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

