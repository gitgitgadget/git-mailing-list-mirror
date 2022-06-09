Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BCBC433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 20:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbiFIUo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 16:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFIUo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 16:44:57 -0400
Received: from nmsh5.e.nsc.no (nmsh5.e.nsc.no [148.123.160.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB6E0C0
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 13:44:55 -0700 (PDT)
Received: from Lorule.wifi.realnett.no (unknown [194.19.73.58])
        (Authenticated sender: joak-pet@online.no)
        by nmsh5.e.nsc.no (smtp.online.no) with ESMTPA id A09C052053;
        Thu,  9 Jun 2022 22:44:52 +0200 (CEST)
From:   Joakim Petersen <joak-pet@online.no>
To:     git@vger.kernel.org
Cc:     Joakim Petersen <joak-pet@online.no>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] git-prompt: fix expansion of branch colour codes
Date:   Thu,  9 Jun 2022 22:44:47 +0200
Message-Id: <20220609204447.32841-1-joak-pet@online.no>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607115024.64724-1-joak-pet@online.no>
References: <20220607115024.64724-1-joak-pet@online.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because of the wrapping of the branch name variable $b, the colour codes
in the variable don't get applied, but are instead printed directly in
the output. Move the wrapping of $b to before colour codes are inserted
to correct this.

Signed-off-by: Joakim Petersen <joak-pet@online.no>
---
 contrib/completion/git-prompt.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index cb01c2fd5d..1435548e00 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -556,9 +556,14 @@ __git_ps1 ()
 		fi
 	fi
 
-	b=${b##refs/heads/}
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
+	b=${b##refs/heads/}
+	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+		__git_ps1_branch_name=$b
+		b="\${__git_ps1_branch_name}"
+	fi
+
 	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
 	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
 		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
@@ -566,11 +571,6 @@ __git_ps1 ()
 		fi
 	fi
 
-	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
-		__git_ps1_branch_name=$b
-		b="\${__git_ps1_branch_name}"
-	fi
-
 	local f="$h$w$i$s$u$p"
 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
 

base-commit: 9470605a1b03dac8fc4f801132e36964b4fbb8c3
-- 
2.36.1

