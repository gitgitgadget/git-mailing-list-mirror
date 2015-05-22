From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] prepare_packed_git: use stat_validity to avoid
 re-reading packs
Date: Fri, 22 May 2015 19:54:05 -0400
Message-ID: <20150522235404.GA4973@peff.net>
References: <20150522235116.GA4300@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Sat May 23 01:54:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvwlp-0006od-07
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757801AbbEVXyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:54:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:35086 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757583AbbEVXyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 19:54:07 -0400
Received: (qmail 11797 invoked by uid 102); 22 May 2015 23:54:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 18:54:07 -0500
Received: (qmail 22443 invoked by uid 107); 22 May 2015 23:54:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 19:54:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2015 19:54:05 -0400
Content-Disposition: inline
In-Reply-To: <20150522235116.GA4300@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269779>

When we try to read an object and fail, we call
reprepare_packed_git() to re-scan the list of packfiles.
This catches any "racy" cases in which somebody is repacking
or making new objects. The performance implications of
re-scanning the pack directory are not usually a big deal,
because failing to find an object is the unlikely case;
we typically die if the re-scan does not help.

Since 45e8a74 (has_sha1_file: re-check pack directory before
giving up, 2013-08-30), we do the same thing for
has_sha1_file.  Some calls to has_sha1_file are in the same
boat: they expect most calls to return true. But some sites,
such as the collision test in index-pack.c, may make a large
number of calls, most of which they expect to be false. On a
local system, this can cause a performance slowdown of
around 5%. But on a system with high-latency system calls
(like NFS), it can be much worse.

Since the common case is that the pack directory has _not_
changed, we can improve the performance by using stat()
before doing the opendir()/readdir()/closedir() to re-scan
the directory. It's valid to check stat() for just the
single "objects/pack" directory because:

  1. We know that packfiles themselves are not changed in
     place; only new files are written, which would update
     the mtime of the directory.

  2. There are no subdirectories inside the pack directory.
     Checking the single top-level directory can tell us
     whether anything changed.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not sure what we want to do for the case where we don't have DIRFD.
We have to separately open the directory, but I'm not sure if regular
open() is even valid on a regular directory on all systems. We could
just skip the stat_validity entirely in that case.

 cache.h           |  1 +
 git-compat-util.h |  4 ++++
 sha1_file.c       | 27 ++++++++++++++++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index cdd279a..9c34a17 100644
--- a/cache.h
+++ b/cache.h
@@ -1216,6 +1216,7 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
 	char *name;
+	struct stat_validity pack_validity;
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
diff --git a/git-compat-util.h b/git-compat-util.h
index b7a97fb..8631e75 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -941,4 +941,8 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define getc_unlocked(fh) getc(fh)
 #endif
 
+#if _POSIX_VERSION >= 200809L
+#define HAVE_DIRFD
+#endif
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index ccc6dac..0e77838 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1225,7 +1225,8 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-static void prepare_packed_git_one(char *objdir, int local)
+static void prepare_packed_git_one(char *objdir, int local,
+				   struct stat_validity *validity)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -1235,6 +1236,12 @@ static void prepare_packed_git_one(char *objdir, int local)
 
 	strbuf_addstr(&path, objdir);
 	strbuf_addstr(&path, "/pack");
+
+	if (stat_validity_check(validity, path.buf)) {
+		strbuf_release(&path);
+		return;
+	}
+
 	dir = opendir(path.buf);
 	if (!dir) {
 		if (errno != ENOENT)
@@ -1243,6 +1250,19 @@ static void prepare_packed_git_one(char *objdir, int local)
 		strbuf_release(&path);
 		return;
 	}
+
+#ifdef HAVE_DIRFD
+	stat_validity_update(validity, dirfd(dir));
+#else
+	{
+		int fd = open(path.buf, O_RDONLY);
+		if (fd >= 0) {
+			stat_validity_update(validity, fd);
+			close(fd);
+		}
+	}
+#endif
+
 	strbuf_addch(&path, '/');
 	dirnamelen = path.len;
 	while ((de = readdir(dir)) != NULL) {
@@ -1348,15 +1368,16 @@ static void rearrange_packed_git(void)
 static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
+	static struct stat_validity validity;
 	struct alternate_object_database *alt;
 
 	if (prepare_packed_git_run_once)
 		return;
-	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_packed_git_one(get_object_directory(), 1, &validity);
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		alt->name[-1] = 0;
-		prepare_packed_git_one(alt->base, 0);
+		prepare_packed_git_one(alt->base, 0, &alt->pack_validity);
 		alt->name[-1] = '/';
 	}
 	rearrange_packed_git();
-- 
2.4.1.538.g69ac333
