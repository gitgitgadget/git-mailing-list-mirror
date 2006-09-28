From: Linus Torvalds <torvalds@osdl.org>
Subject: Clean up approxidate() in preparation for fixes
Date: Thu, 28 Sep 2006 12:12:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609281211260.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 28 21:13:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT1JK-0000V9-5H
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 21:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbWI1TMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 15:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWI1TMj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 15:12:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47759 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751980AbWI1TMi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 15:12:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8SJCXnW026879
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 12:12:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8SJCT4s019736;
	Thu, 28 Sep 2006 12:12:31 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.459 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28035>


Our approxidate cannot handle simple times like "5 PM yesterday", and to
fix that, we will need to add some logic for number handling.  This just
splits that out into a function of its own (the same way the _real_ date
parsing works).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This should change no code what-so-ever, just split it up in preparation 
for the next patch..

diff --git a/date.c b/date.c
index e387dcd..4ff6604 100644
--- a/date.c
+++ b/date.c
@@ -712,6 +712,15 @@ static const char *approxidate_alpha(con
 	return end;
 }
 
+static const char *approxidate_digit(const char *date, struct tm *tm, int *num)
+{
+	char *end;
+	unsigned long number = strtoul(date, &end, 10);
+
+	*num = number;
+	return end;
+}
+
 unsigned long approxidate(const char *date)
 {
 	int number = 0;
@@ -731,9 +740,7 @@ unsigned long approxidate(const char *da
 			break;
 		date++;
 		if (isdigit(c)) {
-			char *end;
-			number = strtoul(date-1, &end, 10);
-			date = end;
+			date = approxidate_digit(date-1, &tm, &number);
 			continue;
 		}
 		if (isalpha(c))
