From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/24] nd/untracked-cache updates
Date: Sun,  8 Mar 2015 17:12:23 +0700
Message-ID: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:13:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYCs-0002Dm-PJ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbbCHKNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 06:13:07 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44242 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbCHKNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:13:05 -0400
Received: by pdjz10 with SMTP id z10so36485675pdj.11
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=P3NHA3Q/F0XgM7Rdfp32JNTh0rDS59v/kcrrVax+c2c=;
        b=Lpy4051DZQJ6DL8SSGDpum2W78GtPITUPe1oRx/oEUvn1AkGgx2bj4kuexK3+fnWRX
         YGcC/IExIwuzTgU7OFAvt2q19F3wQC5PC43zke38pN16hLTfBygr76Xfmw0AAoOA4QHW
         nUQg8NwwXsLNQ61M+tvpLkPqYDFYHd/vnzW66IElaIZ114U+n4IKf0AeVbhmW8jsAyRg
         XzLA2FPzqVNGodYA/sYBTlfaJzMgMIgTeLMyDi+Y2B93g3mNigJu8TwQDPeBaGGflc8b
         RoVecvdlqC8VAGcYfUa88sKCguU6yoUeplLjVbY/uGDQ7g4ye2acx9oN7ASy+zPOUQAT
         8J3w==
X-Received: by 10.70.132.71 with SMTP id os7mr33153752pdb.94.1425809584994;
        Sun, 08 Mar 2015 03:13:04 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id g2sm14382136pbw.37.2015.03.08.03.13.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:13:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:13:00 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265053>

Compared to 'pu', this fixes two bugs (in 01/24 and 10/24) and one
style vololation (in 11/24), found by Junio and Stefan. Diff

-- 8< --
diff --git a/dir.c b/dir.c
index b8a4f9e..8a037ee 100644
--- a/dir.c
+++ b/dir.c
@@ -687,7 +687,8 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 			else if (check_index &&
 				 (pos = cache_name_pos(fname, strlen(fname))) >= 0 &&
 				 !ce_stage(active_cache[pos]) &&
-				 ce_uptodate(active_cache[pos]))
+				 ce_uptodate(active_cache[pos]) &&
+				 !would_convert_to_git(fname, NULL, 0, 0))
 				hashcpy(sha1_stat->sha1, active_cache[pos]->sha1);
 			else
 				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
@@ -2308,6 +2309,9 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	strbuf_add(out, untracked->ident.buf, untracked->ident.len);
 
 	strbuf_add(out, ouc, ouc_size(len));
+	free(ouc);
+	ouc = NULL;
+
 	if (!untracked->root) {
 		varint_len = encode_varint(0, varbuf);
 		strbuf_add(out, varbuf, varint_len);
@@ -2388,11 +2392,6 @@ static void stat_data_from_disk(struct stat_data *to, const struct stat_data *fr
 static int read_one_dir(struct untracked_cache_dir **untracked_,
 			struct read_data *rd)
 {
-#define NEXT(x) \
-	next = data + (x); \
-	if (next > rd->end) \
-		return -1;
-
 	struct untracked_cache_dir ud, *untracked;
 	const unsigned char *next, *data = rd->data, *end = rd->end;
 	unsigned int value;
@@ -2419,7 +2418,9 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	data = next;
 
 	len = strlen((const char *)data);
-	NEXT(len + 1);
+	next = data + len + 1;
+	if (next > rd->end)
+		return -1;
 	*untracked_ = untracked = xmalloc(sizeof(*untracked) + len);
 	memcpy(untracked, &ud, sizeof(ud));
 	memcpy(untracked->name, data, len + 1);
@@ -2427,7 +2428,9 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 
 	for (i = 0; i < untracked->untracked_nr; i++) {
 		len = strlen((const char *)data);
-		NEXT(len + 1);
+		next = data + len + 1;
+		if (next > rd->end)
+			return -1;
 		untracked->untracked[i] = xstrdup((const char*)data);
 		data = next;
 	}
-- 8< --
-- 
2.3.0.rc1.137.g477eb31
