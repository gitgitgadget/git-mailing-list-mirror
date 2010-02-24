From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 1/5] Refactor list of of repo-local env vars
Date: Thu, 25 Feb 2010 00:34:14 +0100
Message-ID: <1267054458-11877-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1267054458-11877-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 00:34:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkQke-0002t5-PO
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758564Ab0BXXea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 18:34:30 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52399 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758420Ab0BXXe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 18:34:29 -0500
Received: by wya21 with SMTP id 21so1497231wya.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 15:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3z1kueZ7eoV1SSfZL6Qv+mas5di3syFIPqwLmwEa99o=;
        b=kCbKvd4E7J5FZEqG/GFLfBMoPSKn8B22kgYWfPfpEwspcJC++An4oDnC9yPQ2epd5a
         EfqTZp2Mw0Tf/7vETlTPLED8EmWISTygkaYNtjJbrspBZyijf4AJxqWxyap/6hwyzSPm
         6AlNKbv+YAMPkzSOLxEVWYsMrSKTdhsMFwQwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V/s1h9eH7IS/weFZvhseRZH9spuypIYD+5iyHb1lkdR+6k7qs6sMVL49l7KKt1zJC/
         Tgza16VDR3nHDVixjhp3aeaYvu0jjd1sLIZwhg/xBusK7vItSWFEVC7PBi5Kxs9EjOOI
         peZGNofNM7Qj0N+ivmFAWBSGE5FVAkuMEIHwo=
Received: by 10.216.159.204 with SMTP id s54mr268285wek.99.1267054467308;
        Wed, 24 Feb 2010 15:34:27 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id i35sm24023576gve.25.2010.02.24.15.34.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 15:34:26 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g5b851b.dirty
In-Reply-To: <1267054458-11877-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141006>

Move the list of GIT_* environment variables that are local to a
repository into a static list in environment.c, as it is also
useful elsewhere. Also add the missing GIT_CONFIG variable to the
list.

Make it easy to use the list both by NULL-termination and by size;
the latter (excluding the terminating NULL) is stored in the
local_repo_env_size define.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 cache.h       |    8 ++++++++
 connect.c     |   14 ++------------
 environment.c |   15 +++++++++++++++
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index d454b7e..0832ee9 100644
--- a/cache.h
+++ b/cache.h
@@ -388,6 +388,14 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 
+/* Repository-local GIT_* environment variables */
+/* The array is NULL-terminated to simplify its usage in contexts such
+   environment creation or simple walk of the list.
+   The number of non-NULL entries is stored in the following define
+   to simplify preallocation of arrays that need to extend it */
+#define local_repo_env_size 8
+extern const char *const local_repo_env[local_repo_env_size+1];
+
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
diff --git a/connect.c b/connect.c
index 9f39038..323a771 100644
--- a/connect.c
+++ b/connect.c
@@ -582,18 +582,8 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		*arg++ = host;
 	}
 	else {
-		/* remove these from the environment */
-		const char *env[] = {
-			ALTERNATE_DB_ENVIRONMENT,
-			DB_ENVIRONMENT,
-			GIT_DIR_ENVIRONMENT,
-			GIT_WORK_TREE_ENVIRONMENT,
-			GRAFT_ENVIRONMENT,
-			INDEX_ENVIRONMENT,
-			NO_REPLACE_OBJECTS_ENVIRONMENT,
-			NULL
-		};
-		conn->env = env;
+		/* remove repo-local variables from the environment */
+		conn->env = local_repo_env;
 		conn->use_shell = 1;
 	}
 	*arg++ = cmd.buf;
diff --git a/environment.c b/environment.c
index 739ec27..b3e9e8c 100644
--- a/environment.c
+++ b/environment.c
@@ -63,6 +63,21 @@ static char *work_tree;
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
 
+/* Repository-local GIT_* environment variables */
+/* Remember to update local_repo_env_size in cache.h when the size
+   of the list changes */
+const char *const local_repo_env[local_repo_env_size+1] = {
+	ALTERNATE_DB_ENVIRONMENT,
+	CONFIG_ENVIRONMENT,
+	DB_ENVIRONMENT,
+	GIT_DIR_ENVIRONMENT,
+	GIT_WORK_TREE_ENVIRONMENT,
+	GRAFT_ENVIRONMENT,
+	INDEX_ENVIRONMENT,
+	NO_REPLACE_OBJECTS_ENVIRONMENT,
+	NULL
+};
+
 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-- 
1.7.0.212.g5b851b.dirty
