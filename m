From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] More friendly message when locking the index fails.
Date: Thu, 19 Feb 2009 13:54:18 +0100
Message-ID: <1235048058-6181-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7v63jn13qd.fsf@gitster.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 14:09:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8c4-0005XP-PB
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 14:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbZBSNFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 08:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbZBSNFT
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 08:05:19 -0500
Received: from imag.imag.fr ([129.88.30.1]:63418 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbZBSNFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 08:05:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n1JCsIdH003590
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Feb 2009 13:54:18 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1La8Py-00088n-DW; Thu, 19 Feb 2009 13:54:18 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1La8Py-0001cL-BD; Thu, 19 Feb 2009 13:54:18 +0100
X-Mailer: git-send-email 1.6.2.rc1.14.g7f87d
In-Reply-To: <7v63jn13qd.fsf@gitster.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 19 Feb 2009 13:54:18 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110695>

Just saying that index.lock exists doesn't tell the user _what_ to do
to fix the problem. We should give an indication that it's normally
safe to delete index.lock after making sure git isn't running here.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> Perhaps it is a good idea to introduce
> 
> NORETURN void unable_to_lock_index_die(const char *path, int err)
> {
> 	if (err == EEXIST)
> 	        die(...);
>  	else
>         	die(...);
> }
> 
> in lockfile.c and call it from these two places you are touching?

Here it is!

 builtin-update-index.c |    3 +--
 cache.h                |    1 +
 lockfile.c             |   16 +++++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 5604977..dd43d5b 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -742,8 +742,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (newfd < 0) {
 			if (refresh_flags & REFRESH_QUIET)
 				exit(128);
-			die("unable to create '%s.lock': %s",
-			    get_index_file(), strerror(lock_error));
+			unable_to_lock_index_die(get_index_file(), lock_error);
 		}
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(lock_file))
diff --git a/cache.h b/cache.h
index 37dfb1c..bb5a190 100644
--- a/cache.h
+++ b/cache.h
@@ -484,6 +484,7 @@ struct lock_file {
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
+extern NORETURN void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index 021c337..1db1a2f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -155,11 +155,25 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	return lk->fd;
 }
 
+
+NORETURN void unable_to_lock_index_die(const char *path, int err)
+{
+	if (errno == EEXIST) {
+		die("Unable to create '%s.lock': %s.\n\n"
+		    "If no other git process is currently running, this probably means a\n"
+		    "git process crashed in this repository earlier. Make sure no other git\n"
+		    "process is running and remove the file manually to continue.",
+		    path, strerror(err));
+	} else {
+		die("Unable to create '%s.lock': %s", path, strerror(err));
+	}
+}
+
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
 	int fd = lock_file(lk, path, flags);
 	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
-		die("unable to create '%s.lock': %s", path, strerror(errno));
+		unable_to_lock_index_die(path, errno);
 	return fd;
 }
 
-- 
1.6.2.rc1.14.g7f87d
