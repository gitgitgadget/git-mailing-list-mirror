From: Timo Sirainen <tss@iki.fi>
Subject: [PATCH 3/3] Use stringbuf to clean up some string handling code.
Date: Sun, 20 May 2007 05:25:42 +0300
Message-ID: <1179627942.32181.1288.camel@hurina>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cl/WODKey1YbAB7z6+9U"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 04:58:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpbcQ-0004ge-UB
	for gcvg-git@gmane.org; Sun, 20 May 2007 04:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758823AbXETC5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 22:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759102AbXETC5t
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 22:57:49 -0400
Received: from dovecot.org ([213.157.71.38]:34755 "EHLO dovecot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758630AbXETC5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 22:57:46 -0400
Received: from [192.168.10.2] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id A02A0F0B65
	for <git@vger.kernel.org>; Sun, 20 May 2007 05:25:42 +0300 (EEST)
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47792>


--=-cl/WODKey1YbAB7z6+9U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

---
 commit.c      |   30 +++++++++++++-----------------
 local-fetch.c |   34 ++++++++++++++++------------------
 2 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/commit.c b/commit.c
index bee066f..58f1718 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "interpolate.h"
 #include "diff.h"
 #include "revision.h"
+#include "str.h"
=20
 int save_commit_buffer =3D 1;
=20
@@ -821,7 +822,7 @@ static long format_commit_message(const struct
commit *commit,
 		ILEFT_RIGHT,
 	};
 	struct commit_list *p;
-	char parents[1024];
+	stringbuf(parents, 1024);
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
=20
@@ -853,22 +854,17 @@ static long format_commit_message(const struct
commit *commit,
 			 ? "<"
 			 : ">");
=20
-	parents[1] =3D 0;
-	for (i =3D 0, p =3D commit->parents;
-			p && i < sizeof(parents) - 1;
-			p =3D p->next)
-		i +=3D snprintf(parents + i, sizeof(parents) - i - 1, " %s",
-			sha1_to_hex(p->item->object.sha1));
-	interp_set_entry(table, IPARENTS, parents + 1);
-
-	parents[1] =3D 0;
-	for (i =3D 0, p =3D commit->parents;
-			p && i < sizeof(parents) - 1;
-			p =3D p->next)
-		i +=3D snprintf(parents + i, sizeof(parents) - i - 1, " %s",
-			find_unique_abbrev(p->item->object.sha1,
-				DEFAULT_ABBREV));
-	interp_set_entry(table, IPARENTS_ABBREV, parents + 1);
+	str_c(parents)[1] =3D 0;
+	for (p =3D commit->parents; p; p =3D p->next)
+		str_printfa(parents, " %s", sha1_to_hex(p->item->object.sha1));
+	interp_set_entry(table, IPARENTS, str_c(parents) + 1);
+
+	str_c(parents)[1] =3D 0;
+	for (p =3D commit->parents; p; p =3D p->next)
+		str_printfa(parents, " %s",
+			    find_unique_abbrev(p->item->object.sha1,
+					       DEFAULT_ABBREV));
+	interp_set_entry(table, IPARENTS_ABBREV, str_c(parents) + 1);
=20
 	for (i =3D 0, state =3D HEADER; msg[i] && state < BODY; i++) {
 		int eol;
diff --git a/local-fetch.c b/local-fetch.c
index 4b650ef..6d0599f 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "fetch.h"
+#include "str.h"
=20
 static int use_link;
 static int use_symlink;
@@ -21,12 +22,11 @@ static struct packed_git *packs;
 static void setup_index(unsigned char *sha1)
 {
 	struct packed_git *new_pack;
-	char filename[PATH_MAX];
-	strcpy(filename, path);
-	strcat(filename, "/objects/pack/pack-");
-	strcat(filename, sha1_to_hex(sha1));
-	strcat(filename, ".idx");
-	new_pack =3D parse_pack_index_file(sha1, filename);
+	stringbuf(filename, PATH_MAX);
+
+	str_printfa(filename, "%s/objects/pack/pack-%s.idx",
+		    path, sha1_to_hex(sha1));
+	new_pack =3D parse_pack_index_file(sha1, str_c(filename));
 	new_pack->next =3D packs;
 	packs =3D new_pack;
 }
@@ -35,10 +35,11 @@ static int setup_indices(void)
 {
 	DIR *dir;
 	struct dirent *de;
-	char filename[PATH_MAX];
+	stringbuf(filename, PATH_MAX);
 	unsigned char sha1[20];
-	sprintf(filename, "%s/objects/pack/", path);
-	dir =3D opendir(filename);
+
+	str_printfa(filename, "%s/objects/pack/", path);
+	dir =3D opendir(str_c(filename));
 	if (!dir)
 		return -1;
 	while ((de =3D readdir(dir)) !=3D NULL) {
@@ -137,20 +138,17 @@ static int fetch_pack(const unsigned char *sha1)
 static int fetch_file(const unsigned char *sha1)
 {
 	static int object_name_start =3D -1;
-	static char filename[PATH_MAX];
+	static stringbuf(filename, PATH_MAX);
 	char *hex =3D sha1_to_hex(sha1);
 	char *dest_filename =3D sha1_file_name(sha1);
=20
  	if (object_name_start < 0) {
-		strcpy(filename, path); /* e.g. git.git */
-		strcat(filename, "/objects/");
-		object_name_start =3D strlen(filename);
+		str_printfa(filename, "%s/objects/", path); /* e.g. git.git */
+		object_name_start =3D str_len(filename);
 	}
-	filename[object_name_start+0] =3D hex[0];
-	filename[object_name_start+1] =3D hex[1];
-	filename[object_name_start+2] =3D '/';
-	strcpy(filename + object_name_start + 3, hex + 2);
-	return copy_file(filename, dest_filename, hex, 0);
+	str_truncate(filename, object_name_start);
+	str_printfa(filename, "%c%c/%s", hex[0], hex[1], hex + 2);
+	return copy_file(str_c(filename), dest_filename, hex, 0);
 }
=20
 int fetch(unsigned char *sha1)
--=20
1.5.1.4


--=-cl/WODKey1YbAB7z6+9U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGT7GmyUhSUUBViskRAkTFAJ98XQi/JET0ZI9r4ns/8+yni+wolQCghzmX
hkt3txBv4ywW6mwQBYFJtV4=
=tsuk
-----END PGP SIGNATURE-----

--=-cl/WODKey1YbAB7z6+9U--
