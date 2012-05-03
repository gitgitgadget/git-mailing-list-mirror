From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 5/9] archive-tar: stream large blobs to tar file
Date: Thu,  3 May 2012 08:51:04 +0700
Message-ID: <1336009868-7411-6-git-send-email-pclouds@gmail.com>
References: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 03:53:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPlEC-0007Ha-Vj
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 03:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636Ab2ECBxD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 21:53:03 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55696 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615Ab2ECBwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 21:52:54 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1813971pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MoGDGiVbFSc+UuQGLhZ/k2cMsjwoipWCNlyBUIrje+4=;
        b=h7HYKaRZdLZHVkk2/7KC9yMgDuALcMMpJF4wu5inrzjzHgIvv7KM7tRWQj9hr45b1o
         6Du03wJpYDGARJYLWHCX9RRVa+cG4ID3DSlDhzdNfF2W/aT1NzG51RL55TbyfaK0Otae
         AIqm1W0r+0V/IF5rFox+BRYFbSYLdh+PJUTTcbfLtyKKIkE7tIrxkofdXFJQwF5zeWIT
         wUTRlomnzWYxO0pEvMEgl+2nTCitrYM+E3KnOkYP+35qrlOzqICA79YPb4RDaQhvQsZ7
         cuB4H5xhg5MmXQppz1NUsbI2ZXNUaE1PU263xUb5HNfPcnI1xW891CCbGfmDKIyrWLuM
         eBMQ==
Received: by 10.68.132.232 with SMTP id ox8mr2311341pbb.145.1336009974726;
        Wed, 02 May 2012 18:52:54 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ns3sm1234071pbb.8.2012.05.02.18.52.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 18:52:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 May 2012 08:51:58 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196878>

t5000 verifies output while t1050 makes sure the command always
respects core.bigfilethreshold

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-tar.c       |   56 +++++++++++++++++++++++++++++++++++++++++++=
+++----
 t/t1050-large.sh    |    4 +++
 t/t5000-tar-tree.sh |    6 +++++
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 3be0cdf..93387ea 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "tar.h"
 #include "archive.h"
+#include "streaming.h"
 #include "run-command.h"
=20
 #define RECORDSIZE	(512)
@@ -30,10 +31,9 @@ static void write_if_needed(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static void write_blocked(const void *data, unsigned long size)
+static void do_write_blocked(const void *data, unsigned long size)
 {
 	const char *buf =3D data;
-	unsigned long tail;
=20
 	if (offset) {
 		unsigned long chunk =3D BLOCKSIZE - offset;
@@ -54,6 +54,11 @@ static void write_blocked(const void *data, unsigned=
 long size)
 		memcpy(block + offset, buf, size);
 		offset +=3D size;
 	}
+}
+
+static void finish_record(void)
+{
+	unsigned long tail;
 	tail =3D offset % RECORDSIZE;
 	if (tail)  {
 		memset(block + offset, 0, RECORDSIZE - tail);
@@ -62,6 +67,12 @@ static void write_blocked(const void *data, unsigned=
 long size)
 	write_if_needed();
 }
=20
+static void write_blocked(const void *data, unsigned long size)
+{
+	do_write_blocked(data, size);
+	finish_record();
+}
+
 /*
  * The end of tar archives is marked by 2*512 nul bytes and after that
  * follows the rest of the block (if any).
@@ -78,6 +89,33 @@ static void write_trailer(void)
 }
=20
 /*
+ * queues up writes, so that all our write(2) calls write exactly one
+ * full block; pads writes to RECORDSIZE
+ */
+static int stream_blocked(const unsigned char *sha1)
+{
+	struct git_istream *st;
+	enum object_type type;
+	unsigned long sz;
+	char buf[BLOCKSIZE];
+	ssize_t readlen;
+
+	st =3D open_istream(sha1, &type, &sz, NULL);
+	if (!st)
+		return error("cannot stream blob %s", sha1_to_hex(sha1));
+	for (;;) {
+		readlen =3D read_istream(st, buf, sizeof(buf));
+		if (readlen <=3D 0)
+			break;
+		do_write_blocked(buf, readlen);
+	}
+	close_istream(st);
+	if (!readlen)
+		finish_record();
+	return readlen;
+}
+
+/*
  * pax extended header records have the format "%u %s=3D%s\n".  %u con=
tains
  * the size of the whole string (including the %u), the first %s is th=
e
  * keyword, the second one is the value.  This function constructs suc=
h a
@@ -203,7 +241,11 @@ static int write_tar_entry(struct archiver_args *a=
rgs,
 	} else
 		memcpy(header.name, path, pathlen);
=20
-	if (S_ISLNK(mode) || S_ISREG(mode)) {
+	if (S_ISREG(mode) && !args->convert &&
+	    sha1_object_info(sha1, &size) =3D=3D OBJ_BLOB &&
+	    size > big_file_threshold)
+		buffer =3D NULL;
+	else if (S_ISLNK(mode) || S_ISREG(mode)) {
 		enum object_type type;
 		buffer =3D sha1_file_to_archive(args, path, sha1, old_mode, &type, &=
size);
 		if (!buffer)
@@ -235,8 +277,12 @@ static int write_tar_entry(struct archiver_args *a=
rgs,
 	}
 	strbuf_release(&ext_header);
 	write_blocked(&header, sizeof(header));
-	if (S_ISREG(mode) && buffer && size > 0)
-		write_blocked(buffer, size);
+	if (S_ISREG(mode) && size > 0) {
+		if (buffer)
+			write_blocked(buffer, size);
+		else
+			err =3D stream_blocked(sha1);
+	}
 	free(buffer);
 	return err;
 }
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 4d127f1..fe47554 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -134,4 +134,8 @@ test_expect_success 'repack' '
 	git repack -ad
 '
=20
+test_expect_success 'tar achiving' '
+	git archive --format=3Dtar HEAD >/dev/null
+'
+
 test_done
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 527c9e7..d9b997f 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -84,6 +84,12 @@ test_expect_success \
     'git archive vs. git tar-tree' \
     'test_cmp b.tar b2.tar'
=20
+test_expect_success 'git archive on large files' '
+    test_config core.bigfilethreshold 1 &&
+    git archive HEAD >b3.tar &&
+    test_cmp b.tar b3.tar
+'
+
 test_expect_success \
     'git archive in a bare repo' \
     '(cd bare.git && git archive HEAD) >b3.tar'
--=20
1.7.3.1.256.g2539c.dirty
