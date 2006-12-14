X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Avoid accessing a slow working copy during diffcore operations.
Date: Thu, 14 Dec 2006 06:15:57 -0500
Message-ID: <20061214111557.GA24297@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 11:16:12 +0000 (UTC)
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34315>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuoZM-0003w5-Io for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932559AbWLNLQF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWLNLQF
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:16:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35617 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932559AbWLNLQE (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 06:16:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuoZ9-0006Rq-Oi; Thu, 14 Dec 2006 06:15:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 835B520FB65; Thu, 14 Dec 2006 06:15:57 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

The Cygwin folks have done a fine job at creating a POSIX layer
on Windows That Just Works(tm).  However it comes with a penalty;
accessing files in the working tree by way of stat/open/mmap can
be slower for diffcore than inflating the data from a blob which
is stored in a packfile.

This performance problem is especially an issue in merge-recursive
when dealing with nearly 7000 added files, as we are loading
each file's content from the working directory to perform rename
detection.  I have literally seen (and sadly watched) paint dry in
less time than it takes for merge-recursive to finish such a merge.
On the other hand this very same merge runs very fast on Solaris.

If Git is compiled with NO_FAST_WORKING_DIRECTORY set then we will
avoid looking at the working directory when the blob in question
is available within a packfile and the caller doesn't need the data
unpacked into a temporary file.

We don't use loose objects as they have the same open/mmap/close
costs as the working directory file access, but have the additional
CPU overhead of needing to inflate the content before use.  So it
is still faster to use the working tree file over the loose object.

If the caller needs the file data unpacked into a temporary file
its likely because they are going to call an external diff program,
passing the file as a parameter.  In this case reusing the working
tree file will be faster as we don't need to inflate the data and
write it out to a temporary file.

The NO_FAST_WORKING_DIRECTORY feature is enabled by default on
Cygwin, as that is the platform which currently appears to benefit
the most from this option.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |    7 +++++++
 diff.c   |   20 +++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index bf4c65d..cd9992a 100644
--- a/Makefile
+++ b/Makefile
@@ -69,6 +69,9 @@ all:
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
+# Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
+# generally faster on your platform than accessing the working directory.
+#
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
 #
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
@@ -355,6 +358,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_SYMLINK_HEAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_C99_FORMAT = YesPlease
+	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try uncommenting this if you see things break -- YMMV.
@@ -506,6 +510,9 @@ ifdef NO_MMAP
 	COMPAT_CFLAGS += -DNO_MMAP
 	COMPAT_OBJS += compat/mmap.o
 endif
+ifdef NO_FAST_WORKING_DIRECTORY
+	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
+endif
 ifdef NO_IPV6
 	BASIC_CFLAGS += -DNO_IPV6
 endif
diff --git a/diff.c b/diff.c
index 0b284b3..565b23c 100644
--- a/diff.c
+++ b/diff.c
@@ -1172,7 +1172,7 @@ void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
  * the work tree has that object contents, return true, so that
  * prepare_temp_file() does not have to inflate and extract.
  */
-static int work_tree_matches(const char *name, const unsigned char *sha1)
+static int work_tree_matches(const char *name, const unsigned char *sha1, int want_file)
 {
 	struct cache_entry *ce;
 	struct stat st;
@@ -1193,6 +1193,20 @@ static int work_tree_matches(const char *name, const unsigned char *sha1)
 	if (!active_cache)
 		return 0;
 
+#ifdef NO_FAST_WORKING_DIRECTORY
+	/* We want to avoid the working directory if our caller
+	 * doesn't need the data in a normal file, this system
+	 * is rather slow with its stat/open/mmap/close syscalls,
+	 * and the object is contained in a pack file.  The pack
+	 * is probably already open and will be faster to obtain
+	 * the data through than the working directory.  Loose
+	 * objects however would tend to be slower as they need
+	 * to be individually opened and inflated.
+	 */
+	if (!want_file && has_sha1_pack(sha1, NULL))
+		return 0;
+#endif
+
 	len = strlen(name);
 	pos = cache_name_pos(name, len);
 	if (pos < 0)
@@ -1279,7 +1293,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 	if (s->data)
 		return err;
 	if (!s->sha1_valid ||
-	    work_tree_matches(s->path, s->sha1)) {
+	    work_tree_matches(s->path, s->sha1, 0)) {
 		struct stat st;
 		int fd;
 		if (lstat(s->path, &st) < 0) {
@@ -1386,7 +1400,7 @@ static void prepare_temp_file(const char *name,
 	}
 
 	if (!one->sha1_valid ||
-	    work_tree_matches(name, one->sha1)) {
+	    work_tree_matches(name, one->sha1, 1)) {
 		struct stat st;
 		if (lstat(name, &st) < 0) {
 			if (errno == ENOENT)
-- 
