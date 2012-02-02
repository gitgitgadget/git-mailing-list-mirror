From: Jeff King <peff@peff.net>
Subject: [PATCH 2/9] grep: move sha1-reading mutex into low-level code
Date: Thu, 2 Feb 2012 03:18:41 -0500
Message-ID: <20120202081841.GB6786@sigill.intra.peff.net>
References: <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsrsX-0008Md-Vm
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab2BBISp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:18:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52850
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635Ab2BBISp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:18:45 -0500
Received: (qmail 17793 invoked by uid 107); 2 Feb 2012 08:25:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:25:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:18:41 -0500
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189594>

The multi-threaded git-grep code needs to serialize access
to the thread-unsafe read_sha1_file call. It does this with
a mutex that is local to builtin/grep.c.

Let's instead push this down into grep.c, where it can be
used by both builtin/grep.c and grep.c. This will let us
safely teach the low-level grep.c code tricks that involve
reading from the object db.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c |   29 ++++++-----------------------
 grep.c         |    6 ++++++
 grep.h         |   17 +++++++++++++++++
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 06983f9..f4402fa 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -85,21 +85,6 @@ static inline void grep_unlock(void)
 		pthread_mutex_unlock(&grep_mutex);
 }
 
-/* Used to serialize calls to read_sha1_file. */
-static pthread_mutex_t read_sha1_mutex;
-
-static inline void read_sha1_lock(void)
-{
-	if (use_threads)
-		pthread_mutex_lock(&read_sha1_mutex);
-}
-
-static inline void read_sha1_unlock(void)
-{
-	if (use_threads)
-		pthread_mutex_unlock(&read_sha1_mutex);
-}
-
 /* Signalled when a new work_item is added to todo. */
 static pthread_cond_t cond_add;
 
@@ -254,7 +239,7 @@ static void start_threads(struct grep_opt *opt)
 	int i;
 
 	pthread_mutex_init(&grep_mutex, NULL);
-	pthread_mutex_init(&read_sha1_mutex, NULL);
+	pthread_mutex_init(&grep_read_mutex, NULL);
 	pthread_mutex_init(&grep_attr_mutex, NULL);
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
@@ -303,7 +288,7 @@ static int wait_all(void)
 	}
 
 	pthread_mutex_destroy(&grep_mutex);
-	pthread_mutex_destroy(&read_sha1_mutex);
+	pthread_mutex_destroy(&grep_read_mutex);
 	pthread_mutex_destroy(&grep_attr_mutex);
 	pthread_cond_destroy(&cond_add);
 	pthread_cond_destroy(&cond_write);
@@ -313,8 +298,6 @@ static int wait_all(void)
 	return hit;
 }
 #else /* !NO_PTHREADS */
-#define read_sha1_lock()
-#define read_sha1_unlock()
 
 static int wait_all(void)
 {
@@ -376,9 +359,9 @@ static void *lock_and_read_sha1_file(const unsigned char *sha1, enum object_type
 {
 	void *data;
 
-	read_sha1_lock();
+	grep_read_lock();
 	data = read_sha1_file(sha1, type, size);
-	read_sha1_unlock();
+	grep_read_unlock();
 	return data;
 }
 
@@ -617,10 +600,10 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		struct strbuf base;
 		int hit, len;
 
-		read_sha1_lock();
+		grep_read_lock();
 		data = read_object_with_reference(obj->sha1, tree_type,
 						  &size, NULL);
-		read_sha1_unlock();
+		grep_read_unlock();
 
 		if (!data)
 			die(_("unable to read tree (%s)"), sha1_to_hex(obj->sha1));
diff --git a/grep.c b/grep.c
index 7a67c2f..db58a29 100644
--- a/grep.c
+++ b/grep.c
@@ -826,6 +826,12 @@ static inline void grep_attr_unlock(void)
 	if (grep_use_locks)
 		pthread_mutex_unlock(&grep_attr_mutex);
 }
+
+/*
+ * Same as git_attr_mutex, but protecting the thread-unsafe object db access.
+ */
+pthread_mutex_t grep_read_mutex;
+
 #else
 #define grep_attr_lock()
 #define grep_attr_unlock()
diff --git a/grep.h b/grep.h
index 3653bb3..4f1b025 100644
--- a/grep.h
+++ b/grep.h
@@ -139,6 +139,23 @@ extern int grep_threads_ok(const struct grep_opt *opt);
  */
 extern int grep_use_locks;
 extern pthread_mutex_t grep_attr_mutex;
+extern pthread_mutex_t grep_read_mutex;
+
+static inline void grep_read_lock(void)
+{
+	if (grep_use_locks)
+		pthread_mutex_lock(&grep_read_mutex);
+}
+
+static inline void grep_read_unlock(void)
+{
+	if (grep_use_locks)
+		pthread_mutex_unlock(&grep_read_mutex);
+}
+
+#else
+#define grep_read_lock()
+#define grep_read_unlock()
 #endif
 
 #endif
-- 
1.7.9.3.gc3fce1.dirty
