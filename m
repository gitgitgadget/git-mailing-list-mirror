From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/8] wrapper: give zlib wrappers their own translation unit
Date: Sat, 6 Nov 2010 06:47:34 -0500
Message-ID: <20101106114734.GE27641@burratino>
References: <20101106113905.GA27405@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:47:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEhFL-0002uL-49
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab0KFLrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:47:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36569 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab0KFLrl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 07:47:41 -0400
Received: by iwn41 with SMTP id 41so1928499iwn.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6JqSgI+/J4HjiAtSHAnyWz+RDbu8ffq/0fq1W7+TGXI=;
        b=RkVey9JrXBQZ00gyanAZLtdTX84+hO/NwmfkFZpKLUPVnuLFlFurrmEi2YcHo+iG88
         fQG6YkEKJF4QUUdzcCfPyK6qpVCTZlpZZYvAsteCEzwr8X/nDsbO3OyPVMpAfR7djY8x
         AUWOeaj99AzNVLNEvvlp96SsFkDUoL9tYrZzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RNUuHv1ZyfwOmfgORukY4/W8BHr+3E3JMBmJOrg47YfhWYr/6e5d/gBfZZi+IFojUe
         KIxq3o529Kho6w66KkCITgayt15khLC8Kf3g4DdE1Ia902VMm5+eqyV3GrCezPT4pZRv
         TBrlBNz/bDC9ujlWS4TZz7tya7o6RSE3EXEKI=
Received: by 10.42.26.210 with SMTP id g18mr2011331icc.462.1289044061143;
        Sat, 06 Nov 2010 04:47:41 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d21sm2824636ibg.3.2010.11.06.04.47.39
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 04:47:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101106113905.GA27405@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160847>

Programs using xmalloc() but not git_inflate() require -lz on the
linker command line because git_inflate() is in the same translation
unit as xmalloc().

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile  |    1 +
 wrapper.c |   60 ------------------------------------------------------------
 zlib.c    |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 60 deletions(-)
 create mode 100644 zlib.c

diff --git a/Makefile b/Makefile
index d3dcfb1..45d03f8 100644
--- a/Makefile
+++ b/Makefile
@@ -659,6 +659,7 @@ LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
+LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/annotate.o
diff --git a/wrapper.c b/wrapper.c
index b3efefb..185dfbc 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -327,66 +327,6 @@ int xmkstemp_mode(char *template, int mode)
 	return fd;
 }
 
-/*
- * zlib wrappers to make sure we don't silently miss errors
- * at init time.
- */
-void git_inflate_init(z_streamp strm)
-{
-	const char *err;
-
-	switch (inflateInit(strm)) {
-	case Z_OK:
-		return;
-
-	case Z_MEM_ERROR:
-		err = "out of memory";
-		break;
-	case Z_VERSION_ERROR:
-		err = "wrong version";
-		break;
-	default:
-		err = "error";
-	}
-	die("inflateInit: %s (%s)", err, strm->msg ? strm->msg : "no message");
-}
-
-void git_inflate_end(z_streamp strm)
-{
-	if (inflateEnd(strm) != Z_OK)
-		error("inflateEnd: %s", strm->msg ? strm->msg : "failed");
-}
-
-int git_inflate(z_streamp strm, int flush)
-{
-	int ret = inflate(strm, flush);
-	const char *err;
-
-	switch (ret) {
-	/* Out of memory is fatal. */
-	case Z_MEM_ERROR:
-		die("inflate: out of memory");
-
-	/* Data corruption errors: we may want to recover from them (fsck) */
-	case Z_NEED_DICT:
-		err = "needs dictionary"; break;
-	case Z_DATA_ERROR:
-		err = "data stream error"; break;
-	case Z_STREAM_ERROR:
-		err = "stream consistency error"; break;
-	default:
-		err = "unknown error"; break;
-
-	/* Z_BUF_ERROR: normal, needs more space in the output buffer */
-	case Z_BUF_ERROR:
-	case Z_OK:
-	case Z_STREAM_END:
-		return ret;
-	}
-	error("inflate: %s (%s)", err, strm->msg ? strm->msg : "no message");
-	return ret;
-}
-
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	if (rc < 0) {
diff --git a/zlib.c b/zlib.c
new file mode 100644
index 0000000..c4d58da
--- /dev/null
+++ b/zlib.c
@@ -0,0 +1,61 @@
+/*
+ * zlib wrappers to make sure we don't silently miss errors
+ * at init time.
+ */
+#include "cache.h"
+
+void git_inflate_init(z_streamp strm)
+{
+	const char *err;
+
+	switch (inflateInit(strm)) {
+	case Z_OK:
+		return;
+
+	case Z_MEM_ERROR:
+		err = "out of memory";
+		break;
+	case Z_VERSION_ERROR:
+		err = "wrong version";
+		break;
+	default:
+		err = "error";
+	}
+	die("inflateInit: %s (%s)", err, strm->msg ? strm->msg : "no message");
+}
+
+void git_inflate_end(z_streamp strm)
+{
+	if (inflateEnd(strm) != Z_OK)
+		error("inflateEnd: %s", strm->msg ? strm->msg : "failed");
+}
+
+int git_inflate(z_streamp strm, int flush)
+{
+	int ret = inflate(strm, flush);
+	const char *err;
+
+	switch (ret) {
+	/* Out of memory is fatal. */
+	case Z_MEM_ERROR:
+		die("inflate: out of memory");
+
+	/* Data corruption errors: we may want to recover from them (fsck) */
+	case Z_NEED_DICT:
+		err = "needs dictionary"; break;
+	case Z_DATA_ERROR:
+		err = "data stream error"; break;
+	case Z_STREAM_ERROR:
+		err = "stream consistency error"; break;
+	default:
+		err = "unknown error"; break;
+
+	/* Z_BUF_ERROR: normal, needs more space in the output buffer */
+	case Z_BUF_ERROR:
+	case Z_OK:
+	case Z_STREAM_END:
+		return ret;
+	}
+	error("inflate: %s (%s)", err, strm->msg ? strm->msg : "no message");
+	return ret;
+}
-- 
1.7.2.3.557.gab647.dirty
