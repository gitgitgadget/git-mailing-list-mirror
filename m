From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/14] pack v4: split pv4_create_dict() out of load_dict()
Date: Sun,  8 Sep 2013 14:22:27 +0700
Message-ID: <1378624960-8919-2-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:19:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZHd-0003a2-SF
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab3IHHTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:19:42 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:48917 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab3IHHTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:19:41 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so4937806pdj.11
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gxCk0ygIfV2mwzx1IckDmS/WL1PrCf29GfAs9Hh2UHc=;
        b=ieUl2/RKOIWSvKR/CTp/kxOy/4y8s+VhdKq7FKb5OdJdHeTOWqI5zOYOLLv1g5R8Ii
         n1A0wVYMezeo8NNJ6jAVkrKS+P49CjZtRtYweP/GXjXt2XEMNZWWfAfIL7Z3szlxqt4M
         SQamkwHUzd3koQtTjRf2gAc1vbsoJHCYaYMuHRPQkQF+Bag8EJZ7zWUyKasJijULrVkc
         qMSOy4M316PShhoyJFjbWGX0xqJaAD7R7y79fKB9U/uaNsKabI+L4McerBdqoiO5UGWg
         AsT7M6tDYMUJMBTYe7c57+w/oIxTQPEg6YK+PUXOAzGfSwAr2ZpUG9RUuxfy9CQp49kR
         4tYA==
X-Received: by 10.66.231.42 with SMTP id td10mr72506pac.144.1378624780744;
        Sun, 08 Sep 2013 00:19:40 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id gh9sm8413698pbc.40.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:19:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:22:49 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234198>

---
 packv4-parse.c | 63 ++++++++++++++++++++++++++++++++--------------------------
 packv4-parse.h |  8 ++++++++
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index 63bba03..82661ba 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -30,11 +30,38 @@ const unsigned char *get_sha1ref(struct packed_git *p,
 	return sha1;
 }
 
-struct packv4_dict {
-	const unsigned char *data;
-	unsigned int nb_entries;
-	unsigned int offsets[FLEX_ARRAY];
-};
+struct packv4_dict *pv4_create_dict(const unsigned char *data, int dict_size)
+{
+	struct packv4_dict *dict;
+	int i;
+
+	/* count number of entries */
+	int nb_entries = 0;
+	const unsigned char *cp = data;
+	while (cp < data + dict_size - 3) {
+		cp += 2;  /* prefix bytes */
+		cp += strlen((const char *)cp);  /* entry string */
+		cp += 1;  /* terminating NUL */
+		nb_entries++;
+	}
+	if (cp - data != dict_size) {
+		error("dict size mismatch");
+		return NULL;
+	}
+
+	dict = xmalloc(sizeof(*dict) + nb_entries * sizeof(dict->offsets[0]));
+	dict->data = data;
+	dict->nb_entries = nb_entries;
+
+	cp = data;
+	for (i = 0; i < nb_entries; i++) {
+		dict->offsets[i] = cp - data;
+		cp += 2;
+		cp += strlen((const char *)cp) + 1;
+	}
+
+	return dict;
+}
 
 static struct packv4_dict *load_dict(struct packed_git *p, off_t *offset)
 {
@@ -45,7 +72,7 @@ static struct packv4_dict *load_dict(struct packed_git *p, off_t *offset)
 	const unsigned char *cp;
 	git_zstream stream;
 	struct packv4_dict *dict;
-	int nb_entries, i, st;
+	int st;
 
 	/* get uncompressed dictionary data size */
 	src = use_pack(p, &w_curs, curpos, &avail);
@@ -77,32 +104,12 @@ static struct packv4_dict *load_dict(struct packed_git *p, off_t *offset)
 		return NULL;
 	}
 
-	/* count number of entries */
-	nb_entries = 0;
-	cp = data;
-	while (cp < data + dict_size - 3) {
-		cp += 2;  /* prefix bytes */
-		cp += strlen((const char *)cp);  /* entry string */
-		cp += 1;  /* terminating NUL */
-		nb_entries++;
-	}
-	if (cp - data != dict_size) {
-		error("dict size mismatch");
+	dict = pv4_create_dict(data, dict_size);
+	if (!dict) {
 		free(data);
 		return NULL;
 	}
 
-	dict = xmalloc(sizeof(*dict) + nb_entries * sizeof(dict->offsets[0]));
-	dict->data = data;
-	dict->nb_entries = nb_entries;
-
-	cp = data;
-	for (i = 0; i < nb_entries; i++) {
-		dict->offsets[i] = cp - data;
-		cp += 2;
-		cp += strlen((const char *)cp) + 1;
-	}
-
 	*offset = curpos;
 	return dict;
 }
diff --git a/packv4-parse.h b/packv4-parse.h
index 5f9d809..0b2405a 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -1,6 +1,14 @@
 #ifndef PACKV4_PARSE_H
 #define PACKV4_PARSE_H
 
+struct packv4_dict {
+	const unsigned char *data;
+	unsigned int nb_entries;
+	unsigned int offsets[FLEX_ARRAY];
+};
+
+struct packv4_dict *pv4_create_dict(const unsigned char *data, int dict_size);
+
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 		     off_t offset, unsigned long size);
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
-- 
1.8.2.83.gc99314b
