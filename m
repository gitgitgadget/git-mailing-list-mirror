From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 1/2] compat: introduce stat_to_kilobytes
Date: Mon, 18 Aug 2008 21:57:16 +0200
Message-ID: <200808182157.16392.johannes.sixt@telecom.at>
References: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de> <7vy72w6kiv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Andreas =?iso-8859-1?q?F=E4rber?= <andreas.faerber@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 21:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVAs0-0006la-2q
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 21:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbYHRT5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 15:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754278AbYHRT5V
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 15:57:21 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:38304 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbYHRT5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 15:57:20 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 187E013A368;
	Mon, 18 Aug 2008 21:57:16 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7CDCB1D391;
	Mon, 18 Aug 2008 21:57:16 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vy72w6kiv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92732>

From: Junio C Hamano <gitster@pobox.com>

Some platforms do not have st_blocks member in "struct stat"; mingw
already emulates it by rounding it up to closest 512-byte blocks (even
though it could overcount when a file has holes).

The reason to use the member is only to figure out how many kilobytes the
file occupies on-disk, so give a helper in git-compat-util.h to help these
platforms.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Acked-by: Johannes Sixt <johannes.sixt@telecom.at>
---
On Sonntag, 17. August 2008, Junio C Hamano wrote:
>    The comment before "struct mingw_stat" suggests that the only reason
>    this compatiblity definition exists is to add st_blocks member, so I
>    suspect we could remove the definition and simplify the compatibility
>    layer a lot more, but I do not know MinGW, so I am CC'ing j6t here.

Makes sense. Here it is again, with the Makefile fixup noted by Andreas.

But notice that we now underestimated the size of loose objects more than
we did previously because we now round down individual sizes; previously
we rounded down only the total size.

 Makefile                |    7 +++++++
 builtin-count-objects.c |    4 ++--
 compat/mingw.c          |    8 --------
 compat/mingw.h          |    1 -
 git-compat-util.h       |    6 ++++++
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 979fcf8..7095b1f 100644
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
@@ -863,6 +867,9 @@ endif
 ifdef NO_D_INO_IN_DIRENT
 	BASIC_CFLAGS += -DNO_D_INO_IN_DIRENT
 endif
+ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
+	BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STRUCT_STAT
+endif
 ifdef NO_C99_FORMAT
 	BASIC_CFLAGS += -DNO_C99_FORMAT
 endif
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
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not 
a stat64 */
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
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not 
a stat64 */
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
index a843444..d6b9a43 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -193,6 +193,12 @@ extern int git_munmap(void *start, size_t length);
 
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
1.6.0.rc2.4.g07fd3
