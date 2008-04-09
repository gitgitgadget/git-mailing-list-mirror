From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-archive: ignore prefix when checking file attribute
Date: Wed, 09 Apr 2008 23:14:43 +0200
Message-ID: <47FD31C3.8070001@lsrfire.ath.cx>
References: <a1b6cb1b0804081435w24074d1aq177e8c1a5e1af0f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 23:15:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjhdk-00014r-R0
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 23:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbYDIVOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 17:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbYDIVOs
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 17:14:48 -0400
Received: from india601.server4you.de ([85.25.151.105]:45806 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbYDIVOr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 17:14:47 -0400
Received: from [10.0.1.101] (p57B7E69B.dip.t-dialin.net [87.183.230.155])
	by india601.server4you.de (Postfix) with ESMTPSA id ABCE52F8028;
	Wed,  9 Apr 2008 23:14:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <a1b6cb1b0804081435w24074d1aq177e8c1a5e1af0f8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79137>

Ulrik Sverdrup noticed that git-archive doesn't correctly apply the attribute
export-subst when the option --prefix is given, too.

When it checked if a file has the attribute turned on, git-archive would try
to look up the full path -- including the prefix -- in .gitattributes.  That's
wrong, as the prefix doesn't need to have any relation to any existing
directories, tracked or not.

This patch makes git-archive ignore the prefix when looking up if value of the
attribute export-subst for a file.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Ulrik, does this patch fix the problem for you?  It applies to v1.5.4.4 and
v1.5.5 equally.

 archive-tar.c       |    6 ++++--
 archive-zip.c       |    6 ++++--
 t/t5000-tar-tree.sh |   15 ++++++++++++++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 30aa2e2..4add802 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -17,6 +17,7 @@ static time_t archive_time;
 static int tar_umask = 002;
 static int verbose;
 static const struct commit *commit;
+static size_t base_len;
 
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
@@ -251,8 +252,8 @@ static int write_tar_entry(const unsigned char *sha1,
 		buffer = NULL;
 		size = 0;
 	} else {
-		buffer = sha1_file_to_archive(path.buf, sha1, mode, &type,
-		                              &size, commit);
+		buffer = sha1_file_to_archive(path.buf + base_len, sha1, mode,
+				&type, &size, commit);
 		if (!buffer)
 			die("cannot read %s", sha1_to_hex(sha1));
 	}
@@ -272,6 +273,7 @@ int write_tar_archive(struct archiver_args *args)
 	archive_time = args->time;
 	verbose = args->verbose;
 	commit = args->commit;
+	base_len = args->base ? strlen(args->base) : 0;
 
 	if (args->commit_sha1)
 		write_global_extended_header(args->commit_sha1);
diff --git a/archive-zip.c b/archive-zip.c
index 74e30f6..18c0f87 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -13,6 +13,7 @@ static int verbose;
 static int zip_date;
 static int zip_time;
 static const struct commit *commit;
+static size_t base_len;
 
 static unsigned char *zip_dir;
 static unsigned int zip_dir_size;
@@ -197,8 +198,8 @@ static int write_zip_entry(const unsigned char *sha1,
 		if (S_ISREG(mode) && zlib_compression_level != 0)
 			method = 8;
 		result = 0;
-		buffer = sha1_file_to_archive(path, sha1, mode, &type, &size,
-		                              commit);
+		buffer = sha1_file_to_archive(path + base_len, sha1, mode,
+				&type, &size, commit);
 		if (!buffer)
 			die("cannot read %s", sha1_to_hex(sha1));
 		crc = crc32(crc, buffer, size);
@@ -321,6 +322,7 @@ int write_zip_archive(struct archiver_args *args)
 	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
 	verbose = args->verbose;
 	commit = args->commit;
+	base_len = args->base ? strlen(args->base) : 0;
 
 	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
 		char *base = xstrdup(args->base);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index dca2067..fa62b6a 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -109,9 +109,10 @@ test_expect_success \
     'diff -r a c/prefix/a'
 
 test_expect_success \
-    'create an archive with a substfiles' \
+    'create archives with substfiles' \
     'echo "substfile?" export-subst >a/.gitattributes &&
      git archive HEAD >f.tar &&
+     git archive --prefix=prefix/ HEAD >g.tar &&
      rm a/.gitattributes'
 
 test_expect_success \
@@ -127,6 +128,18 @@ test_expect_success \
 '
 
 test_expect_success \
+    'extract substfiles from archive with prefix' \
+    '(mkdir g && cd g && $TAR xf -) <g.tar'
+
+test_expect_success \
+     'validate substfile contents from archive with prefix' \
+     'git log --max-count=1 "--pretty=format:A${SUBSTFORMAT}O" HEAD \
+      >g/prefix/a/substfile1.expected &&
+      diff g/prefix/a/substfile1.expected g/prefix/a/substfile1 &&
+      diff a/substfile2 g/prefix/a/substfile2
+'
+
+test_expect_success \
     'git archive --format=zip' \
     'git archive --format=zip HEAD >d.zip'
 
