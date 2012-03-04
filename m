From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/10] show: use streaming interface for showing blobs
Date: Sun,  4 Mar 2012 19:59:51 +0700
Message-ID: <1330865996-2069-6-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 14:03:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4B5a-0003aH-B9
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 14:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab2CDNCt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 08:02:49 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:42943 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab2CDNCr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 08:02:47 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so3847615dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 05:02:46 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.220.196 as permitted sender) client-ip=10.68.220.196;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.220.196 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.220.196])
        by 10.68.220.196 with SMTP id py4mr37609565pbc.166.1330866166966 (num_hops = 1);
        Sun, 04 Mar 2012 05:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=THkjyzy0anhrr4jTrc/jof4b6dgnKdhuP/RLrP6ovmM=;
        b=ck6/tQgaO7ltu7NaGKj1oDeFkf/QFJZcSQxD0jEl/yC2Fe6e6fF9NrbwNLIgfOhCss
         emB6elxiq9Zc1fP7Yg1b7F7NOdGEmaBDgLvIduOMZ4rOI5ljK/ecWD4zkS8wOF9ZmfbM
         qbSF040Qxq2XFCRD3sdxlxKsTTov6eWIMbj8mjY2igA2aAn/SYH3YBJQfttHoCc/CLq4
         jT4Lo4/70KdkMTwkODnEGjMHR1c7FWLGcOqSAufMY/rx5cRPHFm6O/jFEL2azUPrjoXI
         53DcGdGuIeGecjtCsjEVLos7eZQ67DftQgEpBbCCoxcx+GsyJnQFcLldsyh2P5jkv8Ib
         WJHg==
Received: by 10.68.220.196 with SMTP id py4mr32047420pbc.166.1330866166907;
        Sun, 04 Mar 2012 05:02:46 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.34.94])
        by mx.google.com with ESMTPS id i9sm10445825pba.22.2012.03.04.05.02.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 05:02:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 04 Mar 2012 20:00:40 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192157>


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
index 39a3e77..66acb3b 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -118,7 +118,7 @@ test_expect_success 'cat-file a large file' '
 	git cat-file blob :large1 >/dev/null
 '
=20
-test_expect_failure 'git-show a large file' '
+test_expect_success 'git-show a large file' '
 	git show :large1 >/dev/null
=20
 '
--=20
1.7.8.36.g69ee2
