Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8DDC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 14:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784AA2076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 14:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rbx.email header.i=@rbx.email header.b="Vfysh0NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgHKOKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:10:38 -0400
Received: from aibo.runbox.com ([91.220.196.211]:45528 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbgHKOKf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 10:10:35 -0400
X-Greylist: delayed 3335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2020 10:10:33 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbx.email;
         s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From;
        bh=yx1/RbJhL3UaAcrThEGX+p4nT09LmIzDO36giVyqRi4=; b=Vfysh0NFE5Va4VtB/s4Bivo2ZB
        wYS2/2EkFQYvNSdXTwNEIfPNuNPO1/+FNSQFDazuWrICyNYoRKqd+Q9vhiLCzvxleaoP8cPF/shfq
        WEELCc7GMERZMcxCIbALhpMJicCTYVFQcz4xFCue5TLp42Qge21Iz9tjneobU5rGmveLsDh5SU8vY
        +CMzmNX0biCMB8KO0mODoQbII6J68oHTSODJED695lDKBHzYUryPrsOy2dWvo3QYVfwcp5hDc87Um
        pJ/nYjNuuPvfYokOKIKILGc22xBSeACvIlWYNJEgWQtBE4lVTW/IycTr1anFyHiA1gGEKSmehBeWX
        GVu26EqQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <detegr@rbx.email>)
        id 1k5U7D-0001AL-T9; Tue, 11 Aug 2020 15:14:56 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated alias (932193)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1k5U6u-00070R-OH; Tue, 11 Aug 2020 15:14:36 +0200
From:   =?UTF-8?q?Antti=20Ker=C3=A4nen?= <detegr@rbx.email>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antti=20Ker=C3=A4nen?= <detegr@rbx.email>,
        =?UTF-8?q?Jussi=20Ker=C3=A4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
Date:   Tue, 11 Aug 2020 16:13:15 +0300
Message-Id: <20200811131313.3349582-1-detegr@rbx.email>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'todo_list_write_to_file' may overwrite the static buffer, originating
from 'find_unique_abbrev', that was used to store the short commit hash
'c' for "# Rebase a..b onto c" message in the todo editor.

Fix by duplicating the string before usage, so subsequent calls to
'find_unique_abbrev' or other functions calling 'hash_to_hex_algop_r'
can't overwrite the buffer.

Found-by: Jussi Keränen <jussike@gmail.com>
Signed-off-by: Antti Keränen <detegr@rbx.email>
---
 sequencer.c                   |  7 ++++---
 t/t3404-rebase-interactive.sh | 13 +++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fd7701c88a..0679adb639 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5178,13 +5178,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    struct string_list *commands, unsigned autosquash,
 		    struct todo_list *todo_list)
 {
-	const char *shortonto, *todo_file = rebase_path_todo();
+	const char *todo_file = rebase_path_todo();
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
 	struct object_id oid = onto->object.oid;
 	int res;
-
-	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
+	char *shortonto;
 
 	if (buf->len == 0) {
 		struct todo_item *item = append_new_todo(todo_list);
@@ -5206,8 +5205,10 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error(_("nothing to do"));
 	}
 
+	shortonto = xstrdup(find_unique_abbrev(&oid, DEFAULT_ABBREV));
 	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
 			     shortonto, flags);
+	free(shortonto);
 	if (res == -1)
 		return -1;
 	else if (res == -2) {
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4a7d21f898..09af16753c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1760,6 +1760,19 @@ test_expect_success 'correct error message for commit --amend after empty pick'
 	test_i18ngrep "middle of a rebase -- cannot amend." err
 '
 
+test_expect_success 'todo has correct onto hash' '
+	write_script dump-raw.sh <<-\EOF &&
+		cat "$1"
+	EOF
+	git checkout branch1 &&
+	(
+		test_set_editor "$(pwd)/dump-raw.sh" &&
+		git rebase -i HEAD~5 >actual
+	) &&
+	onto=$(git rev-parse --short HEAD~5) &&
+	test_i18ngrep "^# Rebase ..* onto $onto .*" actual
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.28.0

