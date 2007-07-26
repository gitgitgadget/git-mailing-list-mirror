From: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
Subject: [PATCH] use lockfile.c routines in git_commit_set_multivar()
Date: Thu, 26 Jul 2007 12:55:28 -0400
Message-ID: <11854689283208-git-send-email-bradford.carl.smith@gmail.com>
Cc: git@vger.kernel.org,
	"Bradford C. Smith" <bradford.carl.smith@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 18:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE6ci-0006bB-PS
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 18:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761742AbXGZQzd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 12:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761606AbXGZQzd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 12:55:33 -0400
Received: from qb-out-0506.google.com ([72.14.204.225]:41886 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759540AbXGZQzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 12:55:31 -0400
Received: by qb-out-0506.google.com with SMTP id e11so323946qbe
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 09:55:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        b=IeL5r2kMTuniPAZ1/Din2S/vHBiIaT3DwnmgQHxCrbRVt8bp/6V0A0noXw+MRnPBq2j5iNl8CKB0JCBNlAAH2U1j00q/DBxvjh3eAas0B156HZU22/VO5ZixmSU2E9on/5e+7NOXczyi5iBhIUE30w7RS29yJ1hw+9PFXtrodFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uf+cUwKxWdI92BLDzBF2RPxhOwLB2AxNOBiyZdnq1QYgT4+RljvB22tFPoM4cvI6oN/HCRLmii4Hgb6aVeOFjAHah8ZO+lqe+jnXr0VbV1jjUpEHo+sl0irHXjH5tN4VC7qVxLHlDQLeBV5UQAtbxKOQyfOnUOHTv8oBJtxe6Io=
Received: by 10.100.8.18 with SMTP id 18mr1614642anh.1185468929692;
        Thu, 26 Jul 2007 09:55:29 -0700 (PDT)
Received: from localhost ( [160.36.232.47])
        by mx.google.com with ESMTPS id d24sm2816911and.2007.07.26.09.55.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2007 09:55:29 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc3.9.g1b487
In-Reply-To: 7vbqe0cazy.fsf@assigned-by-dhcp.cox.net
References: 7vbqe0cazy.fsf@assigned-by-dhcp.cox.net
In-Reply-To: <7vbqe0cazy.fsf@assigned-by-dhcp.cox.net>
References: <7vbqe0cazy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53844>

Changed git_commit_set_multivar() to use the routines provided by
lockfile.c to reduce code duplication and ensure consistent behavior.

Signed-off-by: Bradford C. Smith <bradford.carl.smith@gmail.com>
---

I am resubmitting this patch to be considered separately from the
symlink resolution change.  It differs from the first time I submitted
it only in that I have corrected the multi-line comment formatting I
used.

I ran the full test suite (make test) on this patch without failures.

 config.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/config.c b/config.c
index f89a611..dd2de6e 100644
--- a/config.c
+++ b/config.c
@@ -715,7 +715,7 @@ int git_config_set_multivar(const char* key, const char* value,
 	int fd = -1, in_fd;
 	int ret;
 	char* config_filename;
-	char* lock_file;
+	struct lock_file *lock = NULL;
 	const char* last_dot = strrchr(key, '.');
 
 	config_filename = getenv(CONFIG_ENVIRONMENT);
@@ -725,7 +725,6 @@ int git_config_set_multivar(const char* key, const char* value,
 			config_filename  = git_path("config");
 	}
 	config_filename = xstrdup(config_filename);
-	lock_file = xstrdup(mkpath("%s.lock", config_filename));
 
 	/*
 	 * Since "key" actually contains the section name and the real
@@ -770,11 +769,12 @@ int git_config_set_multivar(const char* key, const char* value,
 	store.key[i] = 0;
 
 	/*
-	 * The lock_file serves a purpose in addition to locking: the new
+	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	fd = open(lock_file, O_WRONLY | O_CREAT | O_EXCL, 0666);
-	if (fd < 0 || adjust_shared_perm(lock_file)) {
+	lock = xcalloc(sizeof(struct lock_file), 1);
+	fd = hold_lock_file_for_update(lock, config_filename, 0);
+	if (fd < 0) {
 		fprintf(stderr, "could not lock config file\n");
 		free(store.key);
 		ret = -1;
@@ -914,25 +914,31 @@ int git_config_set_multivar(const char* key, const char* value,
 				goto write_err_out;
 
 		munmap(contents, contents_sz);
-		unlink(config_filename);
 	}
 
-	if (rename(lock_file, config_filename) < 0) {
-		fprintf(stderr, "Could not rename the lock file?\n");
+	if (close(fd) || commit_lock_file(lock) < 0) {
+		fprintf(stderr, "Cannot commit config file!\n");
 		ret = 4;
 		goto out_free;
 	}
 
+	/* fd is closed, so don't try to close it below. */
+	fd = -1;
+	/*
+	 * lock is committed, so don't try to roll it back below.
+	 * NOTE: Since lockfile.c keeps a linked list of all created
+	 * lock_file structures, it isn't safe to free(lock).  It's
+	 * better to just leave it hanging around.
+	 */
+	lock = NULL;
 	ret = 0;
 
 out_free:
 	if (0 <= fd)
 		close(fd);
+	if (lock)
+		rollback_lock_file(lock);
 	free(config_filename);
-	if (lock_file) {
-		unlink(lock_file);
-		free(lock_file);
-	}
 	return ret;
 
 write_err_out:
-- 
1.5.3.rc3.9.g1b487
