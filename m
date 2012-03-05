From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/11] show: use streaming interface for showing blobs
Date: Mon,  5 Mar 2012 10:43:42 +0700
Message-ID: <1330919028-6611-6-git-send-email-pclouds@gmail.com>
References: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 04:45:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Or6-0003n2-4k
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 04:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab2CEDo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 22:44:56 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:52615 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab2CEDoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 22:44:55 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so4472065dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 19:44:55 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.125.196 as permitted sender) client-ip=10.68.125.196;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.125.196 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.125.196])
        by 10.68.125.196 with SMTP id ms4mr41296766pbb.131.1330919095089 (num_hops = 1);
        Sun, 04 Mar 2012 19:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+QWT5DJBlWQlQ2xO/eC/u1v9PBwGxQrGE9+7qKcUT44=;
        b=Iv7g9gbeT+6bGC+6khuu77Pq44vOA4oY+9ZoPsggO4xX8RTGHILksEIlte5c8ekcZG
         yDcaeTzHiTga2K3YEfHmFFhnwaq5JqpMJRROT5qjeJETJhHSn6waIaR7LrGw1zO7JI6o
         3YEBZl4NWIsQB7GqkPPfV2LjNZ1v6sCs+e8drYeN82qYFXTRNzS5AXkVJf7Nsc17Bm4U
         QaQh2LtrYivxWy8CPOWYYtf3+GfXo39+G8uUTQM8Cw2xr4rVpBOHertq+c4sR0vL2sKh
         7JjKI47BZ4WF1QCs7GPT3mtoLoP5WWRCOpcu1VY9LVRF0Aj7Xyh6aLpCFDd9MQXIWM5U
         Wg9Q==
Received: by 10.68.125.196 with SMTP id ms4mr35328684pbb.131.1330919095049;
        Sun, 04 Mar 2012 19:44:55 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id f9sm12087615pbq.60.2012.03.04.19.44.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 19:44:53 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 05 Mar 2012 10:44:29 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192197>


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
index 97ad5b3..4e08e02 100755
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
1.7.3.1.256.g2539c.dirty
