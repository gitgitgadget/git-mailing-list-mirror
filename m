From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH 1/2] Ignore trailing slash in mkdir() on platforms that can't deal with this
Date: Fri, 24 Aug 2012 12:31:03 +0200
Message-ID: <003101cd81e3$90574490$b105cdb0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 12:31:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4rAg-0002qn-0c
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 12:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab2HXKbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 06:31:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52172 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab2HXKbO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 06:31:14 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LyBCX-1Th9tt1h5R-015d3w; Fri, 24 Aug 2012 12:31:12 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2B34sGS/wxixwlQMe53xFDpLsqPg==
Content-Language: de
X-Provags-ID: V02:K0:sjXFN2ORH2Hk0FeV5wwycTEW2+iEs+zDKlQue5tslaC
 5hRWirzJ7DgeM2z9iNV3ZJBBeeydWNnahBGy+SqFdObgemleQb
 zusf0r7HkfBLaEF+EBwZ1TQ9UiuaZH2Y6p2LjE5CMYtVuNjost
 lKwtFM9dCanC6jWvqQj5NueLvELgQ9+gVGR1iXTeCX0wnUVwZE
 3Cb4eK9xLYFG8guCZCGFJGUKaiKfiERXHJsGT3phjcLHE59duU
 bOIfG/OM6AG3+ebVssw8wWIQ015Ryb6mnmMOzQVA+rhbMbos5g
 VqjzLcym28OnvsQrPVKcrDsbl6grv7KhF40Giglq4liC6eC1P+
 dS2JVpYKWAu40Clj4Wsi2PyMPCdid9Pxdhi/lQe+59Eql0fH0G
 tX1zITz0RXosg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204200>


Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 compat/mkdir.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 compat/mkdir.c

diff --git a/compat/mkdir.c b/compat/mkdir.c
new file mode 100644
index 0000000..9e253fb
--- /dev/null
+++ b/compat/mkdir.c
@@ -0,0 +1,24 @@
+#include "../git-compat-util.h"
+#undef mkdir
+
+/* for platforms that can't deal with a trailing '/' */
+int compat_mkdir_wo_trailing_slash(const char *dir, mode_t mode)
+{
+	int retval;
+	char *tmp_dir = NULL;
+	size_t len = strlen(dir);
+
+	if (len && dir[len-1] == '/') {
+		if ((tmp_dir = strdup(dir)) == NULL)
+			return -1;
+		tmp_dir[len-1] = '\0';
+	}
+	else
+		tmp_dir = (char *)dir;
+
+	retval = mkdir(tmp_dir, mode);
+	if (tmp_dir != dir)
+		free(tmp_dir);
+
+	return retval;
+}
-- 
1.7.12
