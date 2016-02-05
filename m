From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v5 1/3] fmt_ident: refactor strictness checks
Date: Fri,  5 Feb 2016 09:01:40 +0200
Message-ID: <1454655702-28164-2-git-send-email-alonid@gmail.com>
References: <1454655702-28164-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 08:02:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRaPT-0007tO-1t
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 08:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbcBEHCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 02:02:20 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35702 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbcBEHCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 02:02:16 -0500
Received: by mail-wm0-f45.google.com with SMTP id r129so13394096wmr.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 23:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=RGKDFLXL7PbIyz5bXaxV/wLO4O8OFMPkQVfDVIN9P0JDGM8NKpc5h544AbWCRRa/4w
         lzbFYSjQNgu6Lp7AUN3CLniQX1BPoL3yVm5m+4o+cAM0xnSEMKwcgVnQN97XwJ5CKk1w
         Md99Y8L5iiF9CHia33yN92l01fP8rZpeOCJ0wopJxwMCjo7OaRCBE9wcD3q7hdn69EH+
         kYaeM87Y6WWlDT8iA5vBlzkf5BNmfpajEst59RgedHFUBskYxT0YrvBf3jXi7kjQbbnj
         kUXchx1XsN9DbreNAeGRtQhHx56Ufbfhj6pw4OpF1SQUjCFIkMRohNfdhgFWjvAmZjOg
         Wi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UXmBoPNLCNAP7mZtrc//rPdn6serjiyONnJaxlXWgG8=;
        b=MYmlGuO0qST9J4C+1Q4vaFZOc05Ylf0wT7JgTfpFfmMBVMmdFejpjnFag6Km6XP3t2
         OB1kW8ZLuywIt7zvohOq5Wtcwx7Le1sXYrxsywaXjx6YoQA2UtVxBsLEIeXNgEDOcqzh
         zVHANWTyh3mHJgfHkztvfJtO73wlrUTEe9atPeMMadLJmcNElFymtT4E51SZJvz5MaLT
         W1e0QV/pLseW3OgNbQ2afBj1vRNJm0w+SnAox+VLIKhC86KHSQ1lVhMqPktGRwG8UoYK
         JhNXkhjdPZa+/b97aBeR45o+jf2IXFdjg3A9EBcs5XTY2Xe6EiZC6yIBs7hvUGj8CEwb
         UBEw==
X-Gm-Message-State: AG10YOTwYPG5aM5UWzCYVnMhQFY6cc425rgiTyZ+HZg5mwytVqDnBi0HxC84FBo0PTBIOQ==
X-Received: by 10.28.194.136 with SMTP id s130mr18691966wmf.23.1454655735644;
        Thu, 04 Feb 2016 23:02:15 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id i2sm14442915wjx.42.2016.02.04.23.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 23:02:15 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454655702-28164-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285545>

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
