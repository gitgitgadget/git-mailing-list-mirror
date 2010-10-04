From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] do not depend on undefined signed integer overflow
Date: Mon,  4 Oct 2010 21:43:08 +0200
Message-ID: <1286221388-4908-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 21:44:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qxO-0005bz-GW
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478Ab0JDToK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 15:44:10 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49878 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab0JDToI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 15:44:08 -0400
Received: by eyb6 with SMTP id 6so2162169eyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=LK0XUjEwpUvSgur40l244+IUPRvep+VzDZ/ILVR4//E=;
        b=vW1NcHXWmLyQ2yO+cffOrlVhaYTyITjHLlhkcs15e1XqMVyefNhlEmQMSDcCpJAQWJ
         MFdquC/t3h8ZtrX9Bdxcw9GwCZpsel4TGTDHoeC7ax3IvUf41Xdvt0tEtWzhBBA2ZN3E
         4TQjrhorEjjWquEsxn80eDuxhS1GxhWk7ygBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=N46eJ26BqU5TS0RgbE6mV2G/61SSVnOZGFud02Q+Cla/48Y4t9tw+8h8DFMW7Ollje
         Upj1+ify6kmEiYB3089A1wVFntTDitz68UIb41yJW48BcSkkAOYUxEp8sqAygVUvfz0j
         6aazinswdwFRdHBSTLXKZrCXY63CPaK+ONZSg=
Received: by 10.14.119.140 with SMTP id n12mr6515280eeh.0.1286221446993;
        Mon, 04 Oct 2010 12:44:06 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id u9sm7774644eeh.17.2010.10.04.12.44.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 12:44:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158105>

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
index 81883e7..5298747 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -28,6 +28,15 @@
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
 
+/*
+ * Signed integer overflow is undefined in C and some compilers take
+ * advantage of this when optimizing, so here's a helper macro to force
+ * wrapping when adding two integers. The size to wrap to is taken from
+ * the first parameter.
+ */
+#define signed_add_overflows(a, b) \
+    ((b) > ((INTMAX_MAX >> (bitsizeof(uintmax_t) - bitsizeof(a))) - (a)))
+
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
-- 
1.7.3.4.g28d92.dirty
