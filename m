From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 2/3] tree-walk: simplify via strnncmp()
Date: Tue, 17 Jun 2014 00:34:38 -0700
Message-ID: <dc427309f0c47c87f4783a3197aa6508f611bcb9.1402990051.git.jmmahler@gmail.com>
References: <cover.1402990051.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 09:35:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwnvU-000486-VQ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 09:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbaFQHfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 03:35:22 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:62090 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbaFQHfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 03:35:20 -0400
Received: by mail-pb0-f45.google.com with SMTP id rr13so2839612pbb.32
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tLAUz6HxAR1tL7MYsrXtjZ0xlEQKJ2+Uv9qiwNikVss=;
        b=kiv+cz44OEgR+ozEAuylVu+AmJ05/kh97sYhEGicuPwFXy3heIZUluJiD2HyUL49xg
         cLP7FI/NF0b0QaFm2CMBggzbIUmykmWY/YmZBYurPjgXHt2hQJIsc9oU6NAeoKukh1LI
         oKz9yVKEJEbVL0DhK23ZbTjADKxv77kYWn7QOm63bc+fjZpDpaBEaaCirynZ1aWa+Ajv
         JTbKiI4jwFkl2Z8a4VI7Tcan3nKVGQ4GG0o7QKkJvLs/MIByjWlz/f2DHV05ZrN9BCP/
         mNis9L2GN+thFIfJb/ifnrq/dN4pZQkxRGYcv5EiBkBLVr3HS8Bh10X+hgK/bXFTASuH
         N7hw==
X-Received: by 10.68.201.97 with SMTP id jz1mr30898642pbc.26.1402990520115;
        Tue, 17 Jun 2014 00:35:20 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ao4sm22459432pbc.51.2014.06.17.00.35.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 00:35:19 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.695.g38ee9a9
In-Reply-To: <cover.1402990051.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402990051.git.jmmahler@gmail.com>
References: <cover.1402990051.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251849>

Simplify tree-walk.c using the strnncmp() function and remove the
name_compare() function.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 tree-walk.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 4dc86c7..efbd3b7 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -144,16 +144,6 @@ struct tree_desc_x {
 	struct tree_desc_skip *skip;
 };
 
-static int name_compare(const char *a, int a_len,
-			const char *b, int b_len)
-{
-	int len = (a_len < b_len) ? a_len : b_len;
-	int cmp = memcmp(a, b, len);
-	if (cmp)
-		return cmp;
-	return (a_len - b_len);
-}
-
 static int check_entry_match(const char *a, int a_len, const char *b, int b_len)
 {
 	/*
@@ -174,7 +164,7 @@ static int check_entry_match(const char *a, int a_len, const char *b, int b_len)
 	 * scanning further.
 	 */
 
-	int cmp = name_compare(a, a_len, b, b_len);
+	int cmp = strnncmp(a, a_len, b, b_len);
 
 	/* Most common case first -- reading sync'd trees */
 	if (!cmp)
@@ -369,7 +359,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 				first_len = len;
 				continue;
 			}
-			if (name_compare(e->path, len, first, first_len) < 0) {
+			if (strnncmp(e->path, len, first, first_len) < 0) {
 				first = e->path;
 				first_len = len;
 			}
@@ -383,7 +373,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 				if (!e->path)
 					continue;
 				len = tree_entry_len(e);
-				if (name_compare(e->path, len, first, first_len))
+				if (strnncmp(e->path, len, first, first_len))
 					entry_clear(e);
 			}
 		}
-- 
2.0.0.695.g38ee9a9
