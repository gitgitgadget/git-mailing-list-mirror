From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 06/10] add common fsck error printing function
Date: Mon, 25 Feb 2008 22:54:56 +0100
Message-ID: <12039765001192-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002397-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:56:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlIn-0006Td-VZ
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759852AbYBYVz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759849AbYBYVzZ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:55:25 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55609 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759585AbYBYVzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:55:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 04AC3680BF8F;
	Mon, 25 Feb 2008 22:55:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7zs6qOwHAiQe; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 5772C680BF99; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12039765002397-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75077>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 fsck.c |   30 ++++++++++++++++++++++++++++++
 fsck.h |    2 ++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/fsck.c b/fsck.c
index 3ce33ff..a8c24a9 100644
--- a/fsck.c
+++ b/fsck.c
@@ -311,3 +311,33 @@ int fsck_object(struct object *obj, int strict, fsck_error error_func)
 	return error_func(obj, FSCK_ERROR, "unknown type '%d' (internal fsck error)",
 			  obj->type);
 }
+
+int fsck_error_function(struct object *obj, int type, const char* fmt, ...)
+{
+	va_list ap;
+	int len;
+	struct strbuf sb;
+	
+	strbuf_init(&sb, 0);
+	strbuf_addf(&sb, "object %s:", obj->sha1?sha1_to_hex(obj->sha1):"(null)");
+	
+	va_start(ap, fmt);
+	len = vsnprintf(sb.buf + sb.len, strbuf_avail(&sb), fmt, ap);
+	va_end(ap);
+	
+	if (len < 0)
+		len = 0;
+	if (len >= strbuf_avail(&sb)) {
+		strbuf_grow(&sb, len + 2);
+		va_start(ap, fmt);
+		len = vsnprintf(sb.buf + sb.len, strbuf_avail(&sb), fmt, ap);
+		va_end(ap);
+		if (len >= strbuf_avail(&sb)) {
+			die("this should not happen, your snprintf is broken");
+		}
+	}
+	
+	error(sb.buf);
+	strbuf_release(&sb);
+	return 1;
+}
diff --git a/fsck.h b/fsck.h
index a5d60d0..188c84b 100644
--- a/fsck.h
+++ b/fsck.h
@@ -17,6 +17,8 @@ typedef int (*fsck_walk_func)(struct object *obj, int type, void *data);
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
 typedef int (*fsck_error)(struct object *obj, int type, const char *err, ...);
 
+int fsck_error_function(struct object *obj, int type, const char* fmt, ...);
+
 /* descend in all linked child objects
  * the return value is:
  *    -1	error in processing the object
-- 
1.5.4.3.g3c5f
