From: Florian Forster <octo@verplant.org>
Subject: [PATCH 1/7] Remove ranges from switch statements.
Date: Sun, 18 Jun 2006 17:18:03 +0200
Message-ID: <1150643889264-git-send-email-octo@verplant.org>
References: <11506438892865-git-send-email-octo@verplant.org>
Reply-To: Florian Forster <octo@verplant.org>
Cc: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 17:18:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frz2n-0005K3-6c
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 17:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWFRPSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 11:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWFRPST
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 11:18:19 -0400
Received: from verplant.org ([213.95.21.52]:35721 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1751172AbWFRPSN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 11:18:13 -0400
Received: from leeloo.lan.home.verplant.org ([2001:780:104:1:2e0:18ff:fead:37e4] ident=Debian-exim)
	by huhu.verplant.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Frz2S-0004ZX-0y; Sun, 18 Jun 2006 17:18:12 +0200
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=octo)
	by leeloo.lan.home.verplant.org with esmtp (Exim 4.62)
	(envelope-from <octo@verplant.org>)
	id 1Frz2P-00028O-5N; Sun, 18 Jun 2006 17:18:09 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3
In-Reply-To: <11506438892865-git-send-email-octo@verplant.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22088>

Though very nice and readable, the "case 'a'...'z':" construct is not ANSI C99
compliant. This patch unfolds the range in `quote.c' and substitutes the
switch-statement with an if-statement in `http-fetch.c' and `http-push.c'.

Signed-off-by: Florian Forster <octo@verplant.org>


---

 http-fetch.c |   13 +++++++------
 http-push.c  |   13 +++++++------
 quote.c      |    9 ++++++++-
 3 files changed, 22 insertions(+), 13 deletions(-)

d90149c5b4e91938329120bdde609e5f6d9b03e8
diff --git a/http-fetch.c b/http-fetch.c
index da1a7f5..3a2cb5e 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1136,13 +1136,14 @@ int fetch(unsigned char *sha1)
 
 static inline int needs_quote(int ch)
 {
-	switch (ch) {
-	case '/': case '-': case '.':
-	case 'A'...'Z':	case 'a'...'z':	case '0'...'9':
+	if (((ch >= 'A') && (ch <= 'Z'))
+			|| ((ch >= 'a') && (ch <= 'z'))
+			|| ((ch >= '0') && (ch <= '9'))
+			|| (ch == '/')
+			|| (ch == '-')
+			|| (ch == '.'))
 		return 0;
-	default:
-		return 1;
-	}
+	return 1;
 }
 
 static inline int hex(int v)
diff --git a/http-push.c b/http-push.c
index 2d9441e..364ab76 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1077,13 +1077,14 @@ static int fetch_indices(void)
 
 static inline int needs_quote(int ch)
 {
-	switch (ch) {
-	case '/': case '-': case '.':
-	case 'A'...'Z':	case 'a'...'z':	case '0'...'9':
+	if (((ch >= 'A') && (ch <= 'Z'))
+			|| ((ch >= 'a') && (ch <= 'z'))
+			|| ((ch >= '0') && (ch <= '9'))
+			|| (ch == '/')
+			|| (ch == '-')
+			|| (ch == '.'))
 		return 0;
-	default:
-		return 1;
-	}
+	return 1;
 }
 
 static inline int hex(int v)
diff --git a/quote.c b/quote.c
index 06792d4..dcc2326 100644
--- a/quote.c
+++ b/quote.c
@@ -206,7 +206,14 @@ #define EMIT(c) (outp ? (*outp++ = (c)) 
 				case '\\': case '"':
 					break; /* verbatim */
 
-				case '0'...'7':
+				case '0':
+				case '1':
+				case '2':
+				case '3':
+				case '4':
+				case '5':
+				case '6':
+				case '7':
 					/* octal */
 					ac = ((ch - '0') << 6);
 					if ((ch = *sp++) < '0' || '7' < ch)
-- 
1.3.3
