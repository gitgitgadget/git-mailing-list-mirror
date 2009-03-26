From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Thu, 26 Mar 2009 00:23:10 -0700
Message-ID: <7vprg4rbmp.fsf@gitster.siamese.dyndns.org>
References: <200903250105.05808.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
 <7vwsadw5pz.fsf@gitster.siamese.dyndns.org>
 <200903260122.24770.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 08:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmjxJ-0008Iy-TS
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 08:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbZCZHXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 03:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbZCZHXS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 03:23:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbZCZHXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 03:23:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3AE8D9B43;
	Thu, 26 Mar 2009 03:23:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1F3DD9B42; Thu,
 26 Mar 2009 03:23:11 -0400 (EDT)
In-Reply-To: <200903260122.24770.johan@herland.net> (Johan Herland's message
 of "Thu, 26 Mar 2009 01:22:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F89B5334-19D6-11DE-8561-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114746>

Johan Herland <johan@herland.net> writes:

> On Thursday 26 March 2009, Junio C Hamano wrote:
>> How about doing it like this, instead?
>
> Looks good, and is obviously much less intrusive than my attempt.
>
> There's still one issue as compared to my series: Hook scripts in
> .git/hooks lose their executable bit when copied from template dir.
> You probably need to do some kind of special x-bit handling, similar
> to what's already done for directories.
>
> Other than that:
> Tested-by: Johan Herland <johan@herland.net>

Sorry to invalidate your Tested-by, but here is a re-roll using a slightly
different strategy.

To fix the loose object codepath, the earlier patch added a call to
adjust_shared_perm() to write_loose_object() function, but after looking
at your 7th patch, I realized that the pattern of file creation inside
$GIT_DIR typically is to first create a temporary file, write to it, and
then finish it off by calling move_temp_to_file().  The true purpose of
the function is to "finalize the file being created", and it is misnamed
in that it describes how its implementation does it currently (i.e. by
renaming the temporary file to its final name), but it makes perfect sense
to call adjust_shared_perm() inside it as a part of finalization.  I think
this should cover the codepaths your 7th patch fixed without actually
touching them.

Could you eyeball and re-test it?

-- >8 --
[PATCH] "core.sharedrepository = 0mode" should set, not loosen

This fixes the behaviour of octal notation to how it is defined in the
documentation, while keeping the traditional "loosen only" semantics
intact for "group" and "everybody".

Three main points of this patch are:

 - For an explicit octal notation, the internal shared_repository variable
   is set to a negative value, so that we can tell "group" (which is to
   "OR" in 0660) and 0660 (which is to "SET" to 0660);

 - git-init did not set shared_repository variable early enough to affect
   the initial creation of many files, notably copied templates and the
   configuration.  We set it very early when a command-line option
   specifies a custom value.

 - Many codepaths create files inside $GIT_DIR by various codepaths that
   involve mkstemp(), and then call move_temp_to_file() to rename it to
   its final destination.  We can add adjust_shared_perm() call here; for
   the traditional "loosen-only", this would be a no-op for many codepaths
   because the mode is already loose enough, but with the new behaviour it
   makes a difference.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-init-db.c      |   12 ++++++++++--
 path.c                 |   36 +++++++++++++++++++++---------------
 setup.c                |    4 ++--
 sha1_file.c            |    8 +++++++-
 t/t1301-shared-repo.sh |   37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index ee3911f..8199e5d 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -195,6 +195,8 @@ static int create_default_files(const char *template_path)
 
 	git_config(git_default_config, NULL);
 	is_bare_repository_cfg = init_is_bare_repository;
+
+	/* reading existing config may have overwrote it */
 	if (init_shared_repository != -1)
 		shared_repository = init_shared_repository;
 
@@ -313,12 +315,15 @@ int init_db(const char *template_dir, unsigned int flags)
 		 * and compatibility values for PERM_GROUP and
 		 * PERM_EVERYBODY.
 		 */
-		if (shared_repository == PERM_GROUP)
+		if (shared_repository < 0)
+			/* force to the mode value */
+			sprintf(buf, "0%o", -shared_repository);
+		else if (shared_repository == PERM_GROUP)
 			sprintf(buf, "%d", OLD_PERM_GROUP);
 		else if (shared_repository == PERM_EVERYBODY)
 			sprintf(buf, "%d", OLD_PERM_EVERYBODY);
 		else
-			sprintf(buf, "0%o", shared_repository);
+			die("oops");
 		git_config_set("core.sharedrepository", buf);
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
@@ -398,6 +403,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			usage(init_db_usage);
 	}
 
