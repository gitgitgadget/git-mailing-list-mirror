From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/3] Export thread-safe version of
 'has_symlink_leading_path()'
Date: Thu, 9 Jul 2009 13:48:41 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain> <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain> <7vab3d3dpc.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 22:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP0Ym-0007o3-5A
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 22:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbZGIUtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 16:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755633AbZGIUte
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 16:49:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58204 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755988AbZGIUtc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 16:49:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69KmflH018029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 13:48:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69Kmfaa011612;
	Thu, 9 Jul 2009 13:48:41 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123007>



From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Jul 2009 13:35:31 -0700
Subject: [PATCH 6/3] Export thread-safe version of 'has_symlink_leading_path()'

The threaded index preloading will want it, so that it can avoid
locking by simply using a per-thread symlink/directory cache.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
This just exposes a thread-safe version of the symlink checking by 
allowing a caller to pass in its own local 'struct cache_def' to the 
function.

No users of this yet, but the next step is trivial and obvious..

 cache.h    |   10 ++++++++++
 symlinks.c |   21 ++++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 871c984..f1e5ede 100644
--- a/cache.h
+++ b/cache.h
@@ -744,7 +744,17 @@ struct checkout {
 };
 
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
+
+struct cache_def {
+	char path[PATH_MAX + 1];
+	int len;
+	int flags;
+	int track_flags;
+	int prefix_len_stat_func;
+};
+
 extern int has_symlink_leading_path(const char *name, int len);
+extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
 extern int has_symlink_or_noent_leading_path(const char *name, int len);
 extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void invalidate_lstat_cache(const char *name, int len);
diff --git a/symlinks.c b/symlinks.c
index 08ad353..4bdded3 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -32,13 +32,7 @@ static int longest_path_match(const char *name_a, int len_a,
 	return match_len;
 }
 
-static struct cache_def {
-	char path[PATH_MAX + 1];
-	int len;
-	int flags;
-	int track_flags;
-	int prefix_len_stat_func;
-} default_cache;
+static struct cache_def default_cache;
 
 static inline void reset_lstat_cache(struct cache_def *cache)
 {
@@ -217,12 +211,17 @@ void clear_lstat_cache(void)
 /*
  * Return non-zero if path 'name' has a leading symlink component
  */
+int threaded_has_symlink_leading_path(struct cache_def *cache, const char *name, int len)
+{
+	return lstat_cache(cache, name, len, FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) & FL_SYMLINK;
+}
+
+/*
+ * Return non-zero if path 'name' has a leading symlink component
+ */
 int has_symlink_leading_path(const char *name, int len)
 {
-	struct cache_def *cache = &default_cache;	/* FIXME */
-	return lstat_cache(cache, name, len,
-			   FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) &
-		FL_SYMLINK;
+	return threaded_has_symlink_leading_path(&default_cache, name, len);
 }
 
 /*
-- 
1.6.3.3.415.ga8877
