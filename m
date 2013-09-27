From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Fri, 27 Sep 2013 17:40:26 +0530
Message-ID: <1380283828-25420-2-git-send-email-artagnon@gmail.com>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 27 14:17:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPWzT-0006ng-0L
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 14:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab3I0MR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 08:17:27 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:60634 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab3I0MRV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 08:17:21 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so2527589pdj.34
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C/2pepEHUjBZM8mWrVN1awTae15XY2YJvsB+UpV/0Zg=;
        b=bwhULgdg7kRHqr6tfwHMqi5OPU4aZDi9mUs8YdiS5yJm11Zol3zFNSTm+W0Gu0xS89
         XDAzEUR+e/JVF56FPmyAtAljWS0khGE/s4IvrtdxkS9QukjWVTlOJraHL1v2JBC/RHZa
         5KXP/7poouEZs5g13N31D0p5eAJdJL1EmPPYXXTsNN5yWIMv5aWky1pY4cSooiiRey3j
         nIL5GhZqwDvz+7y41Y6b0dW4Jo36Xhhcera2BB2cNPtol5gv0m2aEp2/siSKiZXwAdpP
         Yz0Lmw5rBJIaBf8OmXLcg74c40QAQ5tcSbmIwQFpE61ikFcAT2M0aqq6WkKTbBMqIMhc
         IlkA==
X-Received: by 10.68.135.100 with SMTP id pr4mr7173023pbb.62.1380284240823;
        Fri, 27 Sep 2013 05:17:20 -0700 (PDT)
Received: from localhost.localdomain ([122.164.156.52])
        by mx.google.com with ESMTPSA id xe9sm12229901pab.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 05:17:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.478.g55109e3
In-Reply-To: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235457>

Enhance 'git for-each-ref' with color formatting options.  You can now
use the following format in for-each-ref:

  %C(green)%(refname:short)%C(reset)

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 +++-
 builtin/for-each-ref.c             | 23 +++++++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f2e08d1..078a116 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -45,7 +45,9 @@ OPTIONS
 	It also interpolates `%%` to `%`, and `%xx` where `xx`
 	are hex digits interpolates to character with hex code
 	`xx`; for example `%00` interpolates to `\0` (NUL),
-	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
+	`%09` to `\t` (TAB) and `%0a` to `\n` (LF). Additionally,
+	colors can be specified using `%C(colorname)`. Use
+	`%C(reset)` to reset the color.
 
 <pattern>...::
 	If one or more patterns are given, only refs are shown that
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 1d4083c..a1ca186 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "remote.h"
+#include "color.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -155,10 +156,13 @@ static const char *find_next(const char *cp)
 	while (*cp) {
 		if (*cp == '%') {
 			/*
+			 * %C( is the start of a color;
 			 * %( is the start of an atom;
 			 * %% is a quoted per-cent.
 			 */
-			if (cp[1] == '(')
+			if (cp[1] == 'C' && cp[2] == '(')
+				return cp;
+			else if (cp[1] == '(')
 				return cp;
 			else if (cp[1] == '%')
 				cp++; /* skip over two % */
@@ -180,8 +184,11 @@ static int verify_format(const char *format)
 		const char *ep = strchr(sp, ')');
 		if (!ep)
 			return error("malformed format string %s", sp);
-		/* sp points at "%(" and ep points at the closing ")" */
-		parse_atom(sp + 2, ep);
+		/* Ignore color specifications: %C(
+		 * sp points at "%(" and ep points at the closing ")"
+		 */
+		if (prefixcmp(sp, "%C("))
+			parse_atom(sp + 2, ep);
 		cp = ep + 1;
 	}
 	return 0;
@@ -933,12 +940,20 @@ static void emit(const char *cp, const char *ep)
 static void show_ref(struct refinfo *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	char color[COLOR_MAXLEN];
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			emit(cp, sp);
-		print_value(info, parse_atom(sp + 2, ep), quote_style);
+
+		/* Do we have a color specification? */
+		if (!prefixcmp(sp, "%C("))
+			color_parse_mem(sp + 3, ep - sp - 3, "--format", color);
+		else {
+			printf("%s", color);
+			print_value(info, parse_atom(sp + 2, ep), quote_style);
+		}
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-- 
1.8.4.478.g55109e3
