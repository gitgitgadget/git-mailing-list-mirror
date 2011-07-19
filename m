From: Thomas Cort <tcort@minix3.org>
Subject: [PATCH] Makefile: add Minix configuration options.
Date: Tue, 19 Jul 2011 16:26:59 -0400
Message-ID: <20110719162659.81020d7c.tcort@minix3.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 22:27:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjGt1-0002Io-QK
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 22:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab1GSU1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 16:27:03 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55099 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1GSU1C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 16:27:02 -0400
Received: by vxh35 with SMTP id 35so2654943vxh.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 13:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=D06PNmcJSnxIliDQOCv2ViqxThxpmR3YDVEH36JKMVE=;
        b=nQY1nbFmiFoZkFsIZLhxtcTZjiLsJjd6PyF0Lfdytqu2xiWSNfI2co3YJysJ4qpJnG
         +b4GHnQNu3JLfcp3ME767C8n2LvHBgYLzf94x0+RTjKDW09Zow4eRcB9ZFH5ifjgTJoN
         /PCsAp0xLK5axTjMRhTXxquE/hEdg/2FcwcUs=
Received: by 10.52.89.240 with SMTP id br16mr7602778vdb.401.1311107221167;
        Tue, 19 Jul 2011 13:27:01 -0700 (PDT)
Received: from oedipus (modemcable118.130-21-96.mc.videotron.ca [96.21.130.118])
        by mx.google.com with ESMTPS id cg6sm2501898vdc.29.2011.07.19.13.27.00
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 13:27:00 -0700 (PDT)
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177502>

 * Adds a $(uname_S) case for Minix with the correct options.

 * Adds NEEDS_SSL_WITH_CURL and NEEDS_CRYPTO_WITH_SSL to the
   libcurl section. On Minix both -lssl and -lcrypto are
   needed when using -lcurl.

 * Changes OPENSSL_LINK to OPENSSL_LIBSSL in the
   NEEDS_CRYPTO_WITH_SSL conditional in the libopenssl section.
   The -lcrypto needs to be in OPENSSL_LIBSSL.

Signed-off-by: Thomas Cort <tcort@minix3.org>
---
 Makefile |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 46793d1..e8280fc 100644
--- a/Makefile
+++ b/Makefile
@@ -1146,6 +1146,20 @@ ifeq ($(uname_S),Interix)
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
@@ -1290,6 +1304,16 @@ else
 	else
 		CURL_LIBCURL = -lcurl
 	endif
+	ifdef NEEDS_SSL_WITH_CURL
+		CURL_LIBCURL +=	-lssl
+	endif
+	ifdef NEEDS_CRYPTO_WITH_SSL
+		CURL_LIBCURL += -lcrypto
+	endif
+	ifdef NEEDS_IDN_WITH_CURL
+		CURL_LIBCURL += -lidn
+	endif
+
 	REMOTE_CURL_PRIMARY = git-remote-http$X
 	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
@@ -1326,7 +1350,7 @@ ifndef NO_OPENSSL
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
