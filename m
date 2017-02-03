Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AFEF1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 11:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbdBCLCZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 3 Feb 2017 06:02:25 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:52496 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbdBCLCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 06:02:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id D1C9B1E3839;
        Fri,  3 Feb 2017 12:02:20 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QGgIARTjdWRg; Fri,  3 Feb 2017 12:02:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 6F1031E383A;
        Fri,  3 Feb 2017 12:02:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7u0Qx5_PQVaq; Fri,  3 Feb 2017 12:02:20 +0100 (CET)
Received: from localhost.localdomain (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 1119E1E3839;
        Fri,  3 Feb 2017 12:02:20 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, j6t@kdbg.org,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v2 1/7] completion: teach submodule subcommands to complete options
Date:   Fri,  3 Feb 2017 12:01:53 +0100
Message-Id: <20170203110159.377-2-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170203110159.377-1-cornelius.weig@tngtech.com>
References: <20170203110159.377-1-cornelius.weig@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Each submodule subcommand has specific long-options. Therefore, teach
bash completion to support option completion based on the current
subcommand. All long-options that are mentioned in the man-page synopsis
are added.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6721ff8..c54a557 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2556,10 +2556,11 @@ _git_submodule ()
 	__git_has_doubledash && return
 
 	local subcommands="add status init deinit update summary foreach sync"
-	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "--quiet --cached"
+			__gitcomp "--quiet"
 			;;
 		*)
 			__gitcomp "$subcommands"
@@ -2567,6 +2568,33 @@ _git_submodule ()
 		esac
 		return
 	fi
+
+	case "$subcommand,$cur" in
+	add,--*)
+		__gitcomp "--branch --force --name --reference --depth"
+		;;
+	status,--*)
+		__gitcomp "--cached --recursive"
+		;;
+	deinit,--*)
+		__gitcomp "--force --all"
+		;;
+	update,--*)
+		__gitcomp "
+			--init --remote --no-fetch
+			--recommend-shallow --no-recommend-shallow
+			--force --rebase --merge --reference --depth --recursive --jobs
+		"
+		;;
+	summary,--*)
+		__gitcomp "--cached --files --summary-limit"
+		;;
+	foreach,--*|sync,--*)
+		__gitcomp "--recursive"
+		;;
+	*)
+		;;
+	esac
 }
 
 _git_svn ()
-- 
2.10.2

