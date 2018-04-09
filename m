Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931761F404
	for <e@80x24.org>; Mon,  9 Apr 2018 18:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeDISwK (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 14:52:10 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42448 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752947AbeDISwK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Apr 2018 14:52:10 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w39IiGxg005924;
        Mon, 9 Apr 2018 11:52:06 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h6uukhbkt-1;
        Mon, 09 Apr 2018 11:52:06 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E29A42213763;
        Mon,  9 Apr 2018 11:52:05 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D9EA02CDE6F;
        Mon,  9 Apr 2018 11:52:05 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] Make running git under other debugger-like programs easy
Date:   Mon,  9 Apr 2018 11:51:36 -0700
Message-Id: <20180409185136.4880-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.1.gcd9d12fc4a.dirty
In-Reply-To: <20180405174935.598-1-newren@gmail.com>
References: <20180405174935.598-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=650 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804090190
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows us to run git, when using the script from bin-wrappers, under
other programs.  A few examples for usage within testsuite scripts:

   debug git checkout master
   debug --debugger=nemiver git $ARGS
   debug -d "valgrind --tool-memcheck --track-origins=yes" git $ARGS

Or, if someone has bin-wrappers/ in their $PATH and is executing git
outside the testsuite:

   GIT_DEBUGGER="gdb --args" git $ARGS
   GIT_DEBUGGER=nemiver git $ARGS
   GIT_DEBUGGER="valgrind --tool=memcheck --track-origins=yes" git $ARGS

There is also a handy shortcut of GIT_DEBUGGER=1 meaning the same as
GIT_DEBUGGER="gdb --args"

Original-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/test-lib-functions.sh | 24 ++++++++++++++++++++----
 wrap-for-bin.sh         | 19 +++++++++++++------
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1701fe2a06..0591d9a7f8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -145,12 +145,28 @@ test_pause () {
 	"$SHELL_PATH" <&6 >&5 2>&7
 }
 
-# Wrap git in gdb. Adding this to a command can make it easier to
-# understand what is going on in a failing test.
+# Wrap git with a debugger. Adding this to a command can make it easier
+# to understand what is going on in a failing test.
 #
-# Example: "debug git checkout master".
+# Examples:
+#     debug git checkout master
+#     debug --debugger=nemiver git $ARGS
+#     debug -d "valgrind --tool=memcheck --track-origins=yes" git $ARGS
 debug () {
-	 GIT_TEST_GDB=1 "$@" <&6 >&5 2>&7
+	case "$1" in
+	-d)
+		DBG_FLAGS="$2" &&
+		shift 2
+		;;
+	--debugger=*)
+		DBG_FLAGS="${1#*=}" &&
+		shift 1
+		;;
+	*)
+		DBG_FLAGS=1
+		;;
+	esac &&
+	GIT_DEBUGGER="${DBG_FLAGS}" "$@" <&6 >&5 2>&7
 }
 
 # Call test_commit with the arguments
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 22b6e4948f..376c056842 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -20,10 +20,17 @@ PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
 
-if test -n "$GIT_TEST_GDB"
-then
-	unset GIT_TEST_GDB
-	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
-else
+case "$GIT_DEBUGGER" in
+'')
 	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
-fi
+	;;
+1)
+	unset GIT_DEBUGGER
+	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+	;;
+*)
+	GIT_DEBUGGER_ARGS="$GIT_DEBUGGER"
+	unset GIT_DEBUGGER
+	exec ${GIT_DEBUGGER_ARGS} "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+	;;
+esac
-- 
2.15.0.1.gcd9d12fc4a.dirty

