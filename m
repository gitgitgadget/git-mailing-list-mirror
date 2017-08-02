Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B691F991
	for <e@80x24.org>; Wed,  2 Aug 2017 10:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbdHBKpC (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 06:45:02 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:20384 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbdHBKov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 06:44:51 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id cr8nd8nSUiSHacr90dwio9; Wed, 02 Aug 2017 11:44:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501670691; bh=iPRN8CN5o6dShFcUfrZaJHk5v0/8umVQpehlWMMFuO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=k+DWSjtFjPWhmc6qUpxCxZCsELgTAV+gaqwxqNV+D76JJUcjb+sP1sIueZgcFz0KT
         sVIh0g/U2ZeffWIVZ/ln+vpOEZKqR55GMK9nGXMLv/bMFpZCPcKoCcytp8+ZZN3dFX
         zm7/E6PhvWiwEsZuCnjrI3xYxVw0g5HBqi4ckLWU=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=dzGYcLN_5HVkxGECzfoA:9
 a=pUZPmsw3PyTHOvnr:21 a=ukmT-8WQJrwdJHcy:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 5/6] cherry-pick/revert: remember --rerere-autoupdate
Date:   Wed,  2 Aug 2017 11:44:19 +0100
Message-Id: <20170802104420.12809-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170802104420.12809-1-phillip.wood@talktalk.net>
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHgTvAKC5DzJMwXWW/jNZWquGPQiWHTnLai/0GbLU8Wwy7vr44e8FZ+DXIwkTQDlcUYx3S6WeFvcPxd6Ofdr8BHQGBszDtH5x+JpcgE3JRJ4e5kJBYDf
 B1Fy0CB9lpdpET7RndUApAUEzVNclFWHtyuLr3+O0IH2oqGrDqbzH2pnhPoQtfGvF2gJ2Fv2OOuNQTZbahkJ3DkCBgNoTcaTSghAulfL7oRlQ5QKZWrJuba/
 q3lILs8howUQs1jUW0Jamw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When continuing after conflicts, cherry-pick forgot if the user had specified
'--rerere-autoupdate'.

Redo the cherry-pick rerere tests to check --rerere-autoupdate works
as expected.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 10 +++++++-
 t/t3504-cherry-pick-rerere.sh | 60 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7dc0670d902291b8054072d32cc0c8979c13598c..e0e66b987b27072da4aea6304a565ab708be91e4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1439,7 +1439,11 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	else if (!strcmp(key, "options.strategy-option")) {
 		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
-	} else
+	} else if (!strcmp(key, "options.allow-rerere-auto"))
+		opts->allow_rerere_auto =
+			git_config_bool_or_int(key, value, &error_flag) ?
+				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
+	else
 		return error(_("invalid key: %s"), key);
 
 	if (!error_flag)
@@ -1752,6 +1756,10 @@ static int save_opts(struct replay_opts *opts)
 							"options.strategy-option",
 							opts->xopts[i], "^$", 0);
 	}
+	if (opts->allow_rerere_auto)
+		res |= git_config_set_in_file_gently(opts_file, "options.allow-rerere-auto",
+						     opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
+						     "true" : "false");
 	return res;
 }
 
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 33f902b1b0d8eb651e0e6857f8f5b86ef633ef4a..af316cb40b7b16c95881eb8483eea4f6191c7cfa 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -7,9 +7,11 @@ test_description='cherry-pick should rerere for conflicts'
 test_expect_success setup '
 	test_commit foo &&
 	test_commit foo-master foo &&
+	test_commit bar-master bar &&
 
 	git checkout -b dev foo &&
 	test_commit foo-dev foo &&
+	test_commit bar-dev bar &&
 	git config rerere.enabled true
 '
 
@@ -19,22 +21,66 @@ test_expect_success 'conflicting merge' '
 
 test_expect_success 'fixup' '
 	echo foo-resolved >foo &&
+	echo bar-resolved >bar &&
 	git commit -am resolved &&
-	cp foo expect &&
+	cp foo foo-expect &&
+	cp bar bar-expect &&
 	git reset --hard HEAD^
 '
 
-test_expect_success 'cherry-pick conflict' '
-	test_must_fail git cherry-pick master &&
-	test_cmp expect foo
+test_expect_success 'cherry-pick conflict with --rerere-autoupdate' '
+	test_must_fail git cherry-pick --rerere-autoupdate foo..bar-master &&
+	test_cmp foo-expect foo &&
+	git diff-files --quiet &&
+	test_must_fail git cherry-pick --continue &&
+	test_cmp bar-expect bar &&
+	git diff-files --quiet &&
+	git cherry-pick --continue &&
+	git reset --hard bar-dev
 '
 
-test_expect_success 'reconfigure' '
-	git config rerere.enabled false &&
-	git reset --hard
+test_expect_success 'cherry-pick conflict repsects rerere.autoUpdate' '
+	test_config rerere.autoUpdate true &&
+	test_must_fail git cherry-pick foo..bar-master &&
+	test_cmp foo-expect foo &&
+	git diff-files --quiet &&
+	test_must_fail git cherry-pick --continue &&
+	test_cmp bar-expect bar &&
+	git diff-files --quiet &&
+	git cherry-pick --continue &&
+	git reset --hard bar-dev
+'
+
+test_expect_success 'cherry-pick conflict with --no-rerere-autoupdate' '
+	test_config rerere.autoUpdate true &&
+	test_must_fail git cherry-pick --no-rerere-autoupdate foo..bar-master &&
+	test_cmp foo-expect foo &&
+	test_must_fail git diff-files --quiet &&
+	git add foo &&
+	test_must_fail git cherry-pick --continue &&
+	test_cmp bar-expect bar &&
+	test_must_fail git diff-files --quiet &&
+	git add bar &&
+	git cherry-pick --continue &&
+	git reset --hard bar-dev
+'
+
+test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
+	test_must_fail git cherry-pick --rerere-autoupdate --rerere-autoupdate foo..bar-master &&
+	test_cmp foo-expect foo &&
+	git diff-files --quiet &&
+	git cherry-pick --abort &&
+	test_must_fail git cherry-pick --rerere-autoupdate --no-rerere-autoupdate --rerere-autoupdate foo..bar-master &&
+	test_cmp foo-expect foo &&
+	git diff-files --quiet &&
+	git cherry-pick --abort &&
+	test_must_fail git cherry-pick --rerere-autoupdate --no-rerere-autoupdate foo..bar-master &&
+	test_must_fail git diff-files --quiet &&
+	git cherry-pick --abort
 '
 
 test_expect_success 'cherry-pick conflict without rerere' '
+	test_config rerere.enabled false &&
 	test_must_fail git cherry-pick master &&
 	test_must_fail test_cmp expect foo
 '
-- 
2.13.3

