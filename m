From: Thomas Cort <tcort@minix3.org>
Subject: [PATCH] Makefile: add Minix configuration options.
Date: Tue, 19 Jul 2011 18:55:47 -0400
Message-ID: <20110719185547.e9ee8e14.tcort@minix3.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 20 00:55:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjJCm-0001Oi-Cq
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 00:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab1GSWzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 18:55:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45049 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1GSWzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 18:55:50 -0400
Received: by vws1 with SMTP id 1so3263823vws.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=rrru6gtbUljFvLn5ZcWwZJFghVv3eXIAkLhqhM0w7bU=;
        b=QOc0MD0D6LybaH1/bUDUY9UTJVxNBW2xhB1/PjlowJx2YYW+ki9yDdd21okI16G53H
         PI1k0V1UWZKWFkAYhGzD9gG/0OoI6gaZxIXafe5LZip9kIg4bjXKOa5+9VIPZyfuvTVk
         IpCuZxsqnqkDrIo3V9uqXin95TdOh0ILR6gFQ=
Received: by 10.52.177.166 with SMTP id cr6mr6839397vdc.151.1311116149742;
        Tue, 19 Jul 2011 15:55:49 -0700 (PDT)
Received: from oedipus (modemcable118.130-21-96.mc.videotron.ca [96.21.130.118])
        by mx.google.com with ESMTPS id t1sm133186vdv.38.2011.07.19.15.55.48
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 15:55:49 -0700 (PDT)
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177513>

Add a $(uname_S) case for Minix with the correct options.

Minix's linker needs all libraries specified explicitly.
Add NEEDS_SSL_WITH_CURL to add -lssl when using -lcurl.
Add NEEDS_IDN_WITH_CURL to add -lidn when using -lcurl.

When NEEDS_SSL_WITH_CURL is defined and NEEDS_CRYPTO_WITH_SSL
is defined, add -lcrypt to CURL_LIBCURL.

Change OPENSSL_LINK to OPENSSL_LIBSSL in the
NEEDS_CRYPTO_WITH_SSL conditional in the libopenssl
section. Libraries go in OPENSSL_LIBSSL, OPENSSL_LINK
is for linker flags.

Signed-off-by: Thomas Cort <tcort@minix3.org>
---
 Makefile |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 4ed7996..62ad0c2 100644
--- a/Makefile
+++ b/Makefile
@@ -115,6 +115,10 @@ all::
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
 #
+# Define NEEDS_SSL_WITH_CURL if you need -lssl with -lcurl (Minix).
+#
+# Define NEEDS_IDN_WITH_CURL if you need -lidn when using -lcurl (Minix).
+#
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
@@ -1149,6 +1153,20 @@ ifeq ($(uname_S),Interix)
 		NO_FNMATCH_CASEFOLD = YesPlease
 	endif
 endif
+ifeq ($(uname_S),Minix)
+	NO_IPV6 = YesPlease
+	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	NO_NSEC = YesPlease
+	NEEDS_LIBGEN =
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
+	NEEDS_IDN_WITH_CURL = YesPlease
+	NEEDS_SSL_WITH_CURL = YesPlease
+	NEEDS_RESOLV =
+	NO_HSTRERROR = YesPlease
+	NO_MMAP = YesPlease
+	NO_CURL =
+	NO_EXPAT =
+endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -1293,6 +1311,16 @@ else
 	else
 		CURL_LIBCURL = -lcurl
 	endif
+	ifdef NEEDS_SSL_WITH_CURL
+		CURL_LIBCURL +=	-lssl
+		ifdef NEEDS_CRYPTO_WITH_SSL
+			CURL_LIBCURL += -lcrypto
+		endif
+	endif
+	ifdef NEEDS_IDN_WITH_CURL
+		CURL_LIBCURL += -lidn
+	endif
+
 	REMOTE_CURL_PRIMARY = git-remote-http$X
 	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
@@ -1329,7 +1357,7 @@ ifndef NO_OPENSSL
 		OPENSSL_LINK =
 	endif
 	ifdef NEEDS_CRYPTO_WITH_SSL
-		OPENSSL_LINK += -lcrypto
+		OPENSSL_LIBSSL += -lcrypto
 	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
-- 
1.7.4.1
