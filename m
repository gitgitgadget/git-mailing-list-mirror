From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH nd/sparse] Support directory exclusion from index
Date: Sat, 31 Oct 2009 21:09:23 +0700
Message-ID: <1256998163-979-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sat Oct 31 15:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4EeH-0006Si-I1
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 15:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757777AbZJaOJe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Oct 2009 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757774AbZJaOJe
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 10:09:34 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:49653 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757755AbZJaOJd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 10:09:33 -0400
Received: by pxi9 with SMTP id 9so2357220pxi.4
        for <git@vger.kernel.org>; Sat, 31 Oct 2009 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=AGIuViYpDKmPOx+X1y5jFYxCFcAqvhZR5W77PwhCmCo=;
        b=Hq5nON3X71LXe31pSfcUR7ouZmD7UWdUSWrqKCCztlhvEoYWkfCuLbpRNiiCQuLjNR
         XEvNFP+NETyK6e74mx9Bqh57qKCIA3laKzhRDXp7bsHQrwZxG15w7vb2FBhMBMBCtjoJ
         liTPHFYYVHeyneupP9Uj7ptyHXxrckXOEENkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=EkKUhdmBwOFa+xLgxmpfDbXqEbEMXtoBqv/O+8VOUaKz3+xfLbdr61islphsOfoRRB
         3ulKFQrgc2x3gzRRVRjgEHOK/K9sLma85+QKF+R140enMQikvHLUkal3F0Gfu+GtyrGl
         v8x/lzmu/VTd82gHr8bzATClKooJ1jkBVY9ms=
Received: by 10.115.114.7 with SMTP id r7mr3250901wam.72.1256998178630;
        Sat, 31 Oct 2009 07:09:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.200.202])
        by mx.google.com with ESMTPS id 20sm307769pxi.15.2009.10.31.07.09.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Oct 2009 07:09:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 31 Oct 2009 21:09:26 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131844>

The function excluded_from_list (or its public API excluded) is
currently used to mark what entry is included in sparse checkout.
Because index does not have directories, the pattern "foo", while
would match directory "foo" on working directory, would not match
against index.

To overcome this, if a pattern does not match, check if it matches
parent directories too before moving on to the next pattern. This
behavior only applies to index matching.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 There is subtle difference, which might break things. When working
 with file system, it checks top-down, parent directories first.
 I do bottom-up.

 If/you/have/deep/directories sparse checkout may become slow.

 And my test broke :(

 dir.c                                |   24 ++++++++++++++++++++++--
 t/t1009-read-tree-sparse-checkout.sh |    4 ++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 3a8d3e6..82227e5 100644
--- a/dir.c
+++ b/dir.c
@@ -334,13 +334,15 @@ static void prep_exclude(struct dir_struct *dir, =
const char *base, int baselen)
 }
=20
 /* Scan the list and let the last match determine the fate.
+ * dtype =3D=3D NULL means matching against index, not working directo=
ry.
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
-int excluded_from_list(const char *pathname,
-		       int pathlen, const char *basename, int *dtype,
+int excluded_from_list(const char *pathname_,
+		       int pathlen_, const char *basename_, int *dtype,
 		       struct exclude_list *el)
 {
 	int i;
+	char buf[PATH_MAX];
=20
 	if (el->nr) {
 		for (i =3D el->nr - 1; 0 <=3D i; i--) {
@@ -348,6 +350,11 @@ int excluded_from_list(const char *pathname,
 			const char *exclude =3D x->pattern;
 			int to_exclude =3D x->to_exclude;
=20
+			const char *pathname =3D pathname_;
+			const char *basename =3D basename_;
+			int pathlen =3D pathlen_;
+
+recheck:
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
 				if (!dtype) {
 					if (!prefixcmp(pathname, exclude))
@@ -398,6 +405,19 @@ int excluded_from_list(const char *pathname,
 					    return to_exclude;
 				}
 			}
+
+			if (!dtype) { /* matching against index */
+				basename =3D strrchr(pathname, '/');
+				if (basename) {
+					pathlen =3D basename-pathname;
+					memcpy(buf, pathname, pathlen);
+					buf[pathlen] =3D '\0';
+					pathname =3D buf;
+					basename =3D strrchr(pathname, '/');
+					basename =3D (basename) ? basename+1 : pathname;
+					goto recheck;
+				}
+			}
 		}
 	}
 	return -1; /* undecided */
diff --git a/t/t1009-read-tree-sparse-checkout.sh b/t/t1009-read-tree-s=
parse-checkout.sh
index 62246db..b57d237 100755
--- a/t/t1009-read-tree-sparse-checkout.sh
+++ b/t/t1009-read-tree-sparse-checkout.sh
@@ -84,13 +84,13 @@ cat >expected.swt <<EOF
 H init.t
 H sub/added
 EOF
-test_expect_failure 'match directories without trailing slash' '
+test_expect_success 'match directories without trailing slash' '
 	echo init.t > .git/info/sparse-checkout &&
 	echo sub >> .git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
 	git ls-files -t > result &&
 	test_cmp expected.swt result &&
-	test ! -f init.t &&
+	test -f init.t &&
 	test -f sub/added
 '
=20
--=20
1.6.5.2.216.g9c1ec
