Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E24C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 05:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC7864E0F
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 05:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhA3Fwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 00:52:32 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:33194 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhA3FsY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 00:48:24 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l5j6g-00FRSe-6a; Fri, 29 Jan 2021 22:47:38 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1l5j6e-000808-EC; Fri, 29 Jan 2021 22:47:38 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 3E2891280DB7;
        Fri, 29 Jan 2021 22:47:36 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9soNxVWOM0Bp; Fri, 29 Jan 2021 22:47:36 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id C4B54128059F;
        Fri, 29 Jan 2021 22:47:35 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 29 Jan 2021 22:46:53 -0700
Message-Id: <20210130054655.48237-2-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.84.g93c9af8b0b
In-Reply-To: <20210130054655.48237-1-seth@eseth.com>
References: <20201228192919.1195211-1-seth@eseth.com>
 <20210130054655.48237-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1l5j6e-000808-EC;;;mid=<20210130054655.48237-2-seth@eseth.com>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v10 1/3] mergetool: add hideResolved configuration
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of a mergetool is to help the user resolve any conflicts
that Git cannot automatically resolve. If there is a conflict that must
be resolved manually Git will write a file named MERGED which contains
everything Git was able to resolve by itself and also everything that it
was not able to resolve wrapped in conflict markers.

One way to think of MERGED is as a two- or three-way diff. If each
"side" of the conflict markers is separately extracted an external tool
can represent those conflicts as a side-by-side diff.

However many mergetools instead diff LOCAL and REMOTE both of which
contain versions of the file from before the merge. Since the conflicts
Git resolved automatically are not present it forces the user to
manually re-resolve those conflicts. Some mergetools also show MERGED
but often only for reference and not as the focal point to resolve the
conflicts.

This adds a `mergetool.hideResolved` flag that will overwrite LOCAL and
REMOTE with each corresponding "side" of a conflicted file and thus hide
all conflicts that Git was able to resolve itself. Overwriting these
files will immediately benefit any mergetool that uses them without
requiring any changes.

No adverse effects were noted in a small survey of popular mergetools[1]
so this behavior defaults to `true`. However it can be globally disabled
by setting `mergetool.hideResolved` to `false`.

[1] https://www.eseth.org/2020/mergetools.html
    https://github.com/whiteinge/eseth/blob/c884424769fffb05d87afb33b2cf80cecb4044c3/2020/mergetools.md

Original-implementation-by: Felipe Contreras <felipe.contreras@gmail.com>
Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Seth House <seth@eseth.com>
---
 Documentation/config/mergetool.txt |  9 +++++++++
 git-mergetool.sh                   | 14 ++++++++++++++
 t/t7610-mergetool.sh               | 18 ++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 16a27443a3..3171bacf91 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -40,6 +40,15 @@ mergetool.meld.useAutoMerge::
 	value of `false` avoids using `--auto-merge` altogether, and is the
 	default value.
 
+mergetool.hideResolved::
+	During a merge Git will automatically resolve as many conflicts as
+	possible and then wrap conflict markers around any conflicts that it
+	cannot resolve. This flag writes the non-conflicting parts into the
+	corresponding 'LOCAL' and 'REMOTE' files so that only the unresolved
+	conflicts are presented to the merge tool. Can be overriden per-tool
+	via the `mergetool.<tool>.hideResolved` configuration variable.
+	Defaults to `true`.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e3f6d543fb..5b0d15ed89 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -239,6 +239,13 @@ checkout_staged_file () {
 	fi
 }
 
+hide_resolved () {
+	git merge-file --ours -q -p "$LOCAL" "$BASE" "$REMOTE" >"$LCONFL"
+	git merge-file --theirs -q -p "$LOCAL" "$BASE" "$REMOTE" >"$RCONFL"
+	mv -- "$LCONFL" "$LOCAL"
+	mv -- "$RCONFL" "$REMOTE"
+}
+
 merge_file () {
 	MERGED="$1"
 
@@ -276,7 +283,9 @@ merge_file () {
 
 	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
 	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
+	LCONFL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_LCONFL_$$$ext"
 	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
+	RCONFL="$MERGETOOL_TMPDIR/${BASE}_REMOTE_RCONFL_$$$ext"
 	BASE="$MERGETOOL_TMPDIR/${BASE}_BASE_$$$ext"
 
 	base_mode= local_mode= remote_mode=
@@ -322,6 +331,11 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
+	if test "$(git config --get mergetool.hideResolved)" != "false"
+	then
+		hide_resolved
+	fi
+
 	if test -z "$local_mode" || test -z "$remote_mode"
 	then
 		echo "Deleted merge conflict for '$MERGED':"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 70afdd06fa..0e34b87e37 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -828,4 +828,22 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mergetool hideResolved' '
+	test_config mergetool.hideResolved true &&
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


