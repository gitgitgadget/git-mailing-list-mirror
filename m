From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 2/3] tree-walk: simplify via strnncmp()
Date: Mon, 16 Jun 2014 12:13:57 -0700
Message-ID: <571d131f6ebeadb33999fe086656cb642710fb6f.1402945507.git.jmmahler@gmail.com>
References: <cover.1402945507.git.jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 21:14:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwcMS-0000v6-84
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbaFPTO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 15:14:26 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:54920 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602AbaFPTOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 15:14:25 -0400
Received: by mail-pd0-f173.google.com with SMTP id r10so4732314pdi.32
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lW8iszM0Pj3DJByNv4jHBZtb9x7wmDZsBFM4DXqnOZU=;
        b=lr6L61WWf9NSg/T5mcbbWROoJikOMdW0SXr6UCLBygRGzalprENh9jI3TM2/5c04XM
         MR33jaQbA37I4Um4t2x/taybLoeOgxFhiKKIhMKDdQsUJgaZAIvQe2WLPszIhEYo7f/A
         bNN6nOFQObVQN9QFq0Jwr9vlwwGxAJpiGPY7MGIZhfxmcbVNprVgYwRL0djXwuITORsy
         +RERwejugM6REHzLom7Yxqwufhr89+xT5LsvQ551Fr5IZA9DG1Ut+RUTwW/sPAacnpzh
         jKl4zitiAwVajxDtd9Si3ow2MDz9IeAszC6Rqreu0w9vLwPpenKdG+bhhek+8yv2fmez
         fWhA==
X-Received: by 10.66.131.39 with SMTP id oj7mr26570557pab.20.1402946064892;
        Mon, 16 Jun 2014 12:14:24 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id og3sm20127873pbc.48.2014.06.16.12.14.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jun 2014 12:14:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1402945507.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402945507.git.jmmahler@gmail.com>
References: <cover.1402945507.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251802>

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
2.0.0
