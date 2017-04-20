Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EB4207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970307AbdDTUlv (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:41:51 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:56887 "EHLO
        homiemail-a39.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033593AbdDTUlr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Apr 2017 16:41:47 -0400
Received: from homiemail-a39.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a39.g.dreamhost.com (Postfix) with ESMTP id 4DF10150078;
        Thu, 20 Apr 2017 13:41:36 -0700 (PDT)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a39.g.dreamhost.com (Postfix) with ESMTPSA id E4B2F150074;
        Thu, 20 Apr 2017 13:41:35 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH] Increase core.packedGitLimit
Date:   Thu, 20 Apr 2017 16:41:18 -0400
Message-Id: <20170420204118.17856-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When core.packedGitLimit is exceeded, git will close packs.  If there
is a repack operation going on in parallel with a fetch, the fetch
might open a pack, and then be forced to close it due to
packedGitLimit being hit.  The repack could then delete the pack
out from under the fetch, causing the fetch to fail.

Increase core.packedGitLimit's default value to prevent
this.

On current 64-bit x86_64 machines, 48 bits of address space are
available.  It appears that 64-bit ARM machines have no standard
amount of address space (that is, it varies by manufacturer), and IA64
and POWER machines have the full 64 bits.  So 48 bits is the only
limit that we can reasonably care about.  We reserve a few bits of the
48-bit address space for the kernel's use (this is not strictly
necessary, but it's better to be safe), and use up to the remaining
45.  No git repository will be anywhere near this large any time soon,
so this should prevent the failure.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: David Turner <dturner@twosigma.com>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e7..1c5de153a5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -616,7 +616,7 @@ extern int git_lstat(const char *, struct stat *);
 #endif
 
 #define DEFAULT_PACKED_GIT_LIMIT \
-	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? 8192 : 256))
+	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? (32 * 1024L * 1024L) : 256))
 
 #ifdef NO_PREAD
 #define pread git_pread
-- 
2.11.GIT

