Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE262013A
	for <e@80x24.org>; Mon, 13 Feb 2017 01:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdBMBI5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 20:08:57 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:37932 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdBMBI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 20:08:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id A1A141E2E99;
        Mon, 13 Feb 2017 02:08:53 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Qn9P8KF-HbGZ; Mon, 13 Feb 2017 02:08:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 1A29C1E2E9F;
        Mon, 13 Feb 2017 02:08:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zGpCRBNgXElk; Mon, 13 Feb 2017 02:08:53 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-179.dynamic.mnet-online.de [185.17.206.179])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 8D08F1E2E99;
        Mon, 13 Feb 2017 02:08:52 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     bitte.keine.werbung.einwerfen@googlemail.com,
        Cornelius Weig <cornelius.weig@tngtech.com>,
        szeder.dev@gmail.com, s6t@kdbg.org, greened@obbligato.org,
        davvid@gmail.com
Subject: [PATCH] completion: teach to complete git-subtree
Date:   Mon, 13 Feb 2017 02:07:22 +0100
Message-Id: <20170213010722.28518-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Git-subtree is a contrib-command without completion, making it
cumbersome to use.

Teach bash completion to complete the subcommands of subtree (add,
merge, pull, push, split) and options thereof. For subcommands
supporting it (add, push, pull) also complete remote names and refspec.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---
 contrib/completion/git-completion.bash | 35 ++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6c6e1c7..430bfed 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -535,9 +535,9 @@ __git_complete_remote_or_refspec ()
 {
 	local cur_="$cur" cmd="${words[1]}"
 	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
-	if [ "$cmd" = "remote" ]; then
-		((c++))
-	fi
+	case "$cmd" in
+	remote|subtree) ((c++)) ;;
+	esac
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
@@ -586,7 +586,7 @@ __git_complete_remote_or_refspec ()
 			__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
 		fi
 		;;
-	pull|remote)
+	pull|remote|subtree)
 		if [ $lhs = 1 ]; then
 			__gitcomp_nl "$(__git_refs "$remote")" "$pfx" "$cur_"
 		else
@@ -2569,6 +2569,33 @@ _git_submodule ()
 	fi
 }
 
+_git_subtree ()
+{
+	local subcommands="add merge pull push split"
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+		return
+	fi
+	case "$subcommand,$cur" in
+	add,--*|merge,--*|pull,--*)
+		__gitcomp "--prefix= --squash --message="
+		;;
+	push,--*)
+		__gitcomp "--prefix="
+		;;
+	split,--*)
+		__gitcomp "
+			--annotate= --branch= --ignore-joins
+			--onto= --prefix= --rejoin
+			"
+		;;
+	add,*|push,*|pull,*)
+		__git_complete_remote_or_refspec
+		;;
+	esac
+}
+
 _git_svn ()
 {
 	local subcommands="
-- 
2.10.2