+	if (init_shared_repository != -1)
+		shared_repository = init_shared_repository;
+
 	/*
 	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
 	 * without --bare.  Catch the error early.
diff --git a/path.c b/path.c
index e332b50..42898e0 100644
--- a/path.c
+++ b/path.c
@@ -314,33 +314,39 @@ char *enter_repo(char *path, int strict)
 int adjust_shared_perm(const char *path)
 {
 	struct stat st;
-	int mode;
+	int mode, tweak, shared;
 
 	if (!shared_repository)
 		return 0;
 	if (lstat(path, &st) < 0)
 		return -1;
 	mode = st.st_mode;
-
-	if (shared_repository) {
-		int tweak = shared_repository;
-		if (!(mode & S_IWUSR))
-			tweak &= ~0222;
+	if (shared_repository < 0)
+		shared = -shared_repository;
+	else
+		shared = shared_repository;
+	tweak = shared;
+
+	if (!(mode & S_IWUSR))
+		tweak &= ~0222;
+	if (mode & S_IXUSR)
+		/* Copy read bits to execute bits */
+		tweak |= (tweak & 0444) >> 2;
+	if (shared_repository < 0)
+		mode = (mode & ~0777) | tweak;
+	else
 		mode |= tweak;
-	} else {
-		/* Preserve old PERM_UMASK behaviour */
-		if (mode & S_IWUSR)
-			mode |= S_IWGRP;
-	}
 
 	if (S_ISDIR(mode)) {
-		mode |= FORCE_DIR_SET_GID;
-
 		/* Copy read bits to execute bits */
-		mode |= (shared_repository & 0444) >> 2;
+		mode |= (shared & 0444) >> 2;
+		mode |= FORCE_DIR_SET_GID;
 	}
 
-	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
+	if (((shared_repository < 0
+	      ? (st.st_mode & (FORCE_DIR_SET_GID | 0777))
+	      : (st.st_mode & mode)) != mode) &&
+	    chmod(path, mode) < 0)
 		return -2;
 	return 0;
 }
diff --git a/setup.c b/setup.c
index 6c2deda..ebd60de 100644
--- a/setup.c
+++ b/setup.c
@@ -434,7 +434,7 @@ int git_config_perm(const char *var, const char *value)
 
 	/*
 	 * Treat values 0, 1 and 2 as compatibility cases, otherwise it is
-	 * a chmod value.
+	 * a chmod value to restrict to.
 	 */
 	switch (i) {
 	case PERM_UMASK:               /* 0 */
@@ -456,7 +456,7 @@ int git_config_perm(const char *var, const char *value)
 	 * Mask filemode value. Others can not get write permission.
 	 * x flags for directories are handled separately.
 	 */
-	return i & 0666;
+	return -(i & 0666);
 }
 
 int check_repository_format_version(const char *var, const char *value, void *cb)
diff --git a/sha1_file.c b/sha1_file.c
index a07aa4e..45987bd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2243,11 +2243,15 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
 }
 
 /*
- * Move the just written object into its final resting place
+ * Move the just written object into its final resting place.
+ * NEEDSWORK: this should be renamed to finalize_temp_file() as
+ * "moving" is only a part of what it does, when no patch between
+ * master to pu changes the call sites of this function.
  */
 int move_temp_to_file(const char *tmpfile, const char *filename)
 {
 	int ret = 0;
+
 	if (link(tmpfile, filename))
 		ret = errno;
 
@@ -2275,6 +2279,8 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 		/* FIXME!!! Collision check here ? */
 	}
 
+	if (adjust_shared_perm(filename))
+		return error("unable to set permission to '%s'", filename);
 	return 0;
 }
 
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 653362b..d459854 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -126,4 +126,41 @@ test_expect_success 'git reflog expire honors core.sharedRepository' '
 	esac
 '
 
+test_expect_success 'forced modes' '
+	mkdir -p templates/hooks &&
+	echo update-server-info >templates/hooks/post-update &&
+	chmod +x templates/hooks/post-update &&
+	echo : >random-file &&
+	mkdir new &&
+	(
+		cd new &&
+		umask 002 &&
+		git init --shared=0660 --template=../templates &&
+		>frotz &&
+		git add frotz &&
+		git commit -a -m initial &&
+		git repack
+	) &&
+	find new/.git -print |
+	xargs ls -ld >actual &&
+
+	# Everything must be unaccessible to others
+	test -z "$(sed -n -e "/^.......---/d" actual)" &&
+
+	# All directories must have 2770
+	test -z "$(sed -n -e "/^drwxrws---/d" -e "/^d/p" actual)" &&
+
+	# post-update hook must be 0770
+	test -z "$(sed -n -e "/post-update/{
+		/^-rwxrwx---/d
+		p
+	}" actual)" &&
+
+	# All files inside objects must be 0440
+	test -z "$(sed -n -e "/objects\//{
+		/^d/d
+		/^-r--r-----/d
+	}" actual)"
+'
+
 test_done
-- 
1.6.2.1.394.g50949
