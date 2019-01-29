Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7DE61F453
	for <e@80x24.org>; Tue, 29 Jan 2019 18:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfA2Sn2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 13:43:28 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:35072 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfA2Sn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 13:43:28 -0500
Received: from lindisfarne.localdomain ([92.22.27.120])
        by smtp.talktalk.net with SMTP
        id oYLvg8RaGAGVroYM1gZ2Da; Tue, 29 Jan 2019 18:43:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1548787406;
        bh=Vg5JEPwNzKNVdSRKqv/yf/hOW4XUMYAPaLpIcUaQW3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=AnekxbT+e8L3VhI41ZXfaW9xmJXhYCi8FdwBZsnFvxp3DJfgQQD/U4BH1tMiWgHwz
         7LAB5IDXYMZQ87tRTkfIYFATuahG3pnnvG72E6XcLhLl/KVp0SQQtQIFO+1eJGXeaN
         YwD+Y6i1PPzrH50fh7QeYo4UuEW/Nx+1RS1becYY=
X-Originating-IP: [92.22.27.120]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=Dos57XaWGaBQ6LzLGuzouw==:117
 a=Dos57XaWGaBQ6LzLGuzouw==:17 a=evINK-nbAAAA:8 a=MomJa_gHs-XO8AoSorAA:9
 a=ZM-my5MYWK8zTG9Y:21 a=eKxZmEiwEwvxgqkz:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2] rebase -x: sanity check command
Date:   Tue, 29 Jan 2019 18:43:27 +0000
Message-Id: <20190129184327.30391-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <nycvar.QRO.7.76.6.1901291632070.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1901291632070.41@tvgsbejvaqbjf.bet>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKai8qmugmtyEGcshYFXbv2IMOKTXFeR2gYJ98ddLZf+a/Nzh7Bk7d2PILdKs2u5P2AlK9UvqihUb8WNXcIFsGz+zonOsMyL+01AjnuqxSXMrgYguJP2
 p+gGlEq/YQg4OeKTTVjmDt+EO4+8/u/tqwU0g5yZ82ip3Q+Zp6HXHHa/lQi/t7wQ+lQyPLVhkryi5RHC6VfA80bmXxfWLSu3+JTABsQwKPYzVAvPIyPVIayy
 pZuHKnTuutZyEDvea7ZpVwmvY588urMnvWRgtY0c5PCtQWOir00iItUkohKCy4cv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user gives an empty argument to --exec then git creates a todo
list that it cannot parse. The rebase starts to run before erroring out
with

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

Apologies for the resend but I messed up the from address on the
previous send and I don't think it made it to the mailing list.

Thanks for the comments. I've updated the code as suggested by Dscho
and tried to make it clearer in the commit message that this is fixing
git creating a todo-list that it cannot parse.

Range-diff against v1:
1:  9626549aec ! 1:  726b84c300 rebase -x: sanity check command
    @@ -2,8 +2,9 @@
     
         rebase -x: sanity check command
     
    -    If the user gives an empty argument to --exec then the rebase starts to
    -    run before erroring out with
    +    If the user gives an empty argument to --exec then git creates a todo
    +    list that it cannot parse. The rebase starts to run before erroring out
    +    with
     
           error: missing arguments for exec
           error: invalid line 2: exec
    @@ -33,21 +34,16 @@
      
     +static int check_exec_cmd(const char *cmd)
     +{
    -+	int non_blank = 0;
    ++	if (strchr(cmd, '\n'))
    ++		return error(_("exec commands cannot contain newlines"));
     +
    -+	while (*cmd) {
    -+		if (*cmd == '\n')
    -+			return error(_("exec commands cannot contain newlines"));
    -+		if (!isspace(*cmd))
    -+			non_blank = 1;
    -+		cmd++;
    -+	}
    ++	/* Does the command consist purely of whitespace? */
    ++	if (!cmd[strspn(cmd, " \t\r\f\v")])
    ++		return error(_("empty exec command"));
     +
    -+	if (non_blank)
    -+		return 0;
    -+
    -+	return error(_("empty exec command"));
    ++	return 0;
     +}
    ++
     +
      int cmd_rebase(int argc, const char **argv, const char *prefix)
      {

 builtin/rebase.c              | 17 +++++++++++++++++
 t/t3404-rebase-interactive.sh | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 00de70365e..f75bd79b45 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -793,6 +793,19 @@ static void set_reflog_action(struct rebase_options *options)
 	strbuf_release(&buf);
 }
 
+static int check_exec_cmd(const char *cmd)
+{
+	if (strchr(cmd, '\n'))
+		return error(_("exec commands cannot contain newlines"));
+
+	/* Does the command consist purely of whitespace? */
+	if (!cmd[strspn(cmd, " \t\r\f\v")])
+		return error(_("empty exec command"));
+
+	return 0;
+}
+
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
@@ -1130,6 +1143,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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

