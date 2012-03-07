From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] show: use streaming API for showing blobs
Date: Wed,  7 Mar 2012 17:54:19 +0700
Message-ID: <1331117661-19378-6-git-send-email-pclouds@gmail.com>
References: <7vty21twqc.fsf@alter.siamese.dyndns.org>
 <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 11:53:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5EUz-0003DF-0d
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 11:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab2CGKxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 05:53:30 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41429 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433Ab2CGKx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 05:53:28 -0500
Received: by pbcun15 with SMTP id un15so415256pbc.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 02:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bdZuhX1mECLXW2Lg/8sSFSMu49k51xBZBSQ/kF23LQw=;
        b=DAlCroGmOYyWkjzqSDTyfhXMLkFD51izEZYcn0cqrfJZjUUZr44W6I4pHQUfz1SRUO
         gTM5gyHHTXWL6Moqa/9bUPM4tKaHnFIrci8nMuWsJibMO3gOy1gVXIzdVuQIQ9ky8w55
         lh6EvLzFRNCEFd1728JFhORM3uzLUgd9xXGGItpM7hSaUY7z6/jpMxXEwYzMW6GRu+8C
         At1NLOJBVBSj2+mS5ZFqy/ePIGzbSabXwhjIJmYyNi1Lmwch++7bE+YDWfc6G4iyhisf
         ahfUI+cx+9Lb1wTxNMBizQPDwIMFwd0pOIomKIXAYYFfVTd4nyK8CDkHbpnL/papOfah
         3cZA==
Received: by 10.68.244.33 with SMTP id xd1mr2968674pbc.128.1331117607237;
        Wed, 07 Mar 2012 02:53:27 -0800 (PST)
Received: from tre ([115.74.59.10])
        by mx.google.com with ESMTPS id o7sm592358pbq.8.2012.03.07.02.53.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 02:53:26 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 07 Mar 2012 17:54:57 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192440>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c    |   34 ++++++++++++++++++++--------------
 t/t1050-large.sh |    2 +-
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7d1f6f8..d1702e7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -20,6 +20,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 #include "branch.h"
+#include "streaming.h"
=20
 /* Set a default date-time format for git log ("log.date" config varia=
ble) */
 static const char *default_date_mode =3D NULL;
@@ -381,8 +382,13 @@ static void show_tagger(char *buf, int len, struct=
 rev_info *rev)
 	strbuf_release(&out);
 }
=20
-static int show_object(const unsigned char *sha1, int show_tag_object,
-	struct rev_info *rev)
+static int show_blob_object(const unsigned char *sha1, struct rev_info=
 *rev)
+{
+	fflush(stdout);
+	return stream_blob_to_fd(1, sha1, NULL, 0);
+}
+
+static int show_tag_object(const unsigned char *sha1, struct rev_info =
*rev)
 {
 	unsigned long size;
 	enum object_type type;
@@ -392,16 +398,16 @@ static int show_object(const unsigned char *sha1,=
 int show_tag_object,
 	if (!buf)
 		return error(_("Could not read object %s"), sha1_to_hex(sha1));
=20
-	if (show_tag_object)
-		while (offset < size && buf[offset] !=3D '\n') {
-			int new_offset =3D offset + 1;
-			while (new_offset < size && buf[new_offset++] !=3D '\n')
-				; /* do nothing */
-			if (!prefixcmp(buf + offset, "tagger "))
-				show_tagger(buf + offset + 7,
-					    new_offset - offset - 7, rev);
-			offset =3D new_offset;
-		}
+	assert(type =3D=3D OBJ_TAG);
+	while (offset < size && buf[offset] !=3D '\n') {
+		int new_offset =3D offset + 1;
+		while (new_offset < size && buf[new_offset++] !=3D '\n')
+			; /* do nothing */
+		if (!prefixcmp(buf + offset, "tagger "))
+			show_tagger(buf + offset + 7,
+				    new_offset - offset - 7, rev);
+		offset =3D new_offset;
+	}
=20
 	if (offset < size)
 		fwrite(buf + offset, size - offset, 1, stdout);
@@ -459,7 +465,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 		const char *name =3D objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
-			ret =3D show_object(o->sha1, 0, NULL);
+			ret =3D show_blob_object(o->sha1, NULL);
 			break;
 		case OBJ_TAG: {
 			struct tag *t =3D (struct tag *)o;
@@ -470,7 +476,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					t->tag,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			ret =3D show_object(o->sha1, 1, &rev);
+			ret =3D show_tag_object(o->sha1, &rev);
 			rev.shown_one =3D 1;
 			if (ret)
 				break;
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index f662fef..dd1bb84 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -125,7 +125,7 @@ test_expect_success 'cat-file a large file from a t=
ag' '
 	git cat-file blob largefiletag >/dev/null
 '
=20
-test_expect_failure 'git-show a large file' '
+test_expect_success 'git-show a large file' '
 	git show :large1 >/dev/null
=20
 '
--=20
1.7.8.36.g69ee2
