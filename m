From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Wed, 25 Mar 2009 16:19:36 -0700
Message-ID: <7vwsadw5pz.fsf@gitster.siamese.dyndns.org>
References: <200903250105.05808.johan@herland.net>
 <7vvdpybf9i.fsf@gitster.siamese.dyndns.org>
 <200903250311.56300.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 00:21:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmcPL-0008Dy-R6
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 00:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbZCYXTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 19:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbZCYXTo
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 19:19:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZCYXTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 19:19:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 892197F88;
	Wed, 25 Mar 2009 19:19:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A1EA57F87; Wed,
 25 Mar 2009 19:19:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B1B25C2-1993-11DE-8AA2-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114690>

Junio C Hamano <gitster@pobox.com> writes:

> Johan Herland <johan@herland.net> writes:
>
>> On Wednesday 25 March 2009, Junio C Hamano wrote:
>>> You might like to try a patch like this (untested).
>>>
>>>  path.c |   17 +++++------------
>>>  1 files changed, 5 insertions(+), 12 deletions(-)
>>
>> Thanks!
>>
>> This works much better :)
>>
>> However, there are still some questions/issues:
>>
>> - t1301-shared-repo.sh fails:
>>     Oops, .git/HEAD is not 0664 but -rw-rw---- [...]
>>     * FAIL 3: shared=1 does not clear bits preset by umask 022
>>   (I guess this is expected, as your patch changes the assumptions)
>
> I'd rather say the patch breaks people's expectations.

How about doing it like this, instead?

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

 - Loose object creation codepath first letsmkstemp() to create a new
   temporary file; depending on systems, this gets 0660 or 0600, which
   does not have anything to do with user's umask.  To compensate for
   this, close_sha1_file() unconditionally doing fchmod(0444).  For the
   traditional "loosen-only", adjust_shared_perm() call after it would be
   a no-op (the mode is already loose enough), but with the new behaviour
   it makes a difference.

I think there are more places you could sprinkle adjust_shared_perm() for
packfiles and other things.  I didn't check, not because I wasn't
uninterested, but because I am more interested in getting what
adjust_shared_perm() itself does right.

 builtin-init-db.c |   12 ++++++++++--
 path.c            |   33 ++++++++++++++++++---------------
 setup.c           |    5 ++---
 sha1_file.c       |    3 +++
 4 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index fc63d0f..4e02b33 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -194,6 +194,8 @@ static int create_default_files(const char *template_path)
 
 	git_config(git_default_config, NULL);
 	is_bare_repository_cfg = init_is_bare_repository;
+
+	/* reading existing config may have overwrote it */
 	if (init_shared_repository != -1)
 		shared_repository = init_shared_repository;
 
@@ -312,12 +314,15 @@ int init_db(const char *template_dir, unsigned int flags)
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
@@ -397,6 +402,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			usage(init_db_usage);
 	}
 
+	if (init_shared_repository != -1)
+		shared_repository = init_shared_repository;
+
 	/*
 	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
 	 * without --bare.  Catch the error early.
diff --git a/path.c b/path.c
index e332b50..9026b6e 100644
--- a/path.c
+++ b/path.c
@@ -314,33 +314,36 @@ char *enter_repo(char *path, int strict)
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
+		mode |= FORCE_DIR_SET_GID;
+		mode |= (shared & 0444) >> 2;
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
index 6c2deda..a430238 100644
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
@@ -456,7 +455,7 @@ int git_config_perm(const char *var, const char *value)
 	 * Mask filemode value. Others can not get write permission.
 	 * x flags for directories are handled separately.
 	 */
-	return i & 0666;
+	return -(i & 0666);
 }
 
 int check_repository_format_version(const char *var, const char *value, void *cb)
diff --git a/sha1_file.c b/sha1_file.c
index 54972f9..b4c12c4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2393,6 +2393,9 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 				tmpfile, strerror(errno));
 	}
 
+	if (adjust_shared_perm(tmpfile))
+		die("unable to set permission to '%s'", tmpfile);
+
 	return move_temp_to_file(tmpfile, filename);
 }
 
