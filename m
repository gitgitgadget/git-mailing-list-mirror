From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 12/19] pull: fast-forward working tree if head is updated
Date: Thu, 18 Jun 2015 18:54:05 +0800
Message-ID: <1434624852-6869-13-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:56:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XUP-0002Ow-T0
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbbFRKzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:55:55 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34220 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462AbbFRKzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:18 -0400
Received: by pabvl15 with SMTP id vl15so12904513pab.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6XkSzP0EWA0vy4ZeyMz3YJj8tU/qMxEzZ4r5HJsJpXQ=;
        b=OdW5niYkFUoMB2ZIPj6p8nUgHrgyu77V75vjkTiRQlqs1PqiEz2xDgERnzCE8epX4v
         I2xL2wFkGaKAWEFQU5kVHSk3uMH/23olQS2jWifRoypsNXiF+x/7NVK0hewCRss8BVp/
         WIGOnqeXIJoP95S7W/Oq4sg0O48dDTDgUqxr4SZkMT8d4eUdlOQRJ/a1RL22w5qZKZCP
         jvFo1g+jzR6jl+lzT68dpNLTTT3Goa+cRU0FW3N11IzYDM5NsbPK4+9vybTf3Qr+MShY
         1jBp4XLcM75H9Y8I2k6lPeF8KsC5uHnlfkpuqD/KTjwfrdq++oUdpZ6SQIygc5cIDPI4
         bAKw==
X-Received: by 10.66.157.202 with SMTP id wo10mr20172986pab.44.1434624917535;
        Thu, 18 Jun 2015 03:55:17 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:16 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271952>

Since b10ac50 (Fix pulling into the same branch., 2005-08-25), git-pull,
upon detecting that git-fetch updated the current head, will
fast-forward the working tree to the updated head commit.

Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1e688be..110e719 100644
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
