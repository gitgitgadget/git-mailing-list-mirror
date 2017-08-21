Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74EF208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 12:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbdHUMxY (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 08:53:24 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60572 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdHUMxV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 08:53:21 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue004
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MHtgv-1dixFo3Udx-003dAp; Mon, 21
 Aug 2017 14:53:17 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     hIpPy <hippy2981@gmail.com>
Subject: [PATCH v2 3/3] merge: save merge state earlier
Date:   Mon, 21 Aug 2017 14:53:16 +0200
Message-Id: <407f205e2b824d56c652411256eea3c0047576ef.1503319519.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.364.ge466dba5f7
In-Reply-To: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
References: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
In-Reply-To: <cover.1503319519.git.git@grubix.eu>
References: <cover.1503319519.git.git@grubix.eu>
X-Provags-ID: V03:K0:u6BCZR4ZayG+y1eA7Uho5hZKdngSj8QW+F+x1Tw+A7OhsYxE6e3
 rAVdr4Y+sFVmxJgYhvFK+9yCbGBO+MYOOaXnNIogiQEauSJCc2jHCB4qJzvHK+BM4WE8e3z
 9tRkGyWkFOciPU+nat3eGIvbx6DSg8deOsW4rcSSlTH/1qkV3yQ1OXcj1pKgjrgE60oFibe
 WbptnlLGvwsKLxqRuQq1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gRj97A19k8Q=:Ea1RxYXcfw9QEfioCLX7st
 /e4Abpyo0Elq7mBckg+M6woKJ23rttUWyOEtFEO5hzi5k4dEjQtrGuGEPj0+Ptdz5MchV8vMa
 YlY519nlptq7KanPcACjbv7ZIM5D/H0zjChqj4xIZSPOeOf8Le4n8dG/UJCN242ElW2FF/bZ6
 HKUeaghxovhOFyv4kuAh66gk5anbXwj5clw1OmO9zHm0ZaN/yjq86kiziXLU9iGYo/RgYMr+I
 svhkBQ2XjpjEOTdeHrRNBEHhdSkPjPa8jefR6386uw/BVIjNOdWsAgCmEZngXLhkXBat06UbE
 qKXzBo/HCKE8G0Ffqp91JUh4U5KD/QclgPOvp9rxgIjX588YgGqGmA/s3h7YQ/L+afYPBqwUA
 nPCPI93xYNROid/PaRa3tLDG7pTsSsCmRedsPlsXQkeNDGi7vccUQXIlux6ESh5I+OMOXzOo9
 HD+Oef6awpv6nYG8PEg8aU6GiczOrniPdSDAmxhq/WkhpO9zOyr+On7HS3/lzt1sBx/ORYMT1
 aIeI14PV+ROrAKnfTMajKH8Z9TsoTVbic/NgiWVduskUj+K1hEDaXXM8lf7sioWUOVvXlz+z5
 8YSZI5BGITMFr2roXIN5QIpiRknIo72ZdXb8+Z0/M4QxYM+HW2mytFqd7uuJFVcZYkzfR5/z7
 +we70HIju+6VrLuxl3Axg6mywDA2JnkuANHA8VVtVl3yvQqTpA2quLfxv3T3S+1rAhq3E8Siv
 CEcaAgMoUeWjiI9mbC8BlOsj6lb8o57SbAZOJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the `git merge` process is killed while waiting for the editor to
finish, the merge state is lost but the prepared merge msg and tree is kept.
So, a subsequent `git commit` creates a squashed merge even when the
user asked for proper merge commit originally.

Save the merge state earlier (in the non-squash case) so that it does
not get lost.

Reported-by: hIpPy <hippy2981@gmail.com>
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/merge.c  |  3 +++
 t/t7600-merge.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 86f0adde3b..5379b08824 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -758,6 +758,7 @@ N_("Please enter a commit message to explain why this merge is necessary,\n"
    "Lines starting with '%c' will be ignored, and an empty message aborts\n"
    "the commit.\n");
 
+static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
@@ -767,6 +768,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	if (signoff)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
+	if (!squash)
+		write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
 			    git_path_merge_msg(), "merge", NULL))
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 2ebda509ac..80194b79f9 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -774,4 +774,19 @@ test_expect_success 'merge can be completed with --continue' '
 	verify_parents $c0 $c1
 '
 
+write_script .git/FAKE_EDITOR <<EOF
+# kill -TERM command added below.
+EOF
+
+test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue' '
+	git reset --hard c0 &&
+	! "$SHELL_PATH" -c '\''
+	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  GIT_EDITOR=.git/FAKE_EDITOR
+	  export GIT_EDITOR
+	  exec git merge --no-ff --edit c1'\'' &&
+	git merge --continue &&
+	verify_parents $c0 $c1
+'
+
 test_done
-- 
2.14.1.364.ge466dba5f7

