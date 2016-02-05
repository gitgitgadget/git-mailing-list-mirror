From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v7 1/2] fmt_ident: refactor strictness checks
Date: Fri,  5 Feb 2016 23:29:05 +0200
Message-ID: <1454707746-18672-2-git-send-email-alonid@gmail.com>
References: <1454707746-18672-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:29:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRnwv-0006Pu-2n
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 22:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbcBEV3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 16:29:49 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35347 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbcBEV3r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 16:29:47 -0500
Received: by mail-wm0-f51.google.com with SMTP id r129so44127056wmr.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 13:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=UdHi8uiavyVU4eeLo8a6Q5SQvmHv/stt0YmqDlCXtN3ib8yYhwRQ5pK+9X6iJ1WrSu
         VE6EYDrIfZn2+f553FnTz0iQDY2sVe7qSxPY0EZzzTiq2gW2laUKK+FW5d6ZNvLt0e0y
         RZL0Q3tEzTEXywBbbWBOZqjgIyv6YFz2O7KuuWxTaTKdNnp1CmvybxVISANZzwlDN4Ix
         2vYgCO/eTUXovwdD3lNPBlYSkNG8Z2pHmHvs7b56typAMqzYqjwmbUvp+Msh+sT94hgA
         eHO8jTwJ/WPuSbaB6kJRDUipUbDHNhNsJ7mAsJIB+mH0AA8nJQSTZvrxbbXUQ4MnCQ27
         HICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=MOmkfrNMis01ILP5HKEIhRxp28Gy/Gg5aGAC52D1olSiiFE0mE8SZ/ZdKc4If4VgIh
         UUbccZid4QtL04rrkdzsh1pXn7XQ2im6hR4LtsQpGcqOv2aA4q4+Xzw7MRJXvCT2lz2w
         AS9vzpfDyJ2PDe/dtgLWEAlm70Mob8uEVwZIaad/L6/aAmuWBLMkM2r25si6PJQNp6Wd
         9N4Nzf6sKGAjtpGRbtfUNauJaOspasvPniZNENCu6mXZZKo4EkTkD+SGzKpIMwLxIN+H
         uRwTBTctL9V8gdqJkre/kdotHfSm9a5tLpdcT/kaJf2san+WHAztQZ8mDBZRYcgsjWg7
         J2Gg==
X-Gm-Message-State: AG10YORpa8bzkGyNr3KA5WDjZ3SA68TeacnCQncoP166Uhk/adtQDjp43MjBtqDvDzYESg==
X-Received: by 10.194.246.37 with SMTP id xt5mr16169422wjc.7.1454707786902;
        Fri, 05 Feb 2016 13:29:46 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id q75sm446574wmd.6.2016.02.05.13.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 13:29:46 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454707746-18672-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285637>

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
