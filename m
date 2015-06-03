From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 12/19] pull: fast-forward working tree if head is updated
Date: Wed,  3 Jun 2015 14:48:56 +0800
Message-ID: <1433314143-4478-13-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02VU-0004oQ-1T
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbbFCGu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:27 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36501 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbbFCGuV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:21 -0400
Received: by pabqy3 with SMTP id qy3so666268pab.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Bk50vLhXIKTx4HLsim8l+AruMUF9/EN1wUnBEdzT6Y=;
        b=EXvWGfB+y5u85V2Vc+Sb+SjWhTfMQYPr+FMJVIw7uhQUkS9uTia0eGhGHZ54U0Ea5A
         FTxL/cHI1Jx6oa+5MSwR4QjLRcFH77orL4f8gkTlYOZjO2EGFdGv5WzXALgI0W7hzC87
         0mSmxIQDHcCa0k4IDoSHh4rdz9xhvkQ1/HOrQnH5lfLply+Fw7FieQy4aXRSigx/RXFh
         fQOd1dnHRa894olAmbdC5MARJRjqUpdMc32ZPUAeIHFBFNnKT8AdTUS2cEzts4Ojfuad
         xJX776BCmLJppZSsHS4nPddfEJbLXNb+T5GphMCpd08zNI4e2gyyqGPLEQiwF2v6W60j
         AuWg==
X-Received: by 10.66.169.39 with SMTP id ab7mr17114162pac.109.1433314220638;
        Tue, 02 Jun 2015 23:50:20 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:19 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270648>

Since b10ac50 (Fix pulling into the same branch., 2005-08-25), git-pull,
upon detecting that git-fetch updated the current head, will
fast-forward the working tree to the updated head commit.

Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 703fc1d..8db0db2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -411,6 +411,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
 	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
+	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
 
 	if (!getenv("_GIT_USE_BUILTIN_PULL")) {
 		const char *path = mkpath("%s/git-pull", git_exec_path());
@@ -434,12 +435,41 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_ff.len)
 		config_get_ff(&opt_ff);
 
+	if (get_sha1("HEAD", orig_head))
+		hashclr(orig_head);
+
 	if (run_fetch(repo, refspecs))
 		return 1;
 
 	if (opt_dry_run)
 		return 0;
 
+	if (get_sha1("HEAD", curr_head))
+		hashclr(curr_head);
+
+	if (!is_null_sha1(orig_head) && !is_null_sha1(curr_head) &&
+			hashcmp(orig_head, curr_head)) {
+		/*
+		 * The fetch involved updating the current branch.
+		 *
+		 * The working tree and the index file are still based on
+		 * orig_head commit, but we are merging into curr_head.
+		 * Update the working tree to match curr_head.
+		 */
+
+		warning(_("fetch updated the current branch head.\n"
+			"fast-forwarding your working tree from\n"
+			"commit %s."), sha1_to_hex(orig_head));
+
+		if (checkout_fast_forward(orig_head, curr_head, 0))
+			die(_("Cannot fast-forward your working tree.\n"
+				"After making sure that you saved anything precious from\n"
+				"$ git diff %s\n"
+				"output, run\n"
+				"$ git reset --hard\n"
+				"to recover."), sha1_to_hex(orig_head));
+	}
+
 	get_merge_heads(&merge_heads);
 
 	if (!merge_heads.nr)
-- 
2.1.4
