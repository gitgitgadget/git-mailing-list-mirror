From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v8 1/2] fmt_ident: refactor strictness checks
Date: Sat,  6 Feb 2016 00:28:56 +0200
Message-ID: <1454711337-25508-2-git-send-email-alonid@gmail.com>
References: <1454711337-25508-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 23:29:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRosY-0001Y5-QS
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 23:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbcBEW3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 17:29:20 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35472 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbcBEW3T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 17:29:19 -0500
Received: by mail-wm0-f42.google.com with SMTP id r129so45592874wmr.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 14:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=bs60JbpMOVEmJ4POmpK5HZ6vw35fbnX5sKGkyGd2mSz7+3Avs+LkiimyfytR/RWKc3
         8l8ey5C3eEgh4tBtdPYqvzrFE4Lt0jrfawhFmedquh/Al28hZ0It8enJNSC5oO7zPHb0
         y0c7a8bFgru5WgxLzAlKyhWXTO1VqijUt+REsVN0ycOH/B3p46Xm80tABjAUZ95RbyW6
         F4hdKkz0NAWWmBBFF7q5N/2Qd7tyILIpqpNWKob5HZ4FIAJtbofVvfFjqBV39/0kmMfv
         WzRz07XBcRZ1qXPkZa0hplZJCtM9Ayz/srXQEEPVgtgwbrRq+LeSqMduipbREHc6osfO
         WiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=jh2vHayQTKV3q9UFYVxaQKl5sYmh94Dg7+JvSjLpbx/HUmgxiUBpU8mBK1K3IriZ9b
         mkd/5jCq6n+iSnHqVy0Vj7miPs/B+xgDjKuV5nbhkgbzxAXKm/IpvLyTf1Oe5NjksiPK
         Ath4y5VEwH1LuhGIHZPNydlwhE4x/4Lgx7R3S08mwjJ1+BtcQ6un3bTsC+EwrbAabjIA
         0qsnwUP6l93LTN51Um+3Y627uUKTBKh17BBEyuWDGftkKVpNeWLyECwpMGU+93QVdcRh
         Voz3+iEtyQXudOy2M66tSRrJtL3Pc+L0rVbWJLiJliYJnpdZc5HUdiHyYwd5RzOiVFqS
         4FyA==
X-Gm-Message-State: AG10YOQmDgrv66cZ64ZnSlQ7GzxGyfFs+ZrIbAY3yuN4JSgrD+hQL9XM7c56y5+LIvdYQQ==
X-Received: by 10.194.52.37 with SMTP id q5mr16363995wjo.123.1454711357929;
        Fri, 05 Feb 2016 14:29:17 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id t3sm17729626wjz.11.2016.02.05.14.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 14:29:17 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454711337-25508-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285647>

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
