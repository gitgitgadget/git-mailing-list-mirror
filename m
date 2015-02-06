From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] git-compat-util: do not step on MAC_OS_X_VERSION_MIN_REQUIRED
Date: Fri,  6 Feb 2015 01:35:31 -0800
Message-ID: <f2a35ed9fba20d48ef5736ee4564101@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 10:35:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJfKG-0004vp-Hp
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 10:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbbBFJfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 04:35:43 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:44895 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbbBFJfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 04:35:42 -0500
Received: by pdbft15 with SMTP id ft15so13712494pdb.11
        for <git@vger.kernel.org>; Fri, 06 Feb 2015 01:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5xTxOkfCkeRvfJ/V6sW9I/Wk0CznyDb2Sh4NtliAETk=;
        b=EqXe5c8DchWDcCf5mq5x2EhNbcbU8MJ973bzB64/pw+uPyz9Wq2CCRjlvFUfRZrbtC
         NCosofa4P4zO91B7OHCBAODQGp0vE7/9xEt/wBW4nY7PzQjZgC289pVnHSAdLg2uCEAs
         uA+YjMGfBou3i74eN74vQofO6Zqz+ZVa0GCBMXyTgHuK++OywVrjIO3HAC5CXtuxCm8N
         TAlosmngZBI6QVkVMPr+HddCpD3iv/Ze0RC8ms1wmH3oOxO83yE0C90OgEKjrqt/Oxjd
         iv3lQ+QB0/8MeM4hb9s7xCVtTmGyk9uPEcMvrIT5R44WXV6iBrNrf41ZuO6dukN9DnE2
         5sKg==
X-Received: by 10.66.65.168 with SMTP id y8mr1317757pas.138.1423215341625;
        Fri, 06 Feb 2015 01:35:41 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id f5sm7498673pdm.3.2015.02.06.01.35.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 06 Feb 2015 01:35:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263414>

MAC_OS_X_VERSION_MIN_REQUIRED may be defined by the builder to a
specific version in order to produce compatible binaries for a
particular system.  Blindly defining it to MAC_OS_X_VERSION_10_6
is bad.

Additionally MAC_OS_X_VERSION_10_6 will not be defined on older
systems and should AvailabilityMacros.h be included on such as
system an error will result.  However, using the explicit value
of 1060 (which is what MAC_OS_X_VERSION_10_6 is defined to) does
not solve the problem.

The changes that introduced stepping on MAC_OS_X_VERSION_MIN were
made in b195aa00 (git-compat-util: suppress unavoidable
Apple-specific deprecation warnings) to avoid deprecation
warnings.

Instead of blindly setting MAC_OS_X_VERSION_MIN to 1060 change
the definition of DEPRECATED_ATTRIBUTE to empty to avoid the
warnings.  This preserves any MAC_OS_X_VERSION_MIN_REQUIRED
setting while avoiding the warnings as intended by b195aa00.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 git-compat-util.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index eb9b0ff3..0efd32c4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -212,12 +212,15 @@ extern char *gitbasename(char *);
 #endif
 
 #ifndef NO_OPENSSL
+#ifdef __APPLE__
 #define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
-#define MAC_OS_X_VERSION_MIN_REQUIRED MAC_OS_X_VERSION_10_6
+#include <AvailabilityMacros.h>
+#undef DEPRECATED_ATTRIBUTE
+#define DEPRECATED_ATTRIBUTE
+#undef __AVAILABILITY_MACROS_USES_AVAILABILITY
+#endif
 #include <openssl/ssl.h>
 #include <openssl/err.h>
-#undef MAC_OS_X_VERSION_MIN_REQUIRED
-#undef __AVAILABILITY_MACROS_USES_AVAILABILITY
 #ifdef NO_HMAC_CTX_CLEANUP
 #define HMAC_CTX_cleanup HMAC_cleanup
 #endif
--
