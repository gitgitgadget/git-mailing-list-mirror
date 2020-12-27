Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E5DC433E0
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 21:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF11F22522
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 21:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgL0U70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 15:59:26 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:34380 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgL0U7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 15:59:25 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktd7k-008AYA-6g; Sun, 27 Dec 2020 13:58:44 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktd7j-00FgVN-1e; Sun, 27 Dec 2020 13:58:43 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id E77EC128062A;
        Sun, 27 Dec 2020 13:58:42 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dDclQ3H3JTSC; Sun, 27 Dec 2020 13:58:42 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id 8564D12806F6;
        Sun, 27 Dec 2020 13:58:42 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>
Date:   Sun, 27 Dec 2020 13:58:34 -0700
Message-Id: <20201227205835.502556-2-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc0.dirty
In-Reply-To: <20201227205835.502556-1-seth@eseth.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <20201227205835.502556-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktd7j-00FgVN-1e;;;mid=<20201227205835.502556-2-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v6 1/2] mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

It doesn't make sense to display easily-solvable conflicts in the
different views of all mergetools.

Only the chunks that warrant conflict markers should be displayed.

In order to unobtrusively do this, add a new configuration:
mergetool.autoMerge.

See Seth House's blog post [1] for the idea, and the rationale.

[1] https://www.eseth.org/2020/mergetools.html

Original-idea-by: Seth House <seth@eseth.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/mergetool.txt |  3 +++
 git-mergetool.sh                   | 10 ++++++++++
 t/t7610-mergetool.sh               | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 16a27443a3..43af7a96f9 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -61,3 +61,6 @@ mergetool.writeToTemp::
 
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
+
+mergetool.autoMerge::
+	Automatically resolve conflicts that don't require user intervention.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e3f6d543fb..6e86d3b492 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -274,6 +274,7 @@ merge_file () {
 		BASE=${BASE##*/}
 	fi
 
+	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
 	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
 	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
 	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
@@ -322,6 +323,15 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
+	if test "$(git config --bool mergetool.autoMerge)" = "true"
+	then
+		git merge-file --diff3 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
+		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
+		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
+		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
+		rm -- "$DIFF3"
+	fi
+
 	if test -z "$local_mode" || test -z "$remote_mode"
 	then
 		echo "Deleted merge conflict for '$MERGED':"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 70afdd06fa..b75c91199b 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -828,4 +828,22 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mergetool automerge' '
+	test_config mergetool.automerge true &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test${test_count}_b master &&
+	echo -e "base\n\na" >file1 &&
+	git commit -a -m "base" &&
+	echo -e "base\n\nc" >file1 &&
+	git commit -a -m "remote update" &&
+	git checkout -b test${test_count}_a HEAD~ &&
+	echo -e "local\n\nb" >file1 &&
+	git commit -a -m "local update" &&
+	test_must_fail git merge test${test_count}_b &&
+	yes "" | git mergetool file1 &&
+	echo -e "local\n\nc" >expect &&
+	test_cmp expect file1 &&
+	git commit -m "test resolved with mergetool"
+'
+
 test_done
-- 
2.29.2


