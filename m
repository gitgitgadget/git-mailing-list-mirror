Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7591FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755542AbdBNVYz (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:24:55 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:32892 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755516AbdBNVYt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:24:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 674141E3127;
        Tue, 14 Feb 2017 22:24:45 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id y8q1bKK3ENgp; Tue, 14 Feb 2017 22:24:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id DFCAB1E3128;
        Tue, 14 Feb 2017 22:24:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lmti4Lp6qF-U; Tue, 14 Feb 2017 22:24:44 +0100 (CET)
Received: from snowflake.fritz.box (aftr-185-17-204-143.dynamic.mnet-online.de [185.17.204.143])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 590C01E3127;
        Tue, 14 Feb 2017 22:24:44 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     Cornelius Weig <cornelius.weig@tngtech.com>, szeder.dev@gmail.com,
        bitte.keine.werbung.einwerfen@googlemail.com, j6t@kdbg.org
Subject: [PATCH v2 1/2] completion: extract utility to complete paths from tree-ish
Date:   Tue, 14 Feb 2017 22:24:03 +0100
Message-Id: <20170214212404.31469-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
References: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

The function __git_complete_revlist_file understands how to complete a
path such as 'topic:ref<TAB>'. In that case, the revision (topic) and
the path component (ref) are both part of the same word. However,
some cases require that the revision is specified elsewhere than the
current word for completion, such as 'git checkout topic ref<TAB>'.

In order to allow callers to specify the revision, extract a utility
function to complete paths from a tree-ish object. The utility will be
used later to implement path completion for git-checkout.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---
 contrib/completion/git-completion.bash | 73 +++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6c6e1c7..4ab119d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -442,6 +442,46 @@ __git_compute_merge_strategies ()
 	__git_merge_strategies=$(__git_list_merge_strategies)
 }
 
+# __git_complete_tree_file requires 2 argument:
+# 1: the the tree-like to look at for completion
+# 2: the path component to complete
+__git_complete_tree_file ()
+{
+	local pfx ls ref="$1" cur_="$2"
+	case "$cur_" in
+	?*/*)
+		pfx="${cur_%/*}"
+		cur_="${cur_##*/}"
+		ls="$ref:$pfx"
+		pfx="$pfx/"
+		;;
+	*)
+		ls="$ref"
+		;;
+	esac
+
+	case "$COMP_WORDBREAKS" in
+	*:*) : great ;;
+	*)   pfx="$ref:$pfx" ;;
+	esac
+
+	__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" 2>/dev/null \
+				| sed '/^100... blob /{
+						   s,^.*	,,
+						   s,$, ,
+					   }
+					   /^120000 blob /{
+						   s,^.*	,,
+						   s,$, ,
+					   }
+					   /^040000 tree /{
+						   s,^.*	,,
+						   s,$,/,
+					   }
+					   s/^.*	//')" \
+				"$pfx" "$cur_" ""
+}
+
 __git_complete_revlist_file ()
 {
 	local pfx ls ref cur_="$cur"
@@ -452,38 +492,7 @@ __git_complete_revlist_file ()
 	?*:*)
 		ref="${cur_%%:*}"
 		cur_="${cur_#*:}"
-		case "$cur_" in
-		?*/*)
-			pfx="${cur_%/*}"
-			cur_="${cur_##*/}"
-			ls="$ref:$pfx"
-			pfx="$pfx/"
-			;;
-		*)
-			ls="$ref"
-			;;
-		esac
-
-		case "$COMP_WORDBREAKS" in
-		*:*) : great ;;
-		*)   pfx="$ref:$pfx" ;;
-		esac
-
-		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" 2>/dev/null \
-				| sed '/^100... blob /{
-				           s,^.*	,,
-				           s,$, ,
-				       }
-				       /^120000 blob /{
-				           s,^.*	,,
-				           s,$, ,
-				       }
-				       /^040000 tree /{
-				           s,^.*	,,
-				           s,$,/,
-				       }
-				       s/^.*	//')" \
-			"$pfx" "$cur_" ""
+		__git_complete_tree_file "$ref" "$cur_"
 		;;
 	*...*)
 		pfx="${cur_%...*}..."
-- 
2.10.2

