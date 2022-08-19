Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE0C25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 07:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347299AbiHSHu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 03:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347246AbiHSHuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 03:50:55 -0400
Received: from mailproxy02.manitu.net (mailproxy02.manitu.net [217.11.48.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595EEDAA33
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 00:50:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a7b:4400:1d71:18f7:ce27:d603])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy02.manitu.net (Postfix) with ESMTPSA id BE0CDC00A9;
        Fri, 19 Aug 2022 09:50:48 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 4/4 v2] sequencer: spell out command names and do not translate them
Date:   Fri, 19 Aug 2022 09:50:48 +0200
Message-Id: <ef8b4536322eebd2bed53157f43349e9158631ae.1660894946.git.git@grubix.eu>
X-Mailer: git-send-email 2.37.2.653.g5b2587383a
In-Reply-To: <xmqqilmpnvad.fsf@gitster.g>
References: <xmqqilmpnvad.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we talk about sequencer action names as such we do translate the
action name. In all cases, we talk about the like-named git command
name, though, which is not translated.

In order to make the correspondence clearer, reword those error messages
to use the (untranslated) git command name, and adjust the po README to
match the code base.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
I guess there are two extreme views regarding these cases (in terms of
how much to translate) and a few in between. v2 here implements the
one of these. As a result, we don't need to N_()-mark the action names
any more unless I'm overlooking something. I'm holding this back until
the consensus is clear.

Overall, we are not consistent with the prefixes in our error messages
(command or not) nor the capitalisation. One could say that at the point
of an error/die worse has gone wrong than the wording, of course ;)

 po/README.md | 2 +-
 sequencer.c  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/po/README.md b/po/README.md
index 3e4f897d93..7b7ad24412 100644
--- a/po/README.md
+++ b/po/README.md
@@ -273,7 +273,7 @@ General advice:
 
   ```c
   /* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-  die(_("%s: Unable to write new index file"), action_name(opts));
+  die(_("git %s: unable to write new index file"), action_name(opts));
   ```
 
 We provide wrappers for C, Shell and Perl programs. Here's how they're
diff --git a/sequencer.c b/sequencer.c
index 79dad522f5..c26dc46268 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -539,8 +539,8 @@ static int error_dirty_index(struct repository *repo, struct replay_opts *opts)
 	if (repo_read_index_unmerged(repo))
 		return error_resolve_conflict(action_name(opts));
 
-	error(_("your local changes would be overwritten by %s."),
-		_(action_name(opts)));
+	error(_("git %s: your local changes would be overwritten"),
+		action_name(opts)));
 
 	if (advice_enabled(ADVICE_COMMIT_BEFORE_MERGE))
 		advise(_("commit your changes or stash them to proceed."));
@@ -725,8 +725,8 @@ static int do_recursive_merge(struct repository *r,
 		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
 		 * "rebase".
 		 */
-		return error(_("%s: Unable to write new index file"),
-			_(action_name(opts)));
+		return error(_("git %s: unable to write new index file"),
+			action_name(opts));
 
 	if (!clean)
 		append_conflicts_hint(r->index, msgbuf,
-- 
2.37.2.653.g5b2587383a

