Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FFCB1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 11:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbdBCLCj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 3 Feb 2017 06:02:39 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:46351 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbdBCLCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 06:02:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 85F6B1E3834;
        Fri,  3 Feb 2017 12:02:20 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OxxuWT1o-lAS; Fri,  3 Feb 2017 12:02:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 115E91E383B;
        Fri,  3 Feb 2017 12:02:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AmrlTA5gzZ_V; Fri,  3 Feb 2017 12:02:19 +0100 (CET)
Received: from localhost.localdomain (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id AD18C1E3834;
        Fri,  3 Feb 2017 12:02:19 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, j6t@kdbg.org,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v2 0/7] completion bash: add more options and commands
Date:   Fri,  3 Feb 2017 12:01:52 +0100
Message-Id: <20170203110159.377-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

This is the re-roll of patch series <20170122225724.19360-1-cornelius.weig@tngtech.com>.

This patch series adds all long-options that are mentioned in the synopsis of
the man-page for the respective git-command. There are only a few exceptions,
as discussed in the above thread. For example, no unsafe options should be
completed.
Furthermore, the patches add subommand option completion for git-submodule and
git-remote.

Changes wrt first submission:

 - improve completion for git-remote set-head & set-branches
 - remove completion of unsafe options
 - improve commit messages
 - added sign-off :)
 - rebase to current master

Cornelius Weig (7):
  completion: teach submodule subcommands to complete options
  completion: add subcommand completion for rerere
  completion: improve bash completion for git-add
  completion: teach ls-remote to complete options
  completion: teach replace to complete options
  completion: teach remote subcommands to complete options
  completion: recognize more long-options

 contrib/completion/git-completion.bash | 139 ++++++++++++++++++++++++++++-----
 1 file changed, 118 insertions(+), 21 deletions(-)


Interdiff since first iteration:
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 87d3d2c..3545f6a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -936,7 +936,7 @@ _git_apply ()
 			--apply --no-add --exclude=
 			--ignore-whitespace --ignore-space-change
 			--whitespace= --inaccurate-eof --verbose
-			--recount --directory= --unsafe-paths
+			--recount --directory=
 			"
 		return
 	esac
@@ -1459,7 +1459,7 @@ _git_ls_remote ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--heads --tags --refs --get-url"
+		__gitcomp "--heads --tags --refs --get-url --symref"
 		return
 		;;
 	esac
@@ -2415,9 +2415,18 @@ _git_remote ()
 		;;
 	add,*)
 		;;
+	set-head,--*)
+		__gitcomp "--auto --delete"
+		;;
+	set-branches,--*)
+		__gitcomp "--add"
+		;;
 	set-head,*|set-branches,*)
 		__git_complete_remote_or_refspec
 		;;
+	update,--*)
+		__gitcomp "--prune"
+		;;
 	update,*)
 		__gitcomp "$(__git_get_config_variables "remotes")"
 		;;
@@ -2494,7 +2503,7 @@ _git_rm ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet --force"
+		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
 		return
 		;;
 	esac

-- 
2.10.2

