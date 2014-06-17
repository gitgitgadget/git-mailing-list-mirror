From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 3/3] unpack-trees: simplify via strnncmp()
Date: Tue, 17 Jun 2014 00:34:39 -0700
Message-ID: <38ee9a9fac6aa861d18d6f756f48dc9df1ac19b1.1402990051.git.jmmahler@gmail.com>
References: <cover.1402990051.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 09:35:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwnvZ-0004Gd-G1
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 09:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbaFQHfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 03:35:25 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38535 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbaFQHfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 03:35:24 -0400
Received: by mail-pa0-f53.google.com with SMTP id ey11so1936121pad.26
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=W7VYs2noInD77CMm1eeXosC2UY/3P82hR3BrhXeYMdE=;
        b=xrOyrSrTomOHRIjY6FviKvqlEYeJFv0Z7N4P7C5aEerRfN7bq/Ua3llV141ASzbUQm
         RXOOX6PdLpzgYr6VPe1OcGVLr1U4xUhvPpT5WUx3Wxdvc9f6alGQKQHLuNDQ0PPHjfom
         AM5Gb9w9U2YeKnaaYl1bXw70NArfdbaYF1oP2ZbAopCmEjLNSPp0nF3yLh+yveXYBEYN
         wRkspTLoILAFR06knY+Dvqh+9AgdgESF39tfaybW0BE9ZjvO1zejO5IBIUqjVDxXyhFq
         0m5TscGYpij1yMre8Cv6A+/dszGbKZOQMK/81+36ph5JDo9JJ8WZV8WAi+G/QrOWbVpL
         jLAg==
X-Received: by 10.66.120.99 with SMTP id lb3mr30768818pab.2.1402990523962;
        Tue, 17 Jun 2014 00:35:23 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id dz4sm80834221pab.47.2014.06.17.00.35.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 00:35:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.695.g38ee9a9
In-Reply-To: <cover.1402990051.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402990051.git.jmmahler@gmail.com>
References: <cover.1402990051.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251850>

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
2.0.0.695.g38ee9a9
