From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] archive-zip: fix compressed size for stored export-subst
 files
Date: Wed, 27 Feb 2013 11:20:21 +0100
Message-ID: <512DDDE5.5070707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 11:20:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAe84-0007Q8-Nb
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 11:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab3B0KU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 05:20:28 -0500
Received: from india601.server4you.de ([85.25.151.105]:40998 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab3B0KU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 05:20:27 -0500
Received: from [192.168.2.105] (p4FFDBDD7.dip.t-dialin.net [79.253.189.215])
	by india601.server4you.de (Postfix) with ESMTPSA id 0B267392;
	Wed, 27 Feb 2013 11:20:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217200>

Currently ZIP archive entries of files with export-subst attribute are
broken if they are stored uncompressed.

We get the size of a file from sha1_object_info(), but this number is
likely wrong for files whose contents are changed due to export-subst
placeholder expansion.  We use sha1_file_to_archive() to get the
expanded file contents and size in that case.  We proceed to use that
size for the uncompressed size field (good), but the compressed size
field is set based on the size from sha1_object_info() (bad).

This matters only for uncompressed files because for deflated files
we use the correct value after compression is done.  And for files
without export-subst expansion the sizes from sha1_object_info() and
sha1_file_to_archive() are the same, so they are unaffected as well.

This patch fixes the issue by setting the compressed size based on the
uncompressed size only after we actually know the latter.

Also make use of the test file substfile1 to check for the breakage;
it was only stored verbatim so far.  For that purpose, set the
attribute export-subst and replace its contents with the expected
expansion after committing.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This bug was present even before 5ea2c847 (archive-zip: write
uncompressed size into header even with streaming).

 archive-zip.c          | 2 +-
 t/t5003-archive-zip.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/archive-zip.c b/archive-zip.c
index d3aef53..a8d1193 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -240,7 +240,6 @@ static int write_zip_entry(struct archiver_args *args,
 			(mode & 0111) ? ((mode) << 16) : 0;
 		if (S_ISREG(mode) && args->compression_level != 0 && size > 0)
 			method = 8;
-		compressed_size = (method == 0) ? size : 0;
 
 		if (S_ISREG(mode) && type == OBJ_BLOB && !args->convert &&
 		    size > big_file_threshold) {
@@ -259,6 +258,7 @@ static int write_zip_entry(struct archiver_args *args,
 			crc = crc32(crc, buffer, size);
 			out = buffer;
 		}
+		compressed_size = (method == 0) ? size : 0;
 	} else {
 		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
 				sha1_to_hex(sha1));
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 7cfe9ca..6a33606 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -76,6 +76,12 @@ test_expect_success \
      git update-ref HEAD $(TZ=GMT GIT_COMMITTER_DATE="2005-05-27 22:00:00" \
      git commit-tree $treeid </dev/null)'
 
+test_expect_success 'setup export-subst' '
+	echo "substfile?" export-subst >>.git/info/attributes &&
+	git log --max-count=1 "--pretty=format:A${SUBSTFORMAT}O" HEAD \
+		>a/substfile1
+'
+
 test_expect_success \
     'create bare clone' \
     'git clone --bare . bare.git &&
-- 
1.8.0
