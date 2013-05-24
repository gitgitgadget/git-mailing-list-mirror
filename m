From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Fri, 24 May 2013 19:49:35 +0530
Message-ID: <1369405177-7855-2-git-send-email-artagnon@gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 16:20:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufsqc-0007Jp-8O
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 16:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756413Ab3EXOR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 10:17:58 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:56250 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280Ab3EXOR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 10:17:57 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so2971422pde.4
        for <git@vger.kernel.org>; Fri, 24 May 2013 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ldsOW1H4dAy1XoYQFxwQWW5SjbNm8JMFNfVO74DF6OM=;
        b=bNlPXZujT/wKlvss3s3gGEENYCm097XNs9+6qhuwCQjwt0TuZjydq/+cZ63FuPe4Ip
         QebkgvWtaKv8TIAErHHVnvze+tjzl7fedp4nHWZiWHeeG5jtATxTQSVVgiBYOIAqpXgZ
         k9QmCT7HCPbNhKr2/uLZ6VaOWMQGyJdfrYCKHEx/chChFOaNTFAx46LxdruKjhz9iyxq
         rE78GJbf8YHN15OXCtZDsHITin2VblhdHFQM/ju4rmuCckWZKgDdCDPhLoQzCkgEyRId
         Z0qAD8i2uQDi3YTrsmXMH25VXwJfukaFXz4D+WG5ls6P+tmyBb7F0MYXNHWylzQ5Cc4J
         IBHg==
X-Received: by 10.66.188.204 with SMTP id gc12mr18909531pac.85.1369405076660;
        Fri, 24 May 2013 07:17:56 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id qp4sm16338288pbc.41.2013.05.24.07.17.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 07:17:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.2.g99b8f3f.dirty
In-Reply-To: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225357>

Since 'git branch' misses important options like --sort, --count, and
--format that are present in 'git for-each-ref'.  Until we are in a
position to fix 'git branch', let us enhance the 'git for-each-ref'
format so it can atleast colorize output.

You can use the following format in for-each-ref:

  %C(green)%(refname:short)%C(reset)

To display refs in green.  Future patches will attempt to extend the
format even more to get useful output.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 7f059c3..1563b25 100644
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
@@ -180,8 +184,12 @@ static int verify_format(const char *format)
 		const char *ep = strchr(sp, ')');
 		if (!ep)
 			return error("malformed format string %s", sp);
-		/* sp points at "%(" and ep points at the closing ")" */
-		parse_atom(sp + 2, ep);
+		/*
+		 * Ignore color specifications: %C(
+		 * sp points at "%(" and ep points at the closing ")"
+		 */
+		if (prefixcmp(sp, "%C("))
+			parse_atom(sp + 2, ep);
 		cp = ep + 1;
 	}
 	return 0;
@@ -928,12 +936,22 @@ static void emit(const char *cp, const char *ep)
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
+			color_parse_mem(sp + 3,
+					ep - sp - 3,
+					"--format ", color);
+		else {
+			printf("%s", color);
+			print_value(info, parse_atom(sp + 2, ep), quote_style);
+		}
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-- 
1.8.3.rc3.2.g99b8f3f.dirty
