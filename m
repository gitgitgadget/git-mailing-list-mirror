From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] annotate: use argv_array
Date: Wed, 16 Jul 2014 10:51:33 +0200
Message-ID: <53C63D15.8040204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 10:51:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7KwP-0005x1-98
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 10:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301AbaGPIvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 04:51:52 -0400
Received: from mout.web.de ([212.227.15.4]:49771 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334AbaGPIvv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 04:51:51 -0400
Received: from [192.168.178.27] ([79.250.168.234]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MNc1S-1XDMYZ0CGA-007BqM; Wed, 16 Jul 2014 10:51:49
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:JFr074MeBJMpdA7qMnKPXPgnLVBQuoB6H7gVBC7Dld/Yss3QviT
 /Ipp/WbjJQiO70/IMBIWeaRTYlZpFcNY+YghTQ6T4sF8E6tCPrOQODvNWFoKbsG9dLJRMGs
 4wT79tazi9JmuEU8NjyB/6Xud36F20mjeZjw4M1EzWPFm8z31ZcLonRIyTJ32l0i7lPg6rM
 vBXuUjcx6OTXDcB/XE72w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253658>

Simplify the code and get rid of some magic constants by using
argv_array to build the argument list for cmd_blame.  Be lazy and let
the OS release our allocated memory, as before.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/annotate.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/annotate.c b/builtin/annotate.c
index fc43eed..da413ae 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -5,20 +5,18 @@
  */
 #include "git-compat-util.h"
 #include "builtin.h"
+#include "argv-array.h"
 
 int cmd_annotate(int argc, const char **argv, const char *prefix)
 {
-	const char **nargv;
+	struct argv_array args = ARGV_ARRAY_INIT;
 	int i;
-	nargv = xmalloc(sizeof(char *) * (argc + 2));
 
-	nargv[0] = "annotate";
-	nargv[1] = "-c";
+	argv_array_pushl(&args, "annotate", "-c", NULL);
 
 	for (i = 1; i < argc; i++) {
-		nargv[i+1] = argv[i];
+		argv_array_push(&args, argv[i]);
 	}
-	nargv[argc + 1] = NULL;
 
-	return cmd_blame(argc + 1, nargv, prefix);
+	return cmd_blame(args.argc, args.argv, prefix);
 }
-- 
2.0.0
