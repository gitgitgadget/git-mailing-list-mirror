From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/3] for-each-ref: introduce %C(...) for color
Date: Sat, 28 Sep 2013 08:29:19 +0530
Message-ID: <1380337161-803-2-git-send-email-artagnon@gmail.com>
References: <1380337161-803-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 28 05:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPkrg-0006uG-VH
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 05:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab3I1DGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 23:06:23 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:63199 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab3I1DGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 23:06:18 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so3290035pbc.35
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kvfkOOKnm0YwriGiGkXWAgqPiPqQBC8Nhvfn2pPkfqw=;
        b=zNc9yFx0xiKu59i25DIDf+qI9peTd7Np1HhDGTVqUUWcZLEQ4w3ZvICSuNAhSSHxP4
         GbDyaejPOl+d4ctFNFp+oQnR5LW2wJbQdSaGRTU0iG5FqacbqBTUDSPDe4+QdpUM8MFx
         zKTebVeUge73H68thEEoUgQkD43NhQoP0Xa9jzScA/0Zkvjwy51uXCTbj34XV5OuOJTj
         JKL6Mx55xXqpEiYA3/iZMiBu2wYjbJPwzMFjBUUiXlLN/UIh7l/U+O4lVkQmzNQxnjBK
         7SrQp07MHBzIwMBcF1Yeu95MRH8+hv7jzwG/6Cis8wBrXky4p62HP48dpfNLft5gGopn
         uM0Q==
X-Received: by 10.68.173.5 with SMTP id bg5mr8181207pbc.26.1380337578320;
        Fri, 27 Sep 2013 20:06:18 -0700 (PDT)
Received: from localhost.localdomain ([122.164.156.52])
        by mx.google.com with ESMTPSA id hx1sm11880794pbb.35.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 20:06:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.477.g4cae6f5
In-Reply-To: <1380337161-803-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235485>

Enhance 'git for-each-ref' with color formatting options.  You can now
use the following format in for-each-ref:

  %C(green)%(refname:short)%C(reset)

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 +++-
 builtin/for-each-ref.c             | 23 +++++++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f2e08d1..6fa4464 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -45,7 +45,9 @@ OPTIONS
 	It also interpolates `%%` to `%`, and `%xx` where `xx`
 	are hex digits interpolates to character with hex code
 	`xx`; for example `%00` interpolates to `\0` (NUL),
-	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
+	`%09` to `\t` (TAB) and `%0a` to `\n` (LF). Additionally,
+	colors can be specified using `%C(...)`, with names
+	described in color.branch.*.
 
 <pattern>...::
 	If one or more patterns are given, only refs are shown that
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 1d4083c..6da2903 100644
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
+	char color[COLOR_MAXLEN] = "";
 
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
1.8.4.477.g4cae6f5
