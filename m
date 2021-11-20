Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF57C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 19:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhKTToG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 14:44:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38214 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhKTToG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 14:44:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D659A1FD42;
        Sat, 20 Nov 2021 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637437261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u/jB39doVKiNPagV8ks8l9ECPLNqp69wc5pSFbsNUv8=;
        b=0GaOAMfseFbGpPIAUB2LJdmIYImEXhq0YTjKhwCHX3LAgjT9OhQCgJRzasWg/l/8R01Uvx
        NgpGVKbHbqIocNaQnv6Wxe57nIq6Zsjb4PBdrr+QGEndZyJjLWd7hMopvk0peMk9dDdVvi
        ja9hzrEnDXBPdOpD/9XpvhdYq3f9lMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637437261;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u/jB39doVKiNPagV8ks8l9ECPLNqp69wc5pSFbsNUv8=;
        b=c1XwAwnJBbGOak8JZX761ewhf8gWkqi5VWnbus/lY1sIDmHn7/eyuhhL9kVakkRqjkLnfw
        /tQftlqLlwztgLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55BF613B16;
        Sat, 20 Nov 2021 19:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HvqEBk1PmWFYfQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Sat, 20 Nov 2021 19:41:01 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     git@vger.kernel.org
Cc:     Enzo Matsumiya <ematsumiya@suse.de>, Jeff King <peff@peff.net>
Subject: [PATCH v2] pager: fix crash when pager program doesn't exist
Date:   Sat, 20 Nov 2021 16:40:48 -0300
Message-Id: <20211120194048.12125-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When prepare_cmd() fails for, e.g., pager process setup,
child_process_clear() frees the memory in pager_process.args, but .argv
still points to the previously location.

When setup_pager() is called a second time, from cmd_log_init_finish()
in this case, its strvec operations (i.e. using pager_process.argv) will
lead to a use-after-free.

This patch makes sure that further uses of the child_process cleared by
child_process_clear() gets a properly initialized struct.

Reproducer:
$ git config pager.show INVALID_PAGER
$ git show $VALID_COMMIT
error: cannot run INVALID_PAGER: No such file or directory
[1]    3619 segmentation fault (core dumped)  git show $VALID_COMMIT

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
Reviewed-by: Jeff King <peff@peff.net>
---
Changes to v1:
 * Implement all of Jeff's suggestions:
   - remove double frees to .argv
   - discard the idea of falling back to DEFAULT_PAGER
   - replace memset() in child_process_clear() by child_process_init()
   - update/improve commit message

 run-command.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/run-command.c b/run-command.c
index f329391154ae..a7bf81025afb 100644
--- a/run-command.c
+++ b/run-command.c
@@ -19,6 +19,7 @@ void child_process_clear(struct child_process *child)
 {
 	strvec_clear(&child->args);
 	strvec_clear(&child->env_array);
+	child_process_init(child);
 }
 
 struct child_to_clean {
-- 
2.33.1

