From: conrad.irwin@gmail.com
Subject: [PATCH v3 1/3] Use a temporary index for git commit --interactive
Date: Fri,  6 May 2011 22:59:59 -0700
Message-ID: <1304748001-17982-2-git-send-email-conrad.irwin@gmail.com>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Cc: Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 08:00:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIaZ8-0006Kt-TF
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 08:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab1EGGAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 02:00:19 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41167 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab1EGGAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 02:00:11 -0400
Received: by pzk9 with SMTP id 9so1707241pzk.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 23:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=zgctx/myZTvLc7O84gXIfZbc9bD/+1YqfIt1tYUmM50=;
        b=w2hkRB5pmPlvayIdXIknasf2BJi4x8TM19TzTp8gcEIyYPlz481mmrGL4i3DR2LL7o
         z4WXZrOQmACOmgZcYIWY9pSdPA2JrPHXj56VQIHkhZsntWDRP8pgssu343YTLKvQrcJ9
         g+ixAD2+K9XmG6Xl+Ew4wGhuYd8H+R9dnr4Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RJhq7m4Q9l/IG42ABbkgM7BE4r4uPgkTN2R8iIxQC7yHS314MaAHU+CWXZ+BdnWLw1
         fn+bt0yL6Nw/ipXkkUPa9iKSajS55sOnU+MRrWic1HHhhJCVt+RVpdJGG4mJ2KimwuAT
         Rzy+Qdz4GdHpDdhfKN7p17ON/Yxf22AphDSF0=
Received: by 10.68.69.46 with SMTP id b14mr5911064pbu.41.1304748010234;
        Fri, 06 May 2011 23:00:10 -0700 (PDT)
Received: from scarlatti.dunvegan.biz (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id k7sm2623060pbe.32.2011.05.06.23.00.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 May 2011 23:00:08 -0700 (PDT)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.75)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1QIaYg-0004gn-Pn; Fri, 06 May 2011 23:00:06 -0700
X-Mailer: git-send-email 1.7.5.188.g4817
In-Reply-To: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173035>

From: Conrad Irwin <conrad.irwin@gmail.com>

Change the behaviour of git commit --interactive so that when you abort
the commit (by leaving the commit message empty) the index remains
unchanged.

Hitherto an aborted commit --interactive has added the selected hunks to
the index regardless of whether the commit succeeded or not.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/git-commit.txt |    3 ++-
 builtin/commit.c             |   36 ++++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d0534b8..ed50271 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -41,7 +41,8 @@ The content to be added can be specified in several ways:
 
 5. by using the --interactive switch with the 'commit' command to decide one
    by one which files should be part of the commit, before finalizing the
-   operation.  Currently, this is done by invoking 'git add --interactive'.
+   operation.  Currently, this is done by invoking 'git add --interactive'
+   on a temporary index.
 
 The `--dry-run` option can be used to obtain a
 summary of what is included by any of the above for the next
diff --git a/builtin/commit.c b/builtin/commit.c
index 67757e9..636aea6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -336,18 +336,11 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	int fd;
 	struct string_list partial;
 	const char **pathspec = NULL;
+	char *old_index_env = NULL;
 	int refresh_flags = REFRESH_QUIET;
 
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
-	if (interactive) {
-		if (interactive_add(argc, argv, prefix) != 0)
-			die(_("interactive add failed"));
-		if (read_cache_preload(NULL) < 0)
-			die(_("index file corrupt"));
-		commit_style = COMMIT_AS_IS;
-		return get_index_file();
-	}
 
 	if (*argv)
 		pathspec = get_pathspec(prefix, argv);
@@ -355,6 +348,33 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	if (read_cache_preload(pathspec) < 0)
 		die(_("index file corrupt"));
 
+	if (interactive) {
+		fd = hold_locked_index(&index_lock, 1);
+
+		refresh_cache_or_die(refresh_flags);
+
+		if (write_cache(fd, active_cache, active_nr) ||
+		    close_lock_file(&index_lock))
+			die(_("unable to create temporary index"));
+
+		old_index_env = getenv(INDEX_ENVIRONMENT);
+		setenv(INDEX_ENVIRONMENT, index_lock.filename, 1);
+
+		if (interactive_add(argc, argv, prefix) != 0)
+			die(_("interactive add failed"));
+
+		if (old_index_env && *old_index_env)
+			setenv(INDEX_ENVIRONMENT, old_index_env, 1);
+		else
+			unsetenv(INDEX_ENVIRONMENT);
+
+		discard_cache();
+		read_cache_from(index_lock.filename);
+
+		commit_style = COMMIT_NORMAL;
+		return index_lock.filename;
+	}
+
 	/*
 	 * Non partial, non as-is commit.
 	 *
-- 
1.7.5.188.g4817
