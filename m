Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6B41F453
	for <e@80x24.org>; Mon, 28 Jan 2019 10:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfA1K0T (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 05:26:19 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:11859 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1K0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 05:26:19 -0500
Received: from lindisfarne.localdomain ([92.22.28.19])
        by smtp.talktalk.net with SMTP
        id o47GgLKV9oI6Lo47LgOUhi; Mon, 28 Jan 2019 10:26:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1548671176;
        bh=2OEGjO53lu/awZqL6TMqgDc7DdJYAo4+kC1Ed324Ze0=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=M0NqS016G7GZMzY4PwyBf/h1LkRj1wxIKswx94VaVZM/HebH/7AtMfmlBROHidQtk
         J4Y/bQikPNV/SmeWv9kNuTsM0YbhqBa5SqseBjkuWC1BTY8WdKJH7KXs/pPrei3XzH
         BEQR6mzdqACXcSGZIqkywwXInlecY8fpmmHXcCrQ=
X-Originating-IP: [92.22.28.19]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=9gbt3CTG59kvQAKbLaJjPA==:117
 a=9gbt3CTG59kvQAKbLaJjPA==:17 a=evINK-nbAAAA:8 a=_j53P1ue2fiBSQotjYMA:9
 a=s4Civ3FRgCSJKHQ4:21 a=R511VBYVNvxieITe:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] rebase -x: sanity check command
Date:   Mon, 28 Jan 2019 10:26:20 +0000
Message-Id: <20190128102620.18222-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.20.1
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFudidE93LHJ2uh8TzVTW94KpyltaGSYbuCKCSIT0AS167SRWSmo+wAKgsPmY22ImBgY9t1Y2AAaCxASMZqrZ0bosBjv5kiEeiwaiXxKjSWdNJwqjc91
 Kj/AF5wjxFZFfgIMcNmU3x/NvN80AxUaAik5veu8T6OIPfBALberyQl/XpldlaKuAo+KCFe49jn8dunSAHRUYx89MHY3PlFSOimOWnzqA9GpNeDWbv24tksl
 WzSt0NfhpXSl2aFRoLes1eZvN/fWhL/F8RSDQd9no5FjN/jeKSI6ZLspgoLLpMpF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user gives an empty argument to --exec then the rebase starts to
run before erroring out with

  error: missing arguments for exec
  error: invalid line 2: exec
  You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
  Or you can abort the rebase with 'git rebase --abort'.

Instead check for empty commands before starting the rebase.

Also check that the command does not contain any newlines as the
todo-list format is unable to cope with multiline commands. Note that
this changes the behavior, before this change one could do

git rebase --exec='echo one
exec echo two'

and it would insert two exec lines in the todo list, now it will error
out.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c              | 22 ++++++++++++++++++++++
 t/t3404-rebase-interactive.sh | 19 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 00de70365e..b6c54b03c1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -793,6 +793,24 @@ static void set_reflog_action(struct rebase_options *options)
 	strbuf_release(&buf);
 }
 
+static int check_exec_cmd(const char *cmd)
+{
+	int non_blank = 0;
+
+	while (*cmd) {
+		if (*cmd == '\n')
+			return error(_("exec commands cannot contain newlines"));
+		if (!isspace(*cmd))
+			non_blank = 1;
+		cmd++;
+	}
+
+	if (non_blank)
+		return 0;
+
+	return error(_("empty exec command"));
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
@@ -1130,6 +1148,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	for (i = 0; i < exec.nr; i++)
+		if (check_exec_cmd(exec.items[i].string))
+			exit(1);
+
 	if (!(options.flags & REBASE_NO_QUIET))
 		argv_array_push(&options.git_am_opts, "-q");
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7a440e08d8..c98f64eb2d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -147,6 +147,25 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 	git rebase --continue
 '
 
+test_expect_success 'rebase -x with empty command fails' '
+	test_when_finished "git rebase --abort ||:" &&
+	test_must_fail git rebase -x "" @ 2>actual &&
+	test_write_lines "error: empty exec command" >expected &&
+	test_i18ncmp expected actual &&
+	test_must_fail git rebase -x " " @ 2>actual &&
+	test_i18ncmp expected actual
+'
+
+LF='
+'
+test_expect_success 'rebase -x with newline in command fails' '
+	test_when_finished "git rebase --abort ||:" &&
+	test_must_fail git rebase -x "a${LF}b" @ 2>actual &&
+	test_write_lines "error: exec commands cannot contain newlines" \
+			 >expected &&
+	test_i18ncmp expected actual
+'
+
 test_expect_success 'rebase -i with exec of inexistent command' '
 	git checkout master &&
 	test_when_finished "git rebase --abort" &&
-- 
2.20.1

