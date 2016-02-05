From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v6 1/3] fmt_ident: refactor strictness checks
Date: Fri,  5 Feb 2016 09:42:26 +0200
Message-ID: <1454658148-3031-2-git-send-email-alonid@gmail.com>
References: <1454658148-3031-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 08:43:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRb2i-0006Qb-2r
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 08:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbcBEHm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 02:42:57 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33266 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbcBEHmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 02:42:55 -0500
Received: by mail-wm0-f44.google.com with SMTP id g62so36342217wme.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 23:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=0r2KOQ6jiJYQVGmNWFWmEbuNP1PBXnDsaJbOYbWtsKHjRsepQ9CVeiIk0JBwdAGKxJ
         HlbNIF7LIGsPFmQph7Q961Hmf5jzpRkhNTHWgHaGNY9Pc23CnNHKdTIWxY+xr2iOe6uB
         YStO8tQcnEqeWTKgFjW88xuBjHI0X+WQpCMS4qnS3l/NiF23SXcmqBOkF5bsMmsuaxTs
         nL5ciI6h4mEPWws8Y8bp4wCku6tLJdOP3SMZMtawyJyokrpeY4EnXLGmtQ75B+xtW6lz
         RAJmwTxqMGkoy1Y25vSoAHiJ9Ejj3woJiRSytSRoJYXuYTkQ7Xn+ko4VcVhV7a7+eM5C
         x2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=dHo0KufFmJE3BvHrBbmU0A5oP8ZuX8uN6TvE+xoNgjPOfd8UtgUdEMQmnOGFjScmmq
         fbQjFxsZDgCu+JRYOqLi1wjbd2sNAiScCxbQQ6rTl5mPw+TmPrlllcAso8QEePphV9GV
         3mattgBzKX+PSZ/tHbm0+zhYoS8cXObeuxF91l/rwAN+qTXopNeadJ6AMUea0sKl4Y8I
         ikyvQLwrhj0afa+ZGg78V6rldAlYQKBWaM/WXDcEi/CS37Ihe6Mvx493PxTGazsfWH3q
         v3Lb2q3ZU3qsY/N5T7xYH/Pg4oBxemN/BbgWMU54166doFpuTuZTDVL+a8Tcz5FX8rPC
         11Tg==
X-Gm-Message-State: AG10YORPL4g3eBFz+lpnPHTDgptwXMsDgfm/7sGTrQFE4YnALdb+4ZKbr0seQVmikfaGNg==
X-Received: by 10.194.105.99 with SMTP id gl3mr11954073wjb.90.1454658174181;
        Thu, 04 Feb 2016 23:42:54 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id w66sm16062302wmd.2.2016.02.04.23.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 23:42:53 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454658148-3031-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285549>

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
