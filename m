From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/16] list-files: add tag to each entry, filter duplicate tags
Date: Mon,  9 Mar 2015 17:18:22 +0700
Message-ID: <1425896314-10941-5-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:19:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUumy-0002AN-W3
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbbCIKTT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:19:19 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46430 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbbCIKTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:19:17 -0400
Received: by pabli10 with SMTP id li10so71647211pab.13
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lv9PWpSAfjAzMZVwdlJQ4I5eXScEThOCbEfc8xyRbrQ=;
        b=XEJn6+XuNagIhVNEWVOatcgGNRhGUO2kA87uO1OrxHH8o2f8pwN8nDrWPgcttIsTJC
         xKkLR5UEnquF5AYlif9kXa0kd9YlYN991vs42uZsqkghP4ioNrqiPkO9z/v3s/32sNS6
         L+/sNKHIMkw0J8J6OzqPW2BK9pBREw3wXomeoXJIQg9MmIoiUfUId6SHfhOOkLe4zpDg
         wWxi9fMstDI8WCstNrSBgE5zlinEnVm/TdBr09YhYrsOsGk2Voipu1ajT1mYTuow/oQO
         b9t261hC++8JNNAfDJG1Bo92AVjPmgdRSf7Qpk/BUa20jrwNHg3Sre0Hki0TTejmlN6E
         psMw==
X-Received: by 10.66.184.106 with SMTP id et10mr53401595pac.138.1425896356591;
        Mon, 09 Mar 2015 03:19:16 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id ey1sm14463986pdb.30.2015.03.09.03.19.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:19:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:19:11 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265152>

All entry strings start with two-letter tag and a space. If all
entries have the same tags, tags are not displayed.

The outcome before and after this patch is the same. But it will be
useful in future when there are more than one type of entry.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index c444a53..18af65c 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -18,12 +18,16 @@ struct option ls_options[] =3D {
 	OPT_END()
 };
=20
-static void add_one(struct string_list *result, const char *name)
+static void add_one(struct string_list *result, const char *name,
+		    const char *tag)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	struct string_list_item *item;
=20
 	quote_path_relative(name, prefix_length ? prefix : NULL, &sb);
+	strbuf_insert(&sb, 0, "   ", 3);
+	sb.buf[0] =3D tag[0];
+	sb.buf[1] =3D tag[1];
 	item =3D string_list_append(result, strbuf_detach(&sb, NULL));
 	item->util =3D (char *)name;
 }
@@ -42,7 +46,38 @@ static void populate_cached_entries(struct string_li=
st *result,
 				    S_ISGITLINK(ce->ce_mode)))
 			continue;
=20
-		add_one(result, ce->name);
+		add_one(result, ce->name, "  ");
+	}
+}
+
+static void cleanup_tags(struct string_list *result)
+{
+	int i, same_1 =3D 1, same_2 =3D 1, pos, len;
+
+	for (i =3D 1; i < result->nr && (same_1 || same_2); i++) {
+		const char *s0 =3D result->items[i - 1].string;
+		const char *s1 =3D result->items[i].string;
+
+		same_1 =3D same_1 && s0[0] =3D=3D s1[0];
+		same_2 =3D same_2 && s0[1] =3D=3D s1[1];
+	}
+
+	if (same_1 && same_2) {
+		pos =3D 0;
+		len =3D 3;
+	} else if (same_1) {
+		pos =3D 0;
+		len =3D 1;
+	} else if (same_2) {
+		pos =3D 1;
+		len =3D 1;
+	} else
+		return;
+
+	for (i =3D 0; i < result->nr; i++) {
+		char *s =3D result->items[i].string;
+		int length =3D strlen(s);
+		memmove(s + pos, s + pos + len, length - len + 1);
 	}
 }
=20
@@ -93,6 +128,7 @@ int cmd_list_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 		      &pathspec, NULL, NULL);
=20
 	populate_cached_entries(&result, &the_index);
+	cleanup_tags(&result);
 	display(&result);
 	string_list_clear(&result, 0);
 	return 0;
--=20
2.3.0.rc1.137.g477eb31
