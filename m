From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/25] list-files: add tag to each entry, filter duplicate tags
Date: Mon,  6 Apr 2015 20:52:16 +0700
Message-ID: <1428328354-14897-8-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:53:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Sw-000561-BP
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbbDFNxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:53:22 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34544 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbbDFNxV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:53:21 -0400
Received: by pdbni2 with SMTP id ni2so45288070pdb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aWRciUKSCLuT7YNe8OaiNdUYzGycdlbw8FeEGZatzWE=;
        b=Ux8L3aHO9N6362iA9UJSLULb5GcfJJDxRtrLbO2unKK3ozcHq7EQUM8EqmTLdoISUw
         UXXfeZOgVmUCqJdglbf1t11M03M7e1bDgGv90+rZo4EA2Sh6DZeQVJHzQeVMRe21OHCf
         0h62Y2hJMJG/xVCasNpBvRbG79hxuJxLYC06oyeUvqeoH2Sg7KHp3S19pNGlkAjO15Bh
         dVJz7yvCGMQpRnAV20DTb3lUC/+h8FfLB7am5QR2fIn/hAirQN0RkIahwX48zV0fwn7F
         zMVepHzG3lR/hN3NFnBtTfRb+A47VpP/2ykO1/OmGwGkZLL+YohmesOGpv5USt/9dJIG
         mRJA==
X-Received: by 10.66.145.2 with SMTP id sq2mr20063311pab.124.1428328401109;
        Mon, 06 Apr 2015 06:53:21 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id zs5sm4840009pac.11.2015.04.06.06.53.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:53:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:53:32 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266851>

All entries have a two-letter tag. If all entries have the same tags,
tags are not displayed.

The outcome before and after this patch is the same. But it will be
useful in future when there are more than one type of entry.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 64 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 51ff19d..ec9ca17 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -12,17 +12,20 @@ enum item_type {
 struct item {
 	enum item_type type;
 	const char *path;
+	char tag[2];
 	const struct cache_entry *ce;
 };
=20
 struct item_list {
 	struct item *items;
 	int nr, alloc;
+	int tag_pos, tag_len;
 };
=20
 static struct pathspec pathspec;
 static const char *prefix;
 static int prefix_length;
+static int show_tag =3D -1;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -30,6 +33,7 @@ static const char * const ls_usage[] =3D {
 };
=20
 struct option ls_options[] =3D {
+	OPT_BOOL(0, "tag", &show_tag, N_("show tags")),
 	OPT_END()
 };
=20
@@ -52,10 +56,61 @@ static void populate_cached_entries(struct item_lis=
t *result,
 		item =3D result->items + result->nr++;
 		item->type =3D FROM_INDEX;
 		item->path =3D ce->name;
+		item->tag[0] =3D ' ';
+		item->tag[1] =3D ' ';
 		item->ce =3D ce;
 	}
 }
=20
+static void cleanup_tags(struct item_list *result)
+{
+	int i, same_1 =3D 1, same_2 =3D 1;
+
+	if (!show_tag) {
+		result->tag_pos =3D 0;
+		result->tag_len =3D 0;
+		return;
+	}
+	if (show_tag > 0) {
+		result->tag_pos =3D 0;
+		result->tag_len =3D 2;
+		return;
+	}
+
+	for (i =3D 1; i < result->nr && (same_1 || same_2); i++) {
+		const char *s0 =3D result->items[i - 1].tag;
+		const char *s1 =3D result->items[i].tag;
+
+		same_1 =3D same_1 && s0[0] =3D=3D s1[0];
+		same_2 =3D same_2 && s0[1] =3D=3D s1[1];
+	}
+
+	if (same_1 && same_2) {
+		result->tag_pos =3D 0;
+		result->tag_len =3D 0;
+	} else if (same_1) {
+		result->tag_pos =3D 1;
+		result->tag_len =3D 1;
+	} else if (same_2) {
+		result->tag_pos =3D 0;
+		result->tag_len =3D 1;
+	} else {
+		result->tag_pos =3D 0;
+		result->tag_len =3D 2;
+	}
+}
+
+/* this is similar to quote_path_relative() except it does not clear s=
b */
+static void quote_item(struct strbuf *out, const struct item *item)
+{
+	static struct strbuf sb =3D STRBUF_INIT;
+	const char *rel;
+
+	strbuf_reset(&sb);
+	rel =3D relative_path(item->path, prefix, &sb);
+	quote_c_style(rel, out, NULL, 0);
+}
+
 static void display(const struct item_list *result)
 {
 	struct strbuf quoted =3D STRBUF_INIT;
@@ -67,7 +122,13 @@ static void display(const struct item_list *result)
 	for (i =3D 0; i < result->nr; i++) {
 		const struct item *item =3D result->items + i;
=20
-		quote_path_relative(item->path, prefix, &quoted);
+		strbuf_reset(&quoted);
+		if (result->tag_len) {
+			strbuf_add(&quoted, item->tag + result->tag_pos,
+				   result->tag_len);
+			strbuf_addch(&quoted, ' ');
+		}
+		quote_item(&quoted, item);
 		printf("%s\n", quoted.buf);
 	}
 	strbuf_release(&quoted);
@@ -108,6 +169,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	memset(&result, 0, sizeof(result));
 	populate_cached_entries(&result, &the_index);
+	cleanup_tags(&result);
 	display(&result);
 	/* free-ing result seems unnecessary */
 	return 0;
--=20
2.3.0.rc1.137.g477eb31
