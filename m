From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/16] list-files: delete redundant cached entries
Date: Mon,  9 Mar 2015 17:18:33 +0700
Message-ID: <1425896314-10941-16-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:20:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUunW-0002ly-Jc
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbbCIKU0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:20:26 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39621 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbbCIKUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:20:24 -0400
Received: by pabrd3 with SMTP id rd3so38088010pab.6
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cTxKH0dLOS3zstksf0ZqWbRgBf89xKOWHM4gxPtsvOo=;
        b=HZCosD+M/B2keHcUSjqNui1Bcu6DBhHPRZ/E/zRVbvpOjj9QFGNM7AaBUcqNPfLx3o
         rTRfHikapUi2INZZIq3CrzGeeCm65finPANVNsA98xAoze9qYymCiPkdJ+VLT96rf2dm
         PMJ/jVDceNpKubjTOWWYIJxJqQVhJqI4vF+ZXpsHFzAhzI/AHVNU276E9DMZLua633dn
         0IFsG0nFFCSvUDewa/QiqddVsYMjBjOF4tdquQGUEhhi6zCfqzJSp4gSrZ2W2d8+DtaO
         4kGPcR9EvFgLpgsyQELcL20ppTc8k6ZgRV6UXBJS10nSjPzKP2kZJyW3uEpaz02aFzYp
         0ICg==
X-Received: by 10.66.66.230 with SMTP id i6mr51595713pat.108.1425896424424;
        Mon, 09 Mar 2015 03:20:24 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id nw3sm14346558pdb.71.2015.03.09.03.20.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:20:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:20:20 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265157>

When both --cached and one of -amdAMD is used together we may have two
entries of the same path, e.g. "  foo" and "MM foo". In this case it's
pretty clear that "foo" must be tracked, no need to display "   foo".
The new function does that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 74836f6..49fb820 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -153,7 +153,10 @@ static int compare_output(const void *a_, const vo=
id *b_)
 {
 	const struct string_list_item *a =3D a_;
 	const struct string_list_item *b =3D b_;
-	return strcmp(a->util, b->util);
+	int ret =3D strcmp(a->util, b->util);
+	if (ret)
+		return ret;
+	return strncmp(a->string, b->string, 2);
 }
=20
 static void populate_cached_entries(struct string_list *result,
@@ -305,6 +308,34 @@ static void wt_status_populate(struct string_list =
*result,
 	string_list_remove_duplicates(result, 0);
 }
=20
+static void delete_duplicate_cached_entries(struct string_list *result=
)
+{
+	struct string_list_item *src, *dst;
+
+	if (show_unmerged || !show_cached || !show_changed)
+		return;
+
+	src =3D dst =3D result->items;
+	while (src + 1 < result->items + result->nr) {
+		const char *s0 =3D dst->string;
+		const char *s1 =3D src[1].string;
+
+		if (s0[0] =3D=3D ' ' && s0[1] =3D=3D ' ' &&
+		    !strcmp(s0 + 3, s1 + 3)) {
+			src++;
+		} else {
+			dst++;
+			src++;
+		}
+		if (src !=3D dst)
+			*dst =3D *src;
+	}
+	if (src !=3D dst)
+		*dst =3D *src;
+	result->nr =3D dst - result->items;
+
+}
+
 static void cleanup_tags(struct string_list *result)
 {
 	int i, same_1 =3D 1, same_2 =3D 1, pos, len;
@@ -418,6 +449,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	populate_cached_entries(&result, &the_index);
 	wt_status_populate(&result, &the_index);
+	delete_duplicate_cached_entries(&result);
 	cleanup_tags(&result);
 	display(&result);
 	string_list_clear(&result, 0);
--=20
2.3.0.rc1.137.g477eb31
