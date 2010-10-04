From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2] do not depend on signed integer overflow
Date: Mon,  4 Oct 2010 23:25:22 +0200
Message-ID: <1286227522-5468-1-git-send-email-kusmabite@gmail.com>
Cc: jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 23:26:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2sYK-0002Hf-1e
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308Ab0JDV0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 17:26:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63844 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab0JDV0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 17:26:24 -0400
Received: by eyb6 with SMTP id 6so2261214eyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/Tp7ajwb5VOFglOcvdRNPDYxYvYDyP+0Te5NJzSmn3Q=;
        b=aHpPR8Dv1da/R2YrAZQIUa9mB8xR4yqYxA0BGqplD20xWJI7ahhs/9OBKVKqmnFydT
         gNnQiAfbkoJt4cuE5cGF8Wp9i4MXphmH45OK1fH2lHHySrfz1Aed2QWHBm8kgsib3YUo
         GPP7DTSOskSryM7kiYLiup6FDMMq1KFaU9uLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=j62LpfWod8pJ267cIRFVZ8Nj6guH6pX9ljKLPZ+7VoEme6Pm6ID78/G+drW+/E468N
         rnBehwyD4VEqiZ7nxiyl4fOtVejvQSfBfXnyG7aCD0hEIvVMBuzFyglIHD1x4fGwx3jC
         t1hElFbyOG7QNQx8g9XEzm9PtCB2wLg+3TpnM=
Received: by 10.14.48.74 with SMTP id u50mr6666837eeb.13.1286227581847;
        Mon, 04 Oct 2010 14:26:21 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id a48sm7925146eei.12.2010.10.04.14.26.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 14:26:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158125>

Signed integer overflow is not defined in C, so do not depend on it.

This fixes a problem with GCC 4.4.0 and -O3 where the optimizer would
consider "consumed_bytes > consumed_bytes + bytes" as a constant
expression, and never execute the die()-call.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin/index-pack.c     |    2 +-
 builtin/unpack-objects.c |    2 +-
 git-compat-util.h        |    9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

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
index 81883e7..dfb5565 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -28,6 +28,15 @@
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
 
+/*
+ * Signed integer overflow is undefined in C, so here's a helper macro
+ * to detect if the sum of two integers will overflow. The bitsize to
+ * overflow at is taken from the first parameter, which must be zero
+ * or positive.
+ */
+#define signed_add_overflows(a, b) \
+    ((b) > ((INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a))) - (a)))
+
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
-- 
1.7.3.1.51.g3f36d
