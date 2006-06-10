From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] shared repository settings enhancement.
Date: Fri, 09 Jun 2006 17:39:11 -0700
Message-ID: <7vver9lu8g.fsf_-_@assigned-by-dhcp.cox.net>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
	<7virnam435.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Post, Mark K" <mark.post@eds.com>
X-From: git-owner@vger.kernel.org Sat Jun 10 02:39:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ForVV-0004sz-BD
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 02:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWFJAjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 20:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWFJAjO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 20:39:14 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:16572 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030399AbWFJAjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 20:39:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060610003913.WPLG8684.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Jun 2006 20:39:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7virnam435.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 09 Jun 2006 14:06:22 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21574>

This lets you say:

	[core]
		sharedrepository = 075

to allow permission bits on files under $GIT_DIR for OTHER users
(not just GROUP users) to be copied from the permission bits of
the owner of the file.  This is useful for publishing a shared
repository over gitweb, when gitweb does not run as a member of
the project group and some members have umask too strict for
others to read what is created by default.  The historical
boolean sharedrepository maps to 070 (i.e. if the owner can read
or write or execute it, group members can, too).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This patch is meant for discussion, not application, as you
   can see there is one big "NEEDSWORK" in builtin-init-db.c.

   Regardless of this enhancement to deal with S_I[RWX]OTH, I
   spotted a couple of places that lack permission adjustment in
   the existing code, which might be worth fixing first.

 builtin-init-db.c |   21 ++++++++++++++++++---
 config.c          |    2 +-
 lockfile.c        |   15 ++++++++++-----
 refs.c            |    5 +++++
 setup.c           |   25 +++++++++++++++++++++++--
 sha1_file.c       |    9 ++++++---
 6 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 88b39a4..4826c08 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -198,6 +198,11 @@ static void create_default_files(const c
 
 	git_config(git_default_config);
 
+	/* NEEDSWORK: we would have created the above under user's
+	 * umask -- under shared-repository settings, we would need
+	 * to fix them up by scanning under $GIT_DIR here.
+	 */
+
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
@@ -248,7 +253,14 @@ int cmd_init_db(int argc, const char **a
 		if (!strncmp(arg, "--template=", 11))
 			template_dir = arg+11;
 		else if (!strcmp(arg, "--shared"))
-			shared_repository = 1;
+			shared_repository = 070; /* might want 075 */
+		else if (!strncmp(arg, "--shared=", 9)) {
+			char *end;
+			long val = strtol(arg+9, &end, 8);
+			if (*end || 077 < val)
+				die("bad option for --shared=");
+			shared_repository = val;
+		}
 		else
 			die(init_db_usage);
 	}
@@ -286,8 +298,11 @@ int cmd_init_db(int argc, const char **a
 	strcpy(path+len, "/info");
 	safe_create_dir(path, 1);
 
-	if (shared_repository)
-		git_config_set("core.sharedrepository", "true");
+	if (shared_repository) {
+		char buf[6];
+		sprintf(buf, "%o", shared_repository);
+		git_config_set("core.sharedrepository", buf);
+	}
 
 	return 0;
 }
diff --git a/config.c b/config.c
index 2ae6153..c474970 100644
--- a/config.c
+++ b/config.c
@@ -536,7 +536,7 @@ int git_config_set_multivar(const char* 
 	 * contents of .git/config will be written into it.
 	 */
 	fd = open(lock_file, O_WRONLY | O_CREAT | O_EXCL, 0666);
-	if (fd < 0) {
+	if (fd < 0 || adjust_shared_perm(lock_file)) {
 		fprintf(stderr, "could not lock config file\n");
 		free(store.key);
 		ret = -1;
diff --git a/lockfile.c b/lockfile.c
index 9bc6083..2346e0e 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -27,11 +27,16 @@ int hold_lock_file_for_update(struct loc
 	int fd;
 	sprintf(lk->filename, "%s.lock", path);
 	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
-	if (fd >=0 && !lk->next) {
-		lk->next = lock_file_list;
-		lock_file_list = lk;
-		signal(SIGINT, remove_lock_file_on_signal);
-		atexit(remove_lock_file);
+	if (0 <= fd) {
+		if (!lk->next) {
+			lk->next = lock_file_list;
+			lock_file_list = lk;
+			signal(SIGINT, remove_lock_file_on_signal);
+			atexit(remove_lock_file);
+		}
+		if (adjust_shared_perm(lk->filename))
+			return error("cannot fix permission bits on %s",
+				     lk->filename);
 	}
 	return fd;
 }
diff --git a/refs.c b/refs.c
index f91b771..713ca46 100644
--- a/refs.c
+++ b/refs.c
@@ -104,6 +104,11 @@ #endif
 		error("Unable to create %s", git_HEAD);
 		return -3;
 	}
+	if (adjust_shared_perm(git_HEAD)) {
+		unlink(lockpath);
+		error("Unable to fix permissions on %s", lockpath);
+		return -4;
+	}
 	return 0;
 }
 
diff --git a/setup.c b/setup.c
index fe7f884..213c596 100644
--- a/setup.c
+++ b/setup.c
@@ -223,8 +223,29 @@ int check_repository_format_version(cons
 {
        if (strcmp(var, "core.repositoryformatversion") == 0)
                repository_format_version = git_config_int(var, value);
-	else if (strcmp(var, "core.sharedrepository") == 0)
-		shared_repository = git_config_bool(var, value);
+       else if (strcmp(var, "core.sharedrepository") == 0) {
+	       /* This is unfortunate, but historically this
+		* variable was bool, and it now takes the umask
+		* to say if we want to keep the same access bits for
+		* the user to group members and others.
+		*/
+	       if (!value)
+		       shared_repository = 070; /* "true" - perhaps 075? */
+	       else if (!*value)
+		       ; /* bool "false" */
+	       else if (!strcasecmp(value, "true"))
+		       shared_repository = 070; /* "true" - perhaps 075? */
+	       else if (!strcasecmp(value, "false"))
+		       ; /* bool "false" */
+	       else if (strchr("01234567", *value)) {
+		       char *end;
+		       long val = strtol(value, &end, 8);
+		       if (*end || 077 < val)
+			       die("bad config value '%s' for '%s'",
+				   value, var);
+		       shared_repository = val;
+	       }
+       }
        return 0;
 }
 
diff --git a/sha1_file.c b/sha1_file.c
index aea0f40..fa19835 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -61,11 +61,14 @@ int adjust_shared_perm(const char *path)
 		return -1;
 	mode = st.st_mode;
 	if (mode & S_IRUSR)
-		mode |= S_IRGRP;
+		mode |= ( ((shared_repository & 040) ? S_IRGRP : 0) |
+			  ((shared_repository & 004) ? S_IROTH : 0) );
 	if (mode & S_IWUSR)
-		mode |= S_IWGRP;
+		mode |= ( ((shared_repository & 020) ? S_IWGRP : 0) |
+			  ((shared_repository & 002) ? S_IWOTH : 0) );
 	if (mode & S_IXUSR)
-		mode |= S_IXGRP;
+		mode |= ( ((shared_repository & 010) ? S_IXGRP : 0) |
+			  ((shared_repository & 001) ? S_IXOTH : 0) );
 	if (S_ISDIR(mode))
 		mode |= S_ISGID;
 	if (chmod(path, mode) < 0)
-- 
1.4.0.rc2.g55be
