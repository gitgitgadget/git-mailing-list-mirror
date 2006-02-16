From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: [PATCH] Allow building Git in systems without iconv
Date: Thu, 16 Feb 2006 09:38:01 +0100
Message-ID: <20060216083801.GB9323@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:38:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9eeZ-0004pA-7R
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 09:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWBPIiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 03:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWBPIiI
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 03:38:08 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:51588
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S932255AbWBPIiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 03:38:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id CE3638D35C;
	Thu, 16 Feb 2006 09:38:04 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02355-10; Thu, 16 Feb 2006 09:38:02 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id AAA468D30C;
	Thu, 16 Feb 2006 09:38:01 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@gentoo.org; Thu, 16 Feb 2006 09:38:01 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16285>

Systems using some uClibc versions do not properly support
iconv stuff. This patch allows Git to be built on those
systems by passing NO_ICONV=YesPlease to make. The only
drawback is mailinfo won't do charset conversion in those
systems.

Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>

---

 Makefile   |    6 ++++++
 mailinfo.c |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)

ca34460f60a4e0e037953124b91d3377db2cd1c8
diff --git a/Makefile b/Makefile
index 648469e..317be3c 100644
--- a/Makefile
+++ b/Makefile
@@ -53,6 +53,8 @@ all:
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
 # sockaddr_storage.
 #
+# Define NO_ICONV if your libc does not properly support iconv.
+#
 # Define COLLISION_CHECK below if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
 # sufficient guarantee that no collisions between objects will ever happen.
@@ -380,6 +382,10 @@ else
 endif
 endif
 
+ifdef NO_ICONV
+	ALL_CFLAGS += -DNO_ICONV
+endif
+
 ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
diff --git a/mailinfo.c b/mailinfo.c
index ff2d4d4..3c56f8c 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -7,7 +7,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+#ifndef NO_ICONV
 #include <iconv.h>
+#endif
 #include "git-compat-util.h"
 #include "cache.h"
 
@@ -469,6 +471,7 @@ static int decode_b_segment(char *in, ch
 
 static void convert_to_utf8(char *line, char *charset)
 {
+#ifndef NO_ICONV
 	char *in, *out;
 	size_t insize, outsize, nrc;
 	char outbuf[4096]; /* cheat */
@@ -501,6 +504,7 @@ static void convert_to_utf8(char *line, 
 		return;
 	*out = 0;
 	strcpy(line, outbuf);
+#endif
 }
 
 static void decode_header_bq(char *it)
-- 
1.2.0
