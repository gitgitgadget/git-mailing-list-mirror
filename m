Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4198EC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1267B20838
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rbx.email header.i=@rbx.email header.b="RpmXiTp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMRnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:43:19 -0400
Received: from aibo.runbox.com ([91.220.196.211]:43260 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMRnT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbx.email;
         s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date;
        bh=Bwzt98+aLf3csiPuXgjdiU5eW9D9e9905oimVPlW8eo=; b=RpmXiTp48QZJZJDpz/xFjLad4j
        cyTYyHtn9IuekkUIi+RyzfveM/Ie5is+ugLc/MIwmHw5lvqV8grp8izkN1WePzLCSbWnZ1w9QIr8z
        GGQ01RXggJAtVTNtGc+zCPwwkoFlnWIKtPI4PAOgF2cWNbFkDU8eNrbTZFldwXHl/E5nfLF9DdkJC
        e/yxIGUP7bx4OWRNpoBl0hxm9QTU8zSmUiJvhTktATnFK13MUA1LuF/VynAaeYHsw8nOyhHB+nt04
        nPPWb3xh34GcpwXaBuBGJHWcM8LEFZgXmaE1MNWmJgeOULQ7iILVOLlqiDfHklXnYe5b4SU2rj5Ex
        oHIBSdhQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <detegr@rbx.email>)
        id 1k6HFz-0001zq-BW; Thu, 13 Aug 2020 19:43:15 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated alias (932193)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1k6HFi-0000Y2-G9; Thu, 13 Aug 2020 19:42:58 +0200
Date:   Thu, 13 Aug 2020 20:42:57 +0300
From:   Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] rebase -i: Fix possibly wrong onto hash in todo
Message-ID: <20200813174257.ipfnzm2q7cpc7jji@haukka.localdomain>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-Mailer: git-send-email 2.27.0.395.g84249cff14
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'todo_list_write_to_file' may overwrite the static buffer, originating
from 'find_unique_abbrev', that was used to store the short commit hash
'c' for "# Rebase a..b onto c" message in the todo editor. This is
because the buffer that is returned from 'find_unique_abbrev' is valid
until 4 more calls to `find_unique_abbrev` are made.

As 'todo_list_write_to_file' calls 'find_unique_abbrev' for each rebased
commit, the hash for 'c' is overwritten if there are 4 or more commits
in the rebase. This behavior has been broken since its introduction.

Fix by storing the short onto commit hash in a different buffer that
remains valid, before calling 'todo_list_write_to_file'.

Found-by: Jussi Keränen <jussike@gmail.com>
Signed-off-by: Antti Keränen <detegr@rbx.email>
Acked-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c                   | 5 +++--
 t/t3404-rebase-interactive.sh | 6 ++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fd7701c88a..e2007dbb8c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5178,13 +5178,14 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    struct string_list *commands, unsigned autosquash,
 		    struct todo_list *todo_list)
 {
-	const char *shortonto, *todo_file = rebase_path_todo();
+	char shortonto[GIT_MAX_HEXSZ + 1];
+	const char *todo_file = rebase_path_todo();
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
 	struct object_id oid = onto->object.oid;
 	int res;
 
-	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
+	find_unique_abbrev_r(shortonto, &oid, DEFAULT_ABBREV);
 
 	if (buf->len == 0) {
 		struct todo_item *item = append_new_todo(todo_list);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4a7d21f898..1b4fa0843e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1760,6 +1760,12 @@ test_expect_success 'correct error message for commit --amend after empty pick'
 	test_i18ngrep "middle of a rebase -- cannot amend." err
 '
 
+test_expect_success 'todo has correct onto hash' '
+	GIT_SEQUENCE_EDITOR=cat git rebase -i no-conflict-branch~4 no-conflict-branch >actual &&
+	onto=$(git rev-parse --short HEAD~4) &&
+	test_i18ngrep "^# Rebase ..* onto $onto" actual
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.27.0.395.g84249cff14

