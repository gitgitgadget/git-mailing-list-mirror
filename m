From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v4 1/3] fmt_ident: refactor strictness checks
Date: Thu,  4 Feb 2016 11:12:38 +0200
Message-ID: <1454577160-24484-2-git-send-email-alonid@gmail.com>
References: <1454577160-24484-1-git-send-email-alonid@gmail.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:15:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRG0E-0000ws-E5
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965674AbcBDJOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 04:14:51 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33907 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965659AbcBDJOa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:14:30 -0500
Received: by mail-wm0-f42.google.com with SMTP id 128so16953129wmz.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=orQLZ56fM9XHR0dDUcvINz1fNA57lyHeRA+0grWL6PDBtZTWRGej4NntJb7TeG1yWz
         SdmiqmJA01157w54rUmyVi2LcJt8QJ4p2q8BxB1WKL2I5yc4E1QzROro8gDrxQLO6170
         7Dupq69jK+7U5a8C31PW4+WfLnVDb0cGN/HoWh7GthmAqz6QxmW/iGnGABClhlFkida+
         /JQ+1me8z7Tinamvn3x70zI/vRLGc+8RlMnqfEb+Tj1yiVdnSBQVokCQ9cVCHHYo92A8
         G6YuHRQ5kBpur0M1CcUIdkQvBsE11kqdVPXsDwfYV+5MHBHQUWbJ8LRaslX3s45hqL8v
         srsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=D621pHnWned7sBqz6kxfVN0BvwpagGr8RaYzoDmpusET3AUP9i1f4LoKukECCxZG6N
         S8w85xYkfemM1ZBXoTdJohXwohmE7P/KKY54yzuGF3oZdHi621mk7LPGls0IZv5RqAFQ
         Qha1FnDZ5Bxsng6AnOcScOtBjuSxTvFi+WvZUuXmbCM11n+13Q0Y56bm0lzG0XS6S8Sc
         lCzW12OQ1oOvU4O0Uk2kP+U3tCwkHDxLtMS8RuJB8PbnQG7MjW/QZ1F26+FWGKoYTBTM
         F8U4+jyBU36oD6Lhlb2+0lrblr2y15cdOy3csq2h1W/bPIKpzHJgKwSZ7waUbkPws06I
         9RpA==
X-Gm-Message-State: AG10YOSCml1JkbcUd9w3+SvepASqXrovRgvwJCrGfcBqwy4FXHsjR+jezdGUXKxqIPiYbA==
X-Received: by 10.194.22.101 with SMTP id c5mr7696672wjf.151.1454577268978;
        Thu, 04 Feb 2016 01:14:28 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id c7sm10806435wmd.13.2016.02.04.01.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:14:28 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454577160-24484-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285442>

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
