From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 11/15] init-db: die on config errors when initializing empty repo
Date: Mon, 22 Feb 2016 12:23:32 +0100
Message-ID: <1456140216-24169-12-git-send-email-ps@pks.im>
References: <1456140216-24169-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:24:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXobn-0000f0-Hm
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbcBVLYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:24:51 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43236 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754673AbcBVLYt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 06:24:49 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 6FCEF20C49
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 06:24:48 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 22 Feb 2016 06:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Klv4
	dvnDiReNkTGfiUb5iprBaic=; b=aMCoH9Fk7v9XgUvak0cB69QtSmSIIlXiuHTA
	Fh4IYW74eOs1W5WTHrs5pZKhCJ0yOIxl404opX/lGTLP74EdZA8MNvItMjDnFDOT
	eogbI3Nf0oN32tZ3yyzVkUUfoSaCgWuX+7E+fEfmNQZyXJaq2tSshqwvwxJpZw+d
	r9P3TWI=
X-Sasl-enc: Lh2Sad++Vzds4fKwLt+ZGESEwB8zHelcoj8qIN0tI0Kd 1456140288
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0910CC00016;
	Mon, 22 Feb 2016 06:24:47 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456140216-24169-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286912>

When creating an empty repository with `git init-db` we do not
check for error codes returned by `git_config_set` functions.
This may cause the user to end up with an inconsistent repository
without any indication for the user.

Fix this problem by dying early with an error message when we are
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
2.7.1
