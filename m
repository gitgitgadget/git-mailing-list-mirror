From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/14] hold_lock_file_for_append: pass error message back
 through a strbuf
Date: Tue, 2 Dec 2014 21:14:59 -0800
Message-ID: <20141203051459.GN6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:15:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2HT-0005u6-Hs
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbaLCFPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:15:09 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:65481 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbaLCFPD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:15:03 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so16236866igb.11
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XlQCtnLOdJk1FUIb81CayT40QpLiVZbSoO2nS7WHA8w=;
        b=u2DCzxOv7baJdvSaSxmYaUbNR4Gl2MTZpGFi4ztS9jn/gg7n4gcV6FyY3ymwGv8uge
         nIgM4p8uNTGpmjFy8fcbHJXVkIZ1p5mpCMDEuRLbzKsDUVLNMP4el7rGliI5PNyC9trw
         9KZEkMQtrbsXUR/jfboBqdWGU4lJk5KOSjG1YR7LU84vN13EfskJ/i13X1BlYtfFlHDw
         aw38t4LwlvNNt4dBHk6fyB+l4PNwXo5+BboXuaOcVr+odnM0JN6xwvZgh957PzexvVeS
         JxkMICq4PK1Kfb7En+3eqw4DmGwNogyskAtYbOCbVkbohTys/5etdK6M+Rz+f/qTPXKb
         6Whg==
X-Received: by 10.43.157.134 with SMTP id lq6mr5601886icc.64.1417583702375;
        Tue, 02 Dec 2014 21:15:02 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id fy5sm18060035igd.3.2014.12.02.21.15.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:15:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260628>

This way, the code does not need to carefully safeguard errno to allow
callers to print a reasonable error message when they choose to do
some cleanup before die()-ing.

Fixes a bug waiting to happen where copy_fd would clobber the errno
passed back via hold_lock_file_for_append from read() or write() when
flags did not contain LOCK_DIE_ON_ERROR.  Luckily the only caller uses
flags == LOCK_DIE_ON_ERROR, avoiding that bug in practice.

Reported-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The advertised bugfix.

 lockfile.c  | 29 ++++++++++-------------------
 lockfile.h  |  3 ++-
 sha1_file.c |  7 ++++++-
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index b3020f3..8685c68 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -179,45 +179,36 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 	return fd;
 }
 
-int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
+int hold_lock_file_for_append(struct lock_file *lk, const char *path,
+			      int flags, struct strbuf *err)
 {
 	int fd, orig_fd;
-	struct strbuf err = STRBUF_INIT;
+
+	assert(!(flags & LOCK_DIE_ON_ERROR));
+	assert(err && !err->len);
 
 	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
-		if (flags & LOCK_DIE_ON_ERROR)
-			unable_to_lock_die(path, errno);
+		unable_to_lock_message(path, errno, err);
 		return fd;
 	}
 
 	orig_fd = open(path, O_RDONLY);
 	if (orig_fd < 0) {
 		if (errno != ENOENT) {
-			int save_errno = errno;
-
-			if (flags & LOCK_DIE_ON_ERROR)
-				die("cannot open '%s' for copying", path);
+			strbuf_addf(err, "cannot open '%s' for copying: %s",
+				    path, strerror(errno));
 			rollback_lock_file(lk);
-			error("cannot open '%s' for copying", path);
-			errno = save_errno;
 			return -1;
 		}
-	} else if (copy_fd(orig_fd, fd, &err)) {
-		int save_errno = errno;
-
-		error("copy-fd: %s", err.buf);
-		strbuf_release(&err);
-		if (flags & LOCK_DIE_ON_ERROR)
-			exit(128);
+	} else if (copy_fd(orig_fd, fd, err)) {
+		strbuf_prefixf(err, "cannot copy '%s': ", path);
 		close(orig_fd);
 		rollback_lock_file(lk);
-		errno = save_errno;
 		return -1;
 	} else {
 		close(orig_fd);
 	}
-	strbuf_release(&err);
 	return fd;
 }
 
diff --git a/lockfile.h b/lockfile.h
index cd2ec95..ca36a1d 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -75,7 +75,8 @@ extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
 extern NORETURN void unable_to_lock_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
-extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
+extern int hold_lock_file_for_append(struct lock_file *, const char *path,
+				     int, struct strbuf *err);
 extern FILE *fdopen_lock_file(struct lock_file *, const char *mode);
 extern char *get_locked_file_path(struct lock_file *);
 extern int commit_lock_file_to(struct lock_file *, const char *path);
diff --git a/sha1_file.c b/sha1_file.c
index e1945e2..6c0ab3b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -406,17 +406,22 @@ void add_to_alternates_file(const char *reference)
 	struct lock_file *lock;
 	int fd;
 	char *alt;
+	struct strbuf err = STRBUF_INIT;
 
 	lock = xcalloc(1, sizeof(*lock));
 	fd = hold_lock_file_for_append(lock, mkpath("%s/info/alternates",
 						    get_object_directory()),
-				       LOCK_DIE_ON_ERROR);
+				       0, &err);
+	if (fd < 0)
+		die("%s", err.buf);
 	alt = mkpath("%s\n", reference);
 	write_or_die(fd, alt, strlen(alt));
 	if (commit_lock_file(lock))
 		die("could not close alternates file");
 	if (alt_odb_tail)
 		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0);
+
+	strbuf_release(&err);
 }
 
 int foreach_alt_odb(alt_odb_fn fn, void *cb)
