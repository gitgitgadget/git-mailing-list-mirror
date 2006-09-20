From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] add receive.denyNonFastforwards config variable
Date: Thu, 21 Sep 2006 00:28:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 21 00:28:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQAYd-0002qN-Bk
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 00:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWITW2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 18:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWITW2i
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 18:28:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:5571 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932415AbWITW2h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 18:28:37 -0400
Received: (qmail invoked by alias); 20 Sep 2006 22:28:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 21 Sep 2006 00:28:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27418>


If receive.denyNonFastforwards is set to true, git-receive-pack will deny
non fast-forwards, i.e. forced updates. Most notably, a push to a repository
which has that flag set to true will fail.

As a first user, 'git-init-db --shared' sets this flag, since in a shared
setup, you are most unlikely to want forced pushes to succeed.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-init-db.c |    1 +
 cache.h           |    1 +
 environment.c     |    1 +
 receive-pack.c    |   12 ++++++++++++
 setup.c           |    2 ++
 5 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 36c3088..e6a2d7d 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -310,6 +310,7 @@ int cmd_init_db(int argc, const char **a
 		 */
 		sprintf(buf, "%d", shared_repository);
 		git_config_set("core.sharedrepository", buf);
+		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
 	return 0;
diff --git a/cache.h b/cache.h
index f2fdc00..2224c83 100644
--- a/cache.h
+++ b/cache.h
@@ -188,6 +188,7 @@ extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
+extern int deny_non_fast_forwards;
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
 
diff --git a/environment.c b/environment.c
index 84d870c..63b1d15 100644
--- a/environment.c
+++ b/environment.c
@@ -20,6 +20,7 @@ int warn_ambiguous_refs = 1;
 int repository_format_version;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 int shared_repository = PERM_UMASK;
+int deny_non_fast_forwards = 0;
 const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
diff --git a/receive-pack.c b/receive-pack.c
index 78f75da..c5ea2a1 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -2,6 +2,8 @@ #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "run-command.h"
+#include "commit.h"
+#include "object.h"
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
@@ -127,6 +129,16 @@ static int update(struct command *cmd)
 		return error("unpack should have generated %s, "
 			     "but I can't find it!", new_hex);
 	}
+	if (deny_non_fast_forwards) {
+		struct commit *old_commit, *new_commit;
+		old_commit = (struct commit *)parse_object(old_sha1);
+		new_commit = (struct commit *)parse_object(new_sha1);
+		struct commit_list *bases = get_merge_bases(old_commit,
+				new_commit, 1);
+		if (!bases || hashcmp(old_sha1, bases->item->object.sha1))
+			return error("denying non-fast forward;"
+					" you should pull first");
+	}
 	safe_create_leading_directories(lock_name);
 
 	newfd = open(lock_name, O_CREAT | O_EXCL | O_WRONLY, 0666);
diff --git a/setup.c b/setup.c
index 2afdba4..9a46a58 100644
--- a/setup.c
+++ b/setup.c
@@ -244,6 +244,8 @@ int check_repository_format_version(cons
                repository_format_version = git_config_int(var, value);
 	else if (strcmp(var, "core.sharedrepository") == 0)
 		shared_repository = git_config_perm(var, value);
+	else if (strcmp(var, "receive.denynonfastforwards") == 0)
+		deny_non_fast_forwards = git_config_bool(var, value);
        return 0;
 }
 
-- 
1.4.2.1.g7521-dirty
