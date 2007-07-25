From: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
Subject: [PATCH 2/2] use lockfile.c routines in git_commit_set_multivar()
Date: Wed, 25 Jul 2007 12:49:53 -0400
Message-ID: <11853821962210-git-send-email-bradford.carl.smith@gmail.com>
References: <7vps2s2chy.fsf@assigned-by-dhcp.cox.net>
 <11853821932079-git-send-email-bradford.carl.smith@gmail.com>
 <11853821951367-git-send-email-bradford.carl.smith@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Bradford C. Smith" <bradford.carl.smith@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 18:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDk3t-0004AA-73
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 18:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758745AbXGYQuB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 12:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965AbXGYQuA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 12:50:00 -0400
Received: from ag-out-0708.google.com ([72.14.246.246]:34716 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757656AbXGYQt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 12:49:58 -0400
Received: by ag-out-0708.google.com with SMTP id 35so2199451aga
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 09:49:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iKub8tk6zlmQmSZQlOR42voM0dPOt3RbPSNilEMqnBRbfR4HdKbrtug+AbYpQuOqwdUdS3Oju95q1t8PXrtR7EZY3h4+WFbklfDEwRDHlvoJPjMYDtcaN9+djmkooT399cZ5A8yaBxnm2S0YZ8Z8cBRO6jB11VZ2JLm6rvc7dhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S+LKNV8rq/VvFWBo10GS4ke4WMGEX64kIehVwqUSw/bIKYmNZcq9Sew3ixrHQVI/Tdvjk38tIJfJYGyJzE7xqg/gMXLL9Omk4ifWtceF/ds6DytiQRxO7w4XODkw1R8NcFCQFHAvQWhGRKPRyePj1rxvI7ax2aPQ3TFarkgY+pE=
Received: by 10.100.47.9 with SMTP id u9mr491410anu.1185382198019;
        Wed, 25 Jul 2007 09:49:58 -0700 (PDT)
Received: from localhost ( [160.36.232.47])
        by mx.google.com with ESMTPS id b18sm1207088ana.2007.07.25.09.49.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 09:49:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc2.30.g1c06-dirty
In-Reply-To: <11853821951367-git-send-email-bradford.carl.smith@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53700>

From: Bradford C. Smith <bradford.carl.smith@gmail.com>

Changed git_commit_set_multivar() to use the routines provided by
lockfile.c to reduce code duplication and ensure consistent behavior.

Signed-off-by: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
---
 config.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/config.c b/config.c
index f89a611..9101de9 100644
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
@@ -914,25 +914,29 @@ int git_config_set_multivar(const char* key, const char* value,
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
+	/* lock is committed, so don't try to roll it back below.
+	 * NOTE: Since lockfile.c keeps a linked list of all created
+	 * lock files, it isn't safe to free(lock).  It's better to just
+	 * leave it hanging around. */
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
1.5.3.rc2.30.g1c06-dirty
