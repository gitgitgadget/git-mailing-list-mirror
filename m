From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 19/23] checkout: require worktree unconditionally
Date: Fri,  3 Jul 2015 20:17:28 -0400
Message-ID: <1435969052-540-20-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAx-0000QQ-0n
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067AbbGDATR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:17 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34340 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbbGDASp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:45 -0400
Received: by igcsj18 with SMTP id sj18so196950576igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0y48goUHpCPee91ClOqiNDChhahfkAD9fmNwynNjHzA=;
        b=U5FidCfC8OmWKZ5wfUOdwOGF0pSSaZmk392sYYgHdnLTz7B8EE+5X1Sa5GwaqzLpzH
         FoOaXGzEdqHTSWiRu0x+/t6H/CzBfpAZHV1fNOrcAPBo/Tk8GQEdJSK+Csut52dKenEn
         ijvyho1tCpQjjR8NC/Om/DRF0zS2d5WhMLMmZqM8czW/6cSrF3lHm/F9/VRSuktMq/AG
         tPrgr8my2ZLW+o30pFVwhmcusHV6YIvCKGiYMaDdQNRUUNNC66yedGTol7fwyBgEtZOC
         XeZk7Qeai/gKBEMhvqWSYb4r71p6283KsSHWCbL3EglIohOP1knVXjmNKlYvkuWzvr7i
         glMA==
X-Received: by 10.42.189.201 with SMTP id df9mr20983745icb.79.1435969123467;
        Fri, 03 Jul 2015 17:18:43 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273329>

In order to allow linked worktree creation via "git checkout -b" from a
bare repository, 3473ad0 (checkout: don't require a work tree when
checking out into a new one, 2014-11-30) dropped git-checkout's
unconditional NEED_WORK_TREE requirement and instead performed worktree
setup conditionally based upon presence or absence of the --to option.
Now that --to has been retired and git-checkout is no longer responsible
for linked worktree creation, the NEED_WORK_TREE requirement can once
again be unconditional.

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
