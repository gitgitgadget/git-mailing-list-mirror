Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623C5207EC
	for <e@80x24.org>; Fri,  7 Oct 2016 06:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbcJGGYl (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 02:24:41 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34772 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753058AbcJGGYk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 02:24:40 -0400
Received: by mail-pa0-f65.google.com with SMTP id r9so2243685paz.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=U8R1FFaZkn+SMb4wB/uIGhjixctIxmX+UN6gP8uVS7M=;
        b=DVEfg/m1smsa6/69+WuzcsdBjCLrrlx3lL7CT5fTjwOdnXGuOG3VJ6ruf6/fy7eUft
         aDNjt57uB16MFCxPH2XzzoRREQ16pAJO9BjdBybDET/GvGou56Wfc9IzkXgRAS41nPtQ
         cQ0aP9tin+d9SLpbwppf5TZxURLNYHltrqG+79EwVbhCdLoKmPHcLr3jRscT/ePfAZQ9
         r18jcGXFnlm6jYZgC00eYm5W3HXQlknF39Jpl8u3i9uUgh67igVstou4k9avMFxPuYEQ
         VNOot39cx/1f5VHfxJzxYAodFkUW5GxzJ4yujfHOZDZVIErPbQQnCjuvo531EpWWi/Sd
         /muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U8R1FFaZkn+SMb4wB/uIGhjixctIxmX+UN6gP8uVS7M=;
        b=fFoRVE994ELJSsWZ/g4ECvn26/xds/nH89gdHPTee5aqZ6Z7cxQyOWU321P2jb+cj0
         cPOdelecT/EvGvlUqYwixl9mEZVcyuUL4tpg9MN4IpIenxA0FVqL7zNpQrOANmL4uHw0
         qy5BxUsoH5OVWVcd/ILHFtN9quAZrpF8cDZUcczBTn40Y+lKlTivVnd6MwR4ggaDD7o1
         vn9uCjT79zNzrXt7IyZidnQxJGKUyQldYICnaM+F1RRk5gA07WwWrOaxLLgXrLYkdzK9
         PB55n/KssghhgyFj0aym1fc05Rs5tWIOPuZzwlsyHPDqjCEzMmCvQmV9GBiEXWq5NTxE
         ggcQ==
X-Gm-Message-State: AA6/9Rm1F/NK9zs9vQwbLwMYQaXVLtP05WLoI9dN7y28osxnTDPllYFYppAxU9TQMGXmtw==
X-Received: by 10.66.246.13 with SMTP id xs13mr27761348pac.57.1475821459347;
        Thu, 06 Oct 2016 23:24:19 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id r89sm10489615pfd.3.2016.10.06.23.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2016 23:24:17 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH v2 2/4] mergetool: move main program flow into a main() function
Date:   Thu,  6 Oct 2016 23:24:15 -0700
Message-Id: <20161007062415.21551-1-davvid@gmail.com>
X-Mailer: git-send-email 2.10.1.386.g42aabb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it easier to follow the program's flow by isolating all
logic into functions.  Isolate the main execution code path into
a single unit instead of having prompt_after_failed_merge()
interrupt it partyway through.

The use of a main() function is borrowing a convention from C,
Python, Perl, and many other languages.  This helps readers more
familiar with other languages understand the purpose of each
function when diving into the codebase with fresh eyes.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
As suggested by Hannes, v2 provides a better commit message.

This is a stylistic choice, but since I was about to start hacking on it,
I couldn't help but notice the organic sprawl that could use some tidying
before adding new features.

 git-mergetool.sh | 180 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 93 insertions(+), 87 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 300ce7f..b2cd0a4 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -366,51 +366,6 @@ merge_file () {
 	return 0
 }
 
