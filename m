From: tboegi@web.de
Subject: [PATCH v6 10/10] ce_compare_data() did not respect conversion
Date: Fri, 22 Apr 2016 16:53:57 +0200
Message-ID: <1461336837-5380-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:50:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcPE-0003Or-4W
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbcDVOt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 10:49:58 -0400
Received: from mout.web.de ([212.227.17.11]:56422 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbcDVOty (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:49:54 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MfHk6-1b46oD1yh8-00OpPe; Fri, 22 Apr 2016 16:49:47
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:CJBGuCL8AzD9qNEEXMAfGwSN2+/8JttDy3Tq1qoHORJWlD6pzrr
 +QHnUYuSdtes66X/qnELtNC+cJp2k5291L6WdmyPFA7qsHADqshlCP+BTba3Tjuz/wYE+fP
 EZaf94N44X/uBQhGQgxHNS9L4icQiTvOhybXBOn5+6d9QmhMV4Ao0Lct9Wjwy+CDyKdWsBg
 pH6MggPC4COv7G2mfcTAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ztkeeRt4rIc=:tXgaWqNytS5NzEcbQKlYLL
 iHbM2QHIIL00DwkslbUXraARX/EFFyUyhZ+nt8p+HQsYwZNN8IB63zGe+jaOEDGGXWwKl1Wx/
 hDGayaFZkVHu3Oo/0piTA5g1emhIoCb9ddsUYO7V9mFldPcAEZdjPCS0+L6V/WRJpQVSw+sIn
 f5++PGBdeO0XtERQb7CnKIXdGES2RHOxhSbSfbhSK8wv7vn9KNDtdr5IF40Vgs3DpbeySKAY5
 Ds5gU54JsBwykd+jMZMkc1yr6HMgjUXao1wAyMv7mVncUcBC321VJXNKOId/t8zumrpDCHqye
 FPx2pStcCluGsHDeF1O4rFnBDyZwfxocBfDED8dsKTi5tnFwulXZXf+jB/vZDBz3d37YsIGSi
 T2etTsWzRf6uqynesI9RfX/Iy0oftJN2mw4lXAOJP5+/JnExL9VZM7EpfaWX40tGZbeCqQZ0Z
 sEQPrq+CPhNoaXpT+63FPa2vtxMfYbbZlZpb3mjXBMiWsSejhAsfc4BCXP88KPwqtrpuduUW1
 uT7qS7jcLiHZDNMq1RhkozdL3VjpKO2LS3TAhdITRYg6Ow66Uwng49C9YInrjA1vYB+kpYiQR
 xKUjo6rAnmS0ajJwpCZcBOyojfKrHh0x+EvJMBHS7lRfBLExIDVZVOp6Iysm2C57Uwg2FGlQO
 jgj9JFkpEuUS0T19JZG9OdNb3s3tRhC+0zV0U/VSteMDSr7kxNTOIUoMXYOFE3qE46HI2MHRe
 ziBM/t96m39kajDJ5Vrvq9bdJnqy4G8vsPP4BBdif5lSgZJmyuFsjzCTDUbcp6zUMXM9F4db 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292215>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

We define the working tree file is clean if either:

  * the result of running convert_to_git() on the working tree
    contents matches what is in the index (because that would mean
    doing another "git add" on the path is a no-op); OR

  * the result of running convert_to_working_tree() on the content
    in the index matches what is in the working tree (because that
    would mean doing another "git checkout -f" on the path is a
    no-op).

Add an extra check in ce_compare_data() in read_cache.c.

When a file has CRLF in the index, and is checked out into the working =
tree,
but left unchabged, it is not normalized at the next commit.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 read-cache.c               | 61 ++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t6038-merge-text-auto.sh | 14 +++++------
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a3ef967..48c4b31 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,17 +156,78 @@ void fill_stat_cache_info(struct cache_entry *ce,=
 struct stat *st)
 		ce_mark_uptodate(ce);
 }
=20
+/*
+ * Compare the data in buf with the data in the file pointed by fd and
+ * return 0 if they are identical, and non-zero if they differ.
+ */
+static int compare_with_fd(const char *input, ssize_t len, int fd)
+{
+	for (;;) {
+		char buf[1024 * 16];
+		ssize_t chunk_len, read_len;
+
+		chunk_len =3D sizeof(buf) < len ? sizeof(buf) : len;
+		read_len =3D xread(fd, buf, chunk_len ? chunk_len : 1);
+
+		if (!read_len)
+			/* EOF on the working tree file */
+			return !len ? 0 : -1;
+
+		if (!len)
+			/* we expected there is nothing left */
+			return -1;
+
+		if (memcmp(buf, input, read_len))
+			return -1;
+		input +=3D read_len;
+		len -=3D read_len;
+	}
+}
+
 static int ce_compare_data(const struct cache_entry *ce, struct stat *=
st)
 {
 	int match =3D -1;
 	int fd =3D open(ce->name, O_RDONLY);
=20
+	/*
+	 * Would another "git add" on the path change what is in the
+	 * index for the path?
+	 */
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
 			match =3D hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
+	if (!match)
+		return match;
+
+	/*
+	 * Would another "git checkout -f" out of the index change
+	 * what is in the working tree file?
+	 */
+	fd =3D open(ce->name, O_RDONLY);
+	if (fd >=3D 0) {
+		enum object_type type;
+		unsigned long size_long;
+		void *data =3D read_sha1_file(ce->sha1, &type, &size_long);
+
+		if (type =3D=3D OBJ_BLOB) {
+			struct strbuf worktree =3D STRBUF_INIT;
+			if (convert_to_working_tree(ce->name, data,
+						    size_long,
+						    &worktree)) {
+				size_t size;
+				free(data);
+				data =3D strbuf_detach(&worktree, &size);
+				size_long =3D size;
+			}
+			if (!compare_with_fd(data, size_long, fd))
+				match =3D 0;
+		}
+		free(data);
+		close(fd);
+	}
 	return match;
 }
=20
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 0108ead..565daf3 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -108,9 +108,9 @@ test_expect_success 'Merge addition of text=3Dauto'=
 '
=20
 test_expect_success 'Detect CRLF/LF conflict after setting text=3Dauto=
' '
 	echo "<<<<<<<" >expected &&
-	echo first line | append_cr >>expected &&
-	echo same line | append_cr >>expected &&
-	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
+	echo first line >>expected &&
+	echo same line >>expected &&
+	echo =3D=3D=3D=3D=3D=3D=3D >>expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
 	echo ">>>>>>>" >>expected &&
@@ -121,14 +121,13 @@ test_expect_success 'Detect CRLF/LF conflict afte=
r setting text=3Dauto' '
 	fuzz_conflict file >file.fuzzy &&
 	compare_files expected file.fuzzy
 '
-
 test_expect_success 'Detect LF/CRLF conflict from addition of text=3Da=
uto' '
 	echo "<<<<<<<" >expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
-	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
-	echo first line | append_cr >>expected &&
-	echo same line | append_cr >>expected &&
+	echo =3D=3D=3D=3D=3D=3D=3D  >>expected &&
+	echo first line >>expected &&
+	echo same line  >>expected &&
 	echo ">>>>>>>" >>expected &&
 	git config merge.renormalize false &&
 	rm -f .gitattributes &&
@@ -138,6 +137,7 @@ test_expect_success 'Detect LF/CRLF conflict from a=
ddition of text=3Dauto' '
 	compare_files expected file.fuzzy
 '
=20
+
 test_expect_failure 'checkout -m after setting text=3Dauto' '
 	cat <<-\EOF >expected &&
 	first line
--=20
2.8.0.rc2.2.g1a4d45a.dirty
