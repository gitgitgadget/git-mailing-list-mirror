From: Francesco Pretto <ceztkoml@gmail.com>
Subject: [PATCH] Implement selectable group ownership in git-init
Date: Sat, 03 Nov 2007 20:05:26 +0100
Message-ID: <472CC676.3000603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 20:06:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoOJf-0004yb-MT
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 20:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371AbXKCTFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 15:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756013AbXKCTFm
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 15:05:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:56153 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368AbXKCTFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 15:05:41 -0400
Received: by ug-out-1314.google.com with SMTP id z38so749064ugc
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=4j4FPU8kq9S+9CVvUzrsYVFqTVLJMnXL8u1j+07opyc=;
        b=Z+ahU/+WJZbENJFdDxDgMqpOb7G3eUgIdvL3dtSUXv4RvohyX8zDT2OTRYeomByC3ybhLkSvfvBtXRz8qdRYb+gka57GPvJWoKzA7nQSKx9zwt88AREbku0Qy9Gy6bFinGQjt+kpRZ/ntJ4tadTvXuLnLqsy4Q72hiiBpDP9KT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=anvP1iSrrG5RVibwUusQeCjP+E0CiO8capvnHHojtaOIKJgmKW9ibMgHgNGYZsZvHSnL9kqAWrulOflVcNs/o+lVUQ1YfrzK5q0SN5J084pizGExbCNGEb4h5B/bvlkM/LMuI9eOSVrZZ3wqCgiBTauXePaoFK/3EfHveA1/rB0=
Received: by 10.67.15.8 with SMTP id s8mr2259641ugi.1194116739619;
        Sat, 03 Nov 2007 12:05:39 -0700 (PDT)
Received: from ?192.168.1.14? ( [87.2.180.42])
        by mx.google.com with ESMTPS id l22sm4090040uga.2007.11.03.12.05.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Nov 2007 12:05:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63301>

Rationale: continuing the *nix tradition, git is very tied to fs permissions. Groups ownership of git repositories can in fact perfectly resemble projects work groups.
The problem came when sysadmins or git admins create shared repositories: it does not have sense to create repositories with :root group ownership, if you have to put users in the root group to let them use it (!). But the same stands for the administrative git:git user (if you have one): having all the commit users in the git group means that it's impossible to selectively give (or prevent) access to users to different projects. For this reason, git-init should give the possibility to create shared repositories of a selectable group. Moreover, it should warn the user if no specific group is provided, just to warn the user in the case of wrong usage pattern (like :root or :git repositories). The following patch implements this possibility (and the warning), please review it.

---
 builtin-init-db.c |   26 ++++++++++++++++++++++++--
 cache.h           |    2 ++
 environment.c     |    2 ++
 path.c            |    3 +++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 763fa55..c8bed1e 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -321,7 +321,7 @@ static void guess_repository_type(const char *git_dir)
 }
 
 static const char init_db_usage[] =
-"git-init [-q | --quiet] [--template=<template-directory>] [--shared]";
+"git-init [-q | --quiet] [--template=<template-directory>] [--shared] [--group=<project-group>]";
 
 /*
  * If you want to, you can share the DB area with any number of branches.
@@ -346,6 +346,10 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			shared_repository = PERM_GROUP;
 		else if (!prefixcmp(arg, "--shared="))
 			shared_repository = git_config_perm("arg", arg+9);
+		else if (!prefixcmp(arg, "--group=")) {
+			owner_group = arg+8;
+			grouped_repository = 1;
+		}
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
 		        quiet = 1;
 		else
@@ -376,6 +380,20 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	}
 
 	/*
+	 * Complain if the repository is shared and no owner group have
+	 * been selected. 
+	 */
+	if (shared_repository && !grouped_repository)
+		printf("WARNING: You haven't selected any owner group!\n");
+	
+	/*
+	 * Catch the error early if the group provided doesn't exist
+	 */
+	if (getgrnam(owner_group) == NULL)
+		die("The group '%s' doesn't esist",
+		    owner_group);
+
+	/*
 	 * Set up the default .git directory contents
 	 */
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
@@ -417,11 +435,15 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
-	if (!quiet)
+	if (!quiet) {
 		printf("%s%s Git repository in %s/\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
 		       shared_repository ? " shared" : "",
 		       git_dir);
+		if (shared_repository)
+			printf("Put the commit users in the '%s' group\n",
+		       	       grouped_repository ? owner_group : getgrgid(getgid())->gr_name);
+	}
 
 	return 0;
 }
diff --git a/cache.h b/cache.h
index bfffa05..282b0f6 100644
--- a/cache.h
+++ b/cache.h
@@ -306,6 +306,8 @@ extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
+extern int grouped_repository;
+extern const char *owner_group;
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
 extern int core_compression_level;
diff --git a/environment.c b/environment.c
index b5a6c69..a518619 100644
--- a/environment.c
+++ b/environment.c
@@ -23,6 +23,8 @@ int repository_format_version;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
+int grouped_repository = 0;
+const char *owner_group = NULL;
 const char *apply_default_whitespace;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
diff --git a/path.c b/path.c
index 4260952..1ec1379 100644
--- a/path.c
+++ b/path.c
@@ -286,6 +286,9 @@ int adjust_shared_perm(const char *path)
 		mode |= S_ISGID;
 	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
 		return -2;
+	if (grouped_repository)
+		if (chown(path, getuid(), getgrnam(owner_group)->gr_gid) < 0 )
+			return -3;
 	return 0;
 }
 