-prompt=$(git config --bool mergetool.prompt)
-guessed_merge_tool=false
-
-while test $# != 0
-do
-	case "$1" in
-	--tool-help=*)
-		TOOL_MODE=${1#--tool-help=}
-		show_tool_help
-		;;
-	--tool-help)
-		show_tool_help
-		;;
-	-t|--tool*)
-		case "$#,$1" in
-		*,*=*)
-			merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
-			;;
-		1,*)
-			usage ;;
-		*)
-			merge_tool="$2"
-			shift ;;
-		esac
-		;;
-	-y|--no-prompt)
-		prompt=false
-		;;
-	--prompt)
-		prompt=true
-		;;
-	--)
-		shift
-		break
-		;;
-	-*)
-		usage
-		;;
-	*)
-		break
-		;;
-	esac
-	shift
-done
-
 prompt_after_failed_merge () {
 	while true
 	do
@@ -427,57 +382,108 @@ prompt_after_failed_merge () {
 	done
 }
 
-git_dir_init
-require_work_tree
+main () {
+	prompt=$(git config --bool mergetool.prompt)
+	guessed_merge_tool=false
+
+	while test $# != 0
+	do
+		case "$1" in
+		--tool-help=*)
+			TOOL_MODE=${1#--tool-help=}
+			show_tool_help
+			;;
+		--tool-help)
+			show_tool_help
+			;;
+		-t|--tool*)
+			case "$#,$1" in
+			*,*=*)
+				merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
+				;;
+			1,*)
+				usage ;;
+			*)
+				merge_tool="$2"
+				shift ;;
+			esac
+			;;
+		-y|--no-prompt)
+			prompt=false
+			;;
+		--prompt)
+			prompt=true
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	git_dir_init
+	require_work_tree
 
-if test -z "$merge_tool"
-then
-	# Check if a merge tool has been configured
-	merge_tool=$(get_configured_merge_tool)
-	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"
 	then
-		merge_tool=$(guess_merge_tool) || exit
-		guessed_merge_tool=true
+		# Check if a merge tool has been configured
+		merge_tool=$(get_configured_merge_tool)
+		# Try to guess an appropriate merge tool if no tool has been set.
+		if test -z "$merge_tool"
+		then
+			merge_tool=$(guess_merge_tool) || exit
+			guessed_merge_tool=true
+		fi
 	fi
-fi
-merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
-merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
-
-files=
+	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
+	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
-if test $# -eq 0
-then
-	cd_to_toplevel
+	files=
 
-	if test -e "$GIT_DIR/MERGE_RR"
+	if test $# -eq 0
 	then
-		files=$(git rerere remaining)
+		cd_to_toplevel
+
+		if test -e "$GIT_DIR/MERGE_RR"
+		then
+			files=$(git rerere remaining)
+		else
+			files=$(git ls-files -u |
+				sed -e 's/^[^	]*	//' | sort -u)
+		fi
 	else
-		files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
+		files=$(git ls-files -u -- "$@" |
+			sed -e 's/^[^	]*	//' | sort -u)
 	fi
-else
-	files=$(git ls-files -u -- "$@" | sed -e 's/^[^	]*	//' | sort -u)
-fi
-
-if test -z "$files"
-then
-	echo "No files need merging"
-	exit 0
-fi
-
-printf "Merging:\n"
-printf "%s\n" "$files"
-
-rc=0
-for i in $files
-do
-	printf "\n"
-	if ! merge_file "$i"
+
+	if test -z "$files"
 	then
-		rc=1
-		prompt_after_failed_merge || exit 1
+		echo "No files need merging"
+		exit 0
 	fi
-done
 
-exit $rc
+	printf "Merging:\n"
+	printf "%s\n" "$files"
+
+	rc=0
+	for i in $files
+	do
+		printf "\n"
+		if ! merge_file "$i"
+		then
+			rc=1
+			prompt_after_failed_merge || exit 1
+		fi
+	done
+
+	exit $rc
+}
+
+main "$@"
-- 
2.10.1.386.g42aabb0

