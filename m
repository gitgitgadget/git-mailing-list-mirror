Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72244C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 14:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiI3OKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiI3OK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 10:10:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56735CAF87
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so1667854wrr.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pd2X3R7Nek7xE0g0dMmlDRUaoS7VcCCH7AxUkTamsJA=;
        b=UhPXaEq/oABozKiH5e86vaD7KMq0RZwzHxK95/cs/QYkh2j2ymMpmuv/R8uIfH2SRK
         OIHtjLCpozpYd8ZjB0WHNYFFfwY7zUuwSYY2oXF1SdShPyKCuWpjKDMxBnyIo6lWUtBP
         e96Gp8jDfLx61JyLxBTAnCwtikouNWzlByDG4VcC4UEbkAVbbf4+0uy0z/I52vZu9mG8
         gCY70rFt6JH4L9qB6XcyzHoQdHvM+Cdx5zFO0m3xfMYloZ2F6CsPk5/s06PBiIPBT6FE
         pf+ioufL+zish1eoWxrpIbmQV7VG73PwtfFSnLfAEJGExGvLbksSmETKWaQVVUxX+UTW
         aC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pd2X3R7Nek7xE0g0dMmlDRUaoS7VcCCH7AxUkTamsJA=;
        b=HO/zPO7PomlgK+0XW4UkMumLdkualx7Z9dNeFsMWe5+4eKBqfCm8kiKFAfaTKjoWr7
         aZQdoh10blSJEsZ0xt26/7upeSNCE4URwaGLzFMj3h6drW67VnJMS3eW/ZbUNaop1HGR
         qRC/MIP+NJx6GHdpAlgbDBWw8BbSvUh1k0MxkG3HmxfmL2iQGIGhApg5FjLXz35a0DzB
         R65YDgyc3MbnekYOhLyfoR2QCMw3VtFRX4DSYuCAeOQe2k/aAtHEqqfzvu3w5NDX6Xxx
         cidPiq5kEIUhaMWcA//BAZaAzzbEXv2cp9JO/GfE9rxDXOLPZyklEZl1R7GtPKg1m82N
         ssjA==
X-Gm-Message-State: ACrzQf30BNlqzrGwy4ncVenbEsrzM+dSxwolDsHKILTfJJOee/DWCUvL
        0Cdytg80M+i4vqiCgiG69sxuI3beVOU=
X-Google-Smtp-Source: AMsMyM52gtq5GOsPcl89vKx8j+9NrvqkZcoq1Vi21vMjiryholPOb5dUF6Gk61o1WmDz7ducpBHEAw==
X-Received: by 2002:a05:6000:1d8b:b0:22a:c046:946d with SMTP id bk11-20020a0560001d8b00b0022ac046946dmr5968413wrb.249.1664547023579;
        Fri, 30 Sep 2022 07:10:23 -0700 (PDT)
Received: from localhost (94-21-37-194.pool.digikabel.hu. [94.21.37.194])
        by smtp.gmail.com with ESMTPSA id q30-20020adfab1e000000b00228dff8d975sm2029006wrc.109.2022.09.30.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:10:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 6/6] sequencer: fail early if invalid ref is given to 'update-ref' instruction
Date:   Fri, 30 Sep 2022 16:09:48 +0200
Message-Id: <20220930140948.80367-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.542.g9b62912f7f
In-Reply-To: <20220930140948.80367-1-szeder.dev@gmail.com>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users can add their own 'update-ref <ref>' instructions to the rebase
todo list, which also gives them the possibility to specify an invalid
ref as argument.  Now, while git does catch any invalid ref and errors
out, it does so at the very end of the rebase process, when the
invalid ref causes the transaction updating all involved refs to fail,
leaving users on their own to figure out where each of those refs
should point now and to update them themselves.

Let's do better, and catch invalid refs early on by calling
check_refname_format() for the argument of each 'update-ref'
instruction while parsing the todo file.  This way 'git rebase' would
error out right after the user finished editing the todo file, and
would show the same generic advice to rectify the situation that is
shown e.g.  after an unknown instruction or a missing argument for a
'pick' instruction, etc.

Furthermore, require that all refs given to 'update-ref' instructions
live under the "refs/" hierarchy.  The argument of the 'update-ref'
instruction is treated as a fully qualified ref, so if the todo list
were to contain the 'update-ref foo' instruction, then 'git rebase'
would happily create the ref file '.git/foo' containing the
appropriate object id.  This is most likely not what the user wanted
and will cause confusion.  I assume it's much more probable that some
users simply forgot about the "refs/heads/" prefix than that they have
a use-case for using 'git rebase' to create/update a ref outside the
"refs/" hierarchy.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 sequencer.c                   | 19 ++++++++++++++++++-
 t/t3404-rebase-interactive.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index f1732f88f3..ababfa6352 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2522,7 +2522,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 			     command_to_string(item->command));
 
 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
-	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
+	    item->command == TODO_RESET) {
 		item->commit = NULL;
 		item->arg_offset = bol - buf;
 		item->arg_len = (int)(eol - bol);
@@ -2556,6 +2556,23 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 		}
 	}
 
+	if (item->command == TODO_UPDATE_REF) {
+		struct strbuf ref = STRBUF_INIT;
+		int ret = 0;
+
+		item->commit = NULL;
+		item->arg_offset = bol - buf;
+		item->arg_len = (int)(eol - bol);
+
+		strbuf_add(&ref, bol, item->arg_len);
+		if (!starts_with(ref.buf, "refs/") ||
+		    check_refname_format(ref.buf, 0))
+			ret = error(_("invalid ref for update-ref instruction: %s"), ref.buf);
+
+		strbuf_release(&ref);
+		return ret;
+	}
+
 	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 2e081b3914..b97f1e8b31 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1964,6 +1964,34 @@ test_expect_success 'respect user edits to update-ref steps' '
 	test_cmp_rev HEAD refs/heads/no-conflict-branch
 '
 
+test_expect_success 'update-refs with invalid refs' '
+	cat >fake-todo-4 <<-EOF &&
+	update-ref refs/heads/foo..bar
+	update-ref refs/heads/foo.lock
+	update-ref foo
+	update-ref foo/bar
+	pick $(git rev-parse HEAD)
+	EOF
+	cat >expect.err <<-EOF &&
+	error: invalid ref for update-ref instruction: refs/heads/foo..bar
+	error: invalid line 1: update-ref refs/heads/foo..bar
+	error: invalid ref for update-ref instruction: refs/heads/foo.lock
+	error: invalid line 2: update-ref refs/heads/foo.lock
+	error: invalid ref for update-ref instruction: foo
+	error: invalid line 3: update-ref foo
+	error: invalid ref for update-ref instruction: foo/bar
+	error: invalid line 4: update-ref foo/bar
+	You can fix this with ${SQ}git rebase --edit-todo${SQ} and then run ${SQ}git rebase --continue${SQ}.
+	Or you can abort the rebase with ${SQ}git rebase --abort${SQ}.
+	EOF
+	test_when_finished "test_might_fail git rebase --abort" &&
+	(
+		set_replace_editor fake-todo-4 &&
+		test_must_fail git rebase -i HEAD^ 2>err
+	) &&
+	test_cmp expect.err err
+'
+
 test_expect_success REFFILES '--update-refs: check failed ref update' '
 	git checkout -B update-refs-error no-conflict-branch &&
 	git branch -f base HEAD~4 &&
-- 
2.38.0.rc2.542.g9b62912f7f

