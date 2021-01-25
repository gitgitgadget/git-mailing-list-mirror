Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6475FC433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193EC20C56
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbhAYVZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbhAYVWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 16:22:25 -0500
Received: from dandelion.mymedia.su (unknown [IPv6:2604:180:2:1574::c9e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C36C061756
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 13:21:39 -0800 (PST)
Received: from dandelion.mymedia.su (localhost.localdomain [127.0.0.1])
        by dandelion.mymedia.su (8.15.2/8.15.2/Debian-3) with ESMTP id 10PLLYdf032133;
        Tue, 26 Jan 2021 00:21:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=guriev.su; s=default;
        t=1611609695; bh=eVjRlm7FAUfl12B25K52E4711BnRa2mc2jZgYP80nS0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U51bRCo+4QhF+C6+SVJpCqgJHhQ4X2YqMvoeWYw/QbfxicG8YmaWcItxALB+u26nW
         jsR39YX5MJKc3oC3bDlo0J8va7Tps0bRdT6Ni9WKWkOhcee/aknBVCnoXIeWnltVEC
         8+CPnCKtdrJhjBLyh6T4OkGHx47FUssqHr6fOtF4=
Received: (from mymedia@localhost)
        by dandelion.mymedia.su (8.15.2/8.15.2/Submit) id 10PLLY2v032132;
        Tue, 26 Jan 2021 00:21:34 +0300
From:   Nicholas Guriev <nicholas@guriev.su>
To:     git@vger.kernel.org
Subject: [PATCH v3 0/4] difftools in tabbed mode
Date:   Tue, 26 Jan 2021 00:21:28 +0300
Message-Id: <20210125212132.894458-1-nicholas@guriev.su>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210118210003.3071205-1-nicholas@guriev.su>
References: <20210118210003.3071205-1-nicholas@guriev.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, thank you for the comment. I added the diff_combo_supported
function as you suggested. Though it calls to the `true` or the `false` builtins
as I find them much clearer than the "return" command with inverted status. It
is really confusing that C and most other programming languages adequately
interpret non-zero as truth value and zero as falsity value unlike Unix Shell.
Are such changes acceptable?

As regards broken tests, it may seem silly but that error was due to a single
missing colon. I corrected the mistake and added some automated tests of this
new feature.

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 529d55c96d..85a6dc9c30 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -31,7 +31,7 @@ prompt_before_launch () {
 	do
 		printf "Launch '%s' [Y/n]? " "${GIT_DIFFTOOL_EXTCMD:-$merge_tool}"
 		read ans 2>/dev/null || return 1
-		case "${ans-y}" in
+		case "${ans:-y}" in
 		[yY]*) return 0 ;;
 		[nN]*) return 1 ;;
 		esac

Changes compared to v2:
 * Introduced the diff_combo_supported function.
 * Fixed default answer to difftool prompting.
 * More docs about the diff tool mechanism.
 * New auto-tests of the feature.

Nicholas Guriev (4):
  mergetools: support difftool.tabbed setting
  difftool-helper: conciliate difftool.tabbed and difftool.prompt
    settings
  doc: describe new difftool.tabbed feature
  t7800: new tests of difftool.tabbed feature

 Documentation/config/difftool.txt    |   6 +
 Documentation/git-difftool.txt       |  19 ++-
 Documentation/git-mergetool--lib.txt |  62 ++++++++++
 Documentation/git.txt                |   8 ++
 builtin/difftool.c                   |   7 +-
 diff.c                               |  10 +-
 git-difftool--helper.sh              |  39 ++++--
 git-mergetool--lib.sh                |  71 ++++++++++-
 mergetools/meld                      |   8 ++
 mergetools/vimdiff                   |  21 ++++
 t/t7800-difftool.sh                  | 175 ++++++++++++++++++++++++++-
 11 files changed, 401 insertions(+), 25 deletions(-)

-- 
2.27.0

