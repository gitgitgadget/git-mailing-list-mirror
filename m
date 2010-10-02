From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/7] lockfile: introduce alloc_lock_file() to avoid
 valgrind noise
Date: Sat, 2 Oct 2010 03:32:16 -0500
Message-ID: <20101002083216.GC29638@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 10:35:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1xZ5-0003Er-Lb
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 10:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab0JBIf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 04:35:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61060 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab0JBIfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 04:35:25 -0400
Received: by iwn5 with SMTP id 5so4738077iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4PO7jztPCi7ILMRIoJe744tkXW0A3htcIT+PptvVHvM=;
        b=jjiEVdTc6LRxC8Afu9gGr1WyQfjDgjo2nq4knwzQS0BxHS3BsGhc5Tx4Qy4JDQt7zH
         SwIfO3lvwBjNrOSqlKJY0X/KYZDi74uGSzmSv6edV3ReRkjmS/dTiFwCAeZNP3CR5Rv+
         3Eti+d+Dfz8ViwcMEGt9WguBDG9rjRoO5O/W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LWW5G4vycDVy/2iHKkSMj6c9UW7RGeqcCMbnefyd5q6bqbVO9T0AVDJiONIVxw9aoK
         IxgmXryhsMeqwyALy/k/vbFyrUvEoJrGFtrn/Onc458vW/4aqGBCBtbpJ0nobHIrc6Me
         lWP/ArCiFA9SNyCf6ptq7X0lOFhdzIvWoIcwo=
Received: by 10.231.32.135 with SMTP id c7mr6984178ibd.3.1286008524622;
        Sat, 02 Oct 2010 01:35:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n20sm2220857ibe.23.2010.10.02.01.35.23
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 01:35:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101002082752.GA29638@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157797>

The current lockfile API often requires leaking memory:

 - the list of lockfiles to remove at exit is maintained in a
   singly linked list, so one cannot easily remove a lockfile
   record when it is no longer needed

 - some lockfile records are statically allocated and others are on
   the heap, so the remove_lock_file() atexit handler cannot easily
   free them at exit (not to mention that it would be a waste of time
   since _exit() takes care of freeing them anyway)

As the git libification effort proceeds, maybe this will become worth
fixing.  For now, since there are so few lock files used by a given
process, it is simpler to tolerate the leak.

Add a alloc_lock_file() helper to make such tolerance easier.
Allocations made through this helper function will not be reported as
leaks by valgrind even if there is no corresponding free().  The
((optimize("-fno-optimize-sibling-calls"))) attribute is needed on
platforms with GCC to ensure that the stack frame for
alloc_lock_file() is not replaced by the stack frame for xcalloc().

For illustration, this patch updates a few example xcalloc(1,
sizeof(struct lockfile)) call sites to use the new wrapper.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/technical/api-lockfile.txt |    9 +++++++++
 builtin/update-index.c                   |    4 +---
 cache-tree.c                             |    7 +------
 cache.h                                  |    1 +
 config.c                                 |    2 +-
 lockfile.c                               |    6 ++++++
 t/valgrind/default.supp                  |    8 ++++++++
 7 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index dd89404..8eac22a 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -22,6 +22,15 @@ The lockfile API serves two purposes:
 The functions
 -------------
 
+alloc_lock_file::
+
+	Allocate and clear a `struct lock_file`.  Because the
+	structure is used in an `atexit(3)` handler, its
+	storage has to stay throughout the life of the
+	program.  Using this allocation function instead of
+	`malloc` allows profiling tools like valgrind to keep
+	track of such storage and avoid reporting it as a leak.
+
 hold_lock_file_for_update::
 
 	Take a pointer to `struct lock_file`, the filename of
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3ab214d..7697631 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -591,9 +591,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-
+	lock_file = alloc_lock_file();
 	newfd = hold_locked_index(lock_file, 0);
 	if (newfd < 0)
 		lock_error = errno;
diff --git a/cache-tree.c b/cache-tree.c
index f755590..81cf785 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -550,12 +550,7 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 	int entries, was_valid, newfd;
 	struct lock_file *lock_file;
 
-	/*
-	 * We can't free this memory, it becomes part of a linked list
-	 * parsed atexit()
-	 */
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-
+	lock_file = alloc_lock_file();
 	newfd = hold_locked_index(lock_file, 1);
 
 	entries = read_cache();
diff --git a/cache.h b/cache.h
index 2ef2fa3..9ee61a2 100644
--- a/cache.h
+++ b/cache.h
@@ -517,6 +517,7 @@ struct lock_file {
 #define LOCK_NODEREF 2
 extern int unable_to_lock_error(const char *path, int err);
 extern NORETURN void unable_to_lock_index_die(const char *path, int err);
+extern struct lock_file *alloc_lock_file(void);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
diff --git a/config.c b/config.c
index 4b0a820..3f30e2b 100644
--- a/config.c
+++ b/config.c
@@ -1158,7 +1158,7 @@ int git_config_set_multivar(const char *key, const char *value,
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	lock = xcalloc(sizeof(struct lock_file), 1);
+	lock = alloc_lock_file();
 	fd = hold_lock_file_for_update(lock, config_filename, 0);
 	if (fd < 0) {
 		error("could not lock config file %s: %s", config_filename, strerror(errno));
diff --git a/lockfile.c b/lockfile.c
index b0d74cd..161dea8 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -184,6 +184,12 @@ NORETURN void unable_to_lock_index_die(const char *path, int err)
 	die("%s", unable_to_lock_message(path, err));
 }
 
+__attribute__((optimize("-fno-optimize-sibling-calls")))
+struct lock_file *alloc_lock_file(void)
+{
+	return xcalloc(1, sizeof(struct lock_file));
+}
+
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
 	int fd = lock_file(lk, path, flags);
diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 9e013fa..7789edd 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -43,3 +43,11 @@
 	fun:write_buffer
 	fun:write_loose_object
 }
+
+{
+	see api-lockfile.txt
+	Memcheck:Leak
+	fun:calloc
+	fun:xcalloc
+	fun:alloc_lock_file
+}
-- 
1.7.2.3
