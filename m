Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E055FC433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 00:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbhKYAF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 19:05:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52534 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbhKYAF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 19:05:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55D261FD37;
        Thu, 25 Nov 2021 00:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637798567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=s47VqQOiJfnS3LfCsehu8zhOHI3KPCuy2UYfyKQsqM4=;
        b=ky7dldUOaAgTpKsGt5gYWfniRzn7L2TRN16B1XkwblxHLtgv7hMP8tgN6UXnG4FQGcjKdq
        cuRdEVRzjtzHUqrUcKiPfEIzmyttlJQiE5lqiyxBaIsdzagYUvR8edvvigRLb1ydV/2+Da
        P4dBnQ6JVNQJ13jLdPyfogVJaRaBl7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637798567;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=s47VqQOiJfnS3LfCsehu8zhOHI3KPCuy2UYfyKQsqM4=;
        b=joTw0I3uMRnPdsOEoJNHhjhiYMcDBZVUzQeMEAjY/7Y7+uM+ZrD/ei5U2glRCRSmDG0mAw
        Xcypoe2JhyuJ2bDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2F4513E0D;
        Thu, 25 Nov 2021 00:02:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HH5gIKbSnmHgaQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Thu, 25 Nov 2021 00:02:46 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     git@vger.kernel.org
Cc:     Enzo Matsumiya <ematsumiya@suse.de>
Subject: [PATCH v4] pager: fix crash when pager program doesn't exist
Date:   Wed, 24 Nov 2021 21:02:39 -0300
Message-Id: <20211125000239.2336-1-ematsumiya@suse.de>
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
setup_pager(). Drop CHILD_PROCESS_INIT from its declaration since it's
no longer really necessary.

Add a test to catch possible regressions.

Reproducer:
$ git config pager.show INVALID_PAGER
$ git show $VALID_COMMIT
error: cannot run INVALID_PAGER: No such file or directory
[1]    3619 segmentation fault (core dumped)  git show $VALID_COMMIT

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
Changes to v3:
 - change test description, as per Eric's suggestion
 - drop CHILD_PROCESS_INIT, as per Jeff's suggestion

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

 pager.c          | 4 +++-
 t/t7006-pager.sh | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/pager.c b/pager.c
index 52f27a6765c8..27877f8ebbc1 100644
--- a/pager.c
+++ b/pager.c
@@ -8,7 +8,7 @@
 #define DEFAULT_PAGER "less"
 #endif
 
-static struct child_process pager_process = CHILD_PROCESS_INIT;
+static struct child_process pager_process;
 static const char *pager_program;
 
 /* Is the value coming back from term_columns() just a guess? */
@@ -124,6 +124,8 @@ void setup_pager(void)
 
 	setenv("GIT_PAGER_IN_USE", "true", 1);
 
+	child_process_init(&pager_process);
+
 	/* spawn the pager */
 	prepare_pager_args(&pager_process, pager);
 	pager_process.in = -1;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435ec..eed680a2b1ee 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -786,4 +786,9 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 	test_path_is_file pager-used
 '
 
+test_expect_success TTY 'non-existent pager doesnt cause crash' '
+	test_config pager.show invalid-pager &&
+	test_terminal git show
+'
+
 test_done
-- 
2.33.1

