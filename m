From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Tue, 2 Dec 2014 21:19:12 -0800
Message-ID: <20141203051911.GP6527@google.com>
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
X-From: git-owner@vger.kernel.org Wed Dec 03 06:19:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2LQ-0007My-9k
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbaLCFTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:19:16 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43357 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbaLCFTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:19:15 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so13033948iec.16
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UfXYLlPoN9PpmBH1DkzQi6SRrM1b5n5T0HSAnsyXMSU=;
        b=CmR3OSuwewEbTjfPGYSORg54MqK7i90YEc8oCsFdHMaFQ+VHTlA/mmZv2YBChFAkhb
         nA65LqoEEherxZyDMBdxnsWRa9bMt2dm6kjR+yNYewJhEzOo0qFW8zxrHiBX0tgG0ekn
         GQG9V5vBCV2ZpIvCQRLJQlxgpLogta24l9Jw0jNA+dP0yPHOOEy81hXi1MVoEfDvVYSW
         uyS5hujOUyxw0WjCxwryrdYoD39NKKuS7xvb7dv5siXc6iZmCkwpQ3ALk+o/b+uFTcbU
         iyQTiBanOZNJmyA9zwx14zEhmIUy+KQcPTLbf8cvK/0fkqiqW3AEX51BZi80a5doA5dD
         srLw==
X-Received: by 10.107.14.208 with SMTP id 199mr3039453ioo.28.1417583954817;
        Tue, 02 Dec 2014 21:19:14 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id mx10sm18046991igb.21.2014.12.02.21.19.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:19:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260630>

When the lockfile API was introduced, it was only used for the index
file and error messages like

  fatal: Unable to create '/path/to/foo.lock': File exists.

  If no other git process is currently running, this probably means a
  git process crashed in this repository earlier. Make sure no other git
  process is running and remove the file manually to continue.

were appropriate advice for that case.

Nowadays, the lockfile API is used for other files that need similar
lock-then-update semantics, including files not associated to any
repository, such as /etc/gitconfig, ../my.bundle, and /tmp/temp.marks.
Add a flag that makes the message stop referring to "this repository"
for such cases.

This should make it possible to print nicer error messages from
such non-core users of the lockfile API.

This introduces the flag.  Later patches will use it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---

 Documentation/technical/api-lockfile.txt | 12 ++++++++++++
 builtin/update-index.c                   |  2 +-
 lockfile.c                               | 26 +++++++++++++++++---------
 lockfile.h                               |  5 +++--
 refs.c                                   |  4 ++--
 5 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 93b5f23..fa60cfd 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -124,6 +124,18 @@ LOCK_NO_DEREF::
 	for backwards-compatibility reasons can be a symbolic link
 	containing the name of the referred-to-reference.
 
+LOCK_OUTSIDE_REPOSITORY:
+
+	When the ".lock" file being created already exists, the error
+	message usually explains that another git process must have
+	crashed in the same Git repository.  If `LOCK_OUTSIDE_REPOSITORY`
+	is set, then the message is replaced with something more
+	appropriate when updating files that are not inside a
+	repository.
++
+For example, this flag should be set when locking a configuration
+file in the user's home directory.
+
 LOCK_DIE_ON_ERROR::
 
 	If a lock is already taken for the file, `die()` with an error
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b0e3dc9..56abd18 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -943,7 +943,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-			unable_to_lock_die(get_index_file(), lock_error);
+			unable_to_lock_die(get_index_file(), 0, lock_error);
 		}
 		if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
diff --git a/lockfile.c b/lockfile.c
index 8685c68..102584f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -149,24 +149,32 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	return lk->fd;
 }
 
-void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
+void unable_to_lock_message(const char *path, int flags, int err,
+			    struct strbuf *buf)
 {
-	if (err == EEXIST) {
+	if (err != EEXIST) {
+		strbuf_addf(buf, "Unable to create '%s.lock': %s",
+			    absolute_path(path), strerror(err));
+	} else if (flags & LOCK_OUTSIDE_REPOSITORY) {
+		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
+		    "If no other git process is currently running, this probably means\n"
+		    "another git process crashed earlier. Make sure no other git process\n"
+		    "is running and remove the file manually to continue.",
+			    absolute_path(path), strerror(err));
+	} else {
 		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
 		    "process is running and remove the file manually to continue.",
 			    absolute_path(path), strerror(err));
-	} else
-		strbuf_addf(buf, "Unable to create '%s.lock': %s",
-			    absolute_path(path), strerror(err));
+	}
 }
 
-NORETURN void unable_to_lock_die(const char *path, int err)
+NORETURN void unable_to_lock_die(const char *path, int flags, int err)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	unable_to_lock_message(path, err, &buf);
+	unable_to_lock_message(path, flags, err, &buf);
 	die("%s", buf.buf);
 }
 
@@ -175,7 +183,7 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
 	int fd = lock_file(lk, path, flags);
 	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
-		unable_to_lock_die(path, errno);
+		unable_to_lock_die(path, flags, errno);
 	return fd;
 }
 
@@ -189,7 +197,7 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path,
 
 	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
-		unable_to_lock_message(path, errno, err);
+		unable_to_lock_message(path, flags, errno, err);
 		return fd;
 	}
 
diff --git a/lockfile.h b/lockfile.h
index ca36a1d..779a992 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -70,10 +70,11 @@ struct lock_file {
 
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NO_DEREF 2
+#define LOCK_OUTSIDE_REPOSITORY 4
 
-extern void unable_to_lock_message(const char *path, int err,
+extern void unable_to_lock_message(const char *path, int, int err,
 				   struct strbuf *buf);
-extern NORETURN void unable_to_lock_die(const char *path, int err);
+extern NORETURN void unable_to_lock_die(const char *path, int, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path,
 				     int, struct strbuf *err);
diff --git a/refs.c b/refs.c
index 917f8fc..39e43cf 100644
--- a/refs.c
+++ b/refs.c
@@ -2326,7 +2326,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else
-			unable_to_lock_die(ref_file, errno);
+			unable_to_lock_die(ref_file, lflags, errno);
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
@@ -2376,7 +2376,7 @@ int lock_packed_refs(struct strbuf *err)
 	struct packed_ref_cache *packed_ref_cache;
 
 	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0) < 0) {
-		unable_to_lock_message(git_path("packed-refs"), errno, err);
+		unable_to_lock_message(git_path("packed-refs"), 0, errno, err);
 		return -1;
 	}
 
