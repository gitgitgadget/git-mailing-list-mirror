From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add a local implementation of hstrerror for the system which do not have it
Date: Wed, 13 Jun 2007 20:54:32 +0200
Message-ID: <20070613185432.GA3412@steel.home>
References: <86ejkh40cr.fsf@blue.stonehenge.com> <20070612205210.GC2459@steel.home> <20070612213129.GD2459@steel.home> <466F971F.C74761E2@eudaptics.com> <81b0412b0706130051l570e6ab7y48d6eea8c6b2d97e@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 20:56:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyY17-0006ag-5Y
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbXFMSyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180AbXFMSyj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:54:39 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:59799 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbXFMSyi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 14:54:38 -0400
Received: from tigra.home (Fcad5.f.strato-dslnet.de [195.4.202.213])
	by post.webmailer.de (fruni mo18) (RZmta 7.2)
	with ESMTP id F01b57j5DIl833 ; Wed, 13 Jun 2007 20:54:33 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 87822277BD;
	Wed, 13 Jun 2007 20:54:33 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DBFB3D261; Wed, 13 Jun 2007 20:54:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0706130051l570e6ab7y48d6eea8c6b2d97e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTj8OeQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50115>

The function converts the value of h_errno (last error of name
resolver library, see netdb.h).
One of systems which supposedly do not have the function is SunOS.
POSIX does not mandate its presence.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Makefile           |    5 +++++
 compat/hstrerror.c |   21 +++++++++++++++++++++
 git-compat-util.h  |    5 +++++
 3 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 compat/hstrerror.c

diff --git a/Makefile b/Makefile
index 0f6540c..e054bc7 100644
--- a/Makefile
+++ b/Makefile
@@ -410,6 +410,7 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_NSL = YesPlease
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
+	NO_HSTRERROR = YesPlease
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
@@ -654,6 +655,10 @@ endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
+ifdef NO_HSTRERROR
+	COMPAT_CFLAGS += -DNO_HSTRERROR
+	COMPAT_OBJS += compat/hstrerror.o
+endif
 
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
diff --git a/compat/hstrerror.c b/compat/hstrerror.c
new file mode 100644
index 0000000..069c555
--- /dev/null
+++ b/compat/hstrerror.c
@@ -0,0 +1,21 @@
+#include <string.h>
+#include <stdio.h>
+#include <netdb.h>
+
+const char *githstrerror(int err)
+{
+	static char buffer[48];
+	switch (err)
+	{
+	case HOST_NOT_FOUND:
+		return "Authoritative answer: host not found";
+	case NO_DATA:
+		return "Valid name, no data record of requested type";
+	case NO_RECOVERY:
+		return "Non recoverable errors, FORMERR, REFUSED, NOTIMP";
+	case TRY_AGAIN:
+		return "Non-authoritative \"host not found\", or SERVERFAIL";
+	}
+	sprintf(buffer, "Name resolution error %d", err);
+	return buffer;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 6bd8987..b2ab3f8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -167,6 +167,11 @@ extern size_t gitstrlcpy(char *, const char *, size_t);
 extern uintmax_t gitstrtoumax(const char *, char **, int);
 #endif
 
+#ifdef NO_HSTRERROR
+#define hstrerror githstrerror
+extern const char *githstrerror(int herror);
+#endif
+
 extern void release_pack_memory(size_t, int);
 
 static inline char* xstrdup(const char *str)
-- 
1.5.2.1.270.g288d3f
