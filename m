From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4] do not depend on signed integer overflow
Date: Tue,  5 Oct 2010 09:24:10 +0200
Message-ID: <1286263450-5372-1-git-send-email-kusmabite@gmail.com>
Cc: jrnieder@gmail.com, peff@peff.net, nico@fluxnic.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 09:25:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P31tr-00040Z-Ds
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 09:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab0JEHZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 03:25:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42687 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab0JEHZO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 03:25:14 -0400
Received: by ewy23 with SMTP id 23so2370993ewy.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 00:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cRzhPHn5i4YnJjGrcSd990awUveFxfc/bEqmwSCg90k=;
        b=L4LZOWL7F9R5Hl9LR19zLEIuh5bN9UuIpRz/yp0yvrJdKadRSHFCfJFRjrJ0ooISa1
         sin11c3GxVG5J6YH88zlRJhbu3kMn5OCTNrj9wkMjSe7V5Ad263ztisGF/3RKzcTMbTA
         UtI0ciXhcq/hToHRvdJtNgdK8ll8W27aTo7C8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mWQeJ9349hlIH9rv6nSiClOmvLCnBcQYWf7dATkIZDijB7nmL6biVUlwNMM/QwdssU
         hhroipWlhCLVOcTwMvEzpdkCg9GX3aqoykCZIyyfl+0keUSww5MuSYkpMHY0/LvZgFQ0
         ves5ckmOn6sz34mqQG3c8ZOBqRZ0wMcdbJOGQ=
Received: by 10.213.19.203 with SMTP id c11mr676888ebb.31.1286263513535;
        Tue, 05 Oct 2010 00:25:13 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id z55sm8828066eeh.9.2010.10.05.00.25.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 00:25:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158170>

Signed integer overflow is not defined in C, so do not depend on it.

This fixes a problem with GCC 4.4.0 and -O3 where the optimizer would
consider "consumed_bytes > consumed_bytes + bytes" as a constant
expression, and never execute the die()-call.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin/index-pack.c     |    2 +-
 builtin/pack-objects.c   |    2 +-
 builtin/unpack-objects.c |    2 +-
 git-compat-util.h        |   12 ++++++++++++
 4 files changed, 15 insertions(+), 3 deletions(-)

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
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3756cf3..d5a8db1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -431,7 +431,7 @@ static int write_one(struct sha1file *f,
 	written_list[nr_written++] = &e->idx;
 
 	/* make sure off_t is sufficiently large not to wrap */
-	if (*offset > *offset + size)
+	if (signed_add_overflows(*offset, size))
 		die("pack too large for current definition of off_t");
 	*offset += size;
 	return 1;
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
1.7.3.1.51.ge462f.dirty
