X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Enable reflogs by default in any repository with a working directory.
Date: Thu, 14 Dec 2006 17:41:17 -0500
Message-ID: <20061214224117.GA26374@spearce.org>
References: <7v1wn243mu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 22:41:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v1wn243mu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34420>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzGW-0003vM-O5 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 23:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964863AbWLNWlW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 17:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWLNWlW
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 17:41:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39908 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964863AbWLNWlV (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 17:41:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuzGI-0001qK-5T; Thu, 14 Dec 2006 17:41:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 152E820FB65; Thu, 14 Dec 2006 17:41:18 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

New and experienced Git users alike are finding out too late that
they forgot to enable reflogs in the current repository, and cannot
use the information stored within it to recover from an incorrectly
entered command such as `git reset --hard HEAD^^^` when they really
meant HEAD^^ (aka HEAD~2).

So enable reflogs by default in all future versions of Git, unless
the user specifically disables it with:

  [core]
    logAllRefUpdates = false

in their .git/config or ~/.gitconfig.

We only enable reflogs in repositories that have a working directory
associated with them, as shared/bare repositories do not have
an easy means to prune away old log entries, or may fail logging
entirely if the user's gecos information is not valid during a push.
This heuristic was suggested on the mailing list by Junio.

Documentation was also updated to indicate the new default behavior.
We probably should start to teach usuing the reflog to recover
from mistakes in some of the tutorial material, as new users are
likely to make a few along the way and will feel better knowing
they can recover from them quickly and easily, without fsck-objects'
lost+found features.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |    7 +++++--
 builtin-init-db.c        |    4 ++++
 cache.h                  |    1 +
 environment.c            |    9 +++++++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a3587f8..8abb082 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -79,8 +79,11 @@ core.logAllRefUpdates::
 	file is automatically created for branch heads.
 
 	This information can be used to determine what commit
-	was the tip of a branch "2 days ago".  This value is
-	false by default (no automated creation of log files).
+	was the tip of a branch "2 days ago".
+
+	This value is true by default in a repository that has
+	a working directory associated with it, and false by
+	default in a bare repository.
 
 core.repositoryFormatVersion::
 	Internal variable identifying the repository format and layout
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 235a0ee..214fc8e 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -239,6 +239,10 @@ static void create_default_files(const char *git_dir, const char *template_path)
 		git_config_set("core.filemode",
 			       filemode ? "true" : "false");
 	}
+
+	/* Enable logAllRefUpdates if a working tree is attached */
+	git_config_set("core.logallrefupdates",
+		!is_bare_git_dir(git_dir) ? "true" : "false");
 }
 
 static const char init_db_usage[] =
diff --git a/cache.h b/cache.h
index f2ec5c8..2d3df98 100644
--- a/cache.h
+++ b/cache.h
@@ -123,6 +123,7 @@ extern int cache_errno;
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 
+extern int is_bare_git_dir(const char *dir);
 extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
diff --git a/environment.c b/environment.c
index 84d870c..b7256eb 100644
--- a/environment.c
+++ b/environment.c
@@ -48,6 +48,15 @@ static void setup_git_env(void)
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file = xstrdup(git_path("info/grafts"));
+	log_all_ref_updates = !is_bare_git_dir(git_dir);
+}
+
+int is_bare_git_dir (const char *dir)
+{
+	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
+		return 0;
+	const char *s = strrchr(dir, '/');
+	return !s || strcmp(s + 1, DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
 const char *get_git_dir(void)
-- 
