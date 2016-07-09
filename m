Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935282018E
	for <e@80x24.org>; Sat,  9 Jul 2016 22:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868AbcGIWQr (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 18:16:47 -0400
Received: from imap.thunk.org ([74.207.234.97]:48168 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756855AbcGIWQq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 18:16:46 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=Message-Id:Date:Subject:Cc:To:From; bh=8LN6d7LkFM9ccklub3FJ4jxiR2vfMnHYLHiB64eheho=;
	b=ndl25JQEBy7d6mqTpaYOgyhjzjE1gSkQDKIhQEwVrF72NG4HldG5rSgtjzewD3679MtNInMcCRi1ccxFmrTm7ykIxfIgNI8aBlFk9As/4dCOJBxIa4hpc5IxQwLi7hRbtL3VBQUEuwZDEIEDQWIZiOM9kQc5kcsk80N2goVhoDs=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bM0YE-0005WR-Pp; Sat, 09 Jul 2016 22:16:42 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 174BE82030B; Sat,  9 Jul 2016 18:16:42 -0400 (EDT)
From:	Theodore Ts'o <tytso@mit.edu>
To:	Git Mailing List <git@vger.kernel.org>
Cc:	Theodore Ts'o <tytso@mit.edu>,
	Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: [PATCH] guilt: update reflog with annotations of guilt-command being run
Date:	Sat,  9 Jul 2016 18:16:05 -0400
Message-Id: <1468102565-326-1-git-send-email-tytso@mit.edu>
X-Mailer: git-send-email 2.5.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Many of the updates made by guilt use git update-ref, which means that
the output of "git reflog" is extremely unedifying, e.g:

ff0031d HEAD@{177}: reset: moving to ff0031d848a0cd7002606f9feef958de8d5edf19
90f4305 HEAD@{178}:
a638d43 HEAD@{179}:
ff0031d HEAD@{180}:
079788d HEAD@{181}:
87a6280 HEAD@{182}:
5b9554d HEAD@{183}:
de9e918 HEAD@{184}: reset: moving to de9e9181bc066d63d78b768e95b5d949e2a8673a
5b9554d HEAD@{185}:

So teach guilt to use the "set_reflog_action" helper, and since
git-update-ref doesn't respect the GIT_REFLOG_ACTION environment
variable, use its -m option so that "git reflog" can look like this
instead:

1eaa566 HEAD@{11}: guilt-push: track-more-dependencies-on-transaction-commit
ab714af HEAD@{12}: guilt-push: move-lockdep-tracking-to-journal_s
7a4b188 HEAD@{13}: guilt-push: move-lockdep-instrumentation-for-jbd2-handles
78d9625 HEAD@{14}: guilt-push: respect-nobarrier-mount-option-in-nojournal-mode
d08854f HEAD@{15}: guilt-pop: updating HEAD
d08854f HEAD@{16}: guilt-pop: updating HEAD
d08854f HEAD@{17}: guilt-push: optimize-ext4_should_retry_alloc-to-improve-ENOSPC-performance

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/guilt b/guilt
index 35177b9..38d426b 100755
--- a/guilt
+++ b/guilt
@@ -114,6 +114,7 @@ if [ $# -ne 0 ]; then
 		disp "" >&2
 		exit 1
 	fi
+	set_reflog_action "guilt-$CMDNAME"
 
 	shift
 else
@@ -640,7 +641,7 @@ commit()
 		commitish=`git commit-tree $treeish -p $2 < "$TMP_MSG"`
 		if $old_style_prefix || git rev-parse --verify --quiet refs/heads/$GUILT_PREFIX$branch >/dev/null
 		then
-			git update-ref HEAD $commitish
+			git update-ref -m "$GIT_REFLOG_ACTION" HEAD $commitish
 		else
 			git branch $GUILT_PREFIX$branch $commitish
 			git symbolic-ref HEAD refs/heads/$GUILT_PREFIX$branch
@@ -687,7 +688,8 @@ push_patch()
 			fi
 		fi
 
-		commit "$pname" HEAD
+		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: $pname" \
+			commit "$pname" HEAD
 
 		echo "$pname" >> "$applied"
 
-- 
2.5.0

