From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 08/14] pull: fast-forward working tree if head is updated
Date: Mon, 18 May 2015 23:06:05 +0800
Message-ID: <1431961571-20370-9-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:08:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMe9-0004Uz-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbbERPH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:07:58 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33753 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbbERPHv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:51 -0400
Received: by pdbqa5 with SMTP id qa5so153149530pdb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HVBgThmOqA1cvbhEBsqowGJg5RGspeDZUn4oU9uTwus=;
        b=LofDIhQC/El3dbuJXr7gyf7W5VWSt1ab9AlpjeVXLcLDPzXS3c8l5XbgCfIOC3seij
         Xl1FUADkHrC+1ka9IZsMFDNy/RkdM6YO2/pZPAYEaISrrFDjYRJLYrR4ToLv84aTtpzv
         Da4SlP7bqLbdiFVN48h1wjtjCxxKAzRzC3ZtR++i4bT+sgsxLbPTeFZ6GCa+fJ+HhfJ3
         TZbTEeJ6t0slSAlwC4cSLMOK6tXr9FwMy/ZZq4/9SaQyQmoD8IfMq4sf1T5AMJc3sJj7
         aHaZbhe2Mj1kOQAOqIiQ1P3eRoepC9j4j1o/9HTXHJZfEwCQUOrJV+ANLlnMKbh+gFTI
         6hSQ==
X-Received: by 10.66.149.8 with SMTP id tw8mr45464170pab.69.1431961671591;
        Mon, 18 May 2015 08:07:51 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:50 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269265>

Since b10ac50 (Fix pulling into the same branch., 2005-08-25), git-pull,
upon detecting that git-fetch updated the current head, will
fast-forward the working tree to the updated head commit.

Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c  | 30 ++++++++++++++++++++++++++++++
 t/t5520-pull.sh |  4 ++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 9b06dfa..3b7029f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -468,6 +468,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
 	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
+	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
@@ -483,12 +484,41 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
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
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 4c52175..3645a59 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -191,7 +191,7 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_cmp expected file
 '
 
-test_expect_failure 'fast-forwards working tree if branch head is updated' '
+test_expect_success 'fast-forwards working tree if branch head is updated' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&
 	test "$(cat file)" = file &&
@@ -201,7 +201,7 @@ test_expect_failure 'fast-forwards working tree if branch head is updated' '
 	test "$(git rev-parse third)" = "$(git rev-parse second)"
 '
 
-test_expect_failure 'fast-forward fails with conflicting work tree' '
+test_expect_success 'fast-forward fails with conflicting work tree' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&
 	test "$(cat file)" = file &&
-- 
2.1.4
