Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FAFB1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755541AbdBNVYx (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:24:53 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:26874 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755502AbdBNVYs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:24:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id BC08B1E3128;
        Tue, 14 Feb 2017 22:24:45 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eyIxAF2IODrt; Tue, 14 Feb 2017 22:24:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 5D54C1E3130;
        Tue, 14 Feb 2017 22:24:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xUK1xiADJEcV; Tue, 14 Feb 2017 22:24:45 +0100 (CET)
Received: from snowflake.fritz.box (aftr-185-17-204-143.dynamic.mnet-online.de [185.17.204.143])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id E2C4E1E312F;
        Tue, 14 Feb 2017 22:24:44 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     Cornelius Weig <cornelius.weig@tngtech.com>, szeder.dev@gmail.com,
        bitte.keine.werbung.einwerfen@googlemail.com, j6t@kdbg.org
Subject: [PATCH v2 2/2] completion: checkout: complete paths when ref given
Date:   Tue, 14 Feb 2017 22:24:04 +0100
Message-Id: <20170214212404.31469-2-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170214212404.31469-1-cornelius.weig@tngtech.com>
References: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
 <20170214212404.31469-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Git-checkout completes words starting with '--' as options and other
words as refs. Even after specifying a ref, further words not starting
with '--' are completed as refs, which is invalid for git-checkout.

This commit ensures that after specifying a ref, further non-option
words are completed as paths. Four cases are considered:

 - If the word contains a ':', do not treat it as reference and use
   regular revlist completion.
 - If no ref is found on the command line, complete non-options as refs
   as before.
 - If the ref is HEAD or @, complete only with modified files because
   checking out unmodified files is a noop.
   This case also applies if no ref is given, but '--' is present.
 - If a ref other than HEAD or @ is found, offer only valid paths from
   that revision.

Note that one corner-case is not covered by the current implementation:
if a refname contains a ':' and is followed by '--' the completion would
not recognize the valid refname.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---
 contrib/completion/git-completion.bash | 39 +++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4ab119d..df46f62 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1068,7 +1068,7 @@ _git_bundle ()
 
 _git_checkout ()
 {
-	__git_has_doubledash && return
+	local i c=2 ref="" seen_double_dash=""
 
 	case "$cur" in
 	--conflict=*)
@@ -1081,13 +1081,36 @@ _git_checkout ()
 			"
 		;;
 	*)
-		# check if --track, --no-track, or --no-guess was specified
-		# if so, disable DWIM mode
-		local flags="--track --no-track --no-guess" track=1
-		if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
-			track=''
-		fi
-		__gitcomp_nl "$(__git_refs '' $track)"
+		while [ $c -lt $cword ]; do
+			i="${words[c]}"
+			case "$i" in
+			--) seen_double_dash=1 ;;
+			-*|?*:*) ;;
+			*) ref="$i"; break ;;
+			esac
+			((c++))
+		done
+
+		case "$ref,$seen_double_dash,$cur" in
+		,,*:*)
+		    __git_complete_revlist_file
+		    ;;
+		,,*)
+			# check for --track, --no-track, or --no-guess
+			# if so, disable DWIM mode
+			local flags="--track --no-track --no-guess" track=1
+			if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
+				track=''
+			fi
+			__gitcomp_nl "$(__git_refs '' $track)"
+			;;
+		,1,*|@,*|HEAD,*)
+			__git_complete_index_file "--modified"
+			;;
+		*)
+			__git_complete_tree_file "$ref" "$cur"
+			;;
+		esac
 		;;
 	esac
 }
-- 
2.10.2

