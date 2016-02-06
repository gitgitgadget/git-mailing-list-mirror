From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v9 1/2] fmt_ident: refactor strictness checks
Date: Sat,  6 Feb 2016 08:23:35 +0200
Message-ID: <1454739816-24007-2-git-send-email-alonid@gmail.com>
References: <1454739816-24007-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 07:24:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRwIb-0004eX-Hw
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 07:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbcBFGYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 01:24:45 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34234 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbcBFGYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 01:24:03 -0500
Received: by mail-wm0-f41.google.com with SMTP id 128so95798212wmz.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 22:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=CwWqQd5VlNwHCs3Kjz8g/RS0cZxdus9cGzwyo7LoiqYjg7iyxI3qpCB3kQ4L4ROpix
         5U9Gxij6cBmZSlYzPYSx+2ekSDZeh52+7pjla5N41KPQk06E3Me8uASoOr04IovkaPvj
         TILcQ/NRNFzo3clE3n7wql3hk+tBMXhbGQVKp3R2Atxn2SgJPWKY6Khez36Hb2VFDzEo
         XN93RQPIvNMb9Raymr0Bjx4cbsZkJ5xTtOnoK/ITlgp6Ievt5p0CfiBmQ8a8IlCx8O8L
         Bzd/CBBdnb/UHujzZDDLWAAoAtmhTc05kACaSimwellm+KiLJWudm85Q/Ysgx623pnQI
         gb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=WMO/v/FHcWppYDUGAXKCzxcnrl5oVSGMy+uAHCREXhxbbyKKMaOhND03QNyqiuF8xg
         2ciwbKSNz4r3vAqUJrqFLvBCcIZY0zZHwGGGPYLg7t2XBY8IWTKsJK5qjrmDp1246RAu
         Y0Lbeu2UQc2NPkrjxrSjHWqV2QjtbK/Gw8IbEVMQ9cVv1EKTGFGxdX4ctyo6PdmMIBA6
         hQ6nJF3iDUpVMOBn/NZxevkz0H3LUxOs35PGzP5vZ9hm9sI2R/k3Euoq1K+gskFP/rcI
         IWUZmfGOnziMoX4zJtDqIZzxWGuFnTFfBrZUL0x38MPwqfa95kzn6OwGTdERn/P2O15W
         kjQw==
X-Gm-Message-State: AG10YOTexN3MekLq5B4tfoqCWa634CPi75Y9CDABOaeS8KIcyA7OMK+kGJlujGV7Ljjhwg==
X-Received: by 10.28.103.5 with SMTP id b5mr32635705wmc.5.1454739842467;
        Fri, 05 Feb 2016 22:24:02 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id k130sm1807554wmg.6.2016.02.05.22.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 22:24:01 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454739816-24007-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285680>

From: Jeff King <peff@peff.net>

This function has evolved quite a bit over time, and as a
result, the logic for "is this an OK ident" has been
sprinkled throughout. This ends up with a lot of redundant
conditionals, like checking want_name repeatedly. Worse,
we want to know in many cases whether we are using the
"default" ident, and we do so by comparing directly to the
global strbuf, which violates the abstraction of the
ident_default_* functions.

Let's reorganize the function into a hierarchy of
conditionals to handle similar cases together. The only
case that doesn't just work naturally for this is that of an
empty name, where our advice is different based on whether
we came from ident_default_name() or not. We can use a
simple flag to cover this case.

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/ident.c b/ident.c
index 3da555634290..f3a431f738cc 100644
--- a/ident.c
+++ b/ident.c
@@ -345,32 +345,34 @@ const char *fmt_ident(const char *name, const char *email,
 	int want_date = !(flag & IDENT_NO_DATE);
 	int want_name = !(flag & IDENT_NO_NAME);
 
-	if (want_name && !name)
-		name = ident_default_name();
-	if (!email)
-		email = ident_default_email();
-
-	if (want_name && !*name) {
-		struct passwd *pw;
-
-		if (strict) {
-			if (name == git_default_name.buf)
+	if (want_name) {
+		int using_default = 0;
+		if (!name) {
+			name = ident_default_name();
+			using_default = 1;
+			if (strict && default_name_is_bogus) {
 				fputs(env_hint, stderr);
-			die("empty ident name (for <%s>) not allowed", email);
+				die("unable to auto-detect name (got '%s')", name);
+			}
+		}
+		if (!*name) {
+			struct passwd *pw;
+			if (strict) {
+				if (using_default)
+					fputs(env_hint, stderr);
+				die("empty ident name (for <%s>) not allowed", email);
+			}
+			pw = xgetpwuid_self(NULL);
+			name = pw->pw_name;
 		}
-		pw = xgetpwuid_self(NULL);
-		name = pw->pw_name;
-	}
-
-	if (want_name && strict &&
-	    name == git_default_name.buf && default_name_is_bogus) {
-		fputs(env_hint, stderr);
-		die("unable to auto-detect name (got '%s')", name);
 	}
 
-	if (strict && email == git_default_email.buf && default_email_is_bogus) {
-		fputs(env_hint, stderr);
-		die("unable to auto-detect email address (got '%s')", email);
+	if (!email) {
+		email = ident_default_email();
+		if (strict && default_email_is_bogus) {
+			fputs(env_hint, stderr);
+			die("unable to auto-detect email address (got '%s')", email);
+		}
 	}
 
 	strbuf_reset(&ident);
-- 
2.5.0
