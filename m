From: Rafael Gieschke <rafael@gieschke.de>
Subject: [PATCH] ident: add NO_GECOS_IN_PWENT for systems without pw_gecos in struct passwd
Date: Thu, 19 May 2011 13:37:55 +0200
Message-ID: <A5E9A01E-716A-4A34-96C6-C489CDF2CFDE@gieschke.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 13:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN1Yg-00022i-Oc
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 13:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303Ab1ESLiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 07:38:24 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:39168 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753911Ab1ESLiW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 07:38:22 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id 73D271D22AA;
	Thu, 19 May 2011 13:38:21 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.828
X-Spam-Level: 
X-Spam-Status: No, score=-2.828 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.072, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Fqm4YvEQ3C3; Thu, 19 May 2011 13:38:20 +0200 (CEST)
Received: from [10.163.130.160] (unknown [89.204.137.160])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id C43E91D2263;
	Thu, 19 May 2011 13:38:17 +0200 (CEST)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173952>


NO_GECOS_IN_PWENT is defined in Makefile. If set, struct_passwd->pw_gecos is
not used but the capitalized login name is taken as a substitute.

Signed-off-by: Rafael Gieschke <rafael@gieschke.de>
---
 Makefile |    6 ++++++
 ident.c  |    8 +++++++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index d7147cf..de79c8f 100644
--- a/Makefile
+++ b/Makefile
@@ -71,6 +71,9 @@ all::
 #
 # Define NO_STRTOK_R if you don't have strtok_r in the C library.
 #
+# Define NO_GECOS_IN_PWENT if you don't have pw_gecos in struct passwd
+# in the C library.
+#
 # Define NO_FNMATCH if you don't have fnmatch in the C library.
 #
 # Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
@@ -1406,6 +1409,9 @@ ifdef NO_STRTOK_R
 	COMPAT_CFLAGS += -DNO_STRTOK_R
 	COMPAT_OBJS += compat/strtok_r.o
 endif
+ifdef NO_GECOS_IN_PWENT
+	COMPAT_CFLAGS += -DNO_GECOS_IN_PWENT
+endif
 ifdef NO_FNMATCH
 	COMPAT_CFLAGS += -Icompat/fnmatch
 	COMPAT_CFLAGS += -DNO_FNMATCH
diff --git a/ident.c b/ident.c
index 8e56b5e..bcd04e0 100644
--- a/ident.c
+++ b/ident.c
@@ -9,6 +9,12 @@
 
 static char git_default_date[50];
 
+#ifdef NO_GECOS_IN_PWENT
+#define get_gecos(ignored) "&"
+#else
+#define get_gecos(struct_passwd) (struct_passwd->pw_gecos)
+#endif
+
 static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 {
 	char *src, *dst;
@@ -20,7 +26,7 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 	 * with commas.  Also & stands for capitalized form of the login name.
 	 */
 
-	for (len = 0, dst = name, src = w->pw_gecos; len < sz; src++) {
+	for (len = 0, dst = name, src = get_gecos(w); len < sz; src++) {
 		int ch = *src;
 		if (ch != '&') {
 			*dst++ = ch;
-- 
1.7.4
