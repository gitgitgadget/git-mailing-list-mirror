From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 19/23] checkout: require worktree unconditionally
Date: Mon,  6 Jul 2015 13:30:56 -0400
Message-ID: <1436203860-846-20-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:32:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAGA-0008LT-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbbGFRcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:32:22 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35644 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbbGFRbs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:48 -0400
Received: by iecuq6 with SMTP id uq6so118021887iec.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lrrOdUZqncgzl8KdvzkHvdYlaEtNBOWcqyjQk7WPILg=;
        b=wtx3vKaonXe6eEM5WZBHox0BIPGisK4WkHzk4hqdJXuUCnCP5hUEiWiF6iQndmGOUp
         gYFCtxt+XxTsSzbboUfM9zq4j7vBq6OTLAC1PruJf1wtIUoVNPYrAxEJS9TfxO5Jispt
         rbUaU2GADvxTFFpjnVjR+6BBpNWJGfEWrqdK1buNDQE8GFx5gmnV8PLEGIhfPTAG2Kxq
         7J0kNpAHj7OHtgx0z867j79HDHWEe/jKAitgBqQXoEA/XrkzY1aqc59cqdzlxrVqecwY
         dSV4gpOre4gu38l2SR96hnf4Hkp/E/NXGSoR1MXDf1FAJfHp94Vye5REvAXD5utQaMkt
         dWpQ==
X-Received: by 10.107.164.22 with SMTP id n22mr27296137ioe.73.1436203907916;
        Mon, 06 Jul 2015 10:31:47 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.47
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273428>

In order to allow linked worktree creation via "git checkout --to" from
a bare repository, 3473ad0 (checkout: don't require a work tree when
checking out into a new one, 2014-11-30) dropped git-checkout's
unconditional NEED_WORK_TREE requirement and instead performed worktree
setup conditionally based upon presence or absence of the --to option.
Now that --to has been retired and git-checkout is no longer responsible
for linked worktree creation, the NEED_WORK_TREE requirement can be
re-instated.

This effectively reverts 3473ad0, except for the tests it added which
now check bare repository behavior of "git worktree add" instead.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 2 --
 git.c              | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b1e68b3..5754554 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1218,8 +1218,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts.new_worktree_mode = getenv("GIT_CHECKOUT_NEW_WORKTREE") != NULL;
 
-	setup_work_tree();
-
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/git.c b/git.c
index f227838..21a6398 100644
--- a/git.c
+++ b/git.c
@@ -383,7 +383,7 @@ static struct cmd_struct commands[] = {
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 	{ "check-ref-format", cmd_check_ref_format },
-	{ "checkout", cmd_checkout, RUN_SETUP },
+	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
-- 
2.5.0.rc1.197.g417e668
