From: Timo Sirainen <tss@iki.fi>
Subject: [PATCH 2/3] Use stringbuf to fix buffer overflows due to broken
	use of snprintf()
Date: Sun, 20 May 2007 05:24:39 +0300
Message-ID: <1179627879.32181.1286.camel@hurina>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1Bj6gh88jAWaUJIeRt4N"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 04:58:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpbcQ-0004ge-Dk
	for gcvg-git@gmane.org; Sun, 20 May 2007 04:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759155AbXETC5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 22:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759043AbXETC5s
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 22:57:48 -0400
Received: from dovecot.org ([213.157.71.38]:34754 "EHLO dovecot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758410AbXETC5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 22:57:46 -0400
Received: from [192.168.10.2] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id CB402F0AFA
	for <git@vger.kernel.org>; Sun, 20 May 2007 05:24:39 +0300 (EEST)
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47793>


--=-1Bj6gh88jAWaUJIeRt4N
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

---
 diff.c |   51 ++++++++++++++++++++++-----------------------------
 1 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/diff.c b/diff.c
index 33297aa..4d8f4bc 100644
--- a/diff.c
+++ b/diff.c
@@ -9,6 +9,7 @@
 #include "xdiff-interface.h"
 #include "color.h"
 #include "attr.h"
+#include "str.h"
=20
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1823,14 +1824,14 @@ static void diff_fill_sha1_info(struct diff_filespe=
c *one)
 static void run_diff(struct diff_filepair *p, struct diff_options *o)
 {
 	const char *pgm =3D external_diff();
-	char msg[PATH_MAX*2+300], *xfrm_msg;
+	stringbuf(msg, PATH_MAX*2+300);
+	char *xfrm_msg;
 	struct diff_filespec *one;
 	struct diff_filespec *two;
 	const char *name;
 	const char *other;
 	char *name_munged, *other_munged;
 	int complete_rewrite =3D 0;
-	int len;
=20
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
@@ -1847,30 +1848,26 @@ static void run_diff(struct diff_filepair *p, struc=
t diff_options *o)
 	diff_fill_sha1_info(one);
 	diff_fill_sha1_info(two);
=20
-	len =3D 0;
 	switch (p->status) {
 	case DIFF_STATUS_COPIED:
-		len +=3D snprintf(msg + len, sizeof(msg) - len,
-				"similarity index %d%%\n"
-				"copy from %s\n"
-				"copy to %s\n",
-				(int)(0.5 + p->score * 100.0/MAX_SCORE),
-				name_munged, other_munged);
+		str_printfa(msg, "similarity index %d%%\n"
+			    "copy from %s\n"
+			    "copy to %s\n",
+			    (int)(0.5 + p->score * 100.0/MAX_SCORE),
+			    name_munged, other_munged);
 		break;
 	case DIFF_STATUS_RENAMED:
-		len +=3D snprintf(msg + len, sizeof(msg) - len,
-				"similarity index %d%%\n"
-				"rename from %s\n"
-				"rename to %s\n",
-				(int)(0.5 + p->score * 100.0/MAX_SCORE),
-				name_munged, other_munged);
+		str_printfa(msg, "similarity index %d%%\n"
+			    "rename from %s\n"
+			    "rename to %s\n",
+			    (int)(0.5 + p->score * 100.0/MAX_SCORE),
+			    name_munged, other_munged);
 		break;
 	case DIFF_STATUS_MODIFIED:
 		if (p->score) {
-			len +=3D snprintf(msg + len, sizeof(msg) - len,
-					"dissimilarity index %d%%\n",
-					(int)(0.5 + p->score *
-					      100.0/MAX_SCORE));
+			str_printfa(msg, "dissimilarity index %d%%\n",
+				    (int)(0.5 + p->score *
+					  100.0/MAX_SCORE));
 			complete_rewrite =3D 1;
 			break;
 		}
@@ -1889,19 +1886,15 @@ static void run_diff(struct diff_filepair *p, struc=
t diff_options *o)
 			    (!fill_mmfile(&mf, two) && file_is_binary(two)))
 				abbrev =3D 40;
 		}
-		len +=3D snprintf(msg + len, sizeof(msg) - len,
-				"index %.*s..%.*s",
-				abbrev, sha1_to_hex(one->sha1),
-				abbrev, sha1_to_hex(two->sha1));
+		str_printfa(msg, "index %.*s..%.*s",
+			    abbrev, sha1_to_hex(one->sha1),
+			    abbrev, sha1_to_hex(two->sha1));
 		if (one->mode =3D=3D two->mode)
-			len +=3D snprintf(msg + len, sizeof(msg) - len,
-					" %06o", one->mode);
-		len +=3D snprintf(msg + len, sizeof(msg) - len, "\n");
+			str_printfa(msg, " %06o", one->mode);
+		str_append(msg, "\n");
 	}
=20
-	if (len)
-		msg[--len] =3D 0;
-	xfrm_msg =3D len ? msg : NULL;
+	xfrm_msg =3D str_len(msg) ? str_c(msg) : NULL;
=20
 	if (!pgm &&
 	    DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two) &&
--=20
1.5.1.4



--=-1Bj6gh88jAWaUJIeRt4N
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGT7FnyUhSUUBViskRAgs7AJ9SgY0UH1gd0LsdGMrGo8K34Rp4HwCfT64v
PqdXld5lIYSTcfb6HE8ythE=
=IwiJ
-----END PGP SIGNATURE-----

--=-1Bj6gh88jAWaUJIeRt4N--
