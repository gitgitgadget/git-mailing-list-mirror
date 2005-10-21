From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Use sensible domain name (the DNS one) when guessing ident information
Date: Fri, 21 Oct 2005 03:57:39 +0200
Message-ID: <20051021015739.16471.21112.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 03:59:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESmAF-0001UI-Fy
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 03:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVJUB5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 21:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVJUB5n
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 21:57:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:6300 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964841AbVJUB5n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 21:57:43 -0400
Received: (qmail 16484 invoked from network); 21 Oct 2005 03:57:40 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 21 Oct 2005 03:57:40 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10405>

Currently, the code would use getdomainname() call, which however returns
something usually unset and not necessarily related at all to the DNS
domain name (it seems to be mostly some scary NIS/YP thing).

This patch changes the code to actually use the DNS domain name, which is
also what tends to be used in emails, and we aim at emails with our ident
code.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 ident.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/ident.c b/ident.c
index 06d0e6c..bc89e1d 100644
--- a/ident.c
+++ b/ident.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 
 #include <pwd.h>
+#include <netdb.h>
 
 static char git_default_date[50];
 
@@ -64,9 +65,16 @@ int setup_ident(void)
 	git_default_email[len++] = '@';
 	gethostname(git_default_email + len, sizeof(git_default_email) - len);
 	if (!strchr(git_default_email+len, '.')) {
+		struct hostent *he = gethostbyname(git_default_email + len);
+		char *domainname;
+
 		len = strlen(git_default_email);
 		git_default_email[len++] = '.';
-		getdomainname(git_default_email+len, sizeof(git_default_email)-len);
+		if (he && (domainname = strchr(he->h_name, '.')))
+			strncpy(git_default_email + len, domainname + 1, sizeof(git_default_email) - len);
+		else
+			strncpy(git_default_email + len, "(none)", sizeof(git_default_email) - len);
+		git_default_email[sizeof(git_default_email) - 1] = 0;
 	}
 	/* And set the default date */
 	datestamp(git_default_date, sizeof(git_default_date));
