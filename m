Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D0C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhKSXvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:51:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39488 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbhKSXvH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:51:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CC65212BC;
        Fri, 19 Nov 2021 23:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637365684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ItUtFXUEjklrioRrCM+lpHjpG0WiNwXMXlL+x1x4sqY=;
        b=m/NrQnHYAAJDhNAlvfx6n/52ul7XE2QeyU64ZO8io+zbNk9Veb8b1/9n/CmNGnsCHp2JUq
        /TAAKWHBxlB62VcstHMjbuABe5QZXK1dqXCIyan3ebvrX01mxduaiQG+CK2tui0Db07kp1
        mIojn/ICsWdosqlhP6tfIyav5DOV80w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637365684;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ItUtFXUEjklrioRrCM+lpHjpG0WiNwXMXlL+x1x4sqY=;
        b=wBMW6/MvPNmp+ACZKP3n2vW6Git5g+3mFL5IuL2jtjuCVxLVGL8lfZDGWSxaivNfysiihe
        825TMV9e/Q++zJDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04D8013B73;
        Fri, 19 Nov 2021 23:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1uJML7M3mGHXSAAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Fri, 19 Nov 2021 23:48:03 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     git@vger.kernel.org
Cc:     Enzo Matsumiya <ematsumiya@suse.de>
Subject: [PATCH] pager: fix crash when pager program doesn't exist
Date:   Fri, 19 Nov 2021 20:47:45 -0300
Message-Id: <20211119234745.26605-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

setup_pager() doesn't properly free pager_process.argv if
start_command() fails, nor finish_command() is ever called.

setup_pager() is called twice, once from commit_pager_choice(), and then
from cmd_log_init_finish(). On the first run, it runs fine because
start_command() assigns cmd->args.v to cmd->argv, and upon command
failure, child_process_clear() clears cmd->args.

On the second run, though, argv is no longer NULL, but .args has been
cleared, so any strvec_push() operation will crash.

This patch makes sure that freeing pager_process.argv is part of its
argument preparation, as well as zeroing the whole pager_process struct.

Reproduction:
$ git config pager.show INVALID_PAGER
$ git show $VALID_COMMIT
error: cannot run INVALID_PAGER: No such file or directory
[1]    3619 segmentation fault (core dumped)  git show $VALID_COMMIT

While at it, I implemented a fallback to the DEFAULT_PAGER, so it tries
at least one more time when the configured pager fails.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 pager.c       | 25 +++++++++++++++++++++----
 run-command.c |  1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/pager.c b/pager.c
index 52f27a6765c8..79a47db55d63 100644
--- a/pager.c
+++ b/pager.c
@@ -97,6 +97,9 @@ static void setup_pager_env(struct strvec *env)
 
 void prepare_pager_args(struct child_process *pager_process, const char *pager)
 {
+	child_process_clear(pager_process);
+	if (pager_process->argv)
+		free(pager_process->argv);
 	strvec_push(&pager_process->args, pager);
 	pager_process->use_shell = 1;
 	setup_pager_env(&pager_process->env_array);
@@ -105,11 +108,14 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
-	const char *pager = git_pager(isatty(1));
+	const char *tmp_pager = git_pager(isatty(1));
+	char *pager;
 
-	if (!pager)
+	if (!tmp_pager)
 		return;
 
+	pager = xstrdup(tmp_pager);
+
 	/*
 	 * After we redirect standard output, we won't be able to use an ioctl
 	 * to get the terminal size. Let's grab it now, and then set $COLUMNS
@@ -124,12 +130,23 @@ void setup_pager(void)
 
 	setenv("GIT_PAGER_IN_USE", "true", 1);
 
+retry:
 	/* spawn the pager */
 	prepare_pager_args(&pager_process, pager);
 	pager_process.in = -1;
 	strvec_push(&pager_process.env_array, "GIT_PAGER_IN_USE");
-	if (start_command(&pager_process))
-		return;
+	if (start_command(&pager_process)) {
+		/* chosen pager failed, try again with the default pager */
+		if (strcmp(pager, DEFAULT_PAGER)) {
+			free(pager);
+			pager = xstrdup(DEFAULT_PAGER);
+			goto retry;
+		} else {
+			/* default pager failed, let caller handle it */
+			free(pager);
+			return;
+		}
+	}
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
diff --git a/run-command.c b/run-command.c
index f329391154ae..d2b7647afdd8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -19,6 +19,7 @@ void child_process_clear(struct child_process *child)
 {
 	strvec_clear(&child->args);
 	strvec_clear(&child->env_array);
+	memset(child, 0, sizeof(*child));
 }
 
 struct child_to_clean {
-- 
2.33.1

