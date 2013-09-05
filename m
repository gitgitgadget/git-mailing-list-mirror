From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 27/38] pack v4: code to obtain a SHA1 from a sha1ref
Date: Thu, 05 Sep 2013 02:19:50 -0400
Message-ID: <1378362001-1738-28-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSwK-00089M-Bx
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569Ab3IEGU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43577 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757354Ab3IEGUU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:20 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00ANX2XQCY00@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id D2DE02DA0613	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:15 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233910>

Let's start actually parsing pack v4 data.  Here's the first item.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 Makefile       |  1 +
 packv4-parse.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 packv4-parse.c

diff --git a/Makefile b/Makefile
index 4716113..ba6cafc 100644
--- a/Makefile
+++ b/Makefile
@@ -838,6 +838,7 @@ LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
+LIB_OBJS += packv4-parse.o
 LIB_OBJS += pager.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += parse-options-cb.o
diff --git a/packv4-parse.c b/packv4-parse.c
new file mode 100644
index 0000000..299fc48
--- /dev/null
+++ b/packv4-parse.c
@@ -0,0 +1,30 @@
+/*
+ * Code to parse pack v4 object encoding
+ *
+ * (C) Nicolas Pitre <nico@fluxnic.net>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "cache.h"
+#include "varint.h"
+
+const unsigned char *get_sha1ref(struct packed_git *p,
+				 const unsigned char **bufp)
+{
+	const unsigned char *sha1;
+
+	if (!**bufp) {
+		sha1 = *bufp + 1;
+		*bufp += 21;
+	} else {
+		unsigned int index = decode_varint(bufp);
+		if (index < 1 || index - 1 > p->num_objects)
+			die("bad index in %s", __func__);
+		sha1 = p->sha1_table + (index - 1) * 20;
+	}
+
+	return sha1;
+}
-- 
1.8.4.38.g317e65b
