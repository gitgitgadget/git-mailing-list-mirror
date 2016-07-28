Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A6E1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 17:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbcG1Rrg (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 13:47:36 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:43903 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161013AbcG1Rre (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 13:47:34 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s0fSz756Gz5tl9;
	Thu, 28 Jul 2016 19:47:31 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E43F83C9;
	Thu, 28 Jul 2016 19:47:23 +0200 (CEST)
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	Git Mailing List <git@vger.kernel.org>
From:	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH va/i18n-even-more] rebase-interactive: trim leading whitespace
 from progress count
Message-ID: <fa512576-487e-9b9c-3ada-7f0d9b135e4b@kdbg.org>
Date:	Thu, 28 Jul 2016 19:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Interactive rebase uses 'wc -l' to write the current patch number
in a progress report. Some implementations of 'wc -l' produce spaces
before the number, leading to ugly output such as

  Rebasing (     3/8)

Remove the spaces using a trivial arithmetic evaluation.

Before 9588c52 (i18n: rebase-interactive: mark strings for
translation) this was not a problem because printf was used to
generate the text. Since that commit, the count is interpolated
directly from a shell variable into the text, where the spaces
remain. The total number of patches does not have this problem
even though it is interpolated from a shell variable in the same
manner, because the variable is set by an arithmetic evaluation.

Later in the script, there is a virtually identical case where
leading spaces are trimmed, but it uses a pattern substitution:

todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
todocount=${todocount##* }

I did not choose this idiom because it adds a line of code, and
there is already an arithmetic evaluation in the vicinity of the
line that is changed here.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ded4595..e2da524 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -121,7 +121,7 @@ mark_action_done () {
 	sed -e 1q < "$todo" >> "$done"
 	sed -e 1d < "$todo" >> "$todo".new
 	mv -f "$todo".new "$todo"
-	new_count=$(git stripspace --strip-comments <"$done" | wc -l)
+	new_count=$(( $(git stripspace --strip-comments <"$done" | wc -l) ))
 	echo $new_count >"$msgnum"
 	total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
 	echo $total >"$end"
-- 
2.9.0.443.ga8520ad

