Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497A7C43461
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDE16113B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbhDWTni (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:38 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:35334 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243895AbhDWTnc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:32 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 8261280595;
        Fri, 23 Apr 2021 15:42:55 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 16/30] subtree: use git-sh-setup's `say`
Date:   Fri, 23 Apr 2021 13:42:16 -0600
Message-Id: <20210423194230.1388945-17-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

subtree currently defines its own `say` implementation, rather than
using git-sh-setups's implementation.  Change that, don't re-invent the
wheel.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 70e16b807b..bb4934dbc0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -30,7 +30,6 @@ squash        merge subtree changes as a single commit
 
 PATH=$PATH:$(git --exec-path)
 
-quiet=
 branch=
 debug=
 command=
@@ -49,15 +48,8 @@ debug () {
 	fi
 }
 
-say () {
-	if test -z "$quiet"
-	then
-		printf "%s\n" "$*" >&2
-	fi
-}
-
 progress () {
-	if test -z "$quiet"
+	if test -z "$GIT_QUIET"
 	then
 		printf "%s\r" "$*" >&2
 	fi
@@ -93,7 +85,7 @@ main () {
 
 		case "$opt" in
 		-q)
-			quiet=1
+			GIT_QUIET=1
 			;;
 		-d)
 			debug=1
@@ -201,7 +193,7 @@ main () {
 	fi
 
 	debug "command: {$command}"
-	debug "quiet: {$quiet}"
+	debug "quiet: {$GIT_QUIET}"
 	debug "revs: {$revs}"
 	debug "dir: {$dir}"
 	debug "opts: {$*}"
@@ -698,7 +690,7 @@ cmd_add () {
 
 		cmd_add_repository "$@"
 	else
-		say "error: parameters were '$@'"
+		say >&2 "error: parameters were '$@'"
 		die "Provide either a commit or a repository and commit."
 	fi
 }
@@ -742,7 +734,7 @@ cmd_add_commit () {
 	fi
 	git reset "$commit" || exit $?
 
-	say "Added dir '$dir'"
+	say >&2 "Added dir '$dir'"
 }
 
 cmd_split () {
@@ -807,7 +799,7 @@ cmd_split () {
 		fi
 		git update-ref -m 'subtree split' \
 			"refs/heads/$branch" "$latest_new" || exit $?
-		say "$action branch '$branch'"
+		say >&2 "$action branch '$branch'"
 	fi
 	echo "$latest_new"
 	exit 0
@@ -830,7 +822,7 @@ cmd_merge () {
 		sub=$2
 		if test "$sub" = "$rev"
 		then
-			say "Subtree is already at commit $rev."
+			say >&2 "Subtree is already at commit $rev."
 			exit 0
 		fi
 		new=$(new_squash_commit "$old" "$sub" "$rev") || exit $?
-- 
2.31.1

