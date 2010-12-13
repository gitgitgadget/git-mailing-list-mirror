From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] get_sha1_oneline: let callers initialize the commit tips for traverse
Date: Mon, 13 Dec 2010 10:01:14 +0700
Message-ID: <1292209275-17451-2-git-send-email-pclouds@gmail.com>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 04:02:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRygI-0008IJ-8G
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 04:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661Ab0LMDCV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Dec 2010 22:02:21 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41882 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab0LMDCU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 22:02:20 -0500
Received: by pzk6 with SMTP id 6so440938pzk.19
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 19:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CYSWRGxxGT1Dy8QaYi1VdSAmJJxiBE3UV2IU0sSvdb8=;
        b=jJNcBupOkQRZUPrGXDZLib7mPbYcB26mTprZAl2PWGKyTrrZhtqPoSH9MarlVHCDm5
         iizGiQoy6szyq9tFWvSxwFEcro7gjDHq/fNE84POCawHKDTN/mGZFp2u19tv33AmhZA7
         a65XCIr0EFpCG7AhHjjcR0xn2TNHRr4gGx2NM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uOnwe1dDF4NU/Q0o+L9mQYlHijECuwcdgSAdnPspiYqPj7JY4fKWd4rdl8t9MklXrH
         bDjpbSANVQy2wwgvBhwFUhqQb8s5C2K7Sxf6EzFFHxpVRWRyW0PyKKtMtgv9GE3xP0KJ
         JlrMb/svyO97V7tUQy7xqQAMw9wvPmyxRqv6U=
Received: by 10.142.141.14 with SMTP id o14mr2774385wfd.396.1292209340344;
        Sun, 12 Dec 2010 19:02:20 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id x18sm8272909wfa.11.2010.12.12.19.02.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 19:02:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 10:01:25 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163506>

This gives callers more control, i.e. which ref will be searched from.

get_sha1_oneline takes care of ONELINE_SEEN marks (which is now TMP_MAR=
K)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_name.c |   62 +++++++++++++++++++++++++++++++--------------------=
-------
 1 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 13ee6f5..3c2c61c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -6,6 +6,8 @@
 #include "tree-walk.h"
 #include "refs.h"
 #include "remote.h"
+#include "diff.h"
+#include "revision.h"
=20
 static int find_short_object_filename(int len, const char *name, unsig=
ned char *sha1)
 {
@@ -669,30 +671,10 @@ static int get_sha1_1(const char *name, int len, =
unsigned char *sha1)
  * For future extension, ':/!' is reserved. If you want to match a mes=
sage
  * beginning with a '!', you have to repeat the exclamation mark.
  */
-#define ONELINE_SEEN (1u<<20)
-
-static int handle_one_ref(const char *path,
-		const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct commit_list **list =3D cb_data;
-	struct object *object =3D parse_object(sha1);
-	if (!object)
-		return 0;
-	if (object->type =3D=3D OBJ_TAG) {
-		object =3D deref_tag(object, path, strlen(path));
-		if (!object)
-			return 0;
-	}
-	if (object->type !=3D OBJ_COMMIT)
-		return 0;
-	insert_by_date((struct commit *)object, list);
-	object->flags |=3D ONELINE_SEEN;
-	return 0;
-}
-
-static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
+static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
+			    struct commit_list *list)
 {
-	struct commit_list *list =3D NULL, *backup =3D NULL, *l;
+	struct commit_list *backup =3D NULL, *l;
 	int retval =3D -1;
 	char *temp_commit_buffer =3D NULL;
 	regex_t regex;
@@ -706,16 +688,17 @@ static int get_sha1_oneline(const char *prefix, u=
nsigned char *sha1)
 	if (regcomp(&regex, prefix, REG_EXTENDED))
 		die("Invalid search pattern: %s", prefix);
=20
-	for_each_ref(handle_one_ref, &list);
-	for (l =3D list; l; l =3D l->next)
+	for (l =3D list; l; l =3D l->next) {
+		l->item->object.flags |=3D TMP_MARK;
 		commit_list_insert(l->item, &backup);
+	}
 	while (list) {
 		char *p;
 		struct commit *commit;
 		enum object_type type;
 		unsigned long size;
=20
-		commit =3D pop_most_recent_commit(&list, ONELINE_SEEN);
+		commit =3D pop_most_recent_commit(&list, TMP_MARK);
 		if (!parse_object(commit->object.sha1))
 			continue;
 		if (commit->buffer)
@@ -739,7 +722,7 @@ static int get_sha1_oneline(const char *prefix, uns=
igned char *sha1)
 	free(temp_commit_buffer);
 	free_commit_list(list);
 	for (l =3D backup; l; l =3D l->next)
-		clear_commit_marks(l->item, ONELINE_SEEN);
+		clear_commit_marks(l->item, TMP_MARK);
 	free_commit_list(backup);
 	return retval;
 }
@@ -1067,6 +1050,24 @@ int get_sha1_with_mode_1(const char *name, unsig=
ned char *sha1, unsigned *mode,
 	return ret;
 }
=20
+static int handle_one_ref(const char *path,
+		const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct commit_list **list =3D cb_data;
+	struct object *object =3D parse_object(sha1);
+	if (!object)
+		return 0;
+	if (object->type =3D=3D OBJ_TAG) {
+		object =3D deref_tag(object, path, strlen(path));
+		if (!object)
+			return 0;
+	}
+	if (object->type !=3D OBJ_COMMIT)
+		return 0;
+	insert_by_date((struct commit *)object, list);
+	return 0;
+}
+
 int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			    struct object_context *oc,
 			    int gently, const char *prefix)
@@ -1089,9 +1090,12 @@ int get_sha1_with_context_1(const char *name, un=
signed char *sha1,
 		int stage =3D 0;
 		struct cache_entry *ce;
 		int pos;
-		if (namelen > 2 && name[1] =3D=3D '/')
+		if (namelen > 2 && name[1] =3D=3D '/') {
+			struct commit_list *list =3D NULL;
+			for_each_ref(handle_one_ref, &list);
 			/* don't need mode for commit */
-			return get_sha1_oneline(name + 2, sha1);
+			return get_sha1_oneline(name + 2, sha1, list);
+		}
 		if (namelen < 3 ||
 		    name[2] !=3D ':' ||
 		    name[1] < '0' || '3' < name[1])
--=20
1.7.3.3.476.g10a82
