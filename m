Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D24C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 09:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F802206B5
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 09:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="TT7A0HPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHJJEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:04:23 -0400
Received: from out0.migadu.com ([94.23.1.103]:58866 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgHJJEX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 05:04:23 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1597050261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vG6sjA2I6OnzBWcCr3Ad5F/FEHoWhexVi5oWeeI3+2M=;
        b=TT7A0HPYSfF4khjyyrciZMdTxJlbI7yChy79imm6YWIEHF1jb/4pLTKuRrsDVfIgFKTsVC
        Yk9aTaOOeEFx1vXPM0t8sOb3NERq6j4DWOHDVWvTBQly2Ewv6QLg03lJHeU2F1p077mrlH
        Tj/XJ9drcQCgfnWZ0m9f/vsTTvX0biI=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [RESEND PATCH v2] diff-lib: use worktree mode in diffs from i-t-a entries
Date:   Mon, 10 Aug 2020 05:03:36 -0400
Message-Id: <20200810090336.43970-1-ray@ameretat.dev>
In-Reply-To: <20200810085343.43717-1-ray@ameretat.dev>
References: <20200810085343.43717-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When creating "new file" diffs against i-t-a index entries, diff-lib
erroneously uses the placeholder mode in the cache entry rather than the
mode of the file in the worktree.

Change run_diff_files() to correctly use the mode of the worktree file
in this case, and add a test verifying that diff uses the worktree mode.

Tested-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
Whoops - this is a PATCH v2 (passed -v2 on the wrong command line).
Apologies!

 diff-lib.c                    | 3 ++-
 t/t4069-diff-intent-to-add.sh | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 25fd2dee19..50521e2093 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -219,7 +219,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
-				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+				newmode = ce_mode_from_stat(ce, st.st_mode);
+				diff_addremove(&revs->diffopt, '+', newmode,
 					       &null_oid, 0, ce->name, 0);
 				continue;
 			}
diff --git a/t/t4069-diff-intent-to-add.sh b/t/t4069-diff-intent-to-add.sh
index 85c1a35ca7..cdb41ba89d 100644
--- a/t/t4069-diff-intent-to-add.sh
+++ b/t/t4069-diff-intent-to-add.sh
@@ -15,6 +15,12 @@ test_expect_success 'diff between i-t-a and file should be new file' '
 	grep "new file mode 100644" output
 '
 
+test_expect_success 'new file diff should use worktree mode' '
+        chmod 755 test-file &&
+        git diff >output &&
+        grep "new file mode 100755" output
+'
+
 test_expect_success 'diff between i-t-a and no file should be deletion' '
 	rm -f test-file &&
 	git diff >output &&
-- 
2.28.0.3.gc4aba908ca

