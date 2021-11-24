Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65218C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 14:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348072AbhKXO5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:57:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55204 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347867AbhKXO51 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 09:57:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C04721FD2F;
        Wed, 24 Nov 2021 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637765656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5F8TobQSxeOYZgdRcVjjbQLFoKeaaEDXRzSfbXmFXHM=;
        b=qplO6YYPpZVKi0sYV+T0KBildBv1bmyYL8otbqvSyO3SaytmuwkpWVYFH0q/SIlGz7w48I
        uhAbIA0NwDnKsNraugn86Eo3qiGFxLV/up6AKqN74m4r6jcc5N5fUVSva5a8h/IT+Z4UKK
        4Tm22h8gGMci9UxKTbkGvfRPVUzywjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637765656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5F8TobQSxeOYZgdRcVjjbQLFoKeaaEDXRzSfbXmFXHM=;
        b=etJHPwfAyLM0BzaKUzlgSuCdzNbW8aa8Dl0rEsJzwxB1bRPxrkEXxNW+ieSEjoVfKOJtRq
        UwisKoySOGo3klBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F09313F2C;
        Wed, 24 Nov 2021 14:54:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0vNrBhhSnmG1cgAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Wed, 24 Nov 2021 14:54:16 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     git@vger.kernel.org
Cc:     Enzo Matsumiya <ematsumiya@suse.de>
Subject: [PATCH v3] pager: fix crash when pager program doesn't exist
Date:   Wed, 24 Nov 2021 11:54:09 -0300
Message-Id: <20211124145409.8779-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When prepare_cmd() fails for, e.g., pager process setup,
child_process_clear() frees the memory in pager_process.args, but .argv
was pointed to pager_process.args.v earlier in start_command(), so it's
now a dangling pointer.

setup_pager() is then called a second time, from cmd_log_init_finish()
in this case, and any further operations using its .argv, e.g. strvec_*,
will use the dangling pointer and eventually crash. According to trivial
tests, setup_pager() is not called twice if the first call is
successful.

This patch makes sure that pager_process is properly initialized on
setup_pager().

Add a test to catch possible regressions.

Reproducer:
$ git config pager.show INVALID_PAGER
$ git show $VALID_COMMIT
error: cannot run INVALID_PAGER: No such file or directory
[1]    3619 segmentation fault (core dumped)  git show $VALID_COMMIT

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
Changes to v2:
 - move child_process_init() to setup_pager(), as other callers of
   child_process_clear() might've not expected .argv to change
 - add a test case with the reproducer of the original bug

Changes to v1:
 * Implement all of Jeff's suggestions:
   - remove double frees to .argv
   - discard the idea of falling back to DEFAULT_PAGER
   - replace memset() in child_process_clear() by child_process_init()
   - update/improve commit message

 pager.c          | 2 ++
 t/t7006-pager.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/pager.c b/pager.c
index 52f27a6765c8..d93304527d62 100644
--- a/pager.c
+++ b/pager.c
@@ -124,6 +124,8 @@ void setup_pager(void)
 
 	setenv("GIT_PAGER_IN_USE", "true", 1);
 
+	child_process_init(&pager_process);
+
 	/* spawn the pager */
 	prepare_pager_args(&pager_process, pager);
 	pager_process.in = -1;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435ec..0be9bcba49a8 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -786,4 +786,9 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 	test_path_is_file pager-used
 '
 
+test_expect_success TTY 'handle attempt to run an invalid pager' '
+	test_config pager.show invalid-pager &&
+	test_terminal git show
+'
+
 test_done
-- 
2.33.1

