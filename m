From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 6/9] init-db: handle config errors
Date: Thu, 28 Jan 2016 10:00:34 +0100
Message-ID: <1453971637-22273-7-git-send-email-ps@pks.im>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 10:01:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiRp-0006xG-1B
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbcA1JAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 04:00:52 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45945 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933010AbcA1JAt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 04:00:49 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id A800F21F14
	for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:00:48 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 28 Jan 2016 04:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=mme5
	h+BvnhXY08pC7Z4bgHtI8dc=; b=BxA0TB7vrWNgxvF4EdYdUmat/UixqcK1m7Jd
	q37pUzijWf5sSpn3u7EmEWrOCkO1SEZQR/tUUEt0zvUmNQXGyFS/CnmWuaQIDZNH
	Xnt+h/YIYKKEz1EGwVxFCzVqMsdBO2UUK4Qv6Aub6qFT+m6P1u46dkK+DKfZ4h51
	9fRfhhE=
X-Sasl-enc: +AGWVw9HhtsBl874Mf1bp7EMnp3Zwev/BlYFqFBQ1jzW 1453971648
Received: from localhost (f052174253.adsl.alicedsl.de [78.52.174.253])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0F92B6800D1;
	Thu, 28 Jan 2016 04:00:47 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1453971637-22273-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284996>

When creating default files we do not check for error codes
returned by `git_config_set` functions. This may cause the user
to end up with an inconsistent repository without any indication
for the user.

Fix this problem by dying with an error message when we are
unable to write the configuration files to disk.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 07229d6..ef19048 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -227,7 +227,7 @@ static int create_default_files(const char *template_path)
 	/* This forces creation of new config file */
 	xsnprintf(repo_version_string, sizeof(repo_version_string),
 		  "%d", GIT_REPO_VERSION);
-	git_config_set("core.repositoryformatversion", repo_version_string);
+	git_config_set_or_die("core.repositoryformatversion", repo_version_string);
 
 	/* Check filemode trustability */
 	path = git_path_buf(&buf, "config");
@@ -241,18 +241,18 @@ static int create_default_files(const char *template_path)
 		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
 			filemode = 0;
 	}
-	git_config_set("core.filemode", filemode ? "true" : "false");
+	git_config_set_or_die("core.filemode", filemode ? "true" : "false");
 
 	if (is_bare_repository())
-		git_config_set("core.bare", "true");
+		git_config_set_or_die("core.bare", "true");
 	else {
 		const char *work_tree = get_git_work_tree();
-		git_config_set("core.bare", "false");
+		git_config_set_or_die("core.bare", "false");
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
-		    git_config_set("core.logallrefupdates", "true");
+			git_config_set_or_die("core.logallrefupdates", "true");
 		if (needs_work_tree_config(get_git_dir(), work_tree))
-			git_config_set("core.worktree", work_tree);
+			git_config_set_or_die("core.worktree", work_tree);
 	}
 
 	if (!reinit) {
@@ -265,12 +265,12 @@ static int create_default_files(const char *template_path)
 		    S_ISLNK(st1.st_mode))
 			unlink(path); /* good */
 		else
-			git_config_set("core.symlinks", "false");
+			git_config_set_or_die("core.symlinks", "false");
 
 		/* Check if the filesystem is case-insensitive */
 		path = git_path_buf(&buf, "CoNfIg");
 		if (!access(path, F_OK))
-			git_config_set("core.ignorecase", "true");
+			git_config_set_or_die("core.ignorecase", "true");
 		probe_utf8_pathname_composition();
 	}
 
@@ -386,8 +386,8 @@ int init_db(const char *template_dir, unsigned int flags)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
 		else
 			die("BUG: invalid value for shared_repository");
-		git_config_set("core.sharedrepository", buf);
-		git_config_set("receive.denyNonFastforwards", "true");
+		git_config_set_or_die("core.sharedrepository", buf);
+		git_config_set_or_die("receive.denyNonFastforwards", "true");
 	}
 
 	if (!(flags & INIT_DB_QUIET)) {
-- 
2.7.0
