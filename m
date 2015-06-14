From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 12/19] pull: fast-forward working tree if head is updated
Date: Sun, 14 Jun 2015 16:41:59 +0800
Message-ID: <1434271326-11349-13-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:43:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43Vx-0006ZY-KZ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbbFNInf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:35 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33225 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbbFNInE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:43:04 -0400
Received: by padev16 with SMTP id ev16so46750340pad.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Ko7vrNWRe9mlFEnwULGPy+qdXGPKtT3ZGtC3p84kN4=;
        b=d8MpWgVRScDLMXYKhk/T0p0s7LMehYnciPMvc0Lt8lDYeNI6BFlHnKRK42845jhnzh
         g475+MklPkOnsdETJy9OYmocBFkgAJid8cyiz6R1Ddx+GHkxfQE2VHefQ0bQr5xhdera
         rBv7axtE04ZRY6xT4CGcYV8IYtzof+ifAiz9EvUsMv51n3aVaUpqzcJ2nl/GLe7XO2ip
         KYD8GqmVux0+QEwAvMhNpUbP42ZZF8Rt1ckFXfcEDI3sgazWF3uqTQbPoDeAh4QWB3Sk
         +GbtfiLD2D6CM4gdwqwKw+3GwwbuM4PhlnOVIMPSvhBXr42dzWqUQz7uOoJB9312BMaJ
         sUvA==
X-Received: by 10.70.62.6 with SMTP id u6mr37338714pdr.142.1434271383523;
        Sun, 14 Jun 2015 01:43:03 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.42.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:43:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271627>

Since b10ac50 (Fix pulling into the same branch., 2005-08-25), git-pull,
upon detecting that git-fetch updated the current head, will
fast-forward the working tree to the updated head commit.

Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index cb5898a..0e48a14 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -412,6 +412,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
 	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
+	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
 
 	if (!getenv("_GIT_USE_BUILTIN_PULL")) {
 		const char *path = mkpath("%s/git-pull", git_exec_path());
@@ -435,12 +436,41 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (file_exists(git_path("MERGE_HEAD")))
 		die_conclude_merge();
 
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
