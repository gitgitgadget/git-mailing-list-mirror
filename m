From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3] do not depend on signed integer overflow
Date: Tue,  5 Oct 2010 00:49:12 +0200
Message-ID: <1286232552-5244-1-git-send-email-kusmabite@gmail.com>
Cc: jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 00:50:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2trQ-0005Hf-Un
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757247Ab0JDWuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:50:14 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45386 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab0JDWuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:50:13 -0400
Received: by eyb6 with SMTP id 6so2288477eyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=C0BPyEmrl9u2BVqXVZbiAVDQk9v+SSgxchfTwY1zdWo=;
        b=BUoZ0XMqfxVKhppqChqxal2I2o+StDwdgahHDKxfoSteBgaecghXPKbpLJwK985DsN
         Hyw45z+6GZ83mEK0jt2d2F6897ozCeLWyw4i7UuysADAfchHtpKRpo4XFNG0mueQ0AXX
         Cfn/isoi6ewHmzQW59xf+SVSrkVJTEtwtpMHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QLcYmRZybsf/YVY+vNNGBqwnn/vjGpIs/21rN+Akk17FeQrkS2GdBmJtmKWXKpwmaY
         718CZxWXaZTVS3ixXH7Gngko9QivXDvTyQJopiJEsa+BlnXFv8YToyArDzhsnuF9HIZm
         zzA/MVAJ4cbrowiUlgRYv24GYl3gdlcIbSTy8=
Received: by 10.213.108.200 with SMTP id g8mr334255ebp.91.1286232612032;
        Mon, 04 Oct 2010 15:50:12 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id a48sm8066206eei.0.2010.10.04.15.50.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 15:50:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158137>

Signed integer overflow is not defined in C, so do not depend on it.

This fixes a problem with GCC 4.4.0 and -O3 where the optimizer would
consider "consumed_bytes > consumed_bytes + bytes" as a constant
expression, and never execute the die()-call.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin/index-pack.c     |    2 +-
 builtin/unpack-objects.c |    2 +-
 git-compat-util.h        |   12 ++++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2e680d7..e243d9d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -161,7 +161,7 @@ static void use(int bytes)
 	input_offset += bytes;
 
 	/* make sure off_t is sufficiently large not to wrap */
-	if (consumed_bytes > consumed_bytes + bytes)
+	if (signed_add_overflows(consumed_bytes, bytes))
 		die("pack too large for current definition of off_t");
 	consumed_bytes += bytes;
 }
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 685566e..f63973c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -83,7 +83,7 @@ static void use(int bytes)
 	offset += bytes;
 
 	/* make sure off_t is sufficiently large not to wrap */
-	if (consumed_bytes > consumed_bytes + bytes)
+	if (signed_add_overflows(consumed_bytes, bytes))
 		die("pack too large for current definition of off_t");
 	consumed_bytes += bytes;
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index 81883e7..2af8d3e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -28,6 +28,18 @@
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
 
+#define maximum_signed_value_of_type(a) \
+    (INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
+
+/*
+ * Signed integer overflow is undefined in C, so here's a helper macro
+ * to detect if the sum of two integers will overflow.
+ *
+ * Requires: a >= 0, typeof(a) equals typeof(b)
+ */
+#define signed_add_overflows(a, b) \
+    ((b) > maximum_signed_value_of_type(a) - (a))
+
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
-- 
1.7.3.1.51.g3f36d.dirty
