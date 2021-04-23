Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1ACC43460
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096186128B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbhDWTnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbhDWTna (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:30 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DE1C06138D
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:42:52 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 0207280593;
        Fri, 23 Apr 2021 15:42:51 -0400 (EDT)
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
Subject: [PATCH 12/30] subtree: don't have loose code outside of a function
Date:   Fri, 23 Apr 2021 13:42:12 -0600
Message-Id: <20210423194230.1388945-13-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Shove all of the loose code inside of a main() function.

"Ignore space change" is probably helpful when viewing this diff.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh | 245 +++++++++++++++++----------------
 1 file changed, 125 insertions(+), 120 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 868e18b9a1..d1ed7f9a6c 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -4,10 +4,7 @@
 #
 # Copyright (C) 2009 Avery Pennarun <apenwarr@gmail.com>
 #
-if test $# -eq 0
-then
-	set -- -h
-fi
+
 OPTS_SPEC="\
 git subtree add   --prefix=<prefix> <commit>
 git subtree add   --prefix=<prefix> <repository> <ref>
@@ -30,12 +27,8 @@ rejoin        merge the new branch back into HEAD
  options for 'add', 'merge', and 'pull'
 squash        merge subtree changes as a single commit
 "
-eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
 
 PATH=$PATH:$(git --exec-path)
-. git-sh-setup
-
-require_work_tree
 
 quiet=
 branch=
@@ -84,126 +77,138 @@ ensure_single_rev () {
 	fi
 }
 
-while test $# -gt 0
-do
-	opt="$1"
-	shift
+main () {
+	if test $# -eq 0
+	then
+		set -- -h
+	fi
+	eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
+	. git-sh-setup
+	require_work_tree
 
-	case "$opt" in
-	-q)
-		quiet=1
-		;;
-	-d)
-		debug=1
-		;;
-	--annotate)
-		annotate="$1"
-		shift
-		;;
-	--no-annotate)
-		annotate=
-		;;
-	-b)
-		branch="$1"
-		shift
-		;;
-	-P)
-		prefix="${1%/}"
-		shift
-		;;
-	-m)
-		message="$1"
-		shift
-		;;
-	--no-prefix)
-		prefix=
-		;;
-	--onto)
-		onto="$1"
+	while test $# -gt 0
+	do
+		opt="$1"
 		shift
+
+		case "$opt" in
+		-q)
+			quiet=1
+			;;
+		-d)
+			debug=1
+			;;
+		--annotate)
+			annotate="$1"
+			shift
+			;;
+		--no-annotate)
+			annotate=
+			;;
+		-b)
+			branch="$1"
+			shift
+			;;
+		-P)
+			prefix="${1%/}"
+			shift
+			;;
+		-m)
+			message="$1"
+			shift
+			;;
+		--no-prefix)
+			prefix=
+			;;
+		--onto)
+			onto="$1"
+			shift
+			;;
+		--no-onto)
+			onto=
+			;;
+		--rejoin)
+			rejoin=1
+			;;
+		--no-rejoin)
+			rejoin=
+			;;
+		--ignore-joins)
+			ignore_joins=1
+			;;
+		--no-ignore-joins)
+			ignore_joins=
+			;;
+		--squash)
+			squash=1
+			;;
+		--no-squash)
+			squash=
+			;;
+		--)
+			break
+			;;
+		*)
+			die "Unexpected option: $opt"
+			;;
+		esac
+	done
+
+	command="$1"
+	shift
+
+	case "$command" in
+	add|merge|pull)
+		default=
 		;;
-	--no-onto)
-		onto=
-		;;
-	--rejoin)
-		rejoin=1
-		;;
-	--no-rejoin)
-		rejoin=
-		;;
-	--ignore-joins)
-		ignore_joins=1
-		;;
-	--no-ignore-joins)
-		ignore_joins=
-		;;
-	--squash)
-		squash=1
+	split|push)
+		default="--default HEAD"
 		;;
-	--no-squash)
-		squash=
+	*)
+		die "Unknown command '$command'"
 		;;
-	--)
-		break
+	esac
+
+	if test -z "$prefix"
+	then
+		die "You must provide the --prefix option."
+	fi
+
+	case "$command" in
+	add)
+		test -e "$prefix" &&
+			die "prefix '$prefix' already exists."
 		;;
 	*)
-		die "Unexpected option: $opt"
+		test -e "$prefix" ||
+			die "'$prefix' does not exist; use 'git subtree add'"
 		;;
 	esac
-done
-
-command="$1"
-shift
-
-case "$command" in
-add|merge|pull)
-	default=
-	;;
-split|push)
-	default="--default HEAD"
-	;;
-*)
-	die "Unknown command '$command'"
-	;;
-esac
-
-if test -z "$prefix"
-then
-	die "You must provide the --prefix option."
-fi
-
-case "$command" in
-add)
-	test -e "$prefix" &&
-		die "prefix '$prefix' already exists."
-	;;
-*)
-	test -e "$prefix" ||
-		die "'$prefix' does not exist; use 'git subtree add'"
-	;;
-esac
-
-dir="$(dirname "$prefix/.")"
-
-if test "$command" != "pull" &&
-		test "$command" != "add" &&
-		test "$command" != "push"
-then
-	revs=$(git rev-parse $default --revs-only "$@") || exit $?
-	dirs=$(git rev-parse --no-revs --no-flags "$@") || exit $?
-	ensure_single_rev $revs
-	if test -n "$dirs"
-	then
-		die "Error: Use --prefix instead of bare filenames."
-	fi
-fi
-
-debug "command: {$command}"
-debug "quiet: {$quiet}"
-debug "revs: {$revs}"
-debug "dir: {$dir}"
-debug "opts: {$*}"
-debug
+
+	dir="$(dirname "$prefix/.")"
+
+	if test "$command" != "pull" &&
+			test "$command" != "add" &&
+			test "$command" != "push"
+	then
+		revs=$(git rev-parse $default --revs-only "$@") || exit $?
+		dirs=$(git rev-parse --no-revs --no-flags "$@") || exit $?
+		ensure_single_rev $revs
+		if test -n "$dirs"
+		then
+			die "Error: Use --prefix instead of bare filenames."
+		fi
+	fi
+
+	debug "command: {$command}"
+	debug "quiet: {$quiet}"
+	debug "revs: {$revs}"
+	debug "dir: {$dir}"
+	debug "opts: {$*}"
+	debug
+
+	"cmd_$command" "$@"
+}
 
 cache_setup () {
 	cachedir="$GIT_DIR/subtree-cache/$$"
@@ -898,4 +903,4 @@ cmd_push () {
 	fi
 }
 
-"cmd_$command" "$@"
+main "$@"
-- 
2.31.1

