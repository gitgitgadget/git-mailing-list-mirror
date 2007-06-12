X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add a local implementation of hstrerror for the system which do not have it
Date: Tue, 12 Jun 2007 23:31:29 +0200
Message-ID: <20070612213129.GD2459@steel.home>
References: <86ejkh40cr.fsf@blue.stonehenge.com> <20070612205210.GC2459@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Jun 2007 21:31:39 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20070612205210.GC2459@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTj8OeQ=
X-RZG-CLASS-ID: mo07
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1HyDxg-0002PF-2W for gcvg-git@gmane.org; Tue, 12 Jun 2007
 23:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751198AbXFLVbc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Jun 2007
 17:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbXFLVbc
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 17:31:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:58508 "EHLO
 mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751027AbXFLVbb (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007
 17:31:31 -0400
Received: from tigra.home (Fcad5.f.strato-dslnet.de [195.4.202.213]) by
 post.webmailer.de (fruni mo48) (RZmta 7.2) with ESMTP id I01c05j5CKMStm ;
 Tue, 12 Jun 2007 23:31:29 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id BC538277BD; Tue, 12 Jun 2007 23:31:29 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000) id 963C6D261; Tue, 12 Jun
 2007 23:31:29 +0200 (CEST)
Sender: git-owner@vger.kernel.org

The function converts the value of h_errno (last error of name
resolver library, see netdb.h). One of systems which supposedly do
not have the function is SunOS. POSIX does not mandate its presence.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Randal, you seem to have access to a SunOS system. Could you try to
compile your git with NO_IPV6 (if you already applied the previous
fix, which removed superflous calls to hstrerror), and than again
without it (just to be sure)?

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
index 0000000..c59b808
--- /dev/null
+++ b/compat/hstrerror.c
@@ -0,0 +1,21 @@
+#include <string.h>
+#include <stdio.h>
+#include <netdb.h>
+
+const char *githstrerror(int err)
+{
+	static char buffer[32];
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
1.5.2.1.191.gc01a
