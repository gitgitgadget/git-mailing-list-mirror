From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/14] index-pack: do not allocate buffer for unpacking deltas in the first pass
Date: Sun,  8 Sep 2013 14:22:31 +0700
Message-ID: <1378624960-8919-6-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:20:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZI4-0003tn-KG
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814Ab3IHHUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:06 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:49354 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:20:05 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so4961596pdj.15
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QlDj53b65zvtQg7LLY2VWnHURJjsAgtKpHuWsuhdEow=;
        b=Q7kHTElJksEqx2CauBLX3kwJHMNJp52JajNUl1QmUvVnG5SbU8mPp532+lDyTSGEqQ
         ALTVJSvCxFSQy/oljjo2AUOb2vwVg4snTWcbvX5c9OTQID3fslZQGE4wHpOGhcIGj52z
         GkbLb3FTPrzBrPQmst8GncAZANJtas30LqWxZ3m6Hipgnw6PkebiqrskGxGy+wPNOPpv
         cQUP0cCe8LI30LpwtFGxnOYGE5Xcjx+ltTBqAEjU13dNl062deCRRkyqHzU60txnuRjh
         1v/rQfV9FNitRKvW65UfK66unjkL7USLuuFQALQ3PxUwWD2kZEbgGbDe7VXe0jaEGbaO
         jPOA==
X-Received: by 10.68.234.165 with SMTP id uf5mr12358699pbc.41.1378624804590;
        Sun, 08 Sep 2013 00:20:04 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id ib9sm8411528pbc.43.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:20:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:13 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234202>

We do need deltas until the second pass. Allocating a buffer for it
then freeing later is wasteful is unnecessary. Make it use fixed_buf
(aka large blob code path).
---
 builtin/index-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5fbd517..78554d0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -453,7 +453,8 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size,
 		git_SHA1_Update(&c, hdr, hdrlen);
 	} else
 		sha1 = NULL;
-	if (type == OBJ_BLOB && size > big_file_threshold)
+	if (is_delta_type(type) ||
+	     (type == OBJ_BLOB && size > big_file_threshold))
 		buf = fixed_buf;
 	else
 		buf = xmalloc(size);
-- 
1.8.2.83.gc99314b
