Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA098C433E6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 04:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5AD20786
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 04:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgL1Ezn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 23:55:43 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55992 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgL1Ezn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 23:55:43 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktkYg-008i4y-1j; Sun, 27 Dec 2020 21:55:02 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktkYe-00Gtyg-Qq; Sun, 27 Dec 2020 21:55:01 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id B25DE5004ED;
        Sun, 27 Dec 2020 21:55:00 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M9NwLpKAn4lq; Sun, 27 Dec 2020 21:55:00 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id C6F80500511;
        Sun, 27 Dec 2020 21:54:59 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>
Date:   Sun, 27 Dec 2020 21:54:24 -0700
Message-Id: <20201228045427.1166911-2-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc2.4.g8f3eabcc0e
In-Reply-To: <20201228045427.1166911-1-seth@eseth.com>
References: <20201228004152.522421-1-seth@eseth.com>
 <20201228045427.1166911-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktkYe-00Gtyg-Qq;;;mid=<20201228045427.1166911-2-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v8 1/4] mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

The purpose of mergetools is to resolve conflicts when git cannot
automatically do so.

In order to do that git has added markers in the specific areas that
need resolving, which the user must manually fix. The tool is supposed
to help with that.

However, by passing the original BASE, LOCAL, and REMOTE files, many
changes without conflict are presented to the user when in fact nothing
needs to be done for those.

We can fix that by propagating the final version of the file with the
automatic merge to all the panes of the mergetool (BASE, LOCAL, and
REMOTE), and only make them differ on the places where there are actual
conflicts.

As most people will want the new behavior, we enable it by default.
Users that do not want the new behavior can set the new configuration
mergetool.autoMerge to false.

See Seth House's blog post [1] for the idea, and the rationale.

[1] https://www.eseth.org/2020/mergetools.html

Original-idea-by: Seth House <seth@eseth.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Seth House <seth@eseth.com>
---
 Documentation/config/mergetool.txt |  3 +++
 git-mergetool.sh                   | 17 +++++++++++++++++
 t/t7610-mergetool.sh               | 18 ++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 16a27443a3..7ce6d0d3ac 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -61,3 +61,6 @@ mergetool.writeToTemp::
 
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
+
+mergetool.autoMerge::
+	Remove lines without conflicts from all the files. Defaults to `true`.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e3f6d543fb..f4db0cac8d 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -239,6 +239,17 @@ checkout_staged_file () {
 	fi
 }
 
+auto_merge () {
+	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
+	if test -s "$DIFF3"
+	then
+		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
+		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
+		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
+	fi
+	rm -- "$DIFF3"
+}
+
 merge_file () {
 	MERGED="$1"
 
@@ -274,6 +285,7 @@ merge_file () {
 		BASE=${BASE##*/}
 	fi
 
+	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
 	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
 	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
 	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
@@ -322,6 +334,11 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
+	if test "$(git config --bool mergetool.autoMerge)" != "false"
+	then
+		auto_merge
+	fi
+
 	if test -z "$local_mode" || test -z "$remote_mode"
 	then
 		echo "Deleted merge conflict for '$MERGED':"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 70afdd06fa..ccabd04823 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -828,4 +828,22 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mergetool automerge' '
+	test_config mergetool.automerge true &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test${test_count}_b master &&
+	test_write_lines >file1 base "" a &&
+	git commit -a -m "base" &&
+	test_write_lines >file1 base "" c &&
+	git commit -a -m "remote update" &&
+	git checkout -b test${test_count}_a HEAD~ &&
+	test_write_lines >file1 local "" b &&
+	git commit -a -m "local update" &&
+	test_must_fail git merge test${test_count}_b &&
+	yes "" | git mergetool file1 &&
+	test_write_lines >expect local "" c &&
+	test_cmp expect file1 &&
+	git commit -m "test resolved with mergetool"
+'
+
 test_done
-- 
2.29.2


