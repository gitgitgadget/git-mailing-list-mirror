Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AD2C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 11:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C936124D
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 11:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhKFLpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 07:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhKFLpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 07:45:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF76C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 04:42:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c4so17869213wrd.9
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zV98Z26GCpEN5vRTbu9eXRG5IcopeNvOcXEzfx/2oeY=;
        b=IlZ/vER01JOEQE+yztJsi7KjnJfAtNk7XDk3C3anKJpZq0toZnK8n1ZQXXWk8YX3tK
         kslkhA6xSntlBeldyzUSZq0okLJhQGUIk3JIw1wVltEsbCtyaj4jRlvPV3/HE/qfeErL
         3MNkK9RQQhyB2Ls9xJqBxuYp9WRa3qOQP90yv/HyQdeQw3sFEUOPB6QjDccqjcgNccLw
         0bdFUrzg4abnfT/bAUpIsnb4u2UCKVI5F352y3hyVBBKP978p4zibOYAKXl/Rcu06yLJ
         6eeH6sz5dxx5ofyrwkG0S0hubi7wgEUq5iKlTSOtAgd081ulbQcPXRaVpcuE/uREOEev
         Jo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zV98Z26GCpEN5vRTbu9eXRG5IcopeNvOcXEzfx/2oeY=;
        b=w32IsIlBNRXwvYzArE80a9EMHD8EpvDw6jl97aIUTqvEhWszeE1eR/hkTub2Bn7P1D
         mgeYrq+ooVIC2s8TEC30FzZRy6C1vJoIot+toElzIgHeJS+1IlCrWudh/gCaljrDsc9v
         V/b8i2DmJTaSK+In3n08bFMqyd2LULu7U3Qj3wCFM3bX5WKm5us/52K7BMsUiwYSK6Bk
         HEcmJRL6v6gGgV7v43GIbUgRhom2wQ6Rq4fpDw3+FlMyh0CKLgO8xDnX9WDkIfnEiaMI
         8xfdPFORdU1MUBBYw3k4+uWVUfqHldv+KmoGujWoxFYP9Q+XOznMX77Qg9nLrnowTCJG
         un0w==
X-Gm-Message-State: AOAM532GA8uROVldu/axcRuNfLmgqL5TQBL0jELtwnYVkV5BN+aY65Qc
        w2KHb3fT2ZqwM8ZJTGBOjtI=
X-Google-Smtp-Source: ABdhPJxpDZwgfyaaKi11cH71kkFVx7xs6L4bcEB6JJj50yLLzbMp0muKjRVR6BJYZ6AG/Riilfeu9g==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr44679193wrz.76.1636198952981;
        Sat, 06 Nov 2021 04:42:32 -0700 (PDT)
Received: from lesale.home (62-47-8-237.adsl.highway.telekom.at. [62.47.8.237])
        by smtp.gmail.com with ESMTPSA id h17sm13318691wmb.44.2021.11.06.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 04:42:32 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rhodges@cisco.com, git@vger.kernel.org, rphodges@gmail.com,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH v3] apply: --intent-to-add should imply --index
Date:   Sat,  6 Nov 2021 12:42:02 +0100
Message-Id: <20211106114202.3486969-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211106112439.iw7asj4bq6uwcb3l@gmail.com>
References: <20211106112439.iw7asj4bq6uwcb3l@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise we do not read the current index, and more importantly, we
do not check with the current index, losing all the safety.

And the worst part of the story is that we still write the result
out to the index, which loses all the files that are not mentioned
in the incoming patch.

Make --intent-to-add imply --index. This means that apply
--intent-to-add will error without a repo, and refuse to modify
untracked files (except for added files). Add a test for the latter, and
another one to make sure that combinations like "--cached -N" keep working.
as documented (-N is ignored, otherwise it would do weird things to the index).

Use --intent-to-add instead of -N because we don't document -N in
git-apply.txt, which might be because it's much more obscure than "add -N".

Reported-by: Ryan Hodges <rhodges@cisco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---

Not sure about the log message, it feels a bit stitched together.

Most importantly this adds a test to show the difference between v2 (where
ita did not imply check_index).

I wrapped the doc changes to 80 columns, but not the entire paragraph,
since we are inconsistent about that.

 Documentation/git-apply.txt |  7 +++----
 apply.c                     |  9 +++++++--
 t/t2203-add-intent.sh       |  2 +-
 t/t4140-apply-ita.sh        | 29 +++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index aa1ae56a25..18ddb4cf8a 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -77,10 +77,9 @@ OPTIONS
 --intent-to-add::
 	When applying the patch only to the working tree, mark new
 	files to be added to the index later (see `--intent-to-add`
-	option in linkgit:git-add[1]). This option is ignored unless
-	running in a Git repository and `--index` is not specified.
-	Note that `--index` could be implied by other options such
-	as `--cached` or `--3way`.
+	option in linkgit:git-add[1]). This option has is ignored if `--index`
+	is specified.  Note that `--index` could be implied by other options
+	such as `--cached` or `--3way`.
 
 -3::
 --3way::
diff --git a/apply.c b/apply.c
index 43a0aebf4e..b0239b7482 100644
--- a/apply.c
+++ b/apply.c
@@ -153,8 +153,13 @@ int check_apply_state(struct apply_state *state, int force_apply)
 			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
-	if (state->ita_only && (state->check_index || is_not_gitdir))
+	if (state->ita_only && state->check_index)
 		state->ita_only = 0;
+	if (state->ita_only) {
+		if (is_not_gitdir)
+			return error(_("--intent-to-add outside a repository"));
+		state->check_index = 1;
+	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
 
@@ -4760,7 +4765,7 @@ static int apply_patch(struct apply_state *state,
 	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
 
-	state->update_index = (state->check_index || state->ita_only) && state->apply;
+	state->update_index = state->check_index && state->apply;
 	if (state->update_index && !is_lock_file_locked(&state->lock_file)) {
 		if (state->index_file)
 			hold_lock_file_for_update(&state->lock_file,
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index cf0175ad6e..035ce3a2b9 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -307,7 +307,7 @@ test_expect_success 'apply --intent-to-add' '
 	grep "new file" expected &&
 	git reset --hard &&
 	git apply --intent-to-add expected &&
-	git diff >actual &&
+	(git diff && git diff --cached) >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
index c614eaf04c..4db1ae4e7e 100755
--- a/t/t4140-apply-ita.sh
+++ b/t/t4140-apply-ita.sh
@@ -53,4 +53,33 @@ test_expect_success 'apply deletion patch to ita path (--index)' '
 	git ls-files --stage --error-unmatch test-file
 '
 
+test_expect_success 'apply --intent-to-add is not allowed to modify untracked file' '
+	echo version1 >file &&
+	! git apply --intent-to-add <<-EOF
+	diff --git a/file b/file
+	index 1234567..89abcde 100644
+	--- b/file
+	+++ b/file
+	@@ -1 +1 @@
+	-version1
+	+version2
+	EOF
+'
+
+test_expect_success 'apply --index --intent-to-add ignores --intent-to-add, so it does not set i-t-a bit of touched file' '
+	echo >file &&
+	git add file &&
+	git apply --index --intent-to-add <<-EOF &&
+	diff --git a/file b/file
+	deleted file mode 100644
+	index 1234567..89abcde 100644
+	--- a/file
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-
+	EOF
+	git ls-files file >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
2.33.1

