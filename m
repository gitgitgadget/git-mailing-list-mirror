Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477581F462
	for <e@80x24.org>; Wed, 12 Jun 2019 16:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502096AbfFLQeO (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 12:34:14 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:3351 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438237AbfFLQeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 12:34:13 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45PCBC3rNPz5tlH;
        Wed, 12 Jun 2019 18:34:11 +0200 (CEST)
Received: from dx.site (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 40B4C4A85;
        Wed, 12 Jun 2019 18:34:11 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 4/4] mergetool: use shell variable magic instead of `awk`
Date:   Wed, 12 Jun 2019 18:33:48 +0200
Message-Id: <99a6a893395a8b6bada170172c821550d84d6983.1560356675.git.j6t@kdbg.org>
X-Mailer: git-send-email 2.21.0.285.gc38d92e052
In-Reply-To: <cover.1560356675.git.j6t@kdbg.org>
References: <cover.1560356675.git.j6t@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-mergetool spawns an enormous amount of processes. For this reason,
the test script, t7610, is exceptionally slow, in particular, on
Windows. Most of the processes are invocations of git. There are
also some that can be replaced with shell builtins. Avoid repeated
calls of `git ls-files` and `awk`.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-mergetool.sh | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 8a937f680f..e3f6d543fb 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -279,15 +279,30 @@ merge_file () {
 	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
 	BASE="$MERGETOOL_TMPDIR/${BASE}_BASE_$$$ext"
 
-	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
-	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
-	remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
+	base_mode= local_mode= remote_mode=
+
+	# here, $IFS is just a LF
+	for line in $f
+	do
+		mode=${line%% *}		# 1st word
+		sha1=${line#"$mode "}
+		sha1=${sha1%% *}		# 2nd word
+		case "${line#$mode $sha1 }" in	# remainder
+		'1	'*)
+			base_mode=$mode
+			;;
+		'2	'*)
+			local_mode=$mode local_sha1=$sha1
+			;;
+		'3	'*)
+			remote_mode=$mode remote_sha1=$sha1
+			;;
+		esac
+	done
 
 	if is_submodule "$local_mode" || is_submodule "$remote_mode"
 	then
 		echo "Submodule merge conflict for '$MERGED':"
-		local_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
-		remote_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
 		describe_file "$local_mode" "local" "$local_sha1"
 		describe_file "$remote_mode" "remote" "$remote_sha1"
 		resolve_submodule_merge
-- 
2.21.0.285.gc38d92e052

