From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 3/3] unpack-trees: simplify via strnncmp()
Date: Mon, 16 Jun 2014 12:13:58 -0700
Message-ID: <ee1716e209794a66eb9677e798164a356276700e.1402945507.git.jmmahler@gmail.com>
References: <cover.1402945507.git.jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 21:14:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwcMS-0000v6-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbaFPTO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 15:14:29 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:48794 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602AbaFPTO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 15:14:28 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so1693802pbb.8
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 12:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Gx/uU2MGzwDI1qYlFK/GYKZeD48l0+P3krjxkChqufg=;
        b=DTXbDRUsdRC6CmQ/c/NpCsk8scutuDpF60ino5wRdkXcAT/cYc16+wIFdlmrhj8+gy
         FgvsyzH92AMWQzrp6DEmxOesfpgylW8V5jVw9YPXh/ezn+aZiOSaOWmRLGFsIx0Qe83X
         U69SidlhFDkLK7bLk7lj774CwAY+tf/qHTjbHp9i5uUVdKajObdxANsO/pU7mkcA9gLd
         q9T4QiC8y7yLuKS/3yawo9ibgDOKKcovQGYY7dAwsCZvdF6TuIV7WcCxf6XUExUzKiIe
         Uv80/Acfjd7s4TPKC7qgcPNHFWCvGtxM4JmEs/GYl90lpIk5B4x0iUSWNi4DdWweuYRm
         7vMQ==
X-Received: by 10.68.241.68 with SMTP id wg4mr27024670pbc.66.1402946067724;
        Mon, 16 Jun 2014 12:14:27 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id gu1sm20146809pbd.0.2014.06.16.12.14.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jun 2014 12:14:26 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1402945507.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402945507.git.jmmahler@gmail.com>
References: <cover.1402945507.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251803>

Simplify unpack-trees.c using the strnncmp() function and remove the
name_compare() function.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 unpack-trees.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4a9cdf2..9a71b5a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -629,17 +629,6 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
 	return -1;
 }
 
-/* NEEDSWORK: give this a better name and share with tree-walk.c */
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
 /*
  * The tree traversal is looking at name p.  If we have a matching entry,
  * return it.  If name p is a directory in the index, do not return
@@ -678,7 +667,7 @@ static int find_cache_pos(struct traverse_info *info,
 			ce_len = ce_slash - ce_name;
 		else
 			ce_len = ce_namelen(ce) - pfxlen;
-		cmp = name_compare(p->path, p_len, ce_name, ce_len);
+		cmp = strnncmp(p->path, p_len, ce_name, ce_len);
 		/*
 		 * Exact match; if we have a directory we need to
 		 * delay returning it.
-- 
2.0.0
