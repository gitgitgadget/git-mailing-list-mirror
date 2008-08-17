From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] compat: introduce stat_to_kilobytes
Date: Sun, 17 Aug 2008 02:47:04 -0700
Message-ID: <7vy72w6kiv.fsf@gitster.siamese.dyndns.org>
References: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 11:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUevI-0007Bl-69
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 11:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbYHQJrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 05:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYHQJrO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 05:47:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbYHQJrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 05:47:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B27B05CB3C;
	Sun, 17 Aug 2008 05:47:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7AF805CB3B; Sun, 17 Aug 2008 05:47:07 -0400 (EDT)
In-Reply-To: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de> (Andreas
 =?utf-8?Q?F=C3=A4rber's?= message of "Sun, 17 Aug 2008 10:59:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 770D8956-6C41-11DD-BD3F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92595>

Some platforms do not have st_blocks member in "struct stat"; mingw
already emulates it by rounding it up to closest 512-byte blocks (even
though it could overcount when a file has holes).

The reason to use the member is only to figure out how many kilobytes the
file occupies on-disk, so give a helper in git-compat-util.h to help these
platforms.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I suspect you may be better off building on top of something like
   this.

   The comment before "struct mingw_stat" suggests that the only reason
   this compatiblity definition exists is to add st_blocks member, so I
   suspect we could remove the definition and simplify the compatibility
   layer a lot more, but I do not know MinGW, so I am CC'ing j6t here.

 Makefile                |    4 ++++
 builtin-count-objects.c |    4 ++--
 compat/mingw.c          |    8 --------
 compat/mingw.h          |    1 -
 git-compat-util.h       |    6 ++++++
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 53ab4b5..8f69f16 100644
--- a/Makefile
+++ b/Makefile
@@ -124,6 +124,9 @@ all::
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-index perspective.
 #
+# Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
+# field that counts the on-disk footprint in 512-byte blocks.
+#
 # Define ASCIIDOC8 if you want to format documentation with AsciiDoc 8
 #
 # Define DOCBOOK_XSL_172 if you want to format man pages with DocBook XSL v1.72.
@@ -749,6 +752,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
+	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 91b5487..07ab0a0 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -43,7 +43,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 			if (lstat(path, &st) || !S_ISREG(st.st_mode))
 				bad = 1;
 			else
-				(*loose_size) += xsize_t(st.st_blocks);
+				(*loose_size) += xsize_t(stat_to_kilobytes(st));
 		}
 		if (bad) {
 			if (verbose) {
@@ -115,7 +115,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 			num_pack++;
 		}
 		printf("count: %lu\n", loose);
-		printf("size: %lu\n", loose_size / 2);
+		printf("size: %lu\n", loose_size);
 		printf("in-pack: %lu\n", packed);
 		printf("packs: %lu\n", num_pack);
 		printf("prune-packable: %lu\n", packed_loose);
diff --git a/compat/mingw.c b/compat/mingw.c
index 772cad5..798fb61 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -31,11 +31,6 @@ static inline time_t filetime_to_time_t(const FILETIME *ft)
 	return (time_t)winTime;
 }
 
-static inline size_t size_to_blocks(size_t s)
-{
-	return (s+511)/512;
-}
-
 extern int _getdrive( void );
 /* We keep the do_lstat code in a separate function to avoid recursion.
  * When a path ends with a slash, the stat will fail with ENOENT. In
@@ -59,7 +54,6 @@ static int do_lstat(const char *file_name, struct stat *buf)
 		buf->st_uid = 0;
 		buf->st_mode = fMode;
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
-		buf->st_blocks = size_to_blocks(buf->st_size);
 		buf->st_dev = _getdrive() - 1;
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
@@ -142,7 +136,6 @@ int mingw_fstat(int fd, struct mingw_stat *buf)
 		buf->st_uid = st.st_uid;
 		buf->st_mode = st.st_mode;
 		buf->st_size = st.st_size;
-		buf->st_blocks = size_to_blocks(buf->st_size);
 		buf->st_dev = st.st_dev;
 		buf->st_atime = st.st_atime;
 		buf->st_mtime = st.st_mtime;
@@ -164,7 +157,6 @@ int mingw_fstat(int fd, struct mingw_stat *buf)
 		buf->st_uid = 0;
 		buf->st_mode = fMode;
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
-		buf->st_blocks = size_to_blocks(buf->st_size);
 		buf->st_dev = _getdrive() - 1;
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
diff --git a/compat/mingw.h b/compat/mingw.h
index a52e657..1472d59 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -169,7 +169,6 @@ struct mingw_stat {
 	time_t st_mtime, st_atime, st_ctime;
 	unsigned st_dev, st_ino, st_uid, st_gid;
 	size_t st_size;
-	size_t st_blocks;
 };
 int mingw_lstat(const char *file_name, struct mingw_stat *buf);
 int mingw_fstat(int fd, struct mingw_stat *buf);
diff --git a/git-compat-util.h b/git-compat-util.h
index cf89cdf..8ef3a72 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -192,6 +192,12 @@ extern int git_munmap(void *start, size_t length);
 
 #endif /* NO_MMAP */
 
+#ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
+#define stat_to_kilobytes(st) ((((st).st_size+511) / 512) / 2)
+#else
+#define stat_to_kilobytes(st) ((st).st_blocks / 2)
+#endif
+
 #define DEFAULT_PACKED_GIT_LIMIT \
 	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
 
-- 
1.6.0.rc3.22.g053f
