Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84CDEB64DA
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 14:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjGSOo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 10:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGSOo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 10:44:26 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3661731
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 07:44:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55fcc15e109so3354329a12.3
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689777831; x=1690382631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrD0Ek8VhOZnaTX1VS24yFluFuBTtMALKdkiGlotIZQ=;
        b=BdwfeWiTE46aOuL7QuA3SeDJ13yPu28SkVXJAt4/hFRLzAFSXfdQ+x+8V+x3FQoYll
         NsDOeuE/bZETDBk5dCKyUr87yx4CXalUDMLVr64+BmCEtths2rjak2WqhSP5X5o2GjBU
         xh8ghdILEUBSGdXF5fFzRhwZFzCLGjGLTS+S8y7EMrmWYuA08XhMyfhpLnvTb4OZof0i
         cgrqrqFszWQkzPpXFOGLY5NN2Q49b6vzseL/wDw+FSm+88v3J3s02xMRXC0mfZlETOJJ
         OZs766i3tQNdT/pfUyyukSv1RVAeceaTjxlEZ/5xt8Pi/jqVZX0Ywqe3u2INo0WRM3q8
         f+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689777831; x=1690382631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrD0Ek8VhOZnaTX1VS24yFluFuBTtMALKdkiGlotIZQ=;
        b=HgX81AU0tb+rj5wDGj0bUWMgY2RPAX8fhMyecQCwceTG/E55U31TdyyIPOI4HG788D
         d7jYBihFrHyi5nGayyQ1sRwdykoK7x/bGwmcUGV/LVd4866ZXY5kD5WLLn4d5uIdVofj
         wQHexRWx2Iy2A8TIvbn+GBsAcQDRydFZ69aukmogbwDOgSjotVhaOJrcYdmLo4/cfG54
         GHNodlgk/H/SbVpg8IT+cWIoy9s2A4vVdOFErQZ/5UbGYX7ESarjVdV1ORkUOcb5XHPx
         MMUPPYHHjR4zklOvNelh7S69Q1E7IztNDr+wg+d+nwyL79m3pxOYtO5O5VQtSYNtleUm
         uwyQ==
X-Gm-Message-State: ABy/qLbeaZZTfG7glaumDSyqtOX+kZrD9VtByoiPgdzuaUZJBZDZlTcA
        S9/coyRd+epocZPQSWZKriJtNNCffHM=
X-Google-Smtp-Source: APBJJlF66m/U6yydlF0/Kx4kfYJivKrWF6eSdcZaD160RLgNJMkxTnBlEbme7Ro5f0p3kO8+HFJ2rw==
X-Received: by 2002:a17:903:110d:b0:1b0:3637:384e with SMTP id n13-20020a170903110d00b001b03637384emr2803630plh.25.1689777830675;
        Wed, 19 Jul 2023 07:43:50 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902740100b001b9cb27e07dsm4073191pll.45.2023.07.19.07.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:43:49 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] sequencer: finish parsing the todo list despite an invalid first line
Date:   Wed, 19 Jul 2023 08:43:15 -0600
Message-ID: <20230719144339.447852-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ddb81e5072 (rebase-interactive: use todo_list_write_to_file() in
edit_todo_list(), 2019-03-05) made edit_todo_list more efficient by
replacing transform_todo_file with todo_list_parse_insn_buffer.
Unfortunately, that innocuous change caused a regression because
todo_list_parse_insn_buffer would stop parsing after encountering an
invalid 'fixup' line. If the user accidentally made the first line a
'fixup' and tried to recover from their mistake with `git rebase
--edit-todo`, all of the commands after the first would be lost.

To avoid throwing away important parts of the todo list, change
todo_list_parse_insn_buffer to keep going and not return early on error.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 sequencer.c                   |  2 +-
 t/t3404-rebase-interactive.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index cc9821ece2..adc9cfb4df 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2702,7 +2702,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 		if (fixup_okay)
 			; /* do nothing */
 		else if (is_fixup(item->command))
-			return error(_("cannot '%s' without a previous commit"),
+			res = error(_("cannot '%s' without a previous commit"),
 				command_to_string(item->command));
 		else if (!is_noop(item->command))
 			fixup_okay = 1;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff0afad63e..d2801ffee4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1596,6 +1596,25 @@ test_expect_success 'static check of bad command' '
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'the first command cannot be a fixup' '
+	# When using `git rebase --edit-todo` to recover from this error, ensure
+	# that none of the original todo list is lost
+	rebase_setup_and_clean fixup-first &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="fixup 1 2 3 4 5" \
+			       git rebase -i --root 2>actual &&
+		test_i18ngrep "cannot .fixup. without a previous commit" \
+				actual &&
+		test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
+				actual &&
+		grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&
+		test_must_fail git rebase --edit-todo &&
+		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
+		test_cmp orig actual
+	)
+'
+
 test_expect_success 'tabs and spaces are accepted in the todolist' '
 	rebase_setup_and_clean indented-comment &&
 	write_script add-indent.sh <<-\EOF &&
-- 
2.41.0

