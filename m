From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Thu, 31 Oct 2013 15:16:12 +0530
Message-ID: <1383212774-5232-2-git-send-email-artagnon@gmail.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 31 10:54:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VboxT-0007oq-42
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab3JaJy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:54:28 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:56213 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab3JaJy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:54:27 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so2247741pab.20
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=hxbWny9f1nqinoRu3HyobJ5P4xiRUzh7IzGhBvTiFEk=;
        b=mDR2No4AHwhFvz1YcYHaHY/wKSmbPu9Fo1l7V2SPqInt2Of4C4mJlo6cdbDvB8Q8Jw
         HoJCFE3DouKEU6idoYAUv4kltiLT1fJXFjpwXodWXp7cJ/rwreoHhLizf1CBdyt51vfE
         //qad6tzsgHLQDTeAJZfsnXHRAPx+FJcjNspqh05aB3C9CtDNtNJCXtIKN0xbzDbwbae
         6BzcM63+sexY1qySkirnXEa3sORtHcX0KRsq9p4BIXbvlZaiR1iEGD6Wx9Wb51urQoJ8
         yGgBqN9FZvmtwLyPRADRU+gWBb9utHcwWWhG8buVTPtfQgB7C1VLG1cjZH2mfDM904Dh
         mN6g==
X-Received: by 10.66.67.6 with SMTP id j6mr944230pat.165.1383213266725;
        Thu, 31 Oct 2013 02:54:26 -0700 (PDT)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id i10sm4106533pat.11.2013.10.31.02.54.25
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:54:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.rc0.3.gb488857
In-Reply-To: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237113>

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
1.8.5.rc0.3.gb488857
