Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 603531F462
	for <e@80x24.org>; Wed, 12 Jun 2019 16:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440332AbfFLQeO (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 12:34:14 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:12787 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437983AbfFLQeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 12:34:13 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45PCBC3NMNz5tlK;
        Wed, 12 Jun 2019 18:34:11 +0200 (CEST)
Received: from dx.site (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2BE514A84;
        Wed, 12 Jun 2019 18:34:11 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 3/4] mergetool: dissect strings with shell variable magic instead of `expr`
Date:   Wed, 12 Jun 2019 18:33:47 +0200
Message-Id: <ad34a9a7ab7bcfb20274d404031ff875aab797ae.1560356675.git.j6t@kdbg.org>
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
also some that can be replaced with shell builtins. Do so with `expr`.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-mergetool.sh | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 88fa6a914a..8a937f680f 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -228,9 +228,8 @@ stage_submodule () {
 }
 
 checkout_staged_file () {
-	tmpfile=$(expr \
-		"$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" \
-		: '\([^	]*\)	')
+	tmpfile="$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" &&
+	tmpfile=${tmpfile%%'	'*}
 
 	if test $? -eq 0 && test -n "$tmpfile"
 	then
@@ -255,13 +254,16 @@ merge_file () {
 		return 1
 	fi
 
-	if BASE=$(expr "$MERGED" : '\(.*\)\.[^/]*$')
-	then
-		ext=$(expr "$MERGED" : '.*\(\.[^/]*\)$')
-	else
+	# extract file extension from the last path component
+	case "${MERGED##*/}" in
+	*.*)
+		ext=.${MERGED##*.}
+		BASE=${MERGED%"$ext"}
+		;;
+	*)
 		BASE=$MERGED
 		ext=
-	fi
+	esac
 
 	mergetool_tmpdir_init
 
@@ -406,7 +408,7 @@ main () {
 		-t|--tool*)
 			case "$#,$1" in
 			*,*=*)
-				merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
+				merge_tool=${1#*=}
 				;;
 			1,*)
 				usage ;;
-- 
2.21.0.285.gc38d92e052

