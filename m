From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH 1/3] Use a temporary index for git commit --interactive
Date: Wed,  2 Feb 2011 21:25:30 -0800
Message-ID: <1296710732-12493-2-git-send-email-conrad.irwin@gmail.com>
References: <1296710732-12493-1-git-send-email-conrad.irwin@gmail.com>
Cc: conrad.irwin@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 06:25:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkrhW-0001mN-BF
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 06:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab1BCFZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 00:25:44 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42607 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1BCFZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 00:25:41 -0500
Received: by gwj20 with SMTP id 20so324592gwj.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 21:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=RvjLOsJg9MdZsbJBfJO3SQJMucDI5CtSnlZJm5uxm/s=;
        b=eXIuL0Y6df66HlkR3ocYxLqSeE44996+XV4db+493+YRwx1/Vgt5U9O3wAzhxMTtYO
         5fZDTEb8AmLpF9B1+gJ9VwpsZjFbUgsJpzLIT89nDieCiR+hE23sad59L5SBRF5Y9rXs
         MYXjJ4chX+rG6qseHC2x0+IHdePP/Ul6V5FW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iuXosk/BLCN1mdNpRpmE9LCN2wP54BVZ0XiFrhneP+sslP5GI5/IrRhM7dTbUefpqY
         JVkGlzze3WeenNhd6tgzwGugElly6E7jeIkICwaq3r7bSfXj2NQJMwkdYkvy1J2RkC6Z
         66JOMYRPWb/leCk2MBpHMOuOxcBOxWW6eiI7c=
Received: by 10.90.68.9 with SMTP id q9mr3925709aga.153.1296710740178;
        Wed, 02 Feb 2011 21:25:40 -0800 (PST)
Received: from scarlatti.dunvegan.biz ([173.228.114.197])
        by mx.google.com with ESMTPS id w6sm533136anf.6.2011.02.02.21.25.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 21:25:39 -0800 (PST)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.72)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1PkrhJ-0003Gu-Sm; Wed, 02 Feb 2011 21:25:37 -0800
X-Mailer: git-send-email 1.7.4.1.g1c7a9.dirty
In-Reply-To: <1296710732-12493-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165954>

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
index b586c0f..ca755db 100644
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
index 03cff5a..41f0e2e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -292,18 +292,11 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	int fd;
 	struct string_list partial;
 	const char **pathspec = NULL;
+	char *old_index_env = NULL;
 	int refresh_flags = REFRESH_QUIET;
 
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
-	if (interactive) {
-		if (interactive_add(argc, argv, prefix) != 0)
-			die("interactive add failed");
-		if (read_cache_preload(NULL) < 0)
-			die("index file corrupt");
-		commit_style = COMMIT_AS_IS;
-		return get_index_file();
-	}
 
 	if (*argv)
 		pathspec = get_pathspec(prefix, argv);
@@ -311,6 +304,33 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	if (read_cache_preload(pathspec) < 0)
 		die("index file corrupt");
 
+	if (interactive) {
+		fd = hold_locked_index(&index_lock, 1);
+
+		refresh_cache_or_die(refresh_flags);
+
+		if (write_cache(fd, active_cache, active_nr) ||
+		    close_lock_file(&index_lock))
+			die("unable to write new_index file");
+
+		old_index_env = getenv(INDEX_ENVIRONMENT);
+		setenv(INDEX_ENVIRONMENT, index_lock.filename, 1);
+
+		if (interactive_add(argc, argv, prefix) != 0)
+			die("interactive add failed");
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
1.7.4.1.g1c7a9.dirty
